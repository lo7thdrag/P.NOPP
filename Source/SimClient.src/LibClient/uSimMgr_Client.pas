unit uSimMgr_Client;

interface

uses
  MapXLib_TLB, Windows, Classes, Graphics, SysUtils, uCompassVisual, uObjectVisuals,
  Controls, Forms, Registry, MMSystem, Dialogs,

  uT3SimManager, uLibSetting, uThreadTimer, uDataModule,
  uRecordData, {uNetSessionData,} uSteppers,
  uSimObjects, uConsoleData, uExecuter, uConstantaData, uDataTypes, uClassData;

type

  // ==============================================================================
  // contain: 'session' , scenario management,  objects run..
  // ==============================================================================

  TNotifyGameCtrl = procedure(const r: TRecCmd_GameCtrl) of object;
  TOnUpdateProgress = procedure (const percentVal : integer) of object;

  TSimMgr_Client = class(TT3SimManager)

  protected
//    FUpdateThread: TMSTimer;
    FConnectDelay: TDelayer;
    FCompass: TCompassVisual;

    {$REGION ' Receive UDP '}
    procedure netRecv_CmdGameControl(apRec: PAnsiChar; aSize: word);
    procedure netRecv_CmdClientStateInfo(apRec: PAnsiChar; aSize: word);
    {$ENDREGION}

    {$REGION ' Receive TCP '}
    procedure netRecv_CmdUserState(apRec: PAnsiChar; aSize: word);
    procedure netRecv_CmdSituationBoardTabProperties(apRec: PAnsiChar; aSize: word);
    procedure netRecv_CmdChatUserRole(apRec: PAnsiChar; aSize: word);
    procedure netRecv_CmdOverlayShape(apRec: PAnsiChar; aSize: word);
    {$ENDREGION}

    procedure FGameThread_OnRunning(const dt: double); override;
    procedure FGameThread_OnPaused(const dt: double); override;

    procedure FUpdateThread_OnTerminate(sender: TObject); virtual;
    procedure FUpdateThread_OnRunning(const dt: double); virtual;
    procedure FUpdateThread_OnPaused(const dt: double); virtual;

    procedure FNetworkThread_OnRunning(const dt: double);override;
    procedure FNetworkThread_OnPaused(const dt: double); override;

    procedure FOnUpdateDelay(sender: TObject);
    procedure FOnConnectDelay(sender: TObject);

  private
    FConsoleData : TConsoleData;

    FOnMapViewChange: TNotifyEvent;
    FLastSecond: word;
    FOnUpdateGameState: TNotifyEvent;
    FOnUpdateForm: TNotifyEvent;
    FOnUpdateTime: TNotifyEvent;

  public
    DrawFlagPoint : TFlagPointbContainer;
    DrawRuler : TRuler;

    constructor Create(Map : TMap);
    destructor Destroy; override;

//    function Login(UserName, Password : string): integer;

    procedure GameStart; override;
    procedure GamePause; override;
    procedure GameTerminate; override;

    procedure InitNetwork; override;
    procedure StopNetwork; override;

    procedure LoadConsoleID; override;
    procedure LoadDataAsset(const vSet: TGameDataSetting); override;
    procedure OnUserStateChange(const rec : TRecTCP_UserState); override;
    procedure OnSituationBoardTabPropertiesChange(const rec : TRecTCPSendSituationBoardTabProperties); override;
    procedure OnUserRoleChatChange(const rec : TRecTCPSendChatUserRole); override;
    procedure OnOverlayShape(const rec : TRecTCPSendOverlayShape); override;

    procedure DrawAll(aCnv: TCanvas);

    {$REGION ' Send TCP '}
    procedure netSend_CmdUserState(r: TRecTCP_UserState);
    procedure netSend_CmdRemote(r : TRecTCPSendRemote);
    procedure netSend_CmdSituationBoardTabProperties(r : TRecTCPSendSituationBoardTabProperties);
    procedure netSend_CmdSendMessage(r : TRecTCPSendChatUserRole);
    procedure netSend_CmdOverlayShape(r: TRecTCPSendOverlayShape);

    {$ENDREGION}

    property MyConsoleData: TConsoleData read FConsoleData;

    property OnUpdateGameState: TNotifyEvent read FOnUpdateGameState write FOnUpdateGameState;
    property OnUpdateForm: TNotifyEvent read FOnUpdateForm write FOnUpdateForm;
    property OnUpdateTime: TNotifyEvent read FOnUpdateTime write FOnUpdateTime;
    property OnMapViewChange : TNotifyEvent read FOnMapViewChange write FOnMapViewChange;

  end;

var
  simMgrClient : TSimMgr_Client;

implementation

uses
  uSimManager, uBaseCoordSystem, uCoordConvertor, uMapXhandler, uNetHandle_Client, uNetBaseSocket, uT3ClientEventManager,
  uAppUtils, uT3Listener;

constructor TSimMgr_Client.Create(Map : TMap);
var
  i : integer;
begin
  inherited;

  FCompass := TCompassVisual.Create;

  FConnectDelay := TDelayer.Create;
  with FConnectDelay do
  begin
    DInterval := 8.0;
    OnTime := FOnConnectDelay;
    Enabled := false;
  end;

  FConsoleData := TConsoleData.Create;
  EventManager := TT3ClientEventManager.Create;

  DrawFlagPoint := TFlagPointbContainer.Create;
  DrawRuler := TRuler.Create(Converter);

  SimManager := Self;
end;

destructor TSimMgr_Client.Destroy;
  procedure ClearAndFreeItems(var sl: TStringList);
  var
    i: integer;
    o: TObject;
  begin
    for i := sl.Count - 1 downto 0 do
    begin
      o := sl.Objects[i];
      o.Free;
    end;
    sl.Clear;
  end;
var
  i: Integer;
begin
  if FGameState = gsPlaying then
   GamePause;

  FCompass.Free;
  FConsoleData.Free;

  inherited;
end;

procedure TSimMgr_Client.GameStart;
begin
  inherited;

  if Assigned(FOnUpdateGameState) then
    FOnUpdateGameState(self);
end;

procedure TSimMgr_Client.GamePause;
begin
  inherited;

  if Assigned(FOnUpdateGameState) then
    FOnUpdateGameState(self);
end;

procedure TSimMgr_Client.LoadConsoleID;
var
  i: integer;
  ss: TStrings;
  found: Boolean;
  ip, host: string;

begin
  inherited;

  ss := TStringList.Create;
  if GetHostandIPList(host, ss) then
  begin
    i := 0;
    found := false;
    while not found and (i < ss.Count) do
    begin
      ip := ss[i];
      found := SimConsole.IsGroupMember(ip);

      inc(i);
    end;

    if found then
    begin
      FConsoleData.IpAdrres := ip;
      FConsoleData.Identifier := SimConsole.GetConsoleName(ip);

      if (SimConsole.GetConsoleRoleName(ip)= 'SituationBoard Group') then
        FConsoleData.Group := cgSituationBoard
      else if (SimConsole.GetConsoleRoleName(ip)= 'Instructor Group') then
        FConsoleData.Group := cgInstructor
      else
        FConsoleData.Group := cgOfficial;
    end;
  end;

  ss.Free;
end;

procedure TSimMgr_Client.InitNetwork;
begin

  {$REGION ' UDP SECTION '}
//  VNetClient.RegisterUDPPacket(CPID_CMD_GAME_CTRL, SizeOf(TRecCmd_GameCtrl), netRecv_CmdGameControl);
  VNetClient.RegisterTCPPacket(CPID_CMD_GAME_CTRL, SizeOf(TRecCmd_GameCtrl),netRecv_CmdGameControl);
//  VNetClient.RegisterUDPPacket(CPID_CMD_CLIENT_STATE_INFO, SizeOf(TRecUDP_ClientState_Info),netRecv_CmdClientStateInfo);
  {$ENDREGION}

  {$REGION ' TCP SECTION '}
   VNetClient.RegisterTCPPacket(CPID_CMD_CLIENT_STATE_INFO, SizeOf(TRecTCP_ClientState_Info),netRecv_CmdClientStateInfo);
   VNetClient.RegisterTCPPacket(CPID_CMD_USER_STATE, SizeOf(TRecTCP_UserState),netRecv_CmdUserState);
   VNetClient.RegisterTCPPacket(CPID_CMD_SITUATIONBOARD_TAB_PROPERTIES, SizeOf(TRecTCPSendSituationBoardTabProperties),netRecv_CmdSituationBoardTabProperties);
   VNetClient.RegisterTCPPacket(CPID_CMD_CHAT_USER_ROLE, SizeOf(TRecTCPSendChatUserRole),netRecv_CmdChatUserRole);
   VNetClient.RegisterTCPPacket(CPID_CMD_OVERLAYSHAPE, SizeOf(TRecTCPSendOverlayShape),netRecv_CmdOverlayShape);
  {$ENDREGION}

  FConnectDelay.Enabled := True;
end;

procedure TSimMgr_Client.StopNetwork;
begin
  FConnectDelay.Enabled := false;

  VNetClient.UnRegisterUDP;
  VNetClient.UnRegisterTCP;
end;

procedure TSimMgr_Client.DrawAll(aCnv: TCanvas);
var
  aRect: TRect;
begin
  {$REGION ' Batas draw di map '}
  aRect.Left := 0;
  aRect.Top := 0;

  {$ENDREGION}

  {$REGION ' Draw Compas '}
  FCompass.DrawCompass(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Overlay '}
//  SimOverlayTemplate.Draw(aCnv, VSimMap.FMap);
  {$ENDREGION}

  {$REGION ' Draw Plotting '}
//  SimPlotting.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Shiping Route '}
  {Draw Shiping Route yg sudah dipublish}
//  SimShipingRoute.Draw(aCnv);

  {Draw Shiping Route yg masih dibuat/ temporary }
//  DrawPointRouteTemporary.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Base '}
//  SimPlatformBase.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Ruler '}
//  DrawRuler.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Game Center '}
//  DrawGameCenter.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Range Ring '}
//  FRangeRing.ConvertCoord(Converter);
//  FRangeRing.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Line Visual '}
//  if vFilter.Show(pftNone, 'Range/bearing cursor', 'Display information') then
//  begin
////    FLineVisual.ConvertCoord(Converter);
//    FLineVisual.Draw(aCnv);
//  end;
  {$ENDREGION}

  {$REGION ' Draw Splash Point NGS '}
//  FFlashPointNGS.ConvertCoord(Converter);
//  FFlashPointNGS.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Spalsh Target '}
//  FTargetSymbol.ConvertCoord(Converter);
//  FTargetSymbol.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Flag Point '}
//  DrawFlagPoint.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Move Line '}
//  FMovePlatformLine.ConvertCoord(Converter);
//  FMovePlatformLine.Draw(aCnv);
  {$ENDREGION}

  {$REGION ' Draw Object Platform '}


//  simNonRealPlatform.UpdateAndDrawVisuals(aCnv, aRect);
  {$ENDREGION}

  {$REGION ' Draw Device On Board '}
//  SimDevices.UpdateAndDrawVisuals(aCnv, aRect);
//  SimWeapons.UpdateAndDrawVisuals(aCnv, aRect);
  {$ENDREGION}

end;

procedure TSimMgr_Client.FGameThread_OnPaused(const dt: double);
begin
  inherited;
  //
end;

procedure TSimMgr_Client.FGameThread_OnRunning(const dt: double);
begin
  inherited;
  //
end;

procedure TSimMgr_Client.FNetworkThread_OnPaused(const dt: double);
begin
  inherited;
//x
end;

procedure TSimMgr_Client.FNetworkThread_OnRunning(const dt: double);
begin
  inherited;
  if Assigned(VNetClient) then
    VNetClient.getPacket;
end;

procedure TSimMgr_Client.LoadDataAsset(const vSet: TGameDataSetting);
//var
//  i : Integer;
//  listTemp : TList;
//  userRoleTemp : TUserRole;

begin
  inherited;

//  {$REGION ' Load User Role '}
//  listTemp := TList.Create;
//  dmINWO.GetAllUserRole(listTemp);
//
//  for i := 0 to listTemp.Count-1 do
//  begin
//    userRoleTemp := listTemp.Items[i];
//
//    if Assigned(userRoleTemp) then
//    begin
//      SimUserRole.addUserRole(userRoleTemp);
//    end;
//  end;
//  listTemp.Free;
//  {$ENDREGION}

end;

//function TSimMgr_Client.Login(UserName, Password: string): integer;
//var
//  userRoleTemp : TUser_Role;
//  rec : TRecTCP_Login;
//
//begin
//  Result := 2; {role tidak ditemukan}
//  userRoleTemp := SimUserRole.getUserRoleByUsernamePassword(UserName, Password);
//
//  if Assigned(userRoleTemp) then
//  begin
//    if not userRoleTemp.isInUse then
//    begin
//      Result := 0;
//
//      rec.UserRoleInUse := True;
//      rec.ConsoleIP := ConsoleData.IpAdrres;
//      rec.UserRoleId := userRoleTemp.FData.UserRoleIndex;
//      netSend_CmdLogin(rec);
//    end
//    else
//    begin
//      Result := 1; {role sudah digunakan}
//    end;
//  end;
//end;

{$REGION ' Receive UDP '}

procedure TSimMgr_Client.netRecv_CmdClientStateInfo(apRec: PAnsiChar; aSize: word);
var
  r : ^TRecTCP_ClientState_Info;
//  rec : TRecTCP_ClientState_Info;
begin
  r := @apRec^;

  if r^.SessionID <> FSessionID then
    Exit;

//  rec.SessionID := FSessionID;
//  rec.ClientState := True;
//  rec.ConsoleName := MyConsoleName;

//  VNetClient.SendCommand(CPID_CMD_CLIENT_STATE_INFO, @rec);
end;

procedure TSimMgr_Client.netRecv_CmdGameControl(apRec: PAnsiChar; aSize: word);
var
  r: ^TRecCmd_GameCtrl;

begin
  r := @apRec^;

  if r^.SessionID <> FSessionID then
    Exit;

  VNetClient.GameCtrl := r^.GameCtrl;

  case r^.GameCtrl of
    CORD_ID_start:
    begin
      GameStart;
    end;
    CORD_ID_pause:
    begin
      GamePause;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Receive TCP '}

procedure TSimMgr_Client.netRecv_CmdUserState(apRec: PAnsiChar; aSize: word);
var
  rec : ^TRecTCP_UserState;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnUserStateChange(rec^);

end;

procedure TSimMgr_Client.netRecv_CmdChatUserRole(apRec: PAnsiChar; aSize: word);
var
  rec : ^TRecTCPSendChatUserRole;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnUserRoleChatChange(rec^);

end;

procedure TSimMgr_Client.netRecv_CmdSituationBoardTabProperties(apRec: PAnsiChar; aSize: word);
var
  rec : ^TRecTCPSendSituationBoardTabProperties;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnSituationBoardTabPropertiesChange(rec^);

end;

procedure TSimMgr_Client.netRecv_CmdOverlayShape(apRec: PAnsiChar; aSize: word);
var
  rec : ^TRecTCPSendOverlayShape;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnOverlayShape(rec^);

end;

{$ENDREGION}

{$REGION ' Send TCP '}

procedure TSimMgr_Client.netSend_CmdOverlayShape(r: TRecTCPSendOverlayShape);
begin
  r.SessionID := FSessionID;
  VNetClient.SendCommand(CPID_CMD_OVERLAYSHAPE, @r);
end;

procedure TSimMgr_Client.netSend_CmdRemote(r: TRecTCPSendRemote);
begin
  r.SessionID := FSessionID;
  VNetClient.SendCommand(CPID_CMD_REMOTE, @r);
end;

procedure TSimMgr_Client.netSend_CmdSendMessage(r: TRecTCPSendChatUserRole);
begin
  r.SessionID := FSessionID;
  VNetClient.SendCommand(CPID_CMD_CHAT_USER_ROLE, @r);
end;

procedure TSimMgr_Client.netSend_CmdSituationBoardTabProperties(r: TRecTCPSendSituationBoardTabProperties);
begin
  r.SessionID := FSessionID;
  VNetClient.SendCommand(CPID_CMD_SITUATIONBOARD_TAB_PROPERTIES, @r);
end;

procedure TSimMgr_Client.netSend_CmdUserState(r: TRecTCP_UserState);
begin
  r.SessionID := FSessionID;
  VNetClient.SendCommand(CPID_CMD_USER_STATE, @r);
end;

procedure TSimMgr_Client.OnOverlayShape(const rec: TRecTCPSendOverlayShape);
begin
  inherited;

  {$REGION ' Khusus Console yg bersangkutan '}
  if MyConsoleData.UserRoleData.FData.UserRoleIndex = rec.IdUserRole then
  begin
    TT3ClientEventManager(EventManager).OnUpdateSituationBoardOverlayChange;
  end;
  {$ENDREGION}
end;

procedure TSimMgr_Client.OnSituationBoardTabPropertiesChange(const rec: TRecTCPSendSituationBoardTabProperties);
begin
  inherited;

  {$REGION ' Khusus Console yg bersangkutan '}
  if MyConsoleData.UserRoleData.FData.UserRoleIndex = rec.UserRoleId then
  begin
    TT3ClientEventManager(EventManager).OnUpdateSituationBoardTabPropertiesChange;
  end;
  {$ENDREGION}

end;

procedure TSimMgr_Client.OnUserRoleChatChange(const rec: TRecTCPSendChatUserRole);
begin
  inherited;

  {Update untuk yg ngirim dan yang nerima}
  if (MyConsoleData.UserRoleData.FData.UserRoleIndex = rec.ReceiverUserRoleId) then
  begin
    TT3ClientEventManager(EventManager).OnUpdateUserRoleChatChange(rec.SenderUserRoleId, rec.ReceiverUserRoleId);
  end;

  if (MyConsoleData.UserRoleData.FData.UserRoleIndex = rec.SenderUserRoleId) then
  begin
    TT3ClientEventManager(EventManager).OnUpdateUserRoleChatChange(rec.SenderUserRoleId, rec.ReceiverUserRoleId);
  end;

end;

procedure TSimMgr_Client.OnUserStateChange(const rec: TRecTCP_UserState);
var
  userRoleTemp : TUserRole;

begin
  inherited;

  {$REGION ' Khusus Console yg bersangkutan '}
  if MyConsoleData.IpAdrres = rec.ConsoleIP then
  begin
    userRoleTemp := SimUserRole.getUserRoleByID(rec.UserRoleId);

    if Assigned(userRoleTemp) then
    begin
      case rec.OrderID of
        CORD_ID_LOGIN :
        begin
          MyConsoleData.assignUserRoleData(userRoleTemp);
          TT3ClientEventManager(EventManager).OnUpdateUserStateChange(rec.OrderID);
        end;
        CORD_ID_LOGOUT :
        begin
          MyConsoleData.UnassignUserRoleData(userRoleTemp);
          TT3ClientEventManager(EventManager).OnUpdateUserStateChange(rec.OrderID);
        end;
      end;
    end;
  end;
  {$ENDREGION}
end;

{$ENDREGION}
procedure TSimMgr_Client.GameTerminate;
begin

  inherited;
end;

procedure TSimMgr_Client.FUpdateThread_OnRunning(const dt: double);
var
  t: TDateTime;
  hh, mm, ss, zz: word;
begin // 250 ms

//  if not FIsGotoMode then
//    VSimMap.DrawMap;

  t := FMainVTime.GetTime;
  DecodeTime(t, hh, mm, ss, zz);

  if ss <> FLastSecond then
  begin
    if Assigned(FOnUpdateTime) then
      FOnUpdateTime(self);
  end;

//  VNetClient.getPacket;
  FConnectDelay.Run(dt);
end;

procedure TSimMgr_Client.FUpdateThread_OnPaused(const dt: double);
begin
//  VSimMap.DrawMap;

  FConnectDelay.Run(dt);

  if Assigned(FOnUpdateTime) then
    FOnUpdateTime(self);
end;

procedure TSimMgr_Client.FUpdateThread_OnTerminate(sender: TObject);
begin

end;

procedure TSimMgr_Client.FOnUpdateDelay(sender: TObject);
begin
  if Assigned(FOnUpdateForm) then
    FOnUpdateForm(self);
end;

procedure TSimMgr_Client.FOnConnectDelay(sender: TObject);
begin
  VNetClient.TryReconnect; // tcp only.
end;

end.

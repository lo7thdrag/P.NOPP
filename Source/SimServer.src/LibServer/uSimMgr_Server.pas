unit uSimMgr_Server;

interface

uses
   MapXLib_TLB, Classes, SysUtils, Windows, Forms,

   uSteppers, uLibSetting, uThreadTimer , uVirtualTime, uSimContainers, uT3simManager, uT3UnitContainer, uT3Listener,
   uDataModule, uRecordData, uClassData ;

type
//==============================================================================
// contain: 'session' , scenario management,  objects run..
//==============================================================================

  TOnUpdateGameInfo = procedure (const st: byte; const gSpeed: double) of object;
  TOnUpdateVersion = procedure (const IP: string; ComputerName: string; Version : string; Match:string) of object;

  TSimMgr_Server = class(TT3SimManager)

  protected
    FConnectDelay: TDelayer;

    procedure FGameThread_OnRunning(const dt: double); override;
    procedure FGameThread_OnPaused(const dt: double); override;

    procedure FNetworkThread_OnRunning(const dt: double);override;

  private
    FOnUpdateGameInfo: TOnUpdateGameInfo;
//    FDelaySendingData : Double;

    FOnUpdateGameState: TNotifyEvent;

    procedure setBroadcastData(const Value: boolean);
    function getBroadcastData: boolean;
//    procedure netRecv_CmdSYNCH(apRec: PAnsiChar; aSize: Word);

  protected
    FSendCounter: integer;
    FNetSender    : TDelayer;

    // send UDP
    procedure NetSendUDP_BroadCast(sender: TObject);
//    procedure netSendUDP_GameTime(sender: TObject);

    //send TCP
//    procedure NetSendTCP_Sycnh_Platform();

    {$REGION ' Receive UDP '}
//    procedure netRecv_CmdGameControl(apRec: PAnsiChar; aSize: word);
    {$ENDREGION}

    {$REGION ' Receive TCP '}
    procedure netRecv_CmdUserState(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_CmdSituationBoardTabProperties(apRec: PAnsiChar; aSize: word);
    procedure netRecv_CmdChatUserRole(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_CmdOverlayShape(apRec: PAnsiChar; aSize: Word);
//    procedure netRecv_CmdClientStateInfo(apRec: PAnsiChar; aSize: word);
    {$ENDREGION}

    procedure FOnConnectDelay(sender: TObject);

  public
    constructor Create(Map : TMap);
    destructor Destroy; override;

    procedure GameStart; override;
    procedure GamePause; override;
    procedure GameTerminate; override;

    procedure InitNetwork; override;
    procedure StopNetwork;  override;

    procedure CreateThread;

    procedure PrepareNewScenario;

    procedure ClearBuffer;

    {$REGION ' Event Inherited '}
    procedure LoadConsoleID; override;
    procedure LoadDataAsset(const vSet: TGameDataSetting); override;

    procedure OnUserStateChange(const rec : TRecTCP_UserState); override;
    {$ENDREGION}

    procedure FNetServerOnClientConnect(const S: string);
    procedure FNetServerOnClientDisConnect(const S: string);

    property OnUpdateGameInfo: TOnUpdateGameInfo read FOnUpdateGameInfo  write FOnUpdateGameInfo;
    property OnUpdateGameState: TNotifyEvent read FOnUpdateGameState write FOnUpdateGameState;

    function  GetGameState: Boolean; override;

    property BroadcastData: boolean read getBroadcastData write setBroadcastData;

  end;

var
  simMgrServer: TSimMgr_Server;

implementation

uses
  uConsoleData, uNetHandle_Server, uMapXData, uTCPDatatype, uT3ServerEventManager, uSimObjects ;
{ TSimMgr_Server }


constructor TSimMgr_Server.Create(Map : TMap);
//var
//  i : Integer;
begin
  inherited;

  FNetSender := TDelayer.Create;
  FNetSender.Enabled := false;

  FNetSender.OnTime := NetSendUDP_BroadCast;
  FNetSender.DInterval := 1;  //  awalnya 0.5

  FConnectDelay := TDelayer.Create;

  with FConnectDelay do
  begin
    DInterval := 8.0;
    OnTime := FOnConnectDelay;
    Enabled := false;
  end;

  FSendCounter    := 0;

  EventManager    := TT3ServerEventManager.Create;
  SimManager := Self;
end;

procedure TSimMgr_Server.CreateThread;
begin
  FNetworkThreadTemp := TMSTimer.Create;
  FNetworkThreadTemp.Interval := 2;
  FNetworkThreadTemp.OnRunning := FNetworkThread_OnRunning;
  FNetworkThreadTemp.OnTerminate := FNetworkThread_OnTerminate;
  FNetworkThreadTemp.Enabled := True;
end;

destructor TSimMgr_Server.Destroy;
begin
  EventManager.Free;
  FNetSender.Free;

  inherited;
end;

procedure TSimMgr_Server.setBroadcastData(const Value: boolean);
begin
  FNetSender.Enabled := Value;
end;

function TSimMgr_Server.getBroadcastData: boolean;
begin
  result := FNetSender.Enabled;
end;

procedure TSimMgr_Server.FGameThread_OnRunning(const dt: double);
    procedure SlowDown ;
    begin // d
     
    end;

begin
  inherited;
  
  FConnectDelay.Run(dt);
end;

procedure TSimMgr_Server.FNetServerOnClientConnect(const S: string);
var
  consoleInfoTemp : TConsoleInfo;
begin
  consoleInfoTemp := SimConsole.GetConsoleInfo(s);

  if Assigned(consoleInfoTemp) then
    consoleInfoTemp.State := True;

  TT3ServerEventManager(EventManager).OnUpdateConsoleConnect;

end;

procedure TSimMgr_Server.FNetServerOnClientDisConnect(const S: string);
var
  consoleInfoTemp : TConsoleInfo;
  userRoleDataTemp : TUserRole;
  rec : TRecTCP_UserState;

begin
  consoleInfoTemp := SimConsole.GetConsoleInfo(s);

  if Assigned(consoleInfoTemp) then
  begin
    consoleInfoTemp.State := False;

    userRoleDataTemp := SimUserRole.getUserRoleByIPAddress(consoleInfoTemp.IPAddress);

    if Assigned(userRoleDataTemp) then
    begin
      rec.OrderID := CORD_ID_LOGOUT;
      rec.UserRoleId := userRoleDataTemp.FData.UserRoleIndex;
      rec.ConsoleIP := userRoleDataTemp.ConsoleIP;
      rec.UserRoleInUse := False;

      OnUserStateChange(rec);

      VNetServer.SendBroadcastCommand(CPID_CMD_USER_STATE, @rec);
    end;

  end;

  TT3ServerEventManager(EventManager).OnUpdateConsoleConnect;
end;

procedure TSimMgr_Server.FNetworkThread_OnRunning(const dt: double);
begin
  inherited;
  if Assigned(VNetServer) then
    VNetServer.GetPacket;
end;

procedure TSimMgr_Server.FOnConnectDelay(sender: TObject);
begin
  VNetServer.TryReconnect; // tcp only.
end;

procedure TSimMgr_Server.FGameThread_OnPaused(const dt: double);
begin

end;

procedure TSimMgr_Server.NetSendUDP_BroadCast(sender: TObject);
begin
  FSendCounter := (FSendCounter + 1) mod 2;
end;

procedure TSimMgr_Server.InitNetwork;
begin
  FNetSender.DCounter := 0;
  FNetSender.DInterval := vNetServerSetting.SendInterval;

  {$REGION ' UDP SECTION '}
//  VNetServer.RegisterUDPPacket(CPID_CMD_GAME_CTRL, SizeOf(TRecCmd_GameCtrl),nil);
//  VNetServer.RegisterUDPPacket(CPID_CMD_CLIENT_STATE_INFO, SizeOf(TRecUDP_ClientState_Info),nil);
  {$ENDREGION}

  {$REGION ' TCP SECTION '}
//  VNetServer.RegisterTCPPacket(CPID_CMD_CLIENT_STATE_INFO, SizeOf(TRecTCP_ClientState_Info), nil);
//  VNetServer.RegisterTCPPacket(CPID_CMD_GAME_CTRL, SizeOf(TRecCmd_GameCtrl),netRecv_CmdGameControl);
  VNetServer.RegisterTCPPacket(CPID_CMD_GAME_CTRL, SizeOf(TRecCmd_GameCtrl),nil);
  VNetServer.RegisterTCPPacket(CPID_CMD_USER_STATE, SizeOf(TRecTCP_UserState), netRecv_CmdUserState);
  VNetServer.RegisterTCPPacket(CPID_CMD_SITUATIONBOARD_TAB_PROPERTIES, SizeOf(TRecTCPSendSituationBoardTabProperties),netRecv_CmdSituationBoardTabProperties);
  VNetServer.RegisterTCPPacket(CPID_CMD_CHAT_USER_ROLE, SizeOf(TrecTCPSendChatUserRole), netRecv_CmdChatUserRole);
  VNetServer.RegisterTCPPacket(CPID_CMD_OVERLAYSHAPE, SizeOf(TRecTCPSendOverlayShape), netRecv_CmdOverlayShape);
  {$ENDREGION}

  VNetServer.StartListen;

  FConnectDelay.Enabled := true;
end;

function TSimMgr_Server.GetGameState: Boolean;
begin
  Result := inherited;
end;

procedure TSimMgr_Server.netRecv_CmdChatUserRole(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TrecTCPSendChatUserRole;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnUserRoleChatChange(rec^);

  VNetServer.SendBroadcastCommand(CPID_CMD_CHAT_USER_ROLE, apRec);

end;

procedure TSimMgr_Server.netRecv_CmdOverlayShape(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRecTCPSendOverlayShape;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnOverlayShape(rec^);

  VNetServer.SendBroadcastCommand(CPID_CMD_OVERLAYSHAPE, apRec);

end;

procedure TSimMgr_Server.netRecv_CmdSituationBoardTabProperties(apRec: PAnsiChar; aSize: word);
var
  rec : ^TRecTCPSendSituationBoardTabProperties;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnSituationBoardTabPropertiesChange(rec^);

  VNetServer.SendBroadcastCommand(CPID_CMD_SITUATIONBOARD_TAB_PROPERTIES, apRec);

end;

procedure TSimMgr_Server.netRecv_CmdUserState(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRecTCP_UserState;
  sIP : String;
begin
  rec := @apRec^;
  sIP := LongIp_To_StrIp(rec^.pid.ipSender);

  OnUserStateChange(rec^);

  VNetServer.SendBroadcastCommand(CPID_CMD_USER_STATE, apRec);
end;

procedure TSimMgr_Server.StopNetwork;
begin
  VNetServer.UnRegisterAllPacket;
end;

procedure TSimMgr_Server.GameStart;
begin
  inherited;

  if Assigned(FOnUpdateGameState) then
    FOnUpdateGameState(self);
end;

procedure TSimMgr_Server.GameTerminate;
begin
  inherited;

end;

procedure TSimMgr_Server.GamePause;
begin
  inherited;

  if Assigned(FOnUpdateGameState) then
    FOnUpdateGameState(self);
end;

procedure TSimMgr_Server.PrepareNewScenario;
begin
  FMainVTime.Reset();

end;

procedure TSimMgr_Server.ClearBuffer;
begin
  VNetServer.ClearDatabuufer;
end;

{$REGION ' Event Inherited '}

procedure TSimMgr_Server.LoadConsoleID;
begin
  inherited;

end;

procedure TSimMgr_Server.LoadDataAsset(const vSet: TGameDataSetting);
var
  i : Integer;
  listTemp : TList;
  userRoleTemp : TUserRole;

begin
  inherited;

  {$REGION ' Load User Role '}
//  listTemp := TList.Create;
//  dmINWO.GetAllUserRole(listTemp);
//
//  for i := 0 to listTemp.Count-1 do
//  begin
//    userRoleTemp := listTemp.Items[i];
//
//    dmINWO.GetSubRoleByID(userRoleTemp.FData.SubRoleIndex, userRoleTemp.FSubRoleData);
//
//    if Assigned(userRoleTemp) then
//    begin
//      SimUserRole.addUserRole(userRoleTemp);
//    end;
//  end;
//  listTemp.Free;
  {$ENDREGION}
end;

procedure TSimMgr_Server.OnUserStateChange(const rec: TRecTCP_UserState);
begin
  inherited;
  TT3ServerEventManager(EventManager).OnUpdateUserStateChange(rec.OrderID);
end;

{$ENDREGION}

end.

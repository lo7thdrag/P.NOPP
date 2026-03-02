unit uNetClient_Mgr;

{ simple network client for Tactical team trainer.

}

interface

uses
  Classes, uT3NetPlatform, uTCPclient, uThreadTimer;

type

  TGamePlayState = (gsStop, gsPlaying, gsTerminated );
  TGameStateChange = procedure(const newState: TGamePlayState) of object;

  TNotifyPlatform = procedure(const selPID: integer)of object;

  TNetClient_Mgr = class
  private
    FTimer            : TMSTimer;

    FPlatformList     : TStringList;
    FSessionID        : integer;
    FOnNetLog         : TGetStrProc;
    FGameState        : TGamePlayState;
    FOnGameStateChange: TGameStateChange;

    function getPlatform(index: integer): TT3NetPlatform;
    function getPlatformCount: integer;

    procedure tmr_OnRunning(const dt: double);

  private
    FTimeFlag   : integer;
    FOnConnected: TNotifyEvent;
    FOnDisConnected: TNotifyEvent;

    FVoipCtrlClient : TTCPClient;
    FShouldConnect: boolean;
    FOnPlatformSelected: TNotifyPlatform;
    FOnGetMovementData : TNotifyPlatform;
    FOnCtrlConnected: TNotifyEvent;
    FOnCtrlDisConnected: TNotifyEvent;

    // udp packet handler

    procedure netRecv_PlatformMovement(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_GameTime(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_GameControlInfo(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_CmdGameControl(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_VoipCtrl(apRec: PAnsiChar; aSize: Word);

    procedure netOnConnected(sender: TObject);
    procedure netOnDisConnected(sender: TObject);

    //tcp packet handler

  public

    constructor Create;
    destructor Destroy; override;

    procedure InitNetwork;
    procedure StopNetwork;

    function getPlatformInstanceByID(const pid: integer): TT3NetPlatform;
    function getDistance(const pid1, pid2: integer): double;

  public
    VoipCtrlAddress: string;
    VoipCtrlPort   : Word;

    property OnNetLog: TGetStrProc read FOnNetLog write FOnNetLog;

    property PlatformCount: integer read getPlatformCount;
    property Platforms [index: integer]: TT3NetPlatform read getPlatform;

    property GameState: TGamePlayState read FGameState;

    property OnGameStateChange: TGameStateChange read FOnGameStateChange
     write FOnGameStateChange;

    property OnConnected: TNotifyEvent         // to gameServer
      read FOnConnected write FOnConnected;

    property OnDisConnected: TNotifyEvent
      read FOnDisConnected write FOnDisConnected;

    property OnCtrlConnected: TNotifyEvent         // to gameServer
      read FOnCtrlConnected write FOnCtrlConnected;

    property OnCtrlDisConnected: TNotifyEvent
      read FOnCtrlDisConnected write FOnCtrlDisConnected;

    property OnPlatformSelected: TNotifyPlatform
      read FOnPlatformSelected write FOnPlatformSelected;

    property OnGetMovementData: TNotifyPlatform
      read FOnGetMovementData write FOnGetMovementData;

  end;


procedure StartClient;
procedure EndClient;

var
  netMgr :  TNetClient_Mgr;


implementation

uses
  SysUtils, uNetHandle_Client, uGameData_TTT, uLibSettingTTT, uBaseCoordSystem ;

procedure StartClient;
begin

  vSettingFile := getFileSetting;

  LoadFF_NetSetting(vSettingFile, vNetSetting);
  LoadFF_NetClientSetting(vSettingFile, vNetClientSetting);

  LoadFF_GameSetting(vSettingFile, vGameDataSetting);

  VNetClient  := TNetHandler_Client.Create;
  VNetClient.ServerIP         := vNetClientSetting.ServerIP;
  VNetClient.GamePort         := vNetSetting.GamePort;
  VNetClient.BroadCastAddress := vNetSetting.GameAddress;
  VNetClient.CommandPort      := vNetSetting.CommandPort;


  netMgr      := TNetClient_Mgr.Create;
  netMgr.FSessionID := vGameDataSetting.GameSessionID;

  netMgr.VoipCtrlAddress  := vNetSetting.VoipCtrlAddress;
  netMgr.VoipCtrlPort     := vNetSetting.VoipCtrlPort;

end;

procedure EndClient;
begin

  netMgr.Free;

  VNetClient.Free;

end;
//==============================================================================

procedure ClearAndFreeItems(var sl: TStringList);
var
  i: integer;
  o: TObject;
begin
  for i := sl.Count - 1 downto 0 do begin
    o := sl.Objects[i];
    o.Free;
  end;
  sl.Clear;
end;


//==============================================================================

constructor TNetClient_Mgr.Create;
begin
  inherited;
  FTimer            := TMSTimer.Create;
  FTimer.Interval   := 4000;
  FTimer.OnRunning  := tmr_OnRunning;
  FTimer.Enabled    := false;

  FPlatformList := TStringList.Create;
  FPlatformList.Sorted := true;

  FVoipCtrlClient := TTCPClient.Create;

end;

destructor TNetClient_Mgr.Destroy;
begin
  ClearAndFreeItems(FPlatformList);
  FVoipCtrlClient.Free;

  inherited;
end;

procedure TNetClient_Mgr.InitNetwork;
begin

  VNetClient.RegisterUDPPacket(CPID_PLATFORM_MOVE, SizeOf(TRecUDP_PlatformMovement),
     netRecv_PlatformMovement );

  VNetClient.RegisterUDPPacket(CPID_GAMETIME,
    SizeOf(TRecUDP_GameTime),
    netRecv_GameTime);

  VNetClient.RegisterUDPPacket(CPID_UDP_GAMECTRL_INFO,
    SizeOf(TRecUDP_GameCtrl_Info),
    netRecv_GameControlInfo);

  VNetClient.RegisterUDPPacket(CPID_CMD_GAME_CTRL, SizeOf(TRecCmd_GameCtrl),
    netRecv_CmdGameControl);

// - - - -

  VNetClient.RegisterTCPPacket(CPID_TCP_REQUEST, SizeOf(TRecTCP_Request),
    nil);

  VNetClient.OnConnected    :=  netOnConnected;
  VNetClient.OnDisConnected :=  netOnDisConnected;

  FOnCtrlConnected    := FVoipCtrlClient.OnConnected;
  FOnCtrlDisConnected := FVoipCtrlClient.OnDisConnected;

  FVoipCtrlClient.RegisterProcedure(CPID_VOIP_PLATFORM_SELECT,
    netRecv_VoipCtrl,
    SizeOf(TRecVoip_SelectPlatform));

  FVoipCtrlClient.Connect(VoipCtrlAddress, IntToStr(VoipCtrlPort));

  FTimer.Enabled    := true;

end;

procedure TNetClient_Mgr.StopNetwork;
begin
  FTimer.Enabled := false;
  VNetClient.UnRegisterUDP;

end;

procedure TNetClient_Mgr.tmr_OnRunning(const dt: double);
begin
  VNetClient.TryReconnect;  // connect to game server for requesting session

  if not FVoipCtrlClient.Connected then begin
    FVoipCtrlClient.Connect(VoipCtrlAddress, IntToStr(VoipCtrlPort));
  end;

end;


procedure TNetClient_Mgr.netRecv_PlatformMovement(apRec: PAnsiChar; aSize: Word);
var rec : ^TRecUDP_PlatformMovement;
    pi  : TT3NetPlatform;
    sPID: string;
    i: integer;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    exit;

  sPID := IntToStr(rec^.PlatformID);

  if FPlatformList.Find(sPID, i) then begin
    pi := FPlatformList.Objects[i] as TT3NetPlatform;

  end
  else begin
    pi := TT3NetPlatform.Create;
    pi.MovementData.PlatformID := rec^.PlatformID;
    FPlatformList.AddObject(sPID, pi);
  end;

  pi.MovementData.X  := rec^.X;
  pi.MovementData.Y  := rec^.Y;
  pi.MovementData.Z  := rec^.Z;
  pi.MovementData.Course  := rec^.Course;
  pi.MovementData.Speed   := rec^.Speed;

  if Assigned(FOnNetLog) then
    FOnNetLog(getRecString(rec^));

  if Assigned(FOnGetMovementData) then
    FOnGetMovementData(rec^.PlatformID);
end;

procedure TNetClient_Mgr.netRecv_GameTime(apRec: PAnsiChar; aSize: Word);
begin

end;

procedure TNetClient_Mgr.netRecv_GameControlInfo(apRec: PAnsiChar; aSize: Word);
var rec: ^TRecUDP_GameCtrl_Info;
    dtNow : LongWord;
    dt: integer;
    gs : TGamePlayState;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    exit;

  gs := TGamePlayState(rec^.GameState);

  if gs <> GameState then begin
     FGameState := gs;

     if Assigned(FOnGameStateChange) then
       FOnGameStateChange(gs);
{     case gs of
      gsStop        : GamePause;
      gsPlaying     : GameStart;
//      gsTerminated  : GameTerminate;
     end;}
  end;


end;

procedure TNetClient_Mgr.netRecv_CmdGameControl(apRec: PAnsiChar; aSize: Word);
var r: ^TRecCmd_GameCtrl;
begin
  r := @apRec^;
  case r^.GameCtrl of
  CORD_ID_start       : begin
    if (FGameState <> gsPlaying) then begin

      if Assigned(FOnGameStateChange) then
        FOnGameStateChange(gsPlaying);

      FGameState := gsPlaying;
    end;
  end;

  CORD_ID_pause       : begin
    if (FGameState <> gsStop) then begin

      if Assigned(FOnGameStateChange) then
       FOnGameStateChange(gsStop);

      FGameState := gsStop;
    end;
  end;

  CORD_ID_game_speed  : begin;
//      GameSPEED :=  r^.GameSpeed;
    end;
  end;
end;

procedure TNetClient_Mgr.netRecv_VoipCtrl(apRec: PAnsiChar; aSize: Word);
var r: ^TRecVoip_SelectPlatform;
begin
  r := @apRec^;

  if (r^.PlatfomID = -1) or (getPlatformInstanceByID(r^.PlatfomID) <> nil) then
    if Assigned(FOnPlatformSelected) then FOnPlatformSelected(r^.PlatfomID);

end;

procedure TNetClient_Mgr.netOnConnected(sender: TObject);
var rec : TRecTCP_Request;
begin
  // ini karena dibales lewat udp, maka perlu 'paket id' tambahan
  // untuk memastikan paket yg diproses adalah paket hasil request sendiri.
  // 'sync time'

  rec.reqID     := REQ_SYNCH_GAMECTRL_INFO;
  FTimeFlag     := Random($ffff);
  rec.reqParam  := 0;
  rec.reqFlag   := FTimeFlag;

  VNetClient.SendCommand(CPID_TCP_REQUEST, @rec);

  if Assigned(FOnConnected)  then
    FOnConnected(sender);
end;

procedure TNetClient_Mgr.netOnDisConnected(sender: TObject);
begin
  if Assigned(FOnDisConnected)  then
    FOnDisConnected(sender);
end;


function TNetClient_Mgr.getPlatformInstanceByID(
  const pid: integer): TT3NetPlatform;
var i: integer;
begin
  if FPlatformList.Find(IntToStr(pid), i) then
    result := FPlatformList.Objects[i] as TT3NetPlatform
  else
    result := nil;

end;

function TNetClient_Mgr.getPlatform(index: integer): TT3NetPlatform;
begin
  if (index >= 0) and (index < FPlatformList.Count) then
    result := FPlatformList.Objects[index] as TT3NetPlatform
  else
    result := nil;
end;

function TNetClient_Mgr.getPlatformCount: integer;
begin
   result := FPlatformList.Count;
end;


function TNetClient_Mgr.getDistance(const pid1, pid2: integer): double;
var p1, p2: TT3NetPlatform;
begin
  p1 := getPlatformInstanceByID(pid1);
  p2 := getPlatformInstanceByID(pid2);

  if (p1 <> nil) and (p2 <> nil) then begin
//    result := trueDistance(p1.MovementData.X, p1.MovementData.Y,
//                           p2.MovementData.X, p2.MovementData.Y)
    result := CalcRange(p1.MovementData.X, p1.MovementData.Y,
                           p2.MovementData.X, p2.MovementData.Y)

  end
  else
    result := -1.0;

end;


end.


unit uSessionSvrMain;

interface

uses

  Classes, OverbyteIcsWSocket, uTCPServer, uPacketBuffer, uNetSessionData,
  uSessionData, uExecuter;

type

  TSessionSvrMan = class(TSessionMan)
  private
  protected
    FPortListen: string;


    FOnClientConnect    : TGetStrProc;
    FOnClientDisConnect : TGetStrProc;
    FSessionSetterIP : string;
//    procedure netOnRecv_(apRec: PAnsiChar; aSize: Word);

    procedure netOnRecv_Request (apRec: PAnsiChar; aSize: Word);

    procedure netOnRecv_Session (apRec: PAnsiChar; aSize: Word);
    procedure netOnRecv_Scenario(apRec: PAnsiChar; aSize: Word);

    procedure netSendSessionData(const ipAdd: string='');  //   ''-> broadcast
    procedure netSendScenarioData(const ipAdd: string=''); //   ''-> broadcast


    procedure ServerClientConnect(const sClientIp: string);
    procedure ServerClientDisConnect(const sClientIp: string);

  public
    FTCPServer : TTCPServer;

  public

    constructor Create;
    destructor Destroy; override;

    procedure  ApplySetting; override;

    procedure StartNetworking; override;
    procedure StopNetworking; override;

    procedure SetSessionState(const ssState: TSessionState); override;
    function SetScenario(const scID: Integer): boolean; override;

    procedure SendUpdateSession(const ssState: TSessionState);
    procedure SendUpdateScenario(const scID: Integer);


  public

    property OnClientConnect: TGetStrProc read FOnClientConnect
       write FOnClientConnect;

    property OnClientDisConnect: TGetStrProc read FOnClientDisConnect
      write FOnClientDisConnect;


  end;

  procedure BeginServer;
  procedure EndServer;

var
  theServer : TSessionSvrMan;


implementation

uses
  uLibSettingTTT, SysUtils, uTCPDatatype, Windows;

{ TSessionMan }

procedure BeginServer;
begin
  vSettingFile := getFileSetting;
  LoadFF_NetSetting(vSettingFile, vNetSetting);
  LoadFF_AppSetting(vSettingFile, vAppSetting);

  theServer := TSessionSvrMan.Create;
end;

procedure EndServer;
begin

  theServer.Free;
end;

constructor TSessionSvrMan.Create;
begin
  inherited;

  FTCPServer := TTCPServer.Create;

  FTCPServer.OnStateChange        := socketChangeState;
  FTCPServer.OnClient_Connect     := ServerClientConnect;
  FTCPServer.OnClient_DisConnect  := ServerClientDisConnect;

end;

destructor TSessionSvrMan.Destroy;
begin
  FTCPServer.Free;


//  FNetBuff.Free;

  inherited;
end;

procedure TSessionSvrMan.ApplySetting;
begin
  //warning: using global var

  FPortListen := IntTostr(vNetSetting.SessionPort);

  FAppGame.FExecFname   := vAppSetting.GameServerName;
  FAppDBEdit.FExecFname := vAppSetting.DBEditServerName;

  if vNetSetting.AutoStart then
    StartNetworking;

end;

// === networking app ==========================================================

procedure TSessionSvrMan.ServerClientConnect(const sClientIp: string);
begin
  if Assigned(FOnClientConnect) then FOnClientConnect(sClientIp);

end;

procedure TSessionSvrMan.ServerClientDisConnect(const sClientIp: string);
begin
  if Assigned(FOnClientDisConnect) then FOnClientDisConnect(sClientIp);

end;

procedure TSessionSvrMan.StartNetworking;
begin

  FTCPServer.RegisterProcedure(CPID_REQ,          netOnRecv_Request,
    SizeOf(TRecRequest));
  FTCPServer.RegisterProcedure(CPID_SESSIONSTATE, netOnRecv_Session,
    SizeOf(TRecSessionState));
  FTCPServer.RegisterProcedure(CPID_SCENARIO,     netOnRecv_Scenario,
    SizeOf(TRecScenario));

  FTCPServer.Listen(FPortListen);
end;

procedure TSessionSvrMan.StopNetworking;
begin
//  FTCPServer.CloseSocket;

  FTCPServer.Stop;
  FTCPServer.UnregisterAllProcedure;

end;

procedure TSessionSvrMan.SetSessionState(const ssState: TSessionState);
begin
  inherited;

end;

function TSessionSvrMan.SetScenario(const scID: Integer): boolean;
begin
  // bisa set scenario kalo session lagi play atau edit;
  // klo sudah ada yg set scenario id, tidak boleh langsung di ganti .
  Result := False;
  if FSessionVar.SessionStat <> ssOff then begin
    if FSessionVar.ScenarioID = -1 then begin

      FSessionVar.ScenarioID := scId;
      Result := True;

      if Assigned(FOnScenarioChange) then
         FOnScenarioChange(scID);
    end;
  end;
end;

procedure TSessionSvrMan.SendUpdateSession(const ssState: TSessionState);
var rec: TRecSessionState;
begin
  rec.Order        := CID_UPDATE;
  rec.SessionStat  := Byte(ssState);

  FTCPServer.SendDataALL(CPID_SESSIONSTATE, @rec);
end;

procedure TSessionSvrMan.SendUpdateScenario(const scID: Integer);
var rec: TRecScenario;
begin
  rec.Order        := CID_UPDATE;
  rec.ScenarioID   := scID;

  FTCPServer.SendDataALL(CPID_SCENARIO, @rec);
end;

procedure TSessionSvrMan.netOnRecv_Request(apRec: PAnsiChar; aSize: Word);
{  a single user request something }
var req: ^TRecRequest;
    reqID: Word;
    strIP: string;
begin
  req := @aprec^;

  reqID := req^.RequestID;
  strIP := LongIp_To_StrIp(req^.pid.ipSender);

  case reqID of
    CREQID_SESSION: begin

      netSendSessionData(strIP);
    end;
    CREQID_SCENARIO: begin
      netSendScenarioData(strIP);

    end;
  end;

end;

procedure TSessionSvrMan.netOnRecv_Session(apRec: PAnsiChar; aSize: Word);
var rec  : ^TRecSessionState;
    strIP: string;
    sState : TSessionState;
begin
  rec := @aprec^;

  if rec^.Order = CID_UPDATE  then begin
    strIP := LongIp_To_StrIp(rec^.pid.ipSender);
    //if in authorize user then then
    sState := TSessionState(rec^.SessionStat);
    if sState <> FSessionVar.SessionStat then begin
       SetSessionState(sState);

       FSessionSetterIP := strIP;

       netSendSessionData();

    end;
  end
end;

procedure TSessionSvrMan.netOnRecv_Scenario (apRec: PAnsiChar; aSize: Word);
var rec  : ^TRecScenario;
    strIP: string;
    scID : Integer;
begin //
  rec := @aprec^;
  if rec^.Order = CID_UPDATE  then begin
    strIP := LongIp_To_StrIp(rec^.pid.ipSender);
    //if in authorize user then then update the scenarioID n notify other user
    if strIP = FSessionSetterIP then begin
      scID := rec^.ScenarioID;
      if scID <> FSessionVar.ScenarioID then begin
        if SetScenario(scID) then begin

          netSendScenarioData();
        end;
      end;
    end;
  end;
end;

procedure TSessionSvrMan.netSendSessionData(const ipAdd: string);
var rsSession:  TRecSessionState;
begin
  rsSession.Order       := CID_INFO;
  rsSession.SessionStat := Byte(FSessionVar.SessionStat);

  if ipAdd = '' then
    FTCPServer.SendDataALL(CPID_SESSIONSTATE, @rsSession)
  else
    FTCPServer.SendDataToIPAddress(CPID_SESSIONSTATE, @rsSession, ipAdd  );
end;

procedure TSessionSvrMan.netSendScenarioData(const ipAdd: string);
var rSce : TRecScenario;
begin
  rSce.Order      := CID_INFO;
  rSce.ScenarioID := FSessionVar.ScenarioID;

  if ipAdd = '' then
    FTCPServer.SendDataALL(CPID_SCENARIO, @rSce)
  else
    FTCPServer.SendDataToIPAddress(CPID_SCENARIO, @rSce, ipAdd);

end;


end.

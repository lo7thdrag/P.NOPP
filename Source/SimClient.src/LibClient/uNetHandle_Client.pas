unit uNetHandle_Client;

interface

uses
   Classes, SysUtils, OverbyteIcsWSocket,
   uTCPClient, uNetHandle_TTT;

type
  TOnFinishBuffer = procedure(const b : Boolean) of object;

//==============================================================================
  TNetHandler_Client = class(TNetHandle_TTT)
  private
    FLogRecv: TGetStrProc;
    FOnFinishBuffer: TOnFinishBuffer;
    FGameCtrl: Word;
    function getOnConnected: TNotifyEvent;
    procedure setOnConnected(const Value: TNotifyEvent);

    function getOnDisConnected: TNotifyEvent;
    procedure setOnDisConnected(const Value: TNotifyEvent);
    procedure SetOnReceivedLog(const Value: TGetStrProc);
    function getOnReceivedLog: TGetStrProc;
    procedure setLogRcv(const Value: TGetStrProc);
    procedure setFinishBuffer(const Value: TOnFinishBuffer);

  protected
    FUseDebug : Boolean;
    FNetClient: TTCPClient;

  public

    constructor Create;
    destructor Destroy; override;

    procedure StartNetworking; override;
    procedure StopNetworking;  override;

    procedure SendCommand(const aID: word; aBuffer: PAnsiChar);
    procedure SendUDPRequest(const aID: word; aBuffer: PAnsiChar);


    procedure TryReconnect();

  public
    ServerIP: string;

    procedure getPacket();

  public
    property OnConnected: TNotifyEvent read getOnConnected write setOnConnected;
    property OnDisConnected: TNotifyEvent read getOnDisConnected write setOnDisConnected;
    property OnReceivedLog : TGetStrProc read getOnReceivedLog write setOnReceivedLog;
    property OnLogRecv : TGetStrProc read FLogRecv write setLogRcv;
    property OnFinishBuffer : TOnFinishBuffer read FOnFinishBuffer write setFinishBuffer;
    property GameCtrl : Word read FGameCtrl write FGameCtrl;
  end;

var
  VNetClient: TNetHandler_Client;

implementation

uses
  uTCPDatatype;
{ TNetHandlerServer }


constructor TNetHandler_Client.Create;
begin
  inherited;

  FGameCtrl := 2;
  FUseDebug := false;
end;

destructor TNetHandler_Client.Destroy;
begin

end;

function TNetHandler_Client.getOnConnected: TNotifyEvent;
begin
  result := FNetClient.OnConnected;
end;


//function TNetHandler_Client.getOnConnectedVBS: TNotifyEvent;
//begin
//  Result := FNetClientVBS.OnConnected;
//end;

procedure TNetHandler_Client.setFinishBuffer(const Value: TOnFinishBuffer);
begin
  FOnFinishBuffer := Value;
  FNetClient.OnFinishBuffer := Value;
end;

procedure TNetHandler_Client.setLogRcv(const Value: TGetStrProc);
begin
  FLogRecv := Value;
  FNetClient.OnlogRecv := Value;
end;

procedure TNetHandler_Client.setOnConnected(const Value: TNotifyEvent);
begin
  FNetClient.OnConnected := Value;
end;

//procedure TNetHandler_Client.setOnConnectedVBS(const Value: TNotifyEvent);
//begin
//  FNetClientVBS.OnConnected := Value;
//end;

function TNetHandler_Client.getOnDisConnected: TNotifyEvent;
begin
  result := FNetClient.OnDisConnected;
end;

//function TNetHandler_Client.getOnDisConnectedVBS: TNotifyEvent;
//begin
//  Result := FNetClientVBS.OnDisConnected;
//end;

function TNetHandler_Client.getOnReceivedLog: TGetStrProc;
begin
  //result :=  FNetTCPSock.OnGetRecvLog;
end;

procedure TNetHandler_Client.getPacket;
begin
  FNetClient.GetPacket;
  //FNetClientVBS.GetPacket;
end;

//procedure TNetHandler_Client.getPacketVBS;
//begin
//  FNetClientVBS.GetPacket;
//end;

procedure TNetHandler_Client.setOnDisConnected(const Value: TNotifyEvent);
begin
  FNetClient.OnDisConnected := Value;
end;

//procedure TNetHandler_Client.setOnDisConnectedVBS(const Value: TNotifyEvent);
//begin
//  FNetClientVBS.OnDisConnected := Value;
//end;

{procedprocedure TNetHandler_Client.setOnDisConnectedVBS(const Value: TNotifyEvent);
begin

end;

ure TNetMgr_Client.FNetClient_OnStateChange(st: TSocketState);
begin
  if FUseDebug then begin

    FrmDebugNet.Add_NetStatusLog(SockStateToString(st));
  end;
end;
}


procedure TNetHandler_Client.SetOnReceivedLog(const Value: TGetStrProc);
begin
//  FNetTCPSock.OnGetRecvLog := Value;
//  FNetUDPNode.OnGetRecvLog := Value;
end;

procedure TNetHandler_Client.StartNetworking;
begin
  inherited;

  FNetClient    := TTCPClient.Create;
  FNetTCPSock   := FNetClient;
//  FNetClientVBS := TTCPClient.Create;
//  FNetTCPSockVBS := FNetClientVBS;

//  FNetUDPNode.Listen(IntToStr(GamePort));
  FNetClient.Connect(ServerIP, IntToStr(CommandPort));
//  FNetClientVBS.Connect(ServerIP, IntToStr(VBSPort));

end;

procedure TNetHandler_Client.StopNetworking;
begin
//  FNetClientVBS.Disconnect;
//  FNetClientVBS.Free;
  FNetClient.Disconnect;
  FNetClient.Free;


  inherited;
end;

procedure TNetHandler_Client.TryReconnect;
begin
  if not FNetClient.Connected then
    FNetClient.Connect(ServerIP, IntToStr(CommandPort));

//  if not FNetClientVBS.Connected then
//    FNetClientVBS.Connect(ServerIP, IntToStr(VBSPort));
end;

//==============================================================================

procedure TNetHandler_Client.SendCommand(const aID: word; aBuffer: PAnsiChar);
var pid: ^TPacketID;
begin
  pid := @aBuffer^;
   pid.ipSender := FNetClient.MyLongIP;

  if (GameCtrl <> 2) or (aID = 59) or (aID = 130) or (aID = 67) or (aID = 60)
    or (aID = 187) then
    FNetClient.SendData(aID, aBuffer);
end;

procedure TNetHandler_Client.SendUDPRequest(const aID: word; aBuffer: PAnsiChar);
var pid: ^TPacketID;
begin
  pid := @aBuffer^;
  pid.ipSender := FNetClient.MyLongIP;

  if (GameCtrl <> 2) or (aID = 59) then
    FNetUDPNode.SendDataTo(ServerIP, aID, aBuffer);
end;


end.


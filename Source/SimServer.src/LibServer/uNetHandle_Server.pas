unit uNetHandle_Server;

interface

uses
  Classes, SysUtils, OverbyteIcsWSocket,
  uNetUDPnode, uPacketRegister, uPacketBuffer,
  uTCPServer, uTCPClient,
  uNetHandle_TTT;

type

//==============================================================================

  TNetHandle_Server = class(TNetHandle_TTT)
  private
    FOnClientConnect: TGetStrProc;
    FOnClientDisConnect: TGetStrProc;
//    FOnClientVBSConnect: TGetStrProc;
//    FOnClientVBSDisConnect: TGetStrProc;
    FOnConnectedToSession: TNotifyEvent;
    FLogRecv: TGetStrProc;

    procedure FNetServer_OnClientConnect(const S: string);
    procedure FNetServer_OnClientDisConnect(const S: string);
//    procedure FNetServer_OnClientVBSConnect(const S: string);
//    procedure FNetServer_OnClientVBSDisConnect(const S: string);
    procedure FNetClient_OnConnected(sender: TObject);
    procedure SetLogRecv(const Value: TGetStrProc);
    function getLongIP: Cardinal;
  protected
    FUseDebug : Boolean;
    FOnline   : boolean;
    FNetTCPServer: TTCPServer;
    FNetTCPClient: TTCPClient;
//    FNetTCPStub  : TTCPClient;
//    FNetTCPVBS : TTCPServer;
    FSentBuffer : TPacketBuffer;

  public
    SessionServerIP: string;
    SessionPort    : integer;

    constructor Create;
    destructor Destroy; override;

    procedure StartNetworking; override;
    procedure StopNetworking;  override;

    procedure StartListen;
    procedure StopListen;

    procedure ConnectToSessionServer();
    procedure DisconnectFromSessionServer;

    procedure SendTo(const aID: word; aBuffer: PAnsiChar; const ip: string);
    procedure SendBroadcast_UDP_Data(const aID: word; aBuffer: PAnsiChar; putPacket : boolean = true);
    procedure SendUDP_To(const aID: word; aBuffer: PAnsiChar; const ip: string);
    procedure SendBroadcastCommand(const aID: word; aBuffer: PAnsiChar);
//    procedure SendBroadcastCommandVBS(const aID: word; aBuffer: PAnsiChar);
    procedure SendAlmostBroadcastCommand(const aID: word; aBuffer: PAnsiChar; const noIP: string);

    procedure RegisterSessionPacket(const aType, aRecSize: word; aProcedure: TRegPacketHandlerProc);

    procedure SendRequestToSession(const aID: word; aBuffer: PAnsiChar);
//    procedure SendRequestMapStub(const aID: word; aBuffer: PAnsiChar);
    procedure SendAllSentTo(const toIP: string);

    procedure ClearSentBuffer;
    procedure TryReconnect();
//    procedure RegisterTCPMapStubPacket(const aType, aRecSize: word; aProcedure: TRegPacketHandlerProc);

    procedure ClearDatabuufer();
    procedure GetPacket();

    property OnClientConnect: TGetStrProc read FOnClientConnect write FOnClientConnect;
    property OnClientDisConnect: TGetStrProc read FOnClientDisConnect write FOnClientDisConnect;

    property OnConnectedToSession: TNotifyEvent read FOnConnectedToSession write FOnConnectedToSession;
    property Online: boolean read FOnline;
    property PacketBuffer : TPacketBuffer read FSentBuffer;

    property OnlogRecv: TGetStrProc read FLogRecv write SetLogRecv;
    property LongIP : Cardinal read getLongIP;
  end;

var
  VNetServer: TNetHandle_Server;

implementation

uses
 uTCPDatatype, uRecordData;

{ TNetHandlerServer }


constructor TNetHandle_Server.Create;
begin
  inherited;

  FSentBuffer := TPacketBuffer.Create;

end;

destructor TNetHandle_Server.Destroy;
begin

  FSentBuffer.Free;

  inherited;
end;

procedure TNetHandle_Server.FNetServer_OnClientConnect(const S: string);
begin
  if Assigned(FOnClientConnect) then
    FOnClientConnect(s);
end;

procedure TNetHandle_Server.FNetServer_OnClientDisConnect(const S: string);
begin
  if Assigned(FOnClientDisConnect) then
    FOnClientDisConnect(s);
end;

//procedure TNetHandle_Server.FNetServer_OnClientVBSConnect(const S: string);
//begin
//  if Assigned(FOnClientVBSConnect) then
//    FOnClientVBSConnect(s);
//end;

//procedure TNetHandle_Server.FNetServer_OnClientVBSDisConnect(const S: string);
//begin
//  if Assigned(FOnClientVBSDisConnect) then
//    FOnClientVBSDisConnect(s);
//end;

function TNetHandle_Server.getLongIP: Cardinal;
begin
  Result := FNetTCPServer.LongIP;
end;

procedure TNetHandle_Server.GetPacket;
begin
  if Assigned(FNetTCPServer) then
    FNetTCPServer.getPacket;

  if Assigned(FNetTCPClient) then
    FNetTCPClient.GetPacket;

//  if Assigned(FNetTCPStub) then
//    FNetTCPStub.GetPacket;

end;

procedure TNetHandle_Server.FNetClient_OnConnected(sender: TObject);
begin
  // gameserver connected to session server;
  if Assigned(FOnConnectedToSession) then
    FOnConnectedToSession(sender);
end;


procedure TNetHandle_Server.StartNetworking;
begin
  inherited;

  FNetTCPServer := TTCPServer.Create;
  FNetTCPSock   := FNetTCPServer;

  FNetTCPServer.OnClient_Connect     := FNetServer_OnClientConnect;
  FNetTCPServer.OnClient_DisConnect  := FNetServer_OnClientDisConnect;

  FNetTCPClient := TTCPClient.Create;
  FNetTCPClient.OnConnected  := FNetClient_OnConnected;

  FSentBuffer.Clear;
end;

procedure TNetHandle_Server.StopNetworking;
begin
  inherited;

  FSentBuffer.Clear;
//  FNetTCPVBS.Stop;
//  FNetTCPVBS.Free;

//  FNetTCPStub.Disconnect;
//  FNetTCPStub.Free;

  FNetTCPClient.Disconnect;
  FNetTCPClient.Free;

  FNetTCPServer.Stop;
  FNetTCPServer.Free;
//   FNetSock := nil;

  //inherited;
end;

procedure TNetHandle_Server.TryReconnect;
begin
//  if not Assigned(FNetTCPStub) then exit;
//
//  if not FNetTCPStub.Connected then
//    FNetTCPStub.Connect(StubAddr, IntToStr(StubPort));
end;

procedure TNetHandle_Server.StartListen;
begin
  FOnline := true;

//  FNetUDPNode.Connect();
  FNetTCPServer.Listen(IntToStr(CommandPort));
end;

procedure TNetHandle_Server.StopListen;
begin
//  FNetUDPNode.Close;
  FNetTCPServer.Stop;

  FOnline := false;
end;

procedure TNetHandle_Server.SendTo(const aID: word; aBuffer: PAnsiChar; const ip: string);
var
  pid: ^TPacketID;
begin
  FNetTCPServer.SendDataToIPAddress(aID, aBuffer, ip);

  pid := @aBuffer^;
  pid^.ipReceiver := StrIp_To_LongIp(ip);

  FSentBuffer.PutPacket(aBuffer, pid^.recSize);
end;

procedure TNetHandle_Server.SendBroadcast_UDP_Data(const aID: word; aBuffer: PAnsiChar; putPacket : boolean = true);
var pid: ^TPacketID;
begin

  FNetUDPNode.SendDataTo(BroadCastAddress, aID, aBuffer);

  pid := @aBuffer^;
  pid^.ipReceiver := FLongIpBC;

  if putPacket then
    FSentBuffer.PutPacket(aBuffer, pid^.recSize);
end;

procedure TNetHandle_Server.SendUDP_To(const aID: word; aBuffer: PAnsiChar;
      const ip: string);
var pid: ^TPacketID;
begin
  FNetUDPNode.SendDataTo(ip, aID, aBuffer );

  pid := @aBuffer^;

  pid^.ipReceiver := StrIp_To_LongIp(ip);
  FSentBuffer.PutPacket(aBuffer, pid^.recSize);
end;

procedure TNetHandle_Server.SetLogRecv(const Value: TGetStrProc);
begin
  FLogRecv := Value;
  FNetTCPServer.OnlogRecv := Value;
  FNetTCPClient.OnlogRecv := Value;
//  FNetTCPVBS.OnlogRecv := Value;
end;

procedure TNetHandle_Server.SendBroadcastCommand(const aID: word; aBuffer: PAnsiChar);
var pid: ^TPacketID;
// Size : Integer;
begin
  if Assigned(FNetTCPServer) then
  begin
    FNetTCPServer.SendData(aID, aBuffer);
   // FNetTCPVBS.SendData(aID, aBuffer);

    pid := @aBuffer^;

    pid^.ipReceiver := FLongIpBC;
    FSentBuffer.PutPacket(aBuffer, pid^.recSize);
  end;
end;

//procedure TNetHandle_Server.SendBroadcastCommandVBS(const aID: word; aBuffer: PAnsiChar);
//var pid: ^TPacketID;
//begin
////  FNetTCPVBS.SendData(aID, aBuffer);
//end;

procedure TNetHandle_Server.SendAlmostBroadcastCommand(const aID: word;
  aBuffer: PAnsiChar; const noIP: string);
var pid: ^TPacketID;
begin
  if Assigned(FNetTCPServer) then
  begin
    FNetTCPServer.SendDataExceptThis(aID, aBuffer, noIP);

    pid := @aBuffer^;

    pid^.ipReceiver := FLongIpBC;
    FSentBuffer.PutPacket(aBuffer, pid^.recSize);
  end;
end;

//------------------------------------------------------------------------------
procedure TNetHandle_Server.RegisterSessionPacket(const aType, aRecSize: word;
      aProcedure: TRegPacketHandlerProc);
begin
  FNetTCPClient.RegisterProcedure(aType, aProcedure, aRecSize);
  FNetTCPServer.RegisterProcedure(aType, nil, aRecSize);
end;

//procedure TNetHandle_Server.RegisterTCPMapStubPacket(const aType,
//  aRecSize: word; aProcedure: TRegPacketHandlerProc);
//begin
//  FNetTCPStub.RegisterProcedure(aType, aProcedure, aRecSize);
//end;

procedure TNetHandle_Server.ClearDatabuufer;
begin
  FNetTCPServer.ClearPacket;
end;

procedure TNetHandle_Server.ClearSentBuffer;
begin
  if Assigned(FSentBuffer) then
    FSentBuffer.Clear;
end;

procedure TNetHandle_Server.ConnectToSessionServer();
begin
  FNetTCPClient.Connect(SessionServerIP, IntToStr(SessionPort));
end;

procedure TNetHandle_Server.DisconnectFromSessionServer;
begin
  FNetTCPClient.Disconnect;
end;

//procedure TNetHandle_Server.SendRequestMapStub(const aID: word;
//  aBuffer: PAnsiChar);
//begin
//  FNetTCPStub.SendData(aID, aBuffer);
//end;

procedure TNetHandle_Server.SendRequestToSession(const aID: word; aBuffer: PAnsiChar);
begin
  FNetTCPClient.SendData(aID, aBuffer);
end;

procedure TNetHandle_Server.SendAllSentTo(const toIP: string);
//var
//  i{, id} : integer;
//  pid: ^TPacketID;
//  ipTo: LongWord;
//  pBuff : PAnsiChar;
//  pSize : word;
begin
//  ipTo := StrIp_To_LongIp(toIp);
//  for i := 0 to FSentBuffer.BuffCount - 1 do
//  begin
//    if FSentBuffer.PeekPacket(i, pBuff, pSize) then
//    begin
//      pid := @pBuff^;
////      if (pid.recID <> CPID_REMOTE_CMD) or (pid.recID <> CPID_CMD_SNAPSHOT) then     //mk + mas sam   (filter reconect) 02052012
////      begin
////        if (pid.ipReceiver = ipTo) or (pid.ipReceiver = FLongIpBC) then begin
////          id := pid^.recID;
////          if ( id >=  0) and (id < CPID_UDP) then begin
////             // cuma ada 1 packet, CPID_CUBICLEASSIGN
////            FNetTCPServer.SendDataToIPAddress( id, pBuff, toIP);
////
////          end
////          else
////          if ( id >=  CPID_UDP) and (id < CPID_TCP) then begin
////            // resend to lewat UDP
////            FNetUDPNode.SendDataTo(toIP, id, pBuff);
////
////          end
////          else if (id >= CPID_TCP )then begin
////
////            // daftar paket2 yang tidak akan di kirim ke reconnect client
////            if id in [CPID_CMD_MAPS, CPID_CMD_VERSION {, CPID_...}] then
////              continue;
////
////            // resend to lewat TCP
////            FNetTCPServer.SendDataToIPAddress( id, pBuff, toIP);
////
////          end;
////
////
////        end;
////
////      end;
//    end;
//
//  end;

end;

end.


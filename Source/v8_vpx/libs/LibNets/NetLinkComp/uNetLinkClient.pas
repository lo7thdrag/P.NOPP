unit uNetLinkClient;

interface

uses
  Classes, SysUtils,

  OverbyteIcsWSocket,

  uDataType,
  uDataManager,
  UPacketProtocol,
  uBuffer,
  UPacketHelper;

type
  TOnFinishBuffer = procedure(const b: Boolean) of object;

  // ==============================================================================
  TNetLinkClient = class
  private
    WSocket: TWSocket;
    FLogStat, FLogSend, FLogRecv: TGetStrProc;

    FXAddress: string;
    FLongXAddress: Cardinal;
    FXPort: string;
    FPeerAddress: string;
    FPeerPort: string;

    FHostName: string;
    FIPLists: TStrings;

    FRegProcs: TPacketManager;
    FDataQueue: TDataQueue;

    FLogData: TGetStrProc;

    FPacketizer: TPacketProtocol;

    FReceiveBuffer: TBytes;

    FOnConnected: TNotifyEvent;
    FOnDisConnected: TNotifyEvent;

    function GetMyHostName: string;
    procedure DefStrLog(const s: string);
    procedure SetStrLog(const index: integer; const Value: TGetStrProc);
    function GetChangeState: TChangeState;
    procedure SetChangeState(const Value: TChangeState);
    procedure HandleException(AE: exception; AClient: TWSocket);

    function GetConnected: Boolean;
    procedure SetLogData(const Value: TGetStrProc);

    procedure DoSend(Data: TBytes);

    procedure MessageArrived(const AData: TBytes);

    function GetState: TSocketState;
    procedure WSocket_OnDataAvailable(Sender: TObject; Error: Word);
    procedure WSocket_OnSessionConnected(Sender: TObject; Error: Word);
    procedure WSocket_OnSessionClosed(Sender: TObject; Error: Word);
    // procedure WSocket_OnSessionAvailable(Sender: TObject; Error: Word);

    procedure WSocket_OnDataSent(Sender: TObject; Error: Word);

    procedure CloseSocket;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Connect(aAddr, aPort: string);
    procedure Disconnect;

    procedure SendData(const aID: Word; Data: TBytes); overload;
    procedure SendData(const aID: Word; Data: TStream); overload;
    procedure SendData(const aID: Word; Data: string); overload;
    procedure SendData<T>(const aID: Word; Data: T); overload;
    procedure FlushSendData;

    procedure RegisterProcedure(const aType: Word;
      aProcedure: TPacketHandlerProc);
    procedure UnRegisterProcedure(const aType: Word);
    procedure UnregisterAllProcedure;

    procedure GetPacket();

    property LocalAddress: string read FXAddress;
    property LocalPort: string read FXPort;
    property PeerAddress: string read FPeerAddress;
    property PeerPort: string read FPeerPort;

    property Connected: Boolean read getConnected;
    property State: TSocketState read getState;
    property OnStateChange: TChangeState read GetChangeState
      write SetChangeState;
    property MyLongIP: LongWord read FLongXAddress;

    property OnConnected: TNotifyEvent read FOnConnected write FOnConnected;
    property OnDisConnected: TNotifyEvent read FOnDisConnected
      write FOnDisConnected;
    property OnlogRecv: TGetStrProc read FLogData write SetLogData;

    property OnStatusLog: TGetStrProc index 1 read FLogStat write SetStrLog;
    property OnSendLog: TGetStrProc index 2 read FLogSend write SetStrLog;
    property OnRecvLog: TGetStrProc index 3 read FLogRecv write SetStrLog;
    property MyHostName: string read getMyHostName;
  end;

implementation

uses
  Windows,
  Messages,
  DateUtils;

{ TNetLinkClient }
constructor TNetLinkClient.Create;
begin
  inherited;

  FLogStat := DefStrLog;
  FLogSend := DefStrLog;
  FLogRecv := DefStrLog;

  FPacketizer := TPacketProtocol.Create(10*1024*1024);
  FPacketizer.MessageArrived := MessageArrived;

  FRegProcs := TPacketManager.Create;

  FIPLists := TStringList.Create;
  HostToIPList(FHostName, FIPLists);

  SetLength(FReceiveBuffer, C_SOCK_BUFFER_SIZE);

  WSocket := TWSocket.Create(nil);

  WSocket.OnDataSent := WSocket_OnDataSent;
  WSocket.OnSessionConnected := WSocket_OnSessionConnected;
  WSocket.OnSessionClosed := WSocket_OnSessionClosed;

  FDataQueue := TDataQueue.Create;
  FDataQueue.RegProcs := FRegProcs;
end;

destructor TNetLinkClient.Destroy;
begin
  FreeAndNil(FRegProcs);
  FreeAndNil(FIPLists);

  WSocket.OnDataSent := nil;
  CloseSocket;
  FreeAndNil(WSocket);

  FDataQueue.Clear;
  FreeAndNil(FDataQueue);
  FPacketizer.MessageArrived := nil;
  FreeAndNil(FPacketizer);
  inherited;
end;

function TNetLinkClient.GetMyHostName: string;
var
  i: Integer;
begin
  i:= Length(FHostName);
  if i > 32 then
    result := Copy(FHostName, 1, 32)
  else
    result := FHostName;
end;

procedure TNetLinkClient.DefStrLog(const s: string);
begin
  // do nothing
  // LogFile_net(s);
end;

procedure TNetLinkClient.HandleException(AE: exception; AClient: TWSocket);
begin
  if (AE is ESocketException) then
  begin
    if Assigned(FLogStat) then
      FLogStat(TimeToString + ': Error : ' + AClient.Addr + AE.Message);
    AClient.Close;
  end
  else
  begin
    if Assigned(FLogStat) then
      FLogStat(TimeToString + ': Unhandled exception raised!');
  end;
end;

procedure TNetLinkClient.MessageArrived(const AData: TBytes);
var
  AHeader: TPacketHeader;
  AContent: TBytes;

  AInfo: TPacketInfo;
  dtutc: TDateTime;
begin
  if Assigned(FLogRecv) then
    FLogRecv(TimeToString + ': Packet Found.');

  TPacket.Decompose(AData, AHeader, AContent);

  if TPacketID.Check(AHeader.PacketID) then
  begin
    AInfo.DataID:= AHeader.DataID;

    AInfo.SenderAddress:= StrToLongIP(WSocket.GetPeerAddr);
    AInfo.SenderPort:= StrToInt(WSocket.GetPeerPort);

    AInfo.SentTime:= AHeader.SentTime;

    dtutc:= TTimeZone.Local.ToUniversalTime(Now);
    AInfo.ReceiveTime:= DateTimeToUnixMs(dtutc, False);

    FDataQueue.PutPacket(AInfo, AContent);
    if Assigned(FLogStat) then
      FLogStat(TimeToString + ': Valid Packet !!!');
  end
  else
  begin
    if Assigned(FLogStat) then
      FLogStat(TimeToString + ': Invalid Packet !!!');
  end;
end;

procedure TNetLinkClient.SetStrLog(const index: integer; const Value: TGetStrProc);
var
  x: TGetStrProc;
begin
  if not Assigned(Value) then
    x := DefStrLog
  else
    x := Value;
  case index of
    1:
      FLogStat := x;
    2:
      FLogSend := x;
    3:
      FLogRecv := x;
  end;
end;

procedure TNetLinkClient.Connect(aAddr, aPort: string);
begin
  if (WSocket.State <> wsConnected) and (WSocket.State <> wsConnecting) then
  begin
    WSocket.OnDataAvailable := WSocket_OnDataAvailable;
    WSocket.Proto := C_SOCK_DEF_PROTO;
    WSocket.LineMode := False;
    WSocket.LineEdit := False;
    WSocket.LineEcho := False;
    WSocket.Port := aPort;
    WSocket.Addr := aAddr;
    if Assigned(FLogStat) then
      FLogStat(DateToString + ': Connecting to ' + aAddr + ' port ' + aPort);
    WSocket.Connect;
  end;
end;

procedure TNetLinkClient.CloseSocket;
begin
  PostMessage(WSocket.Handle, WM_QUIT, 0, 0);
end;

procedure TNetLinkClient.Disconnect;
begin
//  if Assigned(FLogStat) then
//    FLogStat(DateToString + ': ' + 'Disconnecting ...');
  WSocket.OnDataAvailable := nil;
//  WSocket.Shutdown(2);
  WSocket.Close;
end;

procedure TNetLinkClient.DoSend(Data: TBytes);
begin
  if not WSocket.AllSent then
  begin
    WSocket.Flush;
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Flush!');
  end;

  try
    WSocket.SendTB(Data);
  except
    on e: exception do
      HandleException(e, WSocket);
  end;
end;

procedure TNetLinkClient.SendData(const aID: Word; Data: TBytes);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  bytes: TBytes;
begin
  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  if WSocket.State = wsConnected then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);

    TPacketID.Fill(h.PacketID);
    h.DataID:= aID;
//    h.SenderAddress:= FLongXAddress;
//    h.SenderPort:= StrToInt(WSocket.GetXPort);
    h.SentTime:= DateTimeToUnixMs(dtutc, False);

    bytes:= TPacketProtocol.WrapMessage(TPacket.Compose(h, Data));

    DoSend(bytes);

    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' -  ' +
        inttostr(Length(bytes)) + ' byte');
  end;
end;

procedure TNetLinkClient.SendData(const aID: Word; Data: TStream);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  bytes: TBytes;
begin
  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  if WSocket.State = wsConnected then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);
    TPacketID.Fill(h.PacketID);
    h.DataID:= aID;
//    h.SenderAddress := FLongXAddress;
//    h.SenderPort := StrToInt(WSocket.GetXPort);
    h.SentTime := DateTimeToUnixMs(dtutc, False);

    bytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeStream(h, Data));

    DoSend(bytes);

    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' -  ' +
        inttostr(Length(bytes)) + ' byte');
  end;
end;

procedure TNetLinkClient.SendData(const aID: Word; Data: string);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  bytes: TBytes;
begin
  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  if WSocket.State = wsConnected then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);

    TPacketID.Fill(h.PacketID);
    h.DataID:= aID;
//    h.SenderAddress := FLongXAddress;
//    h.SenderPort := StrToInt(WSocket.GetXPort);
    h.SentTime := DateTimeToUnixMs(dtutc, False);

    bytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeString(h, Data));

    DoSend(bytes);

    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' -  ' +
        inttostr(Length(bytes)) + ' byte');
  end;
end;

procedure TNetLinkClient.SendData<T>(const aID: Word; Data: T);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  bytes: TBytes;
begin
  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  if WSocket.State = wsConnected then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);

    TPacketID.Fill(h.PacketID);
    h.DataID:= aID;
//    h.SenderAddress := FLongXAddress;
//    h.SenderPort := StrToInt(WSocket.GetXPort);
    h.SentTime := DateTimeToUnixMs(dtutc, False);

    bytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeRecord(h, Data));

    DoSend(bytes);

    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' -  ' +
        inttostr(Length(bytes)) + ' byte');
  end;
end;

procedure TNetLinkClient.WSocket_OnSessionConnected(Sender: TObject; Error: Word);
begin
  if WSocket.State = wsConnected then
  begin
//    try
//      s := WSocket.PeerAddr;
//    except
//      on ESocketException do
//      begin
//        Exit;
//      end;
//    end;
    // connect temenan rek..
    FXAddress:= WSocket.GetXAddr;
    FLongXAddress := StrToLongIP(FXAddress);
    FXPort:= WSocket.GetXPort;
    FPeerAddress:= WSocket.GetPeerAddr;
    FPeerPort:= WSocket.GetPeerPort;

    if Assigned(FLogStat) then
    begin
      FLogStat(TimeToString + ': ' + 'Connected to ' + FPeerAddress + ':' + FPeerPort);
      FLogStat(TimeToString + ': ' + 'Local Address : ' + FXAddress + ':' + FXPort);
      FLogStat(TimeToString + ': ' + 'Error Code : ' + Error.ToString);
    end;

    if Assigned(FOnConnected) then
      FOnConnected(self);
  end;
end;

procedure TNetLinkClient.WSocket_OnSessionClosed(Sender: TObject; Error: Word);
var
  s: string;
begin
  s:= TimeToString + ': Disconnected from ' + FPeerAddress +':' + FPeerPort;
  FLongXAddress := 0;

  if Assigned(FLogStat) then
    FLogStat(s);

  if Assigned(FOnDisConnected) then
    FOnDisConnected(self);

end;


procedure TNetLinkClient.WSocket_OnDataAvailable(Sender: TObject; Error: Word);
var
  receivedByte: Integer;
  readBytes: TBytes;
begin
  if Assigned(FLogRecv) then
      FLogRecv(TimeToString + ': Receive Error Code = ' + inttostr(Error));

  if Error <> 0 then
    Exit;

  try
    //FillChar(FReceiveBuffer[0], Length(FReceiveBuffer), 0);
    receivedByte:= TWSocket(Sender).Receive(FReceiveBuffer,
      Length(FReceiveBuffer));
    if Assigned(FLogRecv) then
      FLogRecv(TimeToString + ': ReceivedBytes = ' + inttostr(receivedByte));
    if receivedByte < 1 then
      Exit;

    // svrIP := TWSocket(Sender).Addr;

    SetLength(readBytes, receivedByte);
    Move(FReceiveBuffer[0], readBytes[0], receivedByte);
    FPacketizer.DataReceived(readBytes);

  finally

  end;
end;

function TNetLinkClient.GetState: TSocketState;
begin
  result := WSocket.State;
end;

procedure TNetLinkClient.WSocket_OnDataSent(Sender: TObject; Error: Word);
var
  s: string;
begin
  if Error = 0 then
    s:= TimeToString + ': Data sent.'
  else
    s:= TimeToString + ': Data sent Error : ' + inttostr(Error);
  if Assigned(FLogSend) then
    FLogSend(s);
end;

function TNetLinkClient.GetConnected: Boolean;
begin
  result := WSocket.State = wsConnected;
end;

procedure TNetLinkClient.GetPacket;
begin
  FDataQueue.GetPacket;
end;

function TNetLinkClient.GetChangeState: TChangeState;
begin
  result := WSocket.OnChangeState;
end;

procedure TNetLinkClient.SetChangeState(const Value: TChangeState);
begin
  WSocket.OnChangeState := Value;
end;

procedure TNetLinkClient.SetLogData(const Value: TGetStrProc);
begin
  FLogData := Value;
  FDataQueue.LogStat := Value;
end;

procedure TNetLinkClient.FlushSendData;
begin
  if (WSocket.State = wsConnected) and not WSocket.AllSent then
    WSocket.Flush;
end;

procedure TNetLinkClient.RegisterProcedure(const aType: Word;
  aProcedure: TPacketHandlerProc);
begin
  if Assigned(FRegProcs) then
    FRegProcs.Register(aType, aProcedure);
end;

procedure TNetLinkClient.UnRegisterProcedure(const aType: Word);
begin
  if Assigned(FRegProcs) then
    FRegProcs.UnRegister(aType);
end;

procedure TNetLinkClient.UnregisterAllProcedure;
begin
  if Assigned(FRegProcs) then
    FRegProcs.UnregisterALL;
end;

end.

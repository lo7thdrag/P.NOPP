unit uNetLinkServer;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Hash,

  OverbyteIcsWSocket,
  OverbyteIcsWSocketS,

  uDataType,
  uDataManager,
  UPacketProtocol,
  uBuffer,
  UPacketHelper;

type
  // -----------------------------------------------------------------------------
  TConnectedClient = class(TWSocketClient)
  private
    FBuffer: TBytes;
    FLogStat, FLogRecv: TGetStrProc;
    FDataQueue: TDataQueue;
    procedure MessageArrived(const AData: TBytes);
  public
    ConnectedIP: string;
    ConnectedPort: string;
    ConnectTime: TDateTime;
    Packetizer: TPacketProtocol;
    property DataQueue: TDataQueue read FDataQueue write FDataQueue;
    property OnLogStat: TGetStrProc read FLogStat write FLogStat;
    property OnLogRecv: TGetStrProc read FLogRecv write FLogRecv;
  end;

  TClientConnect_Event = procedure(const AClient: TConnectedClient; const S: string) of object;
  TClientDisconnect_Event = procedure(const AClient: TConnectedClient; const S: string) of object;

  // -----------------------------------------------------------------------------
  TNetLinkServer = class
  private
    WSocket: TWSocket;
    WSockServer: TWSocketServer;

    FLogStat, FLogSend, FLogRecv: TGetStrProc;

    FIPIndex: TStringList;

    FRegProcs: TPacketManager;

    FOnClient_Connect: TClientConnect_Event;
    FOnClient_DisConnect: TClientDisconnect_Event;
    FOnSvrChangeState: TChangeState;

    // FLongXAddress: Longword;
    FDataQueue: TDataQueue;
    FLongXAddress: Longword;

    function getConnectedClientCount: Integer;
    function getConnectedClient(i: Integer): TConnectedClient;

    function getClientCount: Integer;
    function getClient(i: Integer): TWSocketClient;


    procedure DefStrLog(const s: string);
    procedure SetStrLog(const index: integer; const Value: TGetStrProc);

    function GetChangeState: TChangeState;
    procedure SetChangeState(const Value: TChangeState);
    procedure HandleException(AE: exception; AClient: TWSocket);

    procedure WSockServer_OnChangeState(Sender: TObject;
      OldState, NewState: TSocketState);
    procedure WSockServer_OnClientConnect(Sender: TObject;
      Client: TWSocketClient; Error: Word);
    procedure WSockServer_OnClientDisconnect(Sender: TObject;
      Client: TWSocketClient; Error: Word);
    procedure Client_OnDataSent(Sender: TObject; Error: Word);
    procedure Client_OnDataAvailable(Sender: TObject; Error: Word);
    procedure Client_OnBGException(Sender: TObject; E: Exception;
      var CanClose: Boolean);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Listen(aPort: string);
    procedure Stop;

    procedure DisconnectClient(AClient: TWSocketClient);

//    procedure SendData(const aID: Word; aBuffer: PAnsiChar);
//    procedure SendDataExceptThis(const aID: Word; aBuffer: PAnsiChar;
//      const ipExcept: string);
//    procedure SendDataToIPAddress(const aID: Word; aBuffer: PAnsiChar;
//      const ipAdd: string);
    procedure SendData(const aID: Word; aData: TBytes); overload;
    procedure SendData(const aID: Word; aData: TStream); overload;
    procedure SendData(const aID: Word; aData: string); overload;
    procedure SendData<T>(const aID: Word; aData: T); overload;

    procedure SendDataExceptThis(const aID: Word; aData: TBytes;
      const ipExcept: string; const portExcept: string); overload;
    procedure SendDataExceptThis(const aID: Word; aData: TStream;
      const ipExcept: string; const portExcept: string); overload;
    procedure SendDataExceptThis(const aID: Word; aData: string;
      const ipExcept: string; const portExcept: string); overload;
    procedure SendDataExceptThis<T>(const aID: Word; aData: T;
      const ipExcept: string; const portExcept: string); overload;

    procedure SendDataToIPAddress(const aID: Word; aData: TBytes;
      const ipTarget: string; const portTarget: string); overload;
    procedure SendDataToIPAddress(const aID: Word; aData: TStream;
      const ipTarget: string; const portTarget: string); overload;
    procedure SendDataToIPAddress(const aID: Word; aData: string;
      const ipTarget: string; const portTarget: string); overload;
    procedure SendDataToIPAddress<T>(const aID: Word; aData: T;
      const ipTarget: string; const portTarget: string); overload;

    procedure SendTBTo(const AClient: TConnectedClient;
      const aID: Word; aData: TBytes); overload;
    procedure SendStreamTo(const AClient: TConnectedClient;
      const aID: Word; aData: TStream); overload;
    procedure SendStringTo(const AClient: TConnectedClient;
      const aID: Word; aData: string); overload;
    procedure SendRecordTo<T>(const AClient: TConnectedClient;
    const aID: Word; aData: T); overload;

    procedure FlushSendData;
    procedure GetConnectedList(var sl: TStringList);

    procedure RegisterProcedure(const aType: Word;
      aProcedure: TPacketHandlerProc);
    procedure UnRegisterProcedure(const aType: Word);
    procedure UnregisterAllProcedure;

    procedure GetPacket;

    property OnClient_Connect: TClientConnect_Event read FOnClient_Connect
      write FOnClient_Connect;
    property OnClient_DisConnect: TClientDisconnect_Event read FOnClient_DisConnect
      write FOnClient_DisConnect;
    property OnStateChange: TChangeState read GetChangeState
      write SetChangeState;
    property ConnectedClientCount: Integer read getConnectedClientCount;
    property ConnectedClients[i: Integer]: TConnectedClient read getConnectedClient;
    property ClientCount: Integer read getClientCount;
    property Clients[i: Integer]: TWSocketClient read getClient;
    property LongIP: Longword read FLongXAddress;

    property OnStatusLog: TGetStrProc index 1 read FLogStat write SetStrLog;
    property OnSendLog: TGetStrProc index 2 read FLogSend write SetStrLog;
    property OnRecvLog: TGetStrProc index 3 read FLogRecv write SetStrLog;
  end;

implementation

uses
  DateUtils;

constructor TNetLinkServer.Create;
begin
  inherited;
  WSockServer := TWSocketServer.Create(nil);
  WSocket := WSockServer;

  FRegProcs := TPacketManager.Create;

  WSockServer.MultiThreaded := False;
  WSockServer.OnChangeState := WSockServer_OnChangeState;

  FIPIndex := TStringList.Create;
  FIPIndex.Sorted := True;
  FIPIndex.Duplicates := dupError;
  FIPIndex.CaseSensitive:= False;
  FIPIndex.OwnsObjects:= False;

  FDataQueue := TDataQueue.Create;
  FDataQueue.RegProcs := FRegProcs;
end;

destructor TNetLinkServer.Destroy;
begin
  FreeAndNil(FRegProcs);
  FIPIndex.Clear;
  FreeAndNil(FIPIndex);
  WSocket := nil;
  FreeAndNil(WSockServer);

  FreeAndNil(FDataQueue);
  inherited;
end;

procedure TNetLinkServer.DefStrLog(const s: string);
begin
  // do nothing
  // LogFile_net(s);
end;

procedure TNetLinkServer.SetStrLog(const index: integer; const Value: TGetStrProc);
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
  FDataQueue.LogStat:= x;
end;

procedure TNetLinkServer.SetChangeState(const Value: TChangeState);
begin
  FOnSvrChangeState := Value;
end;

procedure TNetLinkServer.HandleException(AE: exception; AClient: TWSocket);
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

function TNetLinkServer.GetChangeState: TChangeState;
begin
  Result := FOnSvrChangeState;
end;

procedure TNetLinkServer.WSockServer_OnChangeState(Sender: TObject;
  OldState, NewState: TSocketState);
begin
  if Assigned(FOnSvrChangeState) then
    FOnSvrChangeState(Sender, OldState, NewState);
end;

procedure TNetLinkServer.Listen(aPort: string);
begin
  if WSockServer.State = wsClosed then
  begin
    WSockServer.OnClientConnect := WSockServer_OnClientConnect;
    WSockServer.OnClientDisconnect := WSockServer_OnClientDisconnect;
    WSockServer.Proto := C_SOCK_DEF_PROTO;
    WSockServer.Port := aPort;
    WSockServer.Addr := '0.0.0.0';
    WSockServer.LineMode := False;
    WSockServer.LineEdit := False;
    WSockServer.LineEcho := False;
    WSockServer.ClientClass := TConnectedClient;
    WSockServer.Banner := '';
    WSockServer.Listen;
    FLongXAddress := StrToLongIP(WSockServer.LocalAddr);

    if Assigned(FLogStat) then
    begin
      FLogStat(TimeToString + ': ' + 'Server Listening at port ' + aPort);
      FLogStat(TimeToString + ': addr : ' + WSockServer.Addr);
      FLogStat(TimeToString + ': local : ' + WSockServer.LocalAddr);
      FLogStat(TimeToString + ': x addr : ' + WSockServer.GetXAddr);
    end;
  end;
end;

procedure TNetLinkServer.DisconnectClient(AClient: TWSocketClient);
begin
  WSockServer.Disconnect(AClient);
end;

procedure TNetLinkServer.Stop;
var
  i: Integer;
  cClient: TWSocketClient;
  cCon: TConnectedClient;
begin
  while WSockServer.ClientCount > 0 do
  begin
    i:= 0;
    cClient := WSockServer.Client[i];
//    if cClient.State <> wsClosed then
//      cClient.Close;
    cCon:= TConnectedClient(cClient);
    if Assigned(cCon.Packetizer) then
    begin
      cCon.Packetizer.MessageArrived := nil;
      FreeAndNil(cCon.Packetizer);
    end;
    WSockServer.Disconnect(cClient);
  end;
  WSockServer.Close;
  WSockServer.OnClientConnect := nil;
  WSockServer.OnClientDisconnect := nil;
  FDataQueue.Clear;
  if Assigned(FLogStat) then
    FLogStat(DateToString + ': Server stopped');
end;

//procedure TNetLinkServer.SendData(const aID: Word; aBuffer: PAnsiChar);
//var
//  pSize: Word;
//  i: Integer;
//  cCon: TClientConnected;
//  strTemp: string;
//begin
//  if WSockServer.ClientCount <= 0 then
//    Exit;
//  if not PrepareSendData(aID, aBuffer) then
//  begin
//    FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
//    Exit;
//  end;
//  pSize := FRegProcs[aID].recSize;
//  strTemp := 'Send ALL: ID ' + inttostr(aID) + inttostr(pSize) + ' byte ';
//  for i := WSockServer.ClientCount - 1 downto 0 do
//  begin
//    cCon := TClientConnected(WSockServer.Client[i]);
//    if (cCon <> nil) and (cCon.State = wsConnected) then
//    begin
//      // if not cCon.AllSent then
//      // cCon.Flush;
//      FLogSend(TimeToString + ': ' + strTemp + ', to: ' + cCon.ConnectedIP);
//      try
//        cCon.Send(aBuffer, pSize);
//      except
//        on E: Exception do
//          HandleException(E, cCon);
//      end; // end exception
//    end;
//  end;
//end;

procedure TNetLinkServer.SendData(const aID: Word; aData: TBytes);
var
  i: Integer;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);
  DataBytes:= TPacketProtocol.WrapMessage(TPacket.Compose(h, aData));

  sz:= Length(DataBytes);
  strTemp:= 'Send ALL: ID ' + inttostr(aID) + ' -  ' + inttostr(sz) + ' byte ';

  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
    begin
      // if not cCon.AllSent then
      // cCon.Flush;

      if Assigned(FLogSend) then
        FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
          cCon.ConnectedIP + ':' + cCon.ConnectedPort);
      try
        cCon.Send(DataBytes, sz);
      except
        on E: Exception do
          HandleException(E, cCon);
      end; // end exception
    end;
  end;
end;

procedure TNetLinkServer.SendData(const aID: Word; aData: TStream);
var
  i: Integer;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);
  DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeStream(h, aData));

  sz:= Length(DataBytes);
  strTemp:= 'Send ALL: ID ' + inttostr(aID) + ' -  ' + inttostr(sz) + ' byte ';

  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
    begin
      // if not cCon.AllSent then
      // cCon.Flush;

      if Assigned(FLogSend) then
        FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
          cCon.ConnectedIP + ':' + cCon.ConnectedPort);
      try
        cCon.Send(DataBytes, sz);
      except
        on E: Exception do
          HandleException(E, cCon);
      end; // end exception
    end;
  end;
end;

procedure TNetLinkServer.SendData(const aID: Word; aData: string);
var
  i: Integer;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);
  DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeString(h, aData));

  sz:= Length(DataBytes);
  strTemp:= 'Send ALL: ID ' + inttostr(aID) + ' -  ' + inttostr(sz) + ' byte ';

  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
    begin
      // if not cCon.AllSent then
      // cCon.Flush;

      if Assigned(FLogSend) then
        FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
          cCon.ConnectedIP + ':' + cCon.ConnectedPort);
      try
        cCon.Send(DataBytes, sz);
      except
        on E: Exception do
          HandleException(E, cCon);
      end; // end exception
    end;
  end;
end;

procedure TNetLinkServer.SendData<T>(const aID: Word; aData: T);
var
  i: Integer;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  //pSize := FRegProcs[aID].recSize;
  //strTemp := 'Send ALL: ID ' + inttostr(aID) + inttostr(pSize) + ' byte ';

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);
  DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeRecord(h, aData));

  sz:= Length(DataBytes);
  strTemp:= 'Send ALL: ID ' + inttostr(aID) + ' -  ' + inttostr(sz) + ' byte ';

  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
    begin
      // if not cCon.AllSent then
      // cCon.Flush;

      if Assigned(FLogSend) then
        FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
          cCon.ConnectedIP + ':' + cCon.ConnectedPort);
      try
        cCon.Send(DataBytes, sz);
      except
        on E: Exception do
          HandleException(E, cCon);
      end; // end exception
    end;
  end;
end;

//procedure TNetLinkServer.SendDataExceptThis(const aID: Word; aBuffer: PAnsiChar;
//  const ipExcept: string);
//var
//  pSize: Word;
//  i: Integer;
//  cCon: TClientConnected;
//  strTemp: string;
//begin
//  if WSockServer.ClientCount <= 0 then
//    Exit;
//  if not PrepareSendData(aID, aBuffer) then
//  begin
//    FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
//    Exit;
//  end;
//  pSize := FRegProcs[aID].recSize;
//  strTemp := 'Send: ID ' + inttostr(aID) + ' EXCEPT ' + ipExcept;
//  for i := 0 to WSockServer.ClientCount - 1 do
//  begin
//    cCon := TClientConnected(WSockServer.Client[i]);
//    if (cCon <> nil) and (cCon.ConnectedIP <> ipExcept) and
//      (cCon.State = wsConnected) then
//    begin
//      if not cCon.AllSent then
//        cCon.Flush;
//      FLogSend(TimeToString + ': ' + strTemp + ', to: ' + cCon.ConnectedIP);
//      try
//        cCon.Send(aBuffer, pSize);
//      except
//        on E: Exception do
//          HandleException(E, cCon);
//      end; // end exception
//    end;
//  end;
//end;

procedure TNetLinkServer.SendDataExceptThis(const aID: Word; aData: TBytes;
  const ipExcept: string; const portExcept: string);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
  i: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);

  DataBytes:= TPacketProtocol.WrapMessage(TPacket.Compose(h, aData));
  sz:= Length(DataBytes);

  strTemp := 'Send : ID ' + inttostr(aID) + ' EXCEPT ' + ipExcept +
    ' -  ' + inttostr(sz) + ' byte ';


  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
      if (cCon.ConnectedIP = ipExcept) and (cCon.ConnectedPort = portExcept) then
      else
      begin
        // if not cCon.AllSent then
        // cCon.Flush;

        if Assigned(FLogSend) then
          FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
            cCon.ConnectedIP + ':' + cCon.ConnectedPort);
        try
          cCon.Send(DataBytes, sz);
        except
          on E: Exception do
            HandleException(E, cCon);
        end; // end exception
      end;
  end;
end;

procedure TNetLinkServer.SendDataExceptThis(const aID: Word; aData: TStream;
  const ipExcept: string; const portExcept: string);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
  i: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);

  DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeStream(h, aData));
  sz:= Length(DataBytes);

  strTemp := 'Send : ID ' + inttostr(aID) + ' EXCEPT ' + ipExcept +
    ' -  ' + inttostr(sz) + ' byte ';


  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
      if (cCon.ConnectedIP = ipExcept) and (cCon.ConnectedPort = portExcept) then
      else
      begin
        // if not cCon.AllSent then
        // cCon.Flush;

        if Assigned(FLogSend) then
          FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
            cCon.ConnectedIP + ':' + cCon.ConnectedPort);
        try
          cCon.Send(DataBytes, sz);
        except
          on E: Exception do
            HandleException(E, cCon);
        end; // end exception
      end;
  end;
end;

procedure TNetLinkServer.SendDataExceptThis(const aID: Word; aData: string;
  const ipExcept: string; const portExcept: string);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
  i: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);

  DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeString(h, aData));
  sz:= Length(DataBytes);

  strTemp := 'Send : ID ' + inttostr(aID) + ' EXCEPT ' + ipExcept +
    ' -  ' + inttostr(sz) + ' byte ';


  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
      if (cCon.ConnectedIP = ipExcept) and (cCon.ConnectedPort = portExcept) then
      else
      begin
        // if not cCon.AllSent then
        // cCon.Flush;

        if Assigned(FLogSend) then
          FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
            cCon.ConnectedIP + ':' + cCon.ConnectedPort);
        try
          cCon.Send(DataBytes, sz);
        except
          on E: Exception do
            HandleException(E, cCon);
        end; // end exception
      end;
  end;
end;

procedure TNetLinkServer.SendDataExceptThis<T>(const aID: Word; aData: T;
      const ipExcept: string; const portExcept: string);
var
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
  strTemp: string;
  cCon: TConnectedClient;
  i: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(h.PacketID);
  h.DataID := aID;
//  h.SenderAddress := FLongXAddress;
//  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);

  DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeRecord(h, aData));
  sz:= Length(DataBytes);

  strTemp := 'Send : ID ' + inttostr(aID) + ' EXCEPT ' + ipExcept +
    ' -  ' + inttostr(sz) + ' byte ';


  for i:= WSockServer.ClientCount - 1 downto 0 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
      if (cCon.ConnectedIP = ipExcept) and (cCon.ConnectedPort = portExcept) then
      else
      begin
        // if not cCon.AllSent then
        // cCon.Flush;

        if Assigned(FLogSend) then
          FLogSend(TimeToString + ': ' + strTemp + ', to: ' +
            cCon.ConnectedIP + ':' + cCon.ConnectedPort);
        try
          cCon.Send(DataBytes, sz);
        except
          on E: Exception do
            HandleException(E, cCon);
        end; // end exception
      end;
  end;
end;

//
//procedure TNetLinkServer.SendDataToIPAddress(const aID: Word; aBuffer: PAnsiChar;
//  const ipAdd: string);
//var
//  pSize: Word;
//  i: Integer;
//  cCon: TClientConnected;
//begin
//  // gimana klo ada multiple connection dari ip address yg sama?
//  // kirim ke semua..
//  if not PrepareSendData(aID, aBuffer) then
//  begin
//    FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
//    Exit;
//  end;
//  pSize := FRegProcs[aID].recSize;
//  if not FIPIndex.Find(ipAdd, i) then
//  begin
//    FLogSend(TimeToString + ': ' + ipAdd + ' not connected');
//    Exit;
//  end;
//  for i := 0 to FIPIndex.Count - 1 do
//  begin
//    cCon := TClientConnected(FIPIndex.Objects[i]);
//    // if (cCon = nil) then continue; delete ?
//    if (cCon.PeerAddr = ipAdd) and (cCon.State = wsConnected) then
//    begin
//      FLogSend(TimeToString + ':ID ' + inttostr(aID) + ' to: ' + cCon.ConnectedIP);
//      try
//        cCon.Send(aBuffer, pSize);
//      except
//        on E: Exception do
//          HandleException(E, cCon);
//      end; // end exception
//    end;
//  end;
//end;

procedure TNetLinkServer.SendDataToIPAddress(const aID: Word; aData: TBytes;
  const ipTarget: string; const portTarget: string);
var
  isFound: Boolean;
  Con: TConnectedClient;
  i: Integer;
  obj: TObject;
  cCon: TConnectedClient;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  isFound:= False;
  for i:= 0 to FIPIndex.Count - 1 do
  begin
    obj:= FIPIndex.Objects[i];
    if obj <> nil then
    begin
      cCon := TConnectedClient(obj);
      if (cCon.PeerAddr = ipTarget) and (cCon.PeerPort = portTarget) and
        (cCon.State = wsConnected) then
      begin
        isFound:= True;
        Break
      end;
    end;
  end;

  if isFound then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);

    TPacketID.Fill(h.PacketID);
    h.DataID := aID;
//    h.SenderAddress := FLongXAddress;
//    h.SenderPort := StrToInt(WSocket.GetXPort);
    h.SentTime := DateTimeToUnixMs(dtutc, False);
    DataBytes:= TPacketProtocol.WrapMessage(TPacket.Compose(h, aData));
    sz:= Length(DataBytes);

    FLogSend(TimeToString + ':ID ' + inttostr(aID) + ' to: ' + cCon.ConnectedIP);
    try
      cCon.Send(DataBytes, sz);
    except
      on E: Exception do
        HandleException(E, cCon);
    end; // end exception
  end;

end;

procedure TNetLinkServer.SendDataToIPAddress(const aID: Word; aData: TStream;
  const ipTarget: string; const portTarget: string);
var
  isFound: Boolean;
  Con: TConnectedClient;
  i: Integer;
  obj: TObject;
  cCon: TConnectedClient;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  isFound:= False;
  for i:= 0 to FIPIndex.Count - 1 do
  begin
    obj:= FIPIndex.Objects[i];
    if obj <> nil then
    begin
      cCon := TConnectedClient(obj);
      if (cCon.PeerAddr = ipTarget) and (cCon.PeerPort = portTarget) and
        (cCon.State = wsConnected) then
      begin
        isFound:= True;
        Break
      end;
    end;
  end;

  if isFound then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);

    TPacketID.Fill(h.PacketID);
    h.DataID := aID;
//    h.SenderAddress := FLongXAddress;
//    h.SenderPort := StrToInt(WSocket.GetXPort);
    h.SentTime := DateTimeToUnixMs(dtutc, False);
    DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeStream(h, aData));
    sz:= Length(DataBytes);

    FLogSend(TimeToString + ':ID ' + inttostr(aID) + ' to: ' + cCon.ConnectedIP);
    try
      cCon.Send(DataBytes, sz);
    except
      on E: Exception do
        HandleException(E, cCon);
    end; // end exception
  end;

end;

procedure TNetLinkServer.SendDataToIPAddress(const aID: Word; aData: string;
  const ipTarget: string; const portTarget: string);
var
  isFound: Boolean;
  Con: TConnectedClient;
  i: Integer;
  obj: TObject;
  cCon: TConnectedClient;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  isFound:= False;
  for i:= 0 to FIPIndex.Count - 1 do
  begin
    obj:= FIPIndex.Objects[i];
    if obj <> nil then
    begin
      cCon := TConnectedClient(obj);
      if (cCon.PeerAddr = ipTarget) and (cCon.PeerPort = portTarget) and
        (cCon.State = wsConnected) then
      begin
        isFound:= True;
        Break
      end;
    end;
  end;

  if isFound then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);

    TPacketID.Fill(h.PacketID);
    h.DataID := aID;
//    h.SenderAddress := FLongXAddress;
//    h.SenderPort := StrToInt(WSocket.GetXPort);
    h.SentTime := DateTimeToUnixMs(dtutc, False);
    DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeString(h, aData));
    sz:= Length(DataBytes);

    FLogSend(TimeToString + ':ID ' + inttostr(aID) + ' to: ' + cCon.ConnectedIP);
    try
      cCon.Send(DataBytes, sz);
    except
      on E: Exception do
        HandleException(E, cCon);
    end; // end exception
  end;

end;

procedure TNetLinkServer.SendDataToIPAddress<T>(const aID: Word; aData: T;
      const ipTarget: string; const portTarget: string);
var
  isFound: Boolean;
  Con: TConnectedClient;
  i: Integer;
  obj: TObject;
  cCon: TConnectedClient;
  h: TPacketHeader;
  dtutc: TDateTime;
  DataBytes: TBytes;
  sz: integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  isFound:= False;
  for i:= 0 to FIPIndex.Count - 1 do
  begin
    obj:= FIPIndex.Objects[i];
    if obj <> nil then
    begin
      cCon := TConnectedClient(obj);
      if (cCon.PeerAddr = ipTarget) and (cCon.PeerPort = portTarget) and
        (cCon.State = wsConnected) then
      begin
        isFound:= True;
        Break
      end;
    end;
  end;

  if isFound then
  begin
    dtutc:= TTimeZone.Local.ToUniversalTime(Now);

    TPacketID.Fill(h.PacketID);
    h.DataID := aID;
//    h.SenderAddress := FLongXAddress;
//    h.SenderPort := StrToInt(WSocket.GetXPort);
    h.SentTime := DateTimeToUnixMs(dtutc, False);
    DataBytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeRecord(h, aData));
    sz:= Length(DataBytes);

    FLogSend(TimeToString + ':ID ' + inttostr(aID) + ' to: ' + cCon.ConnectedIP);
      try
        cCon.Send(DataBytes, sz);
      except
        on E: Exception do
          HandleException(E, cCon);
      end; // end exception
  end;

end;

procedure TNetLinkServer.SendTBTo(const AClient: TConnectedClient;
  const aID: Word; aData: TBytes);
var
  AHeader: TPacketHeader;
  dtutc: TDateTime;
  ABytes: TBytes;
  ABytesLength: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(AHeader.PacketID);
  AHeader.DataID := aID;
  AHeader.SentTime := DateTimeToUnixMs(dtutc, False);
  ABytes:= TPacketProtocol.WrapMessage(TPacket.Compose(AHeader, aData));
  ABytesLength:= Length(ABytes);

  if Assigned(FLogSend) then
    FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' to: ' +
      AClient.ConnectedIP + ':' + AClient.ConnectedPort + ' - ' +
      ABytesLength.ToString + ' bytes');
  try
    AClient.Send(ABytes, ABytesLength);
  except
    on E: Exception do
      HandleException(E, AClient);
  end;

end;

procedure TNetLinkServer.SendStreamTo(const AClient: TConnectedClient;
  const aID: Word; aData: TStream);
var
  AHeader: TPacketHeader;
  dtutc: TDateTime;
  ABytes: TBytes;
  ABytesLength: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(AHeader.PacketID);
  AHeader.DataID := aID;
  ABytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeStream(AHeader, aData));
  ABytesLength:= Length(ABytes);

  if Assigned(FLogSend) then
    FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' to: ' +
      AClient.ConnectedIP + ':' + AClient.ConnectedPort + ' - ' +
      ABytesLength.ToString + ' bytes');
  try
    AClient.Send(ABytes, ABytesLength);
  except
    on E: Exception do
      HandleException(E, AClient);
  end;
end;

procedure TNetLinkServer.SendStringTo(const AClient: TConnectedClient;
  const aID: Word; aData: string);
var
  AHeader: TPacketHeader;
  dtutc: TDateTime;
  ABytes: TBytes;
  ABytesLength: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(AHeader.PacketID);
  AHeader.DataID := aID;
  AHeader.SentTime := DateTimeToUnixMs(dtutc, False);
  ABytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeString(AHeader, aData));
  ABytesLength:= Length(ABytes);

  if Assigned(FLogSend) then
    FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' to: ' +
      AClient.ConnectedIP + ':' + AClient.ConnectedPort + ' - ' +
      ABytesLength.ToString + ' bytes');
  try
    AClient.Send(ABytes, ABytesLength);
  except
    on E: Exception do
      HandleException(E, AClient);
  end;
end;

procedure TNetLinkServer.SendRecordTo<T>(const AClient: TConnectedClient;
  const aID: Word; aData: T);
var
  AHeader: TPacketHeader;
  dtutc: TDateTime;
  ABytes: TBytes;
  ABytesLength: Integer;
begin
  if WSockServer.ClientCount <= 0 then
    Exit;

  if not FRegProcs.IsRegistered(aID) then
  begin
    if Assigned(FLogSend) then
      FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  dtutc:= TTimeZone.Local.ToUniversalTime(Now);

  TPacketID.Fill(AHeader.PacketID);
  AHeader.DataID := aID;
  AHeader.SentTime := DateTimeToUnixMs(dtutc, False);
  ABytes:= TPacketProtocol.WrapMessage(TDataComposer.ComposeRecord(AHeader, aData));
  ABytesLength:= Length(ABytes);

  if Assigned(FLogSend) then
    FLogSend(TimeToString + ': Send ID ' + inttostr(aID) + ' to: ' +
      AClient.ConnectedIP + ':' + AClient.ConnectedPort + ' - ' +
      ABytesLength.ToString + ' bytes');
  try
    AClient.Send(ABytes, ABytesLength);
  except
    on E: Exception do
      HandleException(E, AClient);
  end; // end exception
end;

procedure TNetLinkServer.WSockServer_OnClientConnect(Sender: TObject;
  Client: TWSocketClient; Error: Word);
var
  cCon: TConnectedClient;
  ipAdd: string;
  AHash: string;
begin
  cCon:= TConnectedClient(Client);

  SetLength(cCon.FBuffer, C_SOCK_BUFFER_SIZE);

  cCon.LineMode := False;
  cCon.LineEdit := False;
  cCon.LineEcho := False;
  cCon.OnDataSent:= Client_OnDataSent;
  cCon.OnDataAvailable := Client_OnDataAvailable;
  cCon.OnBgException := Client_OnBGException;
  cCon.ConnectTime := Now;
  cCon.Packetizer := TPacketProtocol.Create(10*1024*1024);
  cCon.Packetizer.MessageArrived := cCon.MessageArrived;
  cCon.OnLogStat:= FLogStat;
  cCon.OnLogRecv:= FLogRecv;
  cCon.DataQueue:= FDataQueue;

  ipAdd := cCon.PeerAddr;
  cCon.ConnectedIP := ipAdd;
  cCon.ConnectedPort:= cCon.PeerPort;
  AHash:= THashSHA2.GetHashString(cCon.ConnectedIP+':'+cCon.ConnectedPort, SHA512);
  FIPIndex.AddObject(AHash, cCon);
  if Assigned(FLogStat) then
    FLogStat(TimeToString + ': ' + 'Connection from ' + ipAdd + ':' + cCon.PeerPort);
  if Assigned(FOnClient_Connect) then
    //FOnClient_Connect(ipAdd);
    FOnClient_Connect(cCon, ipAdd+':'+cCon.PeerPort);
end;

procedure TNetLinkServer.WSockServer_OnClientDisconnect(Sender: TObject;
  Client: TWSocketClient; Error: Word);
var
  cCon: TConnectedClient;
  i: Integer;
  ipAdd: string;
begin
  cCon:= TConnectedClient(Client);
  if Assigned(cCon.Packetizer) then
  begin
    cCon.Packetizer.MessageArrived := nil;
    FreeAndNil(cCon.Packetizer);
  end;

  i:= FIPIndex.IndexOfObject(cCon);
  if i >= 0 then
    FIPIndex.Delete(i);

  ipAdd := cCon.PeerAddr;


  SetLength(cCon.FBuffer, 0);

  if Assigned(FLogStat) then
    FLogStat(TimeToString + ': ' + 'Disconnecting ' + ipAdd + ':' + cCon.PeerPort +
      ', duration: ' + FormatDateTime('hh:nn:ss', Now - cCon.ConnectTime));

  if Assigned(FOnClient_DisConnect) then
    FOnClient_DisConnect(cCon, ipAdd+':'+cCon.PeerPort);
end;

//procedure TNetLinkServer.Client_OnDataAvailable(Sender: TObject; Error: Word);
//var
//  lbuffer: PAnsiChar;
//  receivedByte, readByte: Integer;
//  p: pointer;
//  findRec: Boolean;
//  pSize: ^Word;
//  recSize: Integer;
//  ipSend: string;
//  bCount: Integer;
//  cCon: TClientConnected;
//begin
//  if Assigned(FLogData) then
//    FLogData('Error Code : ' + inttostr(Error));
//  if Error <> 0 then
//    Exit; // tambahan dari farid
//  cCon := TClientConnected(Sender);
//  ipSend := cCon.PeerAddr;
//  receivedByte := cCon.RcvdCount;
//  // Number of characters in receive buffer but not read yet.
//  if receivedByte < 1 then
//    Exit;
//  FLogRecv(TimeToString + ': ' + inttostr(receivedByte));
//  GetMem(lbuffer, receivedByte + 1);
//  readByte := TWSocket(Sender).Receive(lbuffer, receivedByte);
//  if readByte < 1 then
//    Exit;
//  p := cCon.FBuffer + cCon.FBufferNow;
//  CopyMemory(PAnsiChar(p), lbuffer, readByte);
//  Inc(cCon.FBufferNow, readByte);
//  p := cCon.FBuffer;
//  bCount := cCon.FBufferNow;
//  findRec := True;
//  while findRec and (bCount >= CMAX_PACKET_BYTESIZE) do
//  begin
//    pSize := p;
//    recSize := pSize^;
//    findRec := bCount >= recSize;
//    if (findRec) then
//    begin
//      // PacketRecognizer(p, recSize, cCon.ConnectedIP); // ambil 1 record, lempar.
//      FDataBuffer.PutPacket(p, recSize, cCon.ConnectedIP);
//      // ambil 1 record, lempar.
//      bCount := bCount - recSize;
//      p := pByte(Integer(p) + recSize);
//    end;
//  end;
//  if bCount > 0 then
//  begin
//    CopyMemory(cCon.FBuffer, p, bCount); // geser data ke awal FBuffer
//  end;
//  cCon.FBufferNow := bCount;
//  FreeMem(lbuffer);
//end;

procedure TNetLinkServer.Client_OnDataSent(Sender: TObject; Error: Word);
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

procedure TNetLinkServer.Client_OnDataAvailable(Sender: TObject; Error: Word);
var
  cCon: TConnectedClient;
  ipSend: string;
  receivedByte: Integer;
  readBytes: TBytes;
begin
  if Assigned(FLogStat) then
    FLogStat(TimeToString + ': Receive Error Code : ' + inttostr(Error));

  if Error <> 0 then
    Exit;

  cCon := TConnectedClient(Sender);
  ipSend:= cCon.PeerAddr;

  try
    //FillChar(cCon.FBuffer[0], Length(cCon.FBuffer), 0);
    receivedByte:= TWSocket(Sender).Receive(cCon.FBuffer,
      Length(cCon.FBuffer));
    if Assigned(FLogRecv) then
      FLogRecv(TimeToString + ': ReceivedBytes = ' + inttostr(receivedByte));
    if receivedByte < 1 then
      Exit;

    // svrIP := TWSocket(Sender).Addr;

    SetLength(readBytes, receivedByte);
    Move(cCon.FBuffer[0], readBytes[0], receivedByte);
    cCon.Packetizer.DataReceived(readBytes);

  finally

  end;
end;

procedure TNetLinkServer.Client_OnBGException(Sender: TObject; E: Exception;
  var CanClose: Boolean);
begin
  if Assigned(FLogStat) then
    FLogStat(TimeToString + ': ' + 'Client exception occured: ' + E.ClassName + ': ' +
      E.Message);
  CanClose := True;
end;

function TNetLinkServer.getClient(i: Integer): TWSocketClient;
begin
  Result := nil;
  if i < WSockServer.ClientCount then
    Result := WSockServer.Client[i]
end;

function TNetLinkServer.getClientCount: Integer;
begin
  Result:= WSockServer.ClientCount;
end;

function TNetLinkServer.GetConnectedClient(i: Integer): TConnectedClient;
begin
  Result := nil;
  if i < WSockServer.ClientCount then
    Result := WSockServer.Client[i] as TConnectedClient
end;

function TNetLinkServer.getConnectedClientCount: Integer;
begin
  // kalo pakai WSockServer.ClientCount, waktu event client onDisconnect
  // client yg sedang OnDisconnect masih dihitung.
  // Result := WSockServer.ClientCount;
  Result := FIPIndex.Count;
end;

procedure TNetLinkServer.FlushSendData;
var
  cCon: TConnectedClient;
  i: Integer;
begin
  for i:= 0 to WSockServer.ClientCount - 1 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
    begin
      if not cCon.AllSent then
      begin
        if Assigned(FLogSend) then
          FLogSend(TimeToString + ': Flush ' + cCon.ConnectedIP + ':' +
            cCon.ConnectedPort);
        cCon.Flush;
      end;
    end;
  end;
end;

procedure TNetLinkServer.GetConnectedList(var sl: TStringList);
var
  cCon: TConnectedClient;
  i: Integer;
begin
  if not Assigned(sl) then
    sl := TStringList.Create;
  sl.Clear;

  for i:= 0 to WSockServer.ClientCount - 1 do
  begin
    cCon:= TConnectedClient(WSockServer.Client[i]);
    if (cCon <> nil) and (cCon.State = wsConnected) then
      sl.Add(cCon.PeerAddr + ':' + cCon.PeerPort);
  end;
end;

procedure TNetLinkServer.GetPacket;
begin
  FDataQueue.GetPacket;
end;

procedure TNetLinkServer.RegisterProcedure(const aType: Word;
  aProcedure: TPacketHandlerProc);
begin
//  if Assigned(FRegProcs) and Assigned(aProcedure) then
  if Assigned(FRegProcs) then
    FRegProcs.Register(aType, aProcedure);
end;

procedure TNetLinkServer.UnRegisterProcedure(const aType: Word);
begin
  if Assigned(FRegProcs) then
    FRegProcs.UnRegister(aType);
end;

procedure TNetLinkServer.UnregisterAllProcedure;
begin
  if Assigned(FRegProcs) then
    FRegProcs.UnregisterALL;
end;

{ TConnectedClient }

procedure TConnectedClient.MessageArrived(const AData: TBytes);
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

    AInfo.SenderAddress:= StrToLongIP(GetPeerAddr);
    AInfo.SenderPort:= StrToInt(GetPeerPort);

    AInfo.SentTime:= AHeader.SentTime;

    dtutc:= TTimeZone.Local.ToUniversalTime(Now);
    AInfo.ReceiveTime:= DateTimeToUnixMs(dtutc, False);

    FDataQueue.PutPacket(AInfo, AContent);
  end
  else
  begin
    if Assigned(FLogStat) then
      FLogStat(TimeToString + ': Unknown Packet !!!');
  end;

end;

end.

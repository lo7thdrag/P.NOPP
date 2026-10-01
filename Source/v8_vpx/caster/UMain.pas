unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  USettings,

  UNetLinkServer,
  UNetLinkClient,
  uDataType,
  UPacketHelper,

  //UJPEGCompression,

  UCommands,
  UData,

  UCaptureScreen, Vcl.AppEvnts,

  libyuv, video_encoder_vpx, vp8cx,
  VPXRegionEncoder, vpx_codec, vpx_encoder, vpx_image;

const
  WM_APP_STARTUP  = WM_USER + 1;
  WM_CASTING = WM_USER + 2;
  WM_CAST_GET_PACKET = WM_USER + 3;

type
  TFrmMain = class(TForm)
    PnlTop: TPanel;
    MmoLog: TMemo;
    tmrClientGetPacket: TTimer;
    tmrClientCheckConnection: TTimer;
    Label1: TLabel;
    edtFPS: TEdit;
    tmrFPS: TTimer;
    tmrCasting: TTimer;
    tmrCastGetPacket: TTimer;
    ApplicationEvents1: TApplicationEvents;
    TrayIcon1: TTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrClientGetPacketTimer(Sender: TObject);
    procedure tmrClientCheckConnectionTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrFPSTimer(Sender: TObject);
    procedure tmrCastGetPacketTimer(Sender: TObject);
    procedure tmrCastingTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private
    { Private declarations }
    AppSetting: TCasterSetting;

    Client: TNetLinkClient;

    ServerCast: TNetLinkServer;

    SrcRegion: TRect;
    DestRegion: TRect;

    CaptureBitmap: TBitmap;
    CompressedStream: TMemoryStream;

    Encoder: TVpxEncoder;

    SendCount: Integer;

//    is_Image_ACK_Received: Boolean;
//    ACKCount: Integer;

    procedure Handle_WM_APP_STARTUP(var Msg: TMessage); message WM_APP_STARTUP;
    procedure Handle_WM_CASTING(var Msg: TMessage); message WM_CASTING;
    procedure Handle_WM_CAST_GET_PACKET(var Msg: TMessage); message WM_CAST_GET_PACKET;

    procedure Log(AMessage: string);

    procedure OnClientCastConnect(const AClient: TConnectedClient; const S: string);
    procedure OnClientCastDisconnect(const AClient: TConnectedClient; const S: string);

    procedure OnLogReceivedCast(const S: string);

    procedure OnConnected(Sender: TObject);
    procedure OnDisconnected(Sender: TObject);

    procedure OnLogReceived(const S: string);

    procedure NetHandler_CMD_CON_ALL_WHOAREYOU(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandler_CMD_CON_MOC_GET_INFO_PORT(AHeader: TPacketInfo; AContent: TBytes);

    procedure NetHandler_ReceiveImage(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandler_ReceiveImageACK(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandler_ReceiveString(AHeader: TPacketInfo; AContent: TBytes);

    procedure NetHandler_ReceivePingACK(AHeader: TPacketInfo; AContent: TBytes);

    procedure SetSizeBitmap(ABitmap: TBitmap; AWidth, AHeight: Integer);
    procedure ScreenShot(DestBitmap: TBitmap);
    procedure Shot;
    procedure SendImageStream;

    procedure StartCastServer;
    procedure StopCastServer;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

// Converts a TMemoryStream to a byte array (TBytes)
function MemoryStreamToBytes(M: TMemoryStream): TBytes;
begin
  SetLength(Result, M.Size);
  // Set the length of the result array to match the stream size
  if M.Size > 0 then
    Move(M.Memory^, Result[0], M.Size);
  // Copy the stream's memory to the byte array
end;


procedure TFrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide;
  WindowState:= wsMinimized;

  TrayIcon1.Visible := True;
//  TrayIcon1.Animate := True;
//  TrayIcon1.ShowBalloonHint;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ServerCast.UnregisterAllProcedure;
  ServerCast.Stop;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  MmoLog.Lines.Add('Loading App Setting ...');
  AppSetting:= TCasterSetting.Create;
  if not AppSetting.LoadFromFile('settings.json') then
  begin
    ShowMessage('Error Loading Setting');
    PostQuitMessage(1);
  end;
  MmoLog.Lines.Add('Loading App Setting done.');

  TrayIcon1.Hint := 'Screen Caster';
//  TrayIcon1.AnimateInterval := 200;

//  TrayIcon1.BalloonTitle := 'Restoring the window.';
//  TrayIcon1.BalloonHint :=
//    'Double click the system tray icon to restore the window.';
//  TrayIcon1.BalloonFlags := bfInfo;

  PostMessage(Handle, WM_APP_STARTUP, 0, 0);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  tmrClientCheckConnection.Enabled:= False;
  tmrClientGetPacket.Enabled:= False;

  tmrCastGetPacket.Enabled:= False;

  Client.UnregisterAllProcedure;

  Client.OnRecvLog:= nil;
  Client.OnSendLog:= nil;
  Client.OnStatusLog:= nil;
  Client.OnlogRecv:= nil;
  CLient.OnDisConnected:= nil;
  Client.OnConnected:= nil;

  Client.Disconnect;
  FreeAndNil(Client);

  ServerCast.UnregisterAllProcedure;
  ServerCast.Stop;
  FreeAndNil(ServerCast);

  FreeAndNil(AppSetting);

  if Assigned(Encoder) then
    FreeAndNil(Encoder);

  if Assigned(CompressedStream) then
    FreeAndNil(CompressedStream);
  FreeAndNil(CaptureBitmap);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
//  PostMessage(Handle, WM_APP_STARTUP, 0, 0);
end;

procedure TFrmMain.Log(AMessage: string);
begin
  MmoLog.Lines.Add(AMessage);
end;

procedure TFrmMain.tmrCastGetPacketTimer(Sender: TObject);
begin
//  TTimer(Sender).Enabled:= False;
//  serverCast.GetPacket;
//  TTimer(Sender).Enabled:= True;
  PostMessage(Handle, WM_CAST_GET_PACKET, 0, 0);
end;

procedure TFrmMain.tmrCastingTimer(Sender: TObject);
begin
//  TTimer(Sender).Enabled:= False;
//  if ServerCast.ClientCount > 0 then
//  begin
////    if is_Image_ACK_Received then
////    begin
////      is_Image_ACK_Received:= False;
//
//      Shot;
//      SendImageStream;
//
//      SendCount:= SendCount + 1;
////    end;
//  end;
//  TTimer(Sender).Enabled:= True;
  PostMessage(Handle, WM_CASTING, 0, 0);
end;

procedure TFrmMain.tmrClientCheckConnectionTimer(Sender: TObject);
begin
  if not Client.Connected then
    Client.Connect(AppSetting.ControllerAddress, AppSetting.ControllerPort.ToString);
end;

procedure TFrmMain.tmrClientGetPacketTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled:= False;
  try
    Client.GetPacket;
  finally
    TTimer(Sender).Enabled:= True;
  end;
end;

procedure TFrmMain.tmrFPSTimer(Sender: TObject);
begin
  edtFPS.Text:= SendCount.ToString;
  SendCount:= 0;
end;

procedure TFrmMain.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TFrmMain.Handle_WM_APP_STARTUP(var Msg: TMessage);
begin
  Client:= TNetLinkClient.Create;

  Client.OnConnected:= OnConnected;
  Client.OnDisConnected:= OnDisconnected;

  Client.OnlogRecv:= OnLogReceived;
  Client.OnStatusLog:= OnLogReceived;
  Client.OnSendLog:= OnLogReceived;
  Client.OnRecvLog:= OnLogReceived;

  client.RegisterProcedure(CMD_CON_ALL_WHOAREYOU, NetHandler_CMD_CON_ALL_WHOAREYOU);
  client.RegisterProcedure(CMD_MOC_CON_WHOIAM, nil);
  client.RegisterProcedure(CMD_CON_MOC_GET_INFO_PORT, NetHandler_CMD_CON_MOC_GET_INFO_PORT);
  client.RegisterProcedure(CMD_MOC_CON_INFO_PORT, nil);

//  is_Image_ACK_Received:= False;
//  ACKCount:= 0;

  SrcRegion.Left:= AppSetting.SourceRegion.Left;
  SrcRegion.Top:= AppSetting.SourceRegion.Top;
  SrcRegion.Width:= AppSetting.SourceRegion.Width;
  SrcRegion.Height:= AppSetting.SourceRegion.Height;

  DestRegion.Left:= AppSetting.DestinationRegion.Left;
  DestRegion.Top:= AppSetting.DestinationRegion.Top;
  DestRegion.Width:= AppSetting.DestinationRegion.Width;
  DestRegion.Height:= AppSetting.DestinationRegion.Height;

  // Create encoder
  Encoder := TVpxEncoder.Create(vctVP8);

  CaptureBitmap := TBitmap.Create;
  CaptureBitmap.PixelFormat:= pf32bit;

  SetSizeBitmap(CaptureBitmap, DestRegion.Width, DestRegion.Height);

  //CompressedStream := TBytesStream.Create;\
  CompressedStream:= nil;

  ServerCast:= TNetLinkServer.Create;
  ServerCast.OnClient_Connect:= OnClientCastConnect;
  ServerCast.OnClient_DisConnect:= OnClientCastDisconnect;

  ServerCast.OnStatusLog:= OnLogReceivedCast;
  ServerCast.OnSendLog:= OnLogReceivedCast;
  ServerCast.OnRecvLog:= OnLogReceivedCast;

  ServerCast.RegisterProcedure(ID_IMG, NetHandler_ReceiveImage);
  ServerCast.RegisterProcedure(ID_IMG_ACK, NetHandler_ReceiveImageACK);
  ServerCast.RegisterProcedure(ID_STR, NetHandler_ReceiveString);

  ServerCast.RegisterProcedure(ID_IMG_ACK, NetHandler_ReceiveImageACK);

  tmrCasting.Interval := 1000 div AppSetting.CastFPS;

  tmrCastGetPacket.Interval:= 1000 div AppSetting.CastFPS;

  StartCastServer;

  tmrClientGetPacket.Interval:= 1000 div 30;

  tmrClientCheckConnection.Interval:= 1000 * 10;
  tmrClientCheckConnection.Enabled:= True;

  Hide;
  TrayIcon1.Visible:= True;

  // Tell Windows this is a high-performance application
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST);
end;

procedure TFrmMain.Handle_WM_CASTING(var Msg: TMessage);
begin
//  TTimer(Sender).Enabled:= False;
  if ServerCast.ClientCount > 0 then
  begin
//    if is_Image_ACK_Received then
//    begin
//      is_Image_ACK_Received:= False;

    Shot;
    SendImageStream;
    SendCount:= SendCount + 1;

//    end;
  end;
//  TTimer(Sender).Enabled:= True;
end;

procedure TFrmMain.Handle_WM_CAST_GET_PACKET(var Msg: TMessage);
begin
//  TTimer(Sender).Enabled:= False;
  serverCast.GetPacket;
//  TTimer(Sender).Enabled:= True;
end;

// =============================================================================

procedure TFrmMain.OnClientCastConnect(const AClient: TConnectedClient;
  const S: string);
begin
//  is_Image_ACK_Received:= True;
//  ACKCount:= 0;
  Log('[CAST] ' + S + ' connected.');
end;

procedure TFrmMain.OnClientCastDisconnect(const AClient: TConnectedClient;
  const S: string);
begin
//  is_Image_ACK_Received:= False;
//  ACKCount:= 0;
  Log('[CAST] ' + S + ' disconnected.');

  Log('[CAST] Resetting encoder ...');
  // Reset encoder state
  if Assigned(Encoder) then
  begin
    try
      FreeAndNil(Encoder);
      Encoder := TVpxEncoder.Create(vctVP8);
      Log('[CAST] Encoder successfully reset.');
    except
      on E: Exception do
        Log('[CAST] Error resetting encoder: ' + E.Message);
    end;
  end;
end;

procedure TFrmMain.OnLogReceivedCast(const S: string);
begin
//  Log('[CAST] ' + S);
end;

procedure TFrmMain.ScreenShot(DestBitmap: TBitmap);
var
  isRegion: Boolean;
  isResize: Boolean;
begin
  isRegion:= False;
  if (SrcRegion.Width=DestRegion.Width) and (SrcRegion.Height=DestRegion.Height) then
    isRegion:= True;

  if isRegion then
    TCaptureScreen.RegionScreenshot(DestBitmap, SrcRegion)
  else
    TCaptureScreen.RegionResizeScreenshot(DestBitmap, SrcRegion, DestRegion);
end;

procedure TFrmMain.SendImageStream;
var
  ABytes: TBytes;
begin
  if Assigned(CompressedStream) then begin
    CompressedStream.Position := 0;
    //server.SendData(ID_IMG, CompressedStream);
    //ServerCast.SendData(ID_IMG, CompressedStream.Bytes);
    ABytes:= MemoryStreamToBytes(CompressedStream);
    ServerCast.SendData(ID_IMG, ABytes);
    if Assigned(CompressedStream) then
      FreeAndNil(CompressedStream);
  end;
end;

procedure TFrmMain.SetSizeBitmap(ABitmap: TBitmap; AWidth, AHeight: Integer);
begin
  ABitmap.Width := AWidth;
  ABitmap.Height := AHeight;
end;

procedure TFrmMain.Shot;
//var
//  NormalizedBitmap: TBitmap;
begin
  ScreenShot(CaptureBitmap);

  //TLibTurboJPEG.CompressJPEG(CaptureBitmap, CompressedStream, 95);

  try
    CompressedStream := Encoder.Encode(CaptureBitmap);
  except
    if Assigned(CompressedStream) then
      FreeAndNil(CompressedStream)
  end;

//  mmoLog.Lines.Add('Before Compression: ' + (CaptureBitmap.Width*CaptureBitmap.Height*3).ToString + ' Bytes');
//  mmoLog.Lines.Add('After Compression: ' + CompressedStream.Size.ToString + ' Bytes');
end;

procedure TFrmMain.StartCastServer;
begin
  ServerCast.Listen(AppSetting.Port.ToString);
  SendCount:= 0;
  tmrCastGetPacket.Enabled:= True;
  tmrCasting.Enabled:= True;
  tmrFPS.Enabled:= True;
end;

procedure TFrmMain.StopCastServer;
begin
  ServerCast.Stop;
  tmrCastGetPacket.Enabled:= False;
  tmrCasting.Enabled:= False;
  tmrFPS.Enabled:= False;
end;

procedure TFrmMain.OnConnected(Sender: TObject);
begin
  tmrClientGetPacket.Enabled:= True;
  Log('Connected to ' + Client.PeerAddress + ':' + Client.PeerPort);
end;

procedure TFrmMain.OnDisconnected(Sender: TObject);
begin
  Log('Disconnected from ' + Client.PeerAddress + ':' + Client.PeerPort);
  tmrClientGetPacket.Enabled:= False;
end;

procedure TFrmMain.OnLogReceived(const S: string);
begin
  Log(S);
end;

// =============================================================================

procedure TFrmMain.NetHandler_CMD_CON_ALL_WHOAREYOU(AHeader: TPacketInfo; AContent: TBytes);
var
  s: string;
  ABytes: TBytes;
begin
  Log('CMD : CMD_CON_ALL_WHOAREYOU');
  Log('Length : '+Length(AContent).ToString);
  s:= AppSetting.ID.ToString;
  ABytes:= TEncoding.UTF8.GetBytes(s);
  Log('Send CMD : CMD_MOC_CON_WHOIAM');
  Client.SendData(CMD_MOC_CON_WHOIAM, ABytes);
end;

procedure TFrmMain.NetHandler_CMD_CON_MOC_GET_INFO_PORT(AHeader: TPacketInfo;
  AContent: TBytes);
var
  s: string;
  ABytes: TBytes;
begin
  Log('CMD : CMD_CON_MOC_GET_INFO_PORT');
  s:= AppSetting.Port.ToString;
  ABytes:= TEncoding.UTF8.GetBytes(s);
  Log('Send CMD : CMD_MOC_CON_INFO_PORT');
  Client.SendData(CMD_MOC_CON_INFO_PORT, ABytes);
end;

procedure TFrmMain.NetHandler_ReceiveImage(AHeader: TPacketInfo;
  AContent: TBytes);
begin

end;

procedure TFrmMain.NetHandler_ReceiveImageACK(AHeader: TPacketInfo;
  AContent: TBytes);
//var
//  s: string;
begin
//  s:= TEncoding.UTF8.GetString(AContent);
//  if s='IMG_OK' then
//  begin
//    is_Image_ACK_Received:= True;
//    ACKCount:= ACKCount + 1;
//  end;
end;

procedure TFrmMain.NetHandler_ReceivePingACK(AHeader: TPacketInfo;
  AContent: TBytes);
//var
//  s: string;
begin
//  s:= TEncoding.UTF8.GetString(AContent);
//  if s='IMG_OK' then
//  begin
//    is_Image_ACK_Received:= True;
//    ACKCount:= ACKCount + 1;
//  end;
end;

procedure TFrmMain.NetHandler_ReceiveString(AHeader: TPacketInfo;
  AContent: TBytes);
var
  s: string;
begin
  s:= TEncoding.UTF8.GetString(AContent);
  mmoLog.Lines.Add('Receive String : '+s)
end;

end.

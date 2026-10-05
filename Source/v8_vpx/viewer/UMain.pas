unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,

  USettings,

  UNetLinkClient,
  uDataType,
  UPacketHelper,

  UCommands,
  uData,
  uProcessManager,

//  UJPEGCompression,

  video_decoder_vpx;

const
  WM_APP_INIT  = WM_USER + 1;
  WM_CLIENT_CHECK_CONNECTION = WM_USER + 2;
  WM_CLIENT_GET_PACKET = WM_USER + 3;
  WM_CAST_GET_PACKET = WM_USER + 4;

  TextPadding = 20;

type
  TCustomControlHack = class(TCustomControl);

  TFrmMain = class(TForm)
    tmrClientGetPacket: TTimer;
    tmrClientCheckConnection: TTimer;
    tmrCastGetPacket: TTimer;
    tmrFPS: TTimer;
    pbDraw: TPaintBox;
    pnlDraw: TPanel;
    pnlOfficial: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure tmrClientGetPacketTimer(Sender: TObject);
    procedure tmrClientCheckConnectionTimer(Sender: TObject);
    procedure tmrCastGetPacketTimer(Sender: TObject);
    procedure tmrFPSTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pbDrawDblClick(Sender: TObject);
    procedure pbDrawPaint(Sender: TObject);
  private
    { Private declarations }
    AppSetting: TViewerSetting;
    Client: TNetLinkClient;
    ClientCast: TNetLinkClient;
    CastMocRole: string;

    CompressedStream: TMemoryStream;
    Decoder: TVpxDecoder;

    ScreenBitmap: TBitmap;
    TitleBitmap: TBitmap;
    DecodedBitmap: TBitmap;

    recvCount: Integer;
    isUpdateTitle: Boolean;

    procedure Log(AMessage: string);

    procedure OnClientConnected(Sender: TObject);
    procedure OnClientDisconnected(Sender: TObject);

    procedure OnClientLogReceived(const S: string);

    procedure OnCastConnected(Sender: TObject);
    procedure OnCastDisconnected(Sender: TObject);

    procedure OnCastLogReceived(const S: string);

    procedure NetHandler_CMD_CON_ALL_WHOAREYOU(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandler_CMD_CON_MON_CONNECTION_MON_TO_MOC(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandler_CMD_CON_MON_RESTART(AHeader: TPacketInfo; AContent: TBytes);

    procedure NetHandler_String(AInfo: TPacketInfo; AContent: TBytes);
    procedure NetHandler_Image(AInfo: TPacketInfo; AContent: TBytes);
    procedure NetHandler_ImageACK(AInfo: TPacketInfo; AContent: TBytes);

    procedure Handle_WM_APPINIT(var AMsg: TMessage); message WM_APP_INIT;
    procedure Handle_WM_CLIENT_CHECK_CONNECTION(var AMsg: TMessage); message WM_CLIENT_CHECK_CONNECTION;
    procedure Handle_WM_CLIENT_GET_PACKET(var AMsg: TMessage); message WM_CLIENT_GET_PACKET;

    procedure Handle_WM_CAST_GET_PACKET(var AMsg: TMessage); message WM_Cast_GET_PACKET;

    procedure DrawAText(ACanvas: TCanvas; Region: TRect; AText: string);

//    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses UFrmCommand;

procedure EnableComposited(WinControl:TWinControl);
var
  i:Integer;
  NewExStyle:DWORD;
begin
  NewExStyle := GetWindowLong(WinControl.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED;
  SetWindowLong(WinControl.Handle, GWL_EXSTYLE, NewExStyle);

  for I := 0 to WinControl.ControlCount - 1 do
    if WinControl.Controls[i] is TWinControl then
      EnableComposited(TWinControl(WinControl.Controls[i]));
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tmrClientCheckConnection.Enabled:= False;
  tmrClientGetPacket.Enabled:= False;
  tmrCastGetPacket.Enabled:= False;
  tmrFPS.Enabled:= False;

  ClientCast.UnregisterAllProcedure;
  CLientCast.OnRecvLog:= nil;
  CLientCast.OnSendLog:= nil;
  CLientCast.OnStatusLog:= nil;
  CLientCast.OnlogRecv:= nil;
  CLientCast.OnDisConnected:= nil;
  CLientCast.OnConnected:= nil;

  Client.UnregisterAllProcedure;

  Client.OnRecvLog:= nil;
  Client.OnSendLog:= nil;
  Client.OnStatusLog:= nil;
  Client.OnlogRecv:= nil;
  CLient.OnDisConnected:= nil;
  Client.OnConnected:= nil;

  Client.Disconnect;

  ClientCast.Disconnect;
  CanClose:= True;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  //ControlStyle:= ControlStyle + [csOpaque];
  DoubleBuffered:= False;
  EnableComposited(pnlDraw);
  CastMocRole:= '';
  Color:= clBlack;
  FrmCommand:= TFrmCommand.Create(Application);
  FrmCommand.MainFormHandle:= Self.Handle;

  Log('Loading App Setting ...');
  AppSetting:= TViewerSetting.Create;
  if not AppSetting.LoadFromFile('RemoteViewerSettings.json') then
  begin
    ShowMessage('Error Loading Setting');
    PostQuitMessage(1);
  end;
  Log('Loading App Setting done.');

  PostMessage(Handle, WM_APP_INIT, 0, 0);
end;

procedure TFrmMain.FormDblClick(Sender: TObject);
begin
  frmCommand.Visible:= not frmCommand.Visible;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CLientCast);
  FreeAndNil(Client);
  FreeAndNil(AppSetting);
  if Assigned(DecodedBitmap) then
    FreeAndNil(DecodedBitmap);
  if Assigned(TitleBitmap) then
    FreeAndNil(TitleBitmap);
  if Assigned(ScreenBitmap) then
    FreeAndNil(ScreenBitmap);
  if Assigned(CompressedStream) then
    FreeAndNil(CompressedStream);
  if Assigned(Decoder) then
    FreeAndNil(Decoder);
end;

procedure TFrmMain.Handle_WM_APPINIT(var AMsg: TMessage);
begin
  isUpdateTitle:= False;
  Decoder := TVpxDecoder.Create;

  CompressedStream:= TMemoryStream.Create;

  ScreenBitmap := TBitmap.Create;
  ScreenBitmap.PixelFormat := pf32bit;
  ScreenBitmap.HandleType := bmDIB;
  ScreenBitmap.Canvas.Font.Quality := fqClearType;
  ScreenBitmap.SetSize(Screen.Monitors[0].Width, Screen.Monitors[0].Height);

  ScreenBitmap.Canvas.Brush.Color:= clBlack;

  ScreenBitmap.Canvas.Brush.Style:= bsSolid;
  ScreenBitmap.Canvas.FillRect(ClientRect);

  ScreenBitmap.Canvas.Font.Name:= AppSetting.TitleFontName;
  ScreenBitmap.Canvas.Font.Size:= AppSetting.TitleFontSize;
  ScreenBitmap.Canvas.Font.Style:= [fsBold];
  ScreenBitmap.Canvas.Font.Color:= clWhite;
  ScreenBitmap.Canvas.TextOut(AppSetting.TitlePosX, AppSetting.TitlePosY, AppSetting.TitleText + ' ' + AppSetting.ID.ToString);

  TitleBitmap:= TBitmap.Create;
  TitleBitmap.PixelFormat := pf32bit;
  TitleBitmap.HandleType := bmDIB;
  TitleBitmap.Canvas.Font.Quality := fqClearType;

  DecodedBitmap:= nil;

  Client:= TNetLinkClient.Create;

  Client.OnConnected:= OnClientConnected;
  Client.OnDisConnected:= OnClientDisconnected;

  Client.OnlogRecv:= OnClientLogReceived;
  Client.OnStatusLog:= OnClientLogReceived;
  Client.OnSendLog:= OnClientLogReceived;
  Client.OnRecvLog:= OnClientLogReceived;

  Client.RegisterProcedure(CMD_CON_ALL_WHOAREYOU, NetHandler_CMD_CON_ALL_WHOAREYOU);
  Client.RegisterProcedure(CMD_MON_CON_WHOIAM, nil);

  Client.RegisterProcedure(CMD_CON_MON_CONNECTION_MON_TO_MOC, NetHandler_CMD_CON_MON_CONNECTION_MON_TO_MOC);
  Client.RegisterProcedure(CMD_CON_MON_RESTART, NetHandler_CMD_CON_MON_RESTART);
  Client.RegisterProcedure(CMD_MON_CON_CAST_STATUS, nil);

  ClientCast:= TNetLinkClient.Create;

  ClientCast.OnConnected:= OnCastConnected;
  ClientCast.OnDisConnected:= OnCastDisconnected;

  ClientCast.OnlogRecv:= OnCastLogReceived;
  ClientCast.OnStatusLog:= OnCastLogReceived;
  ClientCast.OnSendLog:= OnCastLogReceived;
  ClientCast.OnRecvLog:= OnCastLogReceived;

  ClientCast.RegisterProcedure(ID_IMG, NetHandler_Image);
  ClientCast.RegisterProcedure(ID_IMG_ACK, NetHandler_ImageACK);
  ClientCast.RegisterProcedure(ID_STR, NetHandler_String);

  tmrClientGetPacket.Interval:= 1000 div 30;
  tmrCastGetPacket.Interval:= 1000 div 60;

  tmrClientCheckConnection.Interval:= 10000;
  tmrClientCheckConnection.Enabled:= True;

  tmrFPS.Interval:= 1000;
  tmrFPS.Enabled:= True;

  pbDraw.Canvas.Brush.Color:= clBlack;
  pbDraw.Canvas.Brush.Style:= bsSolid;
  pbDraw.Canvas.FillRect(ClientRect);
end;

procedure TFrmMain.Log(AMessage: string);
begin
  FrmCommand.MmoLog.Lines.Add(AMessage);
end;

procedure TFrmMain.tmrClientCheckConnectionTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_CLIENT_CHECK_CONNECTION, 0, 0);
end;

procedure TFrmMain.tmrClientGetPacketTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_CLIENT_GET_PACKET, 0, 0);
end;

procedure TFrmMain.tmrCastGetPacketTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_CAST_GET_PACKET, 0, 0)
end;

procedure TFrmMain.tmrFPSTimer(Sender: TObject);
begin
  frmCommand.edtFPS.Text:= recvCount.ToString;
  recvCount:= 0;
end;

//procedure TFrmMain.WMEraseBkgnd(var Message: TWMEraseBkgnd);
//begin
//  Message.Result := 1;
//end;

// =============================================================================

procedure TFrmMain.Handle_WM_CLIENT_CHECK_CONNECTION(var AMsg: TMessage);
begin
  if not Client.Connected then
    Client.Connect(AppSetting.ControllerAddress, AppSetting.ControllerPort.ToString);
end;

procedure TFrmMain.Handle_WM_CLIENT_GET_PACKET(var AMsg: TMessage);
begin
  Client.GetPacket;
end;

procedure TFrmMain.Handle_WM_CAST_GET_PACKET(var AMsg: TMessage);
begin
  ClientCast.GetPacket;
end;

// =============================================================================

procedure TFrmMain.OnClientConnected(Sender: TObject);
begin
  tmrClientGetPacket.Enabled:= True;
  Log('Connected to ' + Client.PeerAddress + ':' + Client.PeerPort);
end;

procedure TFrmMain.OnClientDisconnected(Sender: TObject);
begin
  Log('Disconnected from ' + Client.PeerAddress + ':' + Client.PeerPort);
  tmrClientGetPacket.Enabled:= False;
end;

procedure TFrmMain.OnClientLogReceived(const S: string);
begin
  Log(S);
end;

procedure TFrmMain.pbDrawDblClick(Sender: TObject);
begin
  FormDblClick(Self);
end;

procedure TFrmMain.pbDrawPaint(Sender: TObject);
var
  sw, sh: Integer;
  dw, dh: Integer;
  tw, th: Integer;
begin
  sw:= ScreenBitmap.Width;
  sh:= ScreenBitmap.Height;
  if Assigned(DecodedBitmap) then begin
    dw:= DecodedBitmap.Width;
    dh:= DecodedBitmap.Height;
    tw:= sw - dw;
    th:= sh;
    if DecodedBitmap.Width<Screen.Monitors[0].Width then begin
      if (TitleBitmap.Width<>tw) and
        (TitleBitmap.Height<>th) then begin
        TitleBitmap.SetSize(tw,th);
//        DrawAText(TitleBitmap.Canvas,Rect(0, 0, tw, th),CastMocRole);
      end;
      if isUpdateTitle then begin
        DrawAText(TitleBitmap.Canvas,Rect(0, 0, tw, th),CastMocRole);
        isUpdateTitle:= False;
      end;
      ScreenBitmap.Canvas.Draw(0, 0, TitleBitmap);
      ScreenBitmap.Canvas.Draw(tw, 0, DecodedBitmap)
    end
    else
      ScreenBitmap.Canvas.Draw(0, 0, DecodedBitmap);
  end;

  pbDraw.Canvas.Draw(0, 0, ScreenBitmap);

  if Assigned(DecodedBitmap) then
    FreeAndNil(DecodedBitmap);
end;

procedure TFrmMain.NetHandler_CMD_CON_ALL_WHOAREYOU(AHeader: TPacketInfo;
  AContent: TBytes);
var
  s: string;
  ABytes: TBytes;
begin
  Log('CMD : CMD_CON_ALL_WHOAREYOU');
  Log('Length : '+Length(AContent).ToString);
  s:= AppSetting.ID.ToString;
  ABytes:= TEncoding.UTF8.GetBytes(s);
  Client.SendData(CMD_MON_CON_WHOIAM, ABytes);
end;

procedure TFrmMain.NetHandler_CMD_CON_MON_CONNECTION_MON_TO_MOC(
  AHeader: TPacketInfo; AContent: TBytes);
var
  s: string;
  sl: TStringList;
//  ABytes: TBytes;
begin
  Log('CMD : CMD_CON_MON_CONNECTION_MON_TO_MOC');
  s:= TEncoding.UTF8.GetString(AContent);
  Log('Data : ' + s);
  sl:= TStringList.Create;
  try
    sl.Delimiter:= ';';
    sl.QuoteChar:= #0;
    sl.DelimitedText:= s;
    if sl[0]='CONNECT' then
    begin
//      if ClientCast.Connected then
//        ClientCast.Disconnect;
      if not ClientCast.Connected then begin
        ClientCast.Connect(sl[1], sl[2]);
        CastMocRole:= sl[3];
        isUpdateTitle:= True;

        pnlOfficial.Caption := sl[3] + ' ' + sl[4] + ' ' + sl[5];

        BorderStyle := bsNone;
        WindowState := wsMaximized;
        Self.Show;
      end;
    end
    else
    if sl[0]='DISCONNECT' then
    begin
      if ClientCast.Connected then begin
        ClientCast.Disconnect;
        CastMocRole:= '';
        isUpdateTitle:= True;

        pnlOfficial.Caption := '---';

        BorderStyle := bsSingle;
        WindowState := wsNormal;
        Self.Hide;
      end;
    end;
  finally
    FreeAndNil(sl);
  end;
end;

procedure TFrmMain.NetHandler_CMD_CON_MON_RESTART(AHeader: TPacketInfo; AContent: TBytes);
var
  s: string;
begin
  Log('CMD : CMD_CON_MON_RESTART');
  s:= TEncoding.UTF8.GetString(AContent);
  Log('Data : ' + s);
  if SameText(s, 'RESTART') then
    TProcessManager.RunExe('restart.exe');
end;

procedure TFrmMain.DrawAText(ACanvas: TCanvas; Region: TRect; AText: string);
var
  i, x, y,
  cwidth, cheight,
  maxswidth, maxsheight, sumsheight: integer;
  s: string;
begin

  maxswidth := -999999;
  maxsheight := -999999;
  sumsheight := 0;

  try

    ACanvas.Brush.Color:= $00333333;
    ACanvas.Brush.Style:= bsSolid;
    ACanvas.FillRect(Region);

    ACanvas.Font.Name:= AppSetting.TitleFontName;
    ACanvas.Font.Size:= AppSetting.TitleFontSize;
    ACanvas.Font.Style:= [fsBold];
    ACanvas.Font.Color:= clWhite;
    ACanvas.TextOut(AppSetting.TitlePosX, AppSetting.TitlePosY, AppSetting.TitleText + ' ' + AppSetting.ID.ToString);

//    ACanvas.Font.Name:= 'Verdana';
    ACanvas.Font.Size:= 72;
    ACanvas.Font.Style:= [fsBold];
//    ACanvas.Font.Color:= clWhite;

    for i := 1 to Length(AText) do
    begin
      s := AText[i];
      cwidth := ACanvas.TextWidth(s);
      if cwidth > maxswidth then
        maxswidth := cwidth;

      cheight := ACanvas.TextHeight(s);
      if cheight > maxsheight then
        maxsheight := cheight;
      sumsheight := sumsheight + cheight;
    end;

//    bmp.Width := maxswidth + TextPadding;
//    bmp.Height := sumsheight;
//
//    bmp.Width:= mmoInputText.Width;
//    bmp.Height:= mmoInputText.Height;

//    y := (Region.Height-sumsheight) div 2-maxsheight;
    y := (Region.Height-sumsheight) div 2;
    for i := 1 to Length(AText) do
    begin
      s := AText[i];
      if s='' then
        s:= ' ';
      x:= (Region.Width-ACanvas.TextWidth(s)) div 2;
//      ACanvas.TextOut(TextPadding, y, s);
      ACanvas.TextOut(x, y, s);
      y := y+ACanvas.TextHeight(s)
    end;

  finally

  end;

end;


procedure TFrmMain.NetHandler_Image(AInfo: TPacketInfo; AContent: TBytes);
begin
//  TLibTurboJPEG.DecompressJPEG(AContent, Length(AContent), ScreenBitmap);
  if Length(AContent)=0 then
    Exit;

  // Use existing class-level FStream
  CompressedStream.Clear;
  CompressedStream.Write(AContent[0], Length(AContent));
  CompressedStream.Position := 0;
  try
    DecodedBitmap := Decoder.Decode(CompressedStream);
  except
  end;

  pbDrawPaint(Self);

  recvCount:= recvCount + 1;

//  ClientCast.SendData(ID_IMG_ACK, 'IMG_OK');
end;

procedure TFrmMain.NetHandler_ImageACK(AInfo: TPacketInfo; AContent: TBytes);
begin
//
end;

procedure TFrmMain.NetHandler_String(AInfo: TPacketInfo; AContent: TBytes);
begin
//
end;

// =============================================================================

procedure TFrmMain.OnCastConnected(Sender: TObject);
var
  s: string;
  ABytes: TBytes;
begin
  tmrCastGetPacket.Enabled:= True;
  recvCount:= 0;
  s:= 'CONNECTED';
  ABytes:= TEncoding.UTF8.GetBytes(s);
  Client.SendData(CMD_MON_CON_CAST_STATUS, ABytes);
  Log('[CAST] Connected to ' + CLientCast.PeerAddress + ':' + CLientCast.PeerPort);
end;

procedure TFrmMain.OnCastDisconnected(Sender: TObject);
var
  s: string;
  ABytes: TBytes;
begin
  s:= 'DISCONNECTED';
  ABytes:= TEncoding.UTF8.GetBytes(s);
  Client.SendData(CMD_MON_CON_CAST_STATUS, ABytes);
  Log('[CAST] Disconnected from ' + CLientCast.PeerAddress + ':' + CLientCast.PeerPort);
  tmrCastGetPacket.Enabled:= False;
  recvCount:= 0;

  ScreenBitmap.Canvas.Brush.Color:= clBlack;
  ScreenBitmap.Canvas.Brush.Style:= bsSolid;
  ScreenBitmap.Canvas.FillRect(ClientRect);

  ScreenBitmap.Canvas.Font.Name:= AppSetting.TitleFontName;
  ScreenBitmap.Canvas.Font.Size:= AppSetting.TitleFontSize;
  ScreenBitmap.Canvas.Font.Style:= [fsBold];
  ScreenBitmap.Canvas.Font.Color:= clWhite;
  ScreenBitmap.Canvas.TextOut(AppSetting.TitlePosX, AppSetting.TitlePosY, AppSetting.TitleText + ' ' + AppSetting.ID.ToString);

  pbDrawPaint(Self);
end;

procedure TFrmMain.OnCastLogReceived(const S: string);
begin
//  Log('[CAST] ' + S);
end;

end.

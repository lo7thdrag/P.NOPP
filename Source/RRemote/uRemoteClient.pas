unit uRemoteClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, uRemoteData, uRemoteHost, System.ZLib,
  OverbyteIcsWndControl, OverbyteIcsWSocket;

type
  TfrmRemoteClient = class(TForm)
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    btnConnect: TSpeedButton;
    btnDisconnect: TSpeedButton;
    pbScreen: TPaintBox;
    cbControl: TCheckBox;
    cbStretch: TCheckBox;
    imgStretch: TImage;
    procedure btnConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDisconnectClick(Sender: TObject);
    procedure FClientSessionConnected(Sender: TObject; ErrCode: Word);
    procedure FClientSessionClosed(Sender: TObject; ErrCode: Word);
    procedure FClientDataAvailable(Sender: TObject; ErrCode: Word);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pbScreenPaint(Sender: TObject);
    procedure pbScreenMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pbScreenMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbScreenMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure cbStretchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgStretchClick(Sender: TObject);
  private
    prmIp , prmPort  : string ;
    prmColor : integer ;
    prmControl : boolean;
    FClient: TWSocket;

    FBmp1, FBmp2: TBitmap;
    Fms1, Fms2: TMemoryStream;
    FRemInfoCmd: TRemoteInfo;
    FRemControlCmd: TRemoteCtlCmd;
    FRect: TRect;
    FColor: Byte;
    procedure SendRemoteCommand(ACmd: TRemoteCtlCmd);
    procedure ConnectToIP( const mIP , mPort : string ; mControlled  : boolean ; mColor : integer );
  public
  end;

var
  frmRemoteClient: TfrmRemoteClient;

implementation
{$R *.dfm}

procedure TfrmRemoteClient.ConnectToIP( const mIP , mPort : string ; mControlled : boolean ; mColor : integer );
begin
  case mColor of
    0: FColor := 1;
    1: FColor := 2;
    2: FColor := 3;
    3: FColor := 5;
    4: FColor := 6;
    5: FColor := 7;
  else
    FColor := 3;
  end;
  try
    FClient.Addr := mIP;
    FClient.Port := mPort;
    FClient.Connect;
  except on e: Exception do
    Label1.Caption := e.Message;
  end;

  cbControl.Checked := mControlled;

  BringToFront;

end;

procedure TfrmRemoteClient.FormCreate(Sender: TObject);
begin
  if ParamCount < 4 then
  begin
    ShowMessage('Not Enough Parameter');
    Application.Terminate;
  end
  else
  begin
    prmControl := false;
    prmColor   := 2;
    prmIp      := ParamStr(1);
    prmPort    := ParamStr(2);
    TryStrToInt(ParamStr(3),prmColor);
    TryStrToBool(ParamStr(4),prmControl);
    if ParamCount >= 5 then
      Caption := 'Screen Monitor : '+ UpperCase(ParamStr(5))
    else
      Caption := 'Screen Monitor : ['+ prmIp +']';
    FClient:= TWSocket.Create(Self);
    FClient.OnSessionConnected := FClientSessionConnected ;
    FClient.OnSessionClosed    := FClientSessionClosed ;
    FClient.OnDataAvailable    := FClientDataAvailable ;
    DoubleBuffered := True;
    FBmp1 := TBitmap.Create;
    FBmp2 := TBitmap.Create;
    Fms1  := TMemoryStream.Create;
    Fms2  := TMemoryStream.Create;
    FColor  := 3;
  end;
end;

procedure TfrmRemoteClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FClient.Close;
  FClient.OnSessionConnected := nil ;
  FClient.OnSessionClosed    := nil ;
  FClient.OnDataAvailable    := nil ;
  FClient.Free;

  FBmp1.Free;
  FBmp2.Free;
  Fms1.Free;
  Fms2.Free;
end;

procedure TfrmRemoteClient.cbStretchClick(Sender: TObject);
begin
  if cbStretch.Checked then
    pbScreen.Align := alClient
  else
  begin
    pbScreen.Align := alNone;
    pbScreen.Left   := 0;
    pbScreen.Top    := 0;
    pbScreen.Width  := FBmp2.Width;
    pbScreen.Height := FBmp2.Height;
  end;
end;

procedure TfrmRemoteClient.btnConnectClick(Sender: TObject);
var
  pForm: TfrmRemoteHost;
begin
  pForm := TfrmRemoteHost.Create(Self);
  if (pForm.ShowModal = mrOk) then
  begin
    if (Length(pForm.ComboBox1.Text) > 0) then
    begin
      case pForm.rg1.ItemIndex of
        0: FColor := 1;
        1: FColor := 2;
        2: FColor := 3;
        3: FColor := 5;
        4: FColor := 7;
      else
        FColor := 3;
      end;
      ConnectToIP(pForm.ComboBox1.Text, prmPort , False , FColor );
    end;
  end;
  pForm.Free;
end;

procedure TfrmRemoteClient.btnDisconnectClick(Sender: TObject);
begin
  FClient.Close;
  Fms1.Clear;
  Fms2.Clear;
  btnConnect.Enabled := True;
  btnDisconnect.Enabled := False;
end;

procedure TfrmRemoteClient.FClientSessionConnected(Sender: TObject; ErrCode: Word);
begin
  if (ErrCode <> 0) then
  begin
    ShowMessage('Connect Error!');
    btnConnect.Enabled    := True;
    btnDisconnect.Enabled := False;
    Close;
  end
  else
  begin
    Label1.Caption := 'Connected';
    btnConnect.Enabled    := False;
    btnDisconnect.Enabled := True;
    FRemInfoCmd.Head := True;
    FRemInfoCmd.Pos  := 0;
    FRemControlCmd.Cmd  := 1;
    FRemControlCmd.X    := FColor;
    FClient.Send(@FRemControlCmd, SizeOf(FRemControlCmd));
  end;
end;

procedure TfrmRemoteClient.FClientSessionClosed(Sender: TObject; ErrCode: Word);
begin
  btnConnect.Enabled    := True;
  btnDisconnect.Enabled := False;
  Label1.Caption := 'Connect Closed';
end;

procedure TfrmRemoteClient.FClientDataAvailable(Sender: TObject; ErrCode: Word);
var
  nLen: Integer;
begin
  try
    if FRemInfoCmd.Head then
    begin
      nLen := FClient.Receive(@FRemInfoCmd.Cmd[FRemInfoCmd.Pos], SizeOf(TRemoteCmd) - FRemInfoCmd.Pos);
      if (nLen > 0) then
      begin
        Inc(FRemInfoCmd.Pos, nLen);
        if (FRemInfoCmd.Pos = SizeOf(TRemoteCmd)) then
        begin
          FRemInfoCmd.Head := False;
          FRemInfoCmd.Pos  := 0;
          FRemInfoCmd.Rec  := 0;
          FRemInfoCmd.Size := TRemoteCmd(FRemInfoCmd.Cmd).Size;
          Fms1.SetSize(FRemInfoCmd.Size);
          Fms1.Position := 0;
        end;
      end;
      Exit;
    end;
    if (FRemInfoCmd.Size - FRemInfoCmd.Rec > BUFF_SIZE) then
      nLen := BUFF_SIZE
    else
      nLen := FRemInfoCmd.Size - FRemInfoCmd.Rec;
    nLen := FClient.Receive(@FRemInfoCmd.Buf[0], nLen);
    if (nLen > 0) then
    begin
      Fms1.WriteBuffer(FRemInfoCmd.Buf, nLen);
      Inc(FRemInfoCmd.Rec, nLen);
      if (FRemInfoCmd.Rec >= FRemInfoCmd.Size) then
      begin
        Fms2.Clear;
        Fms1.Position := 0;
        ZDecompressStream(Fms1, Fms2);
        Fms2.Position := 0;
        Label1.Caption := Format('%0.1fK', [Fms1.Size / 1024])+' ';
        try
          if (TRemoteCmd(FRemInfoCmd.Cmd).Cmd = 1) then
          begin
            FBmp2.LoadFromStream(Fms2);
            ScrollBox1.VertScrollBar.Position := 0;
            ScrollBox1.HorzScrollBar.Position := 0;
            pbScreen.Left   := 0;
            pbScreen.Top    := 0;
            pbScreen.Width  := FBmp2.Width;
            pbScreen.Height := FBmp2.Height;
          end
          else
          begin
            while (Fms2.Position < Fms2.Size) do
            begin
              Fms2.Read(FRect, SizeOf(TRect));
              with FBmp1 do
              begin
                Width  := FRect.Right  - FRect.Left;
                Height := FRect.Bottom - FRect.Top;
                LoadFromStream(Fms2);
              end;
              FBmp2.Canvas.Lock;
              FBmp1.Canvas.Lock;
              FBmp2.Canvas.Draw(FRect.Left, FRect.Top, FBmp1);
              FBmp1.Canvas.Unlock;
              FBmp2.Canvas.Unlock;
            end;
          end;
        except
        end;
        pbScreenPaint(Sender);
        FRemInfoCmd.Size := 0;
        FRemInfoCmd.Rec  := 0;
        FRemInfoCmd.Head := True;
      end;
    end;
  except on e: Exception do
    Label1.Caption := e.Message;
  end;
end;

procedure TfrmRemoteClient.pbScreenPaint(Sender: TObject);
begin
  if cbStretch.Checked then
    pbScreen.Canvas.StretchDraw(Rect(0, 0, pbScreen.Width, pbScreen.Height), FBmp2)
  else
    pbScreen.Canvas.Draw(0, 0, FBmp2);
end;

procedure TfrmRemoteClient.SendRemoteCommand(ACmd: TRemoteCtlCmd);
begin
  try
    if (FClient.State = wsConnected) then FClient.Send(@ACmd, SizeOf(TRemoteCtlCmd));
  except
  end;
end;

procedure TfrmRemoteClient.pbScreenMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if cbControl.Checked then
  begin
    FRemControlCmd.Cmd := C_RMT_MOUSE_MOVE;
    FRemControlCmd.X := X;
    FRemControlCmd.Y := Y;
    SendRemoteCommand(FRemControlCmd);
  end;
end;

procedure TfrmRemoteClient.pbScreenMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if cbControl.Checked then
  begin
    FRemControlCmd.X := X;
    FRemControlCmd.Y := Y;
    if (Button = mbLeft) then
      FRemControlCmd.Cmd := C_RMT_MOUSE_LEFT_DOWN
    else
      FRemControlCmd.Cmd := C_RMT_MOUSE_RIGHT_DOWN;
    SendRemoteCommand(FRemControlCmd);
  end
  else
  begin
    case Button of
      mbLeft: begin
          if (ssShift in Shift) then begin
            if Panel1.Visible then
              Panel1.Visible := False
            else
              Panel1.Visible := True;
          end;
        end;
    end;
  end;
end;

procedure TfrmRemoteClient.pbScreenMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if cbControl.Checked then
  begin
    FRemControlCmd.X := X;
    FRemControlCmd.Y := Y;
    if (Button = mbLeft) then
      FRemControlCmd.Cmd := C_RMT_MOUSE_LEFT_UP
    else
      FRemControlCmd.Cmd := C_RMT_MOUSE_RIGHT_UP;
    SendRemoteCommand(FRemControlCmd);
  end;
end;

procedure TfrmRemoteClient.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if cbControl.Checked then
  begin
    if (WheelDelta < 0) then
      FRemControlCmd.Cmd := C_RMT_MOUSE_WHEEL16
    else
      FRemControlCmd.Cmd := C_RMT_MOUSE_WHEEL17;
    FRemControlCmd.X := MousePos.X;
    FRemControlCmd.Y := MousePos.Y;
    SendRemoteCommand(FRemControlCmd);
  end;
end;

procedure TfrmRemoteClient.FormShow(Sender: TObject);
var
  i: Integer;
begin
  DefaultMonitor := dmPrimary;
  if Screen.MonitorCount > 1 then
    i := 1
  else
    i := 0;
  Width := Screen.Monitors[i].Width;
  Height := Screen.Monitors[i].Height;
  Left := Screen.Monitors[i].Left;
  Top := Screen.Monitors[i].Top;
  ConnectToIP(prmIp,prmPort,prmControl,prmColor);
end;

procedure TfrmRemoteClient.imgStretchClick(Sender: TObject);
begin
  if imgStretch.Tag = 0 then
  begin
    BorderStyle := bsNone;
    WindowState := wsMaximized;
    pbScreen.Align := alClient;

    imgStretch.Tag := 1;
  end
  else
  begin
    BorderStyle := bsSizeable;
    WindowState := wsNormal;
    pbScreen.Align := alNone;

    pbScreen.Left   := 0;
    pbScreen.Top    := 0;
    pbScreen.Width  := FBmp2.Width;
    pbScreen.Height := FBmp2.Height;

    imgStretch.Tag := 0;
  end;
end;

procedure TfrmRemoteClient.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if cbControl.Checked then
  begin
    FRemControlCmd.Cmd := C_RMT_FormKey_DOWN;
    FRemControlCmd.X := Key;
    SendRemoteCommand(FRemControlCmd);
  end;
end;

procedure TfrmRemoteClient.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if cbControl.Checked then
  begin
    FRemControlCmd.Cmd := C_RMT_FormKey_UP;
    FRemControlCmd.X := Key;
    SendRemoteCommand(FRemControlCmd);
  end;
end;

end.

unit uRemoteServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  OverbyteIcsWndControl, OverbyteIcsWSocket, OverbyteIcsWSocketS,
  uRemoteScreen, uRemoteData;

type
  TfrmMain = class(TForm)
    Memo1: TMemo;
    Timer1: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FServerClientConnect(Sender: TObject; Client: TWSocketClient; Error: Word);
    procedure FServerClientDisconnect(Sender: TObject; Client: TWSocketClient; Error: Word);
    procedure Timer1Timer(Sender: TObject);
  private
    FServer: TWSocketServer;
  public
    procedure AddMemoLines ( s : string );
  end;

  TRClient = class(TWSocketClient)
  protected
    FRemoteScreen: TRemoteScreen;
    FPos: Integer;
    FCmd: array[0..SizeOf(TRemoteCtlCmd) - 1] of AnsiChar;
    //
    procedure Error(Sender: TObject);
    procedure DataAvailable(Sender: TObject; ErrCode: Word);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    //
    property RemoteScreen : TRemoteScreen read FRemoteScreen;
  end;

var
  frmMain: TfrmMain;
  FRmtPort  : string;
  FRmtScreen : integer ;

implementation   
{$R *.dfm}


procedure TfrmMain.AddMemoLines(s: string);
begin
  Memo1.Lines.Add(s);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // DoubleBuffered := True;
  if Screen.MonitorCount > 1 then
    i := 1
  else
    i := 0;

  Left := Screen.Monitors[i].Left;
  Top := Screen.Monitors[i].Top;
  FRmtScreen      := 0 ;

  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE, getWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);

  if ParamCount>=2 then begin
    if TryStrToInt(ParamStr(2),FRmtScreen) then
    begin
      if Screen.MonitorCount > 1 then
      begin
        DefaultMonitor := dmDesktop;
        Left := Screen.Monitors[FRmtScreen].Left;
        Top := Screen.Monitors[FRmtScreen].Top;
      end;
    end;
  end;

  FRmtPort := ParamStr(1);
  if Length(FRmtPort) <= 0 then
  begin
    Application.Terminate;
  end
  else
  begin
    FServer:= TWSocketServer.Create(Self);
    FServer.OnClientConnect      := FServerClientConnect ;
    FServer.OnClientDisconnect   := FServerClientDisconnect ;
    try
      with FServer do
      begin
        ClientClass   := TRClient;
        BannerTooBusy := '';
        Banner := '';
        Addr   := '0.0.0.0';
        Port   := FRmtPort;
        Listen;
      end;
      Memo1.Lines.Add('Waiting...');
    except on e: Exception do
      begin
        //ShowMessage(e.Message);
        Application.Terminate;
      end;
    end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  Timer1.Enabled := False ;
  FServer.Close;
  for i := 0 to FServer.ClientCount - 1 do FServer.Client[i].Close;
  FServer.OnClientConnect       := nil ;
  FServer.OnClientDisconnect    := nil ;
  FreeAndNil(FServer);
end;

procedure TfrmMain.FServerClientConnect(Sender: TObject; Client: TWSocketClient; Error: Word);
begin
  Memo1.Lines.Add(' Connect From:' + Client.PeerAddr);
end;

procedure TfrmMain.FServerClientDisconnect(Sender: TObject; Client: TWSocketClient; Error: Word);
begin
  Memo1.Lines.Add(' Disconnect From:' + Client.PeerAddr);
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Label1.Caption := ' Client Count: ' + IntToStr(FServer.ClientCount);
end;

constructor TRClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnDataAvailable := DataAvailable;
  OnError := Error;
  //
  FRemoteScreen := TRemoteScreen.Create;
  FRemoteScreen.Socket := Self;
  FPos := 0;
end;

destructor TRClient.Destroy;
begin
  FRemoteScreen.Terminate;
  inherited;
end;

procedure TRClient.Error(Sender: TObject);
begin
  CloseDelayed;
end;

procedure TRClient.DataAvailable(Sender: TObject; ErrCode: Word);
var
  nLen: Integer;
begin
  nLen := Receive(@FCmd[FPos], SizeOf(TRemoteCtlCmd) - FPos);
  if (nLen > 0) then
  begin
    Inc(FPos, nLen);
    if (FPos = SizeOf(TRemoteCtlCmd)) then
    begin
      FPos := 0;
      try
        if TRemoteCtlCmd(FCmd).Cmd in [11..15] then SetCursorPos(TRemoteCtlCmd(FCmd).X, TRemoteCtlCmd(FCmd).Y);
        case TRemoteCtlCmd(FCmd).Cmd of
          C_RMT_COMMAND:
          begin
            FRemoteScreen.PixelFormat := TPixelFormat(TRemoteCtlCmd(FCmd).X);
            FRemoteScreen.Resume;
          end;
          C_RMT_MOUSE_MOVE      : ;//mouse move
          C_RMT_MOUSE_LEFT_DOWN : mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
          C_RMT_MOUSE_RIGHT_DOWN: mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
          C_RMT_MOUSE_LEFT_UP   : mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          C_RMT_MOUSE_RIGHT_UP  : mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
          C_RMT_MOUSE_WHEEL16   : mouse_event(MOUSEEVENTF_WHEEL, 0, 0, 4294967176, 0);
          C_RMT_MOUSE_WHEEL17   : mouse_event(MOUSEEVENTF_WHEEL, 0, 0, 120, 0);
          C_RMT_FormKey_DOWN    : keybd_event(Byte(TRemoteCtlCmd(FCmd).X), MapVirtualKey(Byte(TRemoteCtlCmd(FCmd).X), 0), 0, 0);
          C_RMT_FormKey_UP      : keybd_event(Byte(TRemoteCtlCmd(FCmd).X), MapVirtualKey(Byte(TRemoteCtlCmd(FCmd).X), 0), 2, 0);
        end;
      except
      end;
    end;
  end;
end;

end.

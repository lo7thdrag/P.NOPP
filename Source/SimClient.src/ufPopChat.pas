unit ufPopChat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, ShellAPI,

  uSimMgr_Client, uT3SimManager, uRecordData;

type
  TfrmPopChat = class(TForm)
    Panel1: TPanel;
    lblSender: TLabel;
    lblMessage: TLabel;
    Timer1: TTimer;
    btnOpen: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
  private
    FFileName              : string;
    FSenderID, FReceiverID : Integer;
    FIsFileTransfer        : Boolean;
  public
    procedure ShowMessagePopup(IdSender : Integer; const SenderName, Msg: string; const AFileName: string;IdReceiver : Integer);
  end;

var
  frmPopChat: TfrmPopChat;

implementation

uses
  ufrmDisplayArea;
{$R *.dfm}

{ TForm1 }

procedure TfrmPopChat.btnOpenClick(Sender: TObject);
var
  rec : TRecTCPFileTransfer;
begin
  if not FIsFileTransfer then
    Exit;

  if not FileExists(FFileName) then
  begin
    ShowMessage('File tidak ditemukan: ' + FFileName);
    Exit;
  end;


  ShellExecute(0, 'open', PChar(FFileName), nil, nil,SW_SHOWNORMAL);
  FillChar(rec, SizeOf(rec), 0);

  rec.OrderID            := SEND_FILE_TRANSFER_OPENED;
  rec.FileName           := ExtractFileName(FFileName);
  rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
  rec.ReceiverUserRoleId := FSenderID;

  simMgrClient.netSend_CmdFileTransferToteDisplay(rec);
  Close;
end;

procedure TfrmPopChat.FormCreate(Sender: TObject);
begin
  Timer1.Interval := 10000;
end;

procedure TfrmPopChat.ShowMessagePopup(IdSender : Integer; const SenderName, Msg: string; const AFileName: string;
IdReceiver : Integer);
const
  MARGIN_RIGHT  = 30;
  MARGIN_BOTTOM = 30;
begin
  lblSender.Caption  := SenderName;
  lblMessage.Caption := Msg;

  FFileName := AFileName;
  FSenderID := IdSender;
  FReceiverID := IdReceiver;

  FIsFileTransfer := AFileName <> '';

  btnOpen.Visible := FIsFileTransfer;

  Left := Screen.WorkAreaWidth - Width - 30;
  Top  := Screen.WorkAreaHeight - Height - 30;

  Show;
  BringToFront;

  Timer1.Enabled := True;
end;

procedure TfrmPopChat.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

end.

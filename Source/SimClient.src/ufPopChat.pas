unit ufPopChat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, ShellAPI,

  uSimMgr_Client, uT3SimManager, uRecordData;

type
  TFilePopupType = (fptNone, fptTelegram, fptToteDisplay, fptFileSharing);

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
    FFilePopupType : TFilePopupType;

    procedure ShowMessagePopup(IdSender : Integer; const SenderName, Msg: string; const AFileName: string;
              IdReceiver : Integer; AFilePopupType : TFilePopupType);
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
  recTransfer : TRecTCPFileTransfer;
  recSharing  : TRecTCPFileSharing;
  recSync     : TRecTCPFileSync;
begin
  if not FIsFileTransfer then
    Exit;

  if not FileExists(FFileName) then
  begin
    ShowMessage('File tidak ditemukan: ' + FFileName);
    Exit;
  end;

  ShowMessage('OPEN DEBUG' + #13#10 + 'File = ' + FFileName + #13#10 + 'PopupType = ' + IntToStr(Ord(FFilePopupType)) + #13#10 +
    'SenderID = ' + IntToStr(FSenderID) + #13#10 + 'ReceiverID = ' + IntToStr(FReceiverID));

  ShellExecute(0, 'open', PChar(FFileName), nil, nil, SW_SHOWNORMAL);

  case FFilePopupType of

    fptTelegram:
    begin
      FillChar(recSync, SizeOf(recSync), 0);

      recSync.OrderID            := SEND_FILE_OPENED;
      recSync.FileName           := ExtractFileName(FFileName);
      recSync.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
      recSync.ReceiverUserRoleId := FSenderID;

      simMgrClient.netSend_CmdFileSendTelegram(recSync);
    end;

    fptToteDisplay:
    begin
      FillChar(recTransfer, SizeOf(recTransfer), 0);

      recTransfer.OrderID            := SEND_FILE_TRANSFER_OPENED;
      recTransfer.FileName           := ExtractFileName(FFileName);
      recTransfer.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
      recTransfer.ReceiverUserRoleId := FSenderID;

      simMgrClient.netSend_CmdFileTransferToteDisplay(recTransfer);
    end;

    fptFileSharing:
    begin
      FillChar(recSharing, SizeOf(recSharing), 0);

      recSharing.OrderID            := SEND_FILE_SHARING_OPENED;
      recSharing.FileName           := ExtractFileName(FFileName);
      recSharing.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
      recSharing.ReceiverUserRoleId := FSenderID;

      simMgrClient.netSend_CmdFileSharing(recSharing);
    end;

  end;

  Close;
end;

procedure TfrmPopChat.FormCreate(Sender: TObject);
begin
  Timer1.Interval := 10000;
end;

procedure TfrmPopChat.ShowMessagePopup(IdSender : Integer; const SenderName, Msg: string; const AFileName: string;
IdReceiver : Integer; AFilePopupType : TFilePopupType);
const
  MARGIN_RIGHT  = 30;
  MARGIN_BOTTOM = 30;
begin
  ShowMessage('DEBUG POPUP' + #13#10 + 'AFileName = ' + AFileName + #13#10 + 'FilePopupType = ' + IntToStr(Ord(AFilePopupType)));

  lblSender.Caption  := SenderName;
  lblMessage.Caption := Msg;

  FFileName   := AFileName;
  FSenderID  := IdSender;
  FReceiverID := IdReceiver;

  FFilePopupType := AFilePopupType;

  FIsFileTransfer := AFileName <> '';

  btnOpen.Visible := FIsFileTransfer;

  Left := Screen.WorkAreaWidth - Width - 30;
  Top  := Screen.WorkAreaHeight - Height - 30;

  Show;
  BringToFront;

  if not FIsFileTransfer then
    Timer1.Enabled := True
  else
    Timer1.Enabled := False;
end;

procedure TfrmPopChat.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

end.

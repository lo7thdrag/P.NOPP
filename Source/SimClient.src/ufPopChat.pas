unit ufPopChat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmPopChat = class(TForm)
    Panel1: TPanel;
    lblSender: TLabel;
    lblMessage: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowMessagePopup(const SenderName, Msg: string);
  end;

var
  frmPopChat: TfrmPopChat;

implementation

uses
  ufrmDisplayArea;
{$R *.dfm}

{ TForm1 }

procedure TfrmPopChat.FormCreate(Sender: TObject);
begin
  Timer1.Interval := 10000;
end;

procedure TfrmPopChat.ShowMessagePopup(const SenderName, Msg: string);
const
  MARGIN_RIGHT  = 30;
  MARGIN_BOTTOM = 30;
begin
  lblSender.Caption  := SenderName;
  lblMessage.Caption := Msg;

  Left := Screen.WorkAreaWidth - Width - MARGIN_RIGHT;
  Top  := Screen.WorkAreaHeight - Height - MARGIN_BOTTOM;

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

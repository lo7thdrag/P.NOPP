unit UFrmCommand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmCommand = class(TForm)
    MmoLog: TMemo;
    pnlTop: TPanel;
    edtFPS: TEdit;
    lblFPS: TLabel;
    btnClose: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MainFormHandle: HWND;
  end;

var
  FrmCommand: TFrmCommand;

implementation

{$R *.dfm}

procedure TFrmCommand.btnCloseClick(Sender: TObject);
begin
  PostMessage(MainFormHandle, WM_CLOSE, 0, 0);
end;

procedure TFrmCommand.FormDestroy(Sender: TObject);
begin
//
end;

end.

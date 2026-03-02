unit ufrmAvailableTacticalSyimbol;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmAvailableTacticalSymbol = class(TForm)
    ImgBackgroundForm: TImage;
    edtCheat: TEdit;
    lblClose: TLabel;
    lblPlatform: TLabel;
    lblsearch: TLabel;
    lstAcousticDecoy: TListBox;
    btnNew: TImage;
    btnCopy: TImage;
    btnEdit: TImage;
    btnDelete: TImage;
    procedure lblCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAvailableTacticalSymbol: TfrmAvailableTacticalSymbol;

implementation

{$R *.dfm}

procedure TfrmAvailableTacticalSymbol.lblCloseClick(Sender: TObject);
begin
  Close;
end;

end.

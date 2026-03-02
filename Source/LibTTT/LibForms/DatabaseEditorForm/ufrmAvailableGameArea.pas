unit ufrmAvailableGameArea;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmAvailableGameArea = class(TForm)
    ImgBackgroundForm: TImage;
    btnCopy: TImage;
    btnEdit: TImage;
    btnNew: TImage;
    edtCheat: TEdit;
    lblClose: TLabel;
    lblPlatform: TLabel;
    lblsearch: TLabel;
    lstAcousticDecoy: TListBox;
    btnDelete: TImage;
    procedure lblSingleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAvailableGameArea: TfrmAvailableGameArea;

implementation

{$R *.dfm}

procedure TfrmAvailableGameArea.lblSingleClick(Sender: TObject);
begin
  Close;
end;

end.

unit ufrmVideoConference;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmVideoConference = class(TForm)
    imgMainBackground: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVideoConference: TfrmVideoConference;

implementation

{$R *.dfm}

end.

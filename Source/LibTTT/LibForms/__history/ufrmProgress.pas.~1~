unit ufProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TfrmProgress = class(TForm)
    pBar: TProgressBar;
    Label1: TLabel;
  private
    //procedure setCurrentJob(const Value: string);
    procedure setMaxJob(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    procedure Increase(const s: string);

    property MaxJob: integer  write setMaxJob;

  end;

var
  frmProgress: TfrmProgress;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmProgress.Increase(const s: string);
begin
  Label1.Caption := s;
  pBar.StepIt;
  Show;
  Update;
end;

//procedure TfrmProgress.setCurrentJob(const Value: string);
//begin
//end;

procedure TfrmProgress.setMaxJob(const Value: integer);
begin
  pBar.Max := Value;
  pBar.Position := 0;

end;

end.

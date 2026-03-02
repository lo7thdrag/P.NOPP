unit ufDBSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type

  TfrmDBSetting = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
  private
    function getConfig(const Index: Integer): string;
    procedure setConfig(const Index: Integer; const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property dbServer: string index 0  read getConfig write setConfig;
    property dbName  : string index 1  read getConfig write setConfig;
    property dbUser  : string index 2  read getConfig write setConfig;
    property dbPass  : string index 3  read getConfig write setConfig;
  end;

var
  frmDBSetting: TfrmDBSetting;

implementation

{$R *.dfm}

{ TfrmDBSetting }

procedure TfrmDBSetting.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

function TfrmDBSetting.getConfig(const Index: Integer): string;
begin
  result := '';
  case index of
    0 : result := Edit1.Text;
    1 : result := Edit2.Text;
    2 : result := Edit3.Text;
    3 : result := Edit4.Text;
  end;
end;

procedure TfrmDBSetting.setConfig(const Index: Integer;
  const Value: string);
begin
  case index of
    0 :  Edit1.Text := Value;
    1 :  Edit2.Text := Value;
    2 :  Edit3.Text := Value;
    3 :  Edit4.Text := Value;
  end;
end;

end.

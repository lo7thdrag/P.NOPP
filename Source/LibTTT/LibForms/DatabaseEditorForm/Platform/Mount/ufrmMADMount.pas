unit ufrmMADMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers;

type
  TfrmMADMount = class(TForm)
    pnl1Title: TPanel;
    pnl2ControlPage: TPanel;
    edtName: TEdit;
    PageControl1: TPageControl;
    General: TTabSheet;
    edtAntenna: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    ImgBackgroundForm: TImage;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    lblPlatform: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedVehicle : TAsset;
    FSelectedMAD : TMAD_On_Board;

    function CekInput: Boolean;
    procedure UpdateMADData;
//    procedure DrawBlindZone;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedMAD : TMAD_On_Board read FSelectedMAD write FSelectedMAD;

  end;


var
  frmMADMount: TfrmMADMount;

implementation

uses
  uDataModule, ufrmMADOnBoardPickList;

{$R *.dfm}


{$REGION ' Form Handle '}

procedure TfrmMADMount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmMADMount.FormShow(Sender: TObject);
begin
  UpdateMADData;

  with FSelectedMAD.FData do
    btnApply.Enabled := MAD_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmMADMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

    frmMADOnBoardPickList.UpdateMADList;
    Close;
end;

procedure TfrmMADMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedMAD do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Antenna_Height := StrToInt(edtAntenna.Text);
    FData.MAD_Index := FDef.MAD_Index;

    if FData.MAD_Instance_Index = 0 then
      dmINWO.InsertMADOnBoard(FData)
    else
      dmINWO.UpdateMADOnBoard(FData);
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmMADMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmMADMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetMADOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedMAD.FData.MAD_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate MAD!' + Char(13) + 'Choose different MAD.');
      Exit;
    end
    else if LastName <> edtName.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmMADMount.UpdateMADData;
begin
  with FSelectedMAD do
  begin
    if FData.MAD_Instance_Index = 0 then
      edtName.Text := FDef.Class_Identifier
    else
      edtName.Text := FData.Instance_Identifier;

      LastName := edtName.Text;
    edtAntenna.Text := FormatFloat('0', FData.Antenna_Height);
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmMADMount.GetNumberOfKoma(s: string): Boolean;
var
  a, i : Integer;
begin
  Result := False;
  a := 0;

  for i := 1 to length(s) do
  begin
    if s[i] = '.' then
      a := a + 1;
  end;

  if a > 0 then
    Result := True;
end;

procedure TfrmMADMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
var
  value : Double;
begin
  if not (Key in[#48 .. #57, #8, #13, #46]) then
  begin
    Key := #0;
    Exit;
  end;

  if GetNumberOfKoma(TEdit(sender).Text) then
  begin
    if Key = #46 then
      Key := #0;
  end;

  if Key = #13 then
  begin
    if TEdit(Sender).Text = '' then
      TEdit(Sender).Text := '0';

    value := StrToFloat(TEdit(Sender).Text);

    case TEdit(Sender).Tag of
      0: TEdit(Sender).Text := FormatFloat('0', value);
      1: TEdit(Sender).Text := FormatFloat('0.0', value);
      2: TEdit(Sender).Text := FormatFloat('0.00', value);
      3: TEdit(Sender).Text := FormatFloat('0.000', value);
    end;

    btnApply.Enabled := True;
  end;
end;

procedure TfrmMADMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmMADMount.ValidationFormatInput;
var
  i: Integer;
  value : Double;

begin
  for i:=0 to ComponentCount-1 do
  begin
    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Tag = 4 then
        continue;

      if TEdit(Components[i]).Text = '' then
        TEdit(Components[i]).Text := '0';

      value := StrToFloat(TEdit(Components[i]).Text);

      case TEdit(Components[i]).Tag of
        0: TEdit(Components[i]).Text := FormatFloat('0', value);
        1: TEdit(Components[i]).Text := FormatFloat('0.0', value);
        2: TEdit(Components[i]).Text := FormatFloat('0.00', value);
        3: TEdit(Components[i]).Text := FormatFloat('0.000', value);
      end;
    end;
  end;
end;

{$ENDREGION}
end.

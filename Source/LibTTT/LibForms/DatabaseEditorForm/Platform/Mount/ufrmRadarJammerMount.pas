unit ufrmRadarJammerMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Countermeasure, uClassData, uSimContainers;

type
  TfrmRadarJammerMount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    edtAntenna: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure CheckBoxDataClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedVehicle : TAsset;
    FSelectedRadarJammer : TRadar_Noise_Jammer_On_Board;

    function CekInput: Boolean;
    procedure UpdateRadarJammerData;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedRadarJammer : TRadar_Noise_Jammer_On_Board read FSelectedRadarJammer write FSelectedRadarJammer;
  end;

var
  frmRadarJammerMount: TfrmRadarJammerMount;

implementation

uses
  uDataModule, ufrmRadarNoiseJammerOnBoardPickList ;

{$R *.dfm}


{$REGION ' Form Handle '}

procedure TfrmRadarJammerMount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := cafree;
end;

procedure TfrmRadarJammerMount.FormShow(Sender: TObject);
begin
  UpdateRadarJammerData;

  with FSelectedRadarJammer.FData do
    btnApply.Enabled := Jammer_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmRadarJammerMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmRadarNoiseJammerOnBoardPickList.UpdateRadarJammerList;
  Close;
end;

procedure TfrmRadarJammerMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedRadarJammer do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Instance_Type := 0;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Jammer_Index := FDef.Jammer_Index;
    FData.Antenna_Height := StrToFloat(edtAntenna.Text);

    if FData.Jammer_Instance_Index = 0 then
      dmINWO.InsertRadarNoiseJammerOnBoard(FData)
    else
      dmINWO.UpdateRadarNoiseJammerOnBoard(FData);
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmRadarJammerMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmRadarJammerMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetRadarNoiseJammerOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedRadarJammer.FData.Jammer_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate Radar Jammer!' + Char(13) + 'Choose Radar Jammer to continue.');
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

procedure TfrmRadarJammerMount.UpdateRadarJammerData;
begin
  with FSelectedRadarJammer do
  begin
    if FData.Jammer_Instance_Index = 0 then
      edtName.Text := FDef.Jammer_Identifier
    else
      edtName.Text := FData.Instance_Identifier;

      LastName := edtName.Text;

    edtAntenna.Text := FormatFloat('0', FData.Antenna_Height);
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmRadarJammerMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmRadarJammerMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmRadarJammerMount.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmRadarJammerMount.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmRadarJammerMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmRadarJammerMount.ValidationFormatInput;
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

unit ufrmRadarMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers ;

type
  TfrmRadarMount = class(TForm)
    pnl1Title: TPanel;
    pnl2ControlPage: TPanel;
    edtName: TEdit;
    PageControl1: TPageControl;
    General: TTabSheet;
    cbMountExtension: TComboBox;
    edtAntenna: TEdit;
    edtSubmerged: TEdit;
    edtMaxOperational: TEdit;
    pnlBlindZone: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    ImgBackgroundForm: TImage;
    btnOK: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    txtClass: TLabel;
    edtClassName: TLabel;
    lblPlatform: TLabel;
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure cbMountExtensionChange(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedVehicle : TAsset;
    FSelectedRadar : TRadar_On_Board;

    function CekInput: Boolean;
    procedure UpdateRadarData;

  public
    LastName : string; {dicopy}

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedRadar : TRadar_On_Board read FSelectedRadar write FSelectedRadar;
  end;

var
  frmRadarMount: TfrmRadarMount;

implementation

uses
  uDataModule, ufrmRadarOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmRadarMount.FormShow(Sender: TObject);
begin
  UpdateRadarData;

  with FSelectedRadar.FData do
    btnApply.Enabled := Radar_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmRadarMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmRadarOnBoardPickList.UpdateRadarList;
  Close;
end;

procedure TfrmRadarMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedRadar do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Instance_Type := cbMountExtension.ItemIndex;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Radar_Index := FDef.Radar_Index;

    if FData.Radar_Instance_Index = 0 then
      dmINWO.InsertRadarOnBoard(FData)
    else
      dmINWO.UpdateRadarOnBoard(FData);
  end;

  btnApply.Enabled := False;  {dicopy}
  btnCancel.Enabled := False;  {dicopy}
end;

procedure TfrmRadarMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRadarMount.cbMountExtensionChange(Sender: TObject);
begin
  edtName.Text := FSelectedRadar.FDef.Radar_Identifier + ' ' + cbMountExtension.Text;

  btnApply.Enabled := True;
end;

function TfrmRadarMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetRadarOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedRadar.FData.Radar_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate radar mount!' + Char(13) + 'Choose different mount to continue.');
      Exit;
    end
    else if LastName <> edtName.Text then {dicopy}
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmRadarMount.UpdateRadarData;
begin
  with FSelectedRadar do
  begin
    cbMountExtension.ItemIndex := FData.Instance_Type;

    if FData.Radar_Instance_Index = 0 then
      edtName.Text := FDef.Radar_Identifier + ' ' + cbMountExtension.Text
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;   {dicopy}
    edtClassName.Caption := FDef.Radar_Identifier;
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmRadarMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmRadarMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmRadarMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmRadarMount.ValidationFormatInput;
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

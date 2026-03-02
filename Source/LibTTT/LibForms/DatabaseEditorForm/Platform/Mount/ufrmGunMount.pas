unit ufrmGunMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage, uBaseCoordSystem,

  uDBAsset_Weapon, uClassData, uSimContainers;

type
  TfrmGunMount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    cbMountExtension: TComboBox;
    edtQuantity: TEdit;
    pnlBlindZone: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtTurretID: TEdit;
    lbl6: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
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
    FSelectedGun : TGun_On_Board;

    function CekInput: Boolean;
    procedure UpdateGunData;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedGun : TGun_On_Board read FSelectedGun write FSelectedGun;
  end;

var
  frmGunMount: TfrmGunMount;

implementation

uses
  uDataModule, ufrmGunOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmGunMount.FormShow(Sender: TObject);
begin
  UpdateGunData;

  with FSelectedGun.FData do
    btnApply.Enabled := Gun_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmGunMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

    frmGunOnBoardPickList.UpdateGunList;
    Close;
end;

procedure TfrmGunMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedGun do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Mount_Type := cbMountExtension.ItemIndex;
    FData.Quantity := StrToInt(edtQuantity.Text);
    FData.TurretID := StrToInt(edtTurretID.Text);
    FData.Gun_Index := FDef.Gun_Index;

    if FData.Point_Effect_Index = 0 then
      dmINWO.InsertPointEffectOnBoard(1, FData)
    else
      dmINWO.UpdatePointEffectOnBoard(1, FData)
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmGunMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGunMount.cbMountExtensionChange(Sender: TObject);
begin
  edtName.Text := FSelectedGun.FDef.Gun_Identifier + ' ' + cbMountExtension.Text;

  btnApply.Enabled := True;
end;

function TfrmGunMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetPointEffectOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedGun.FData.Point_Effect_Index = 0 then
    begin
      ShowMessage('Duplicate radar mount!' + Char(13) +
      'Choose different name to continue.');
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

procedure TfrmGunMount.UpdateGunData;
begin
  with FSelectedGun do
  begin
    cbMountExtension.ItemIndex := FData.Mount_Type;

    if FData.Point_Effect_Index = 0 then
      edtName.Text := FDef.Gun_Identifier + ' ' + cbMountExtension.Text
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;
    edtClassName.Caption := FDef.Gun_Identifier;

    edtQuantity.Text := FormatFloat('0', FData.Quantity);
//    edtTurretID.Text := FormatFloat('0', FPoint.FData.TurretID);

  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmGunMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmGunMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmGunMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmGunMount.ValidationFormatInput;
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

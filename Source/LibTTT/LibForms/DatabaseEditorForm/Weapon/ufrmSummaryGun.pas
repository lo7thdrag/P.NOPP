unit ufrmSummaryGun;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  {Project Uses}
  uDBAsset_Weapon{, tttData};

type
  TfrmSummaryGun = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    grpLethality: TGroupBox;
    mnlbl9: TLabel;
    mnlbl8: TLabel;
    edtLethality: TEdit;
    trckbrLethality: TTrackBar;
    grpCapabilities: TGroupBox;
    chkAntiSurface: TCheckBox;
    chkDeployingChaff: TCheckBox;
    chkAntiLand: TCheckBox;
    chkAutofireMode: TCheckBox;
    chkAntiAir: TCheckBox;
    chkNavalGunSupport: TCheckBox;
    chkAntiAmphibious: TCheckBox;
    grpRange: TGroupBox;
    lbl4: TLabel;
    lblAirMaxRange: TLabel;
    lbl5: TLabel;
    lblAirMinRange: TLabel;
    edtAirMinRange: TEdit;
    edtAirMaxRange: TEdit;
    grpPOH: TGroupBox;
    btnEditAirTargetCurve: TButton;
    btnEditSurfaceLandTargetCurve: TButton;
    chkFireControl: TCheckBox;
    GroupBox3: TGroupBox;
    lblSurLandMinRange: TLabel;
    lblSurLandMaxRange: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtSurLandMinRange: TEdit;
    edtSurLandMaxRange: TEdit;
    GroupBox4: TGroupBox;
    lblCategory: TLabel;
    lblRateOfFire: TLabel;
    lbl1: TLabel;
    lblAverageShellVelocity: TLabel;
    lbl3: TLabel;
    lblMaxAltitudeDiff: TLabel;
    lbl2: TLabel;
    cbbCategory: TComboBox;
    edtRateOfFire: TEdit;
    edtAverageShellVelocity: TEdit;
    edtMaxAltitudeDiff: TEdit;
    tsNGS: TTabSheet;
    grpDamageRating: TGroupBox;
    mnlbl18: TLabel;
    mnlbl17: TLabel;
    edtDamageRating: TEdit;
    trckbrDamageRating: TTrackBar;
    GroupBox1: TGroupBox;
    lblMinDeflectionError: TLabel;
    lblMaxDeflectionError: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtMinDeflectionError: TEdit;
    edtMaxDeflectionError: TEdit;
    GroupBox2: TGroupBox;
    lblMinRangeError: TLabel;
    lblMaxRangeError: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    edtMinRangeError: TEdit;
    edtMaxRangeError: TEdit;
    GroupBox5: TGroupBox;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lblMaxDispersionError: TLabel;
    lblMaxDamageRadius: TLabel;
    lblEffectiveRadius: TLabel;
    edtEffectiveRadius: TEdit;
    edtMaxDamageRadius: TEdit;
    edtMaxDispersionError: TEdit;
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure CheckBoxDataClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    //General
    procedure trckbrGeneralChange(Sender: TObject);
    procedure edtGeneralChange(Sender: TObject);
    procedure btnEditAirTargetCurveClick(Sender: TObject);
    procedure btnEditSurfaceLandTargetCurveClick(Sender: TObject);

    //Naval Gun Fire Support
    procedure trckbrDamageRatingChange(Sender: TObject);
    procedure edtDamageRatingChange(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedGun : TGun_On_Board;

    function CekInput: Boolean;
    function GetWeaponCategory(sValue : string): Integer;
    function SetWeaponCategory(aValue : Integer): string;
    procedure UpdateGunData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedGun : TGun_On_Board read FSelectedGun write FSelectedGun;
  end;

var
frmSummaryGun: TfrmSummaryGun;

implementation

uses
  {Project Uses}
    uDataModule, ufrmGunOnBoardPickList{, ufrmGunPOHGraphic};

 {$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmSummaryGun.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateGunData;

  with FSelectedGun.FData do
    btnApply.Enabled := Gun_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryGun.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmGunOnBoardPickList.UpdateGunList;
  Close;
end;

procedure TfrmSummaryGun.btnApplyClick(Sender: TObject);
begin

  with FSelectedGun do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Gun_Identifier := edtClass.Text;
    FDef.Gun_Category := GetWeaponCategory(cbbCategory.Text);
    FDef.Rate_of_Fire := StrToInt(edtRateOfFire.Text);
    FDef.Max_Target_Altitude_Delta := StrToInt(edtMaxAltitudeDiff.Text);
    FDef.Gun_Average_Shell_Velocity := StrToFloat(edtAverageShellVelocity.Text);

    FDef.Fire_Cntl_Director_Req := Ord(chkFireControl.Checked);

    FDef.Air_Min_Range := StrToFloat(edtAirMinRange.Text);
    FDef.Air_Max_Range := StrToFloat(edtAirMaxRange.Text);

    FDef.Min_Range := StrToFloat(edtSurLandMinRange.Text);
    FDef.Max_Range := StrToFloat(edtSurLandMaxRange.Text);

    FDef.Anti_Sur_Capable := Ord(chkAntiSurface.Checked);
    FDef.Anti_Land_Capable := Ord(chkAntiLand.Checked);
    FDef.Anti_Air_Capable := Ord(chkAntiAir.Checked);
    FDef.Anti_Amphibious_Capable := Ord(chkAntiAmphibious.Checked);
    FDef.Automode_Capable := Ord(chkAutofireMode.Checked);
    FDef.Chaff_Capable_Gun := Ord(chkDeployingChaff.Checked);
    FDef.NGS_Capable := Ord(chkNavalGunSupport.Checked);

    FDef.Lethality_per_Round := trckbrLethality.Position;
    {$ENDREGION}

    {$REGION ' Naval Gunfire Support '}
    FDef.NGS_MinDeflectionError := StrToFloat(edtMinDeflectionError.Text);
    FDef.NGS_MaxDeflectionError := StrToFloat(edtMaxDeflectionError.Text);

    FDef.NGS_MinRangeError := StrToFloat(edtMinRangeError.Text);
    FDef.NGS_MaxRangeError := StrToFloat(edtMaxRangeError.Text);

    FDef.NGS_MaxDispersionError := StrToFloat(edtMaxDispersionError.Text);
    FDef.NGS_MaxDamageRadius := StrToFloat(edtMaxDamageRadius.Text);
    FDef.NGS_EffectiveRadius := StrToFloat(edtEffectiveRadius.Text);

    FDef.NGS_DamageRating := trckbrDamageRating.Position;
    {$ENDREGION}

    if FDef.Gun_Index = 0 then
    begin
      if dmINWO.InsertGunDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateGunDef(FDef) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  UpdateGunData;

//  isOK := True;
//  AfterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryGun.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryGun.btnEditAirTargetCurveClick(Sender: TObject);
begin
//  frmGunPOHGraphic := TfrmGunPOHGraphic.Create(Self);
//  try
//    with frmGunPOHGraphic do
//    begin
//      ProbabilityGraph := pgGunAir;
//      SelectedProbObj := FSelectedGun;
//      ShowModal;
//    end;
//    AfterClose := frmGunPOHGraphic.AfterClose;
//  finally
//    frmGunPOHGraphic.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryGun.btnEditSurfaceLandTargetCurveClick(Sender: TObject);
begin
//  frmGunPOHGraphic := TfrmGunPOHGraphic.Create(Self);
//  try
//    with frmGunPOHGraphic do
//    begin
//      ProbabilityGraph := pgGunSurfaceLand;
//      SelectedProbObj := FSelectedGun;
//      ShowModal;
//    end;
//    AfterClose := frmGunPOHGraphic.AfterClose;
//  finally
//    frmGunPOHGraphic.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryGun.trckbrGeneralChange(Sender: TObject);
begin
  edtLethality.Text := IntToStr(TTrackBar(Sender).Position);
end;

procedure TfrmSummaryGun.edtGeneralChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 10) then
    TEdit(Sender).Text := '10';

  trckbrLethality.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

procedure TfrmSummaryGun.edtDamageRatingChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 100) then
    TEdit(Sender).Text := '100';

  trckbrDamageRating.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

procedure TfrmSummaryGun.trckbrDamageRatingChange(Sender: TObject);
begin
  edtDamageRating.Text := IntToStr(TTrackBar(Sender).Position);
end;

procedure TfrmSummaryGun.UpdateGunData;
begin
  with FSelectedGun do
  begin
    if FDef.Gun_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Gun_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    cbbCategory.Text := SetWeaponCategory(FDef.Gun_Category);
    edtRateOfFire.Text := IntToStr(FDef.Rate_of_Fire);
    edtMaxAltitudeDiff.Text := IntToStr(FDef.Max_Target_Altitude_Delta);
    edtAverageShellVelocity.Text := FormatFloat('0.00', FDef.Gun_Average_Shell_Velocity);

    chkFireControl.Checked := Boolean(FDef.Fire_Cntl_Director_Req);

    edtAirMinRange.Text := FormatFloat('0.00', FDef.Air_Min_Range);
    edtAirMaxRange.Text := FormatFloat('0.00', FDef.Air_Max_Range);

    edtSurLandMinRange.Text := FormatFloat('0.00', FDef.Min_Range);
    edtSurLandMaxRange.Text := FormatFloat('0.00', FDef.Max_Range);

    btnEditAirTargetCurve.Enabled := FDef.Gun_Index <> 0;
    btnEditSurfaceLandTargetCurve.Enabled := FDef.Gun_Index <> 0;

    chkAntiSurface.Checked := Boolean(FDef.Anti_Sur_Capable);
    chkAntiLand.Checked := Boolean(FDef.Anti_Land_Capable);
    chkAntiAir.Checked := Boolean(FDef.Anti_Air_Capable);
    chkAntiAmphibious.Checked := Boolean(FDef.Anti_Amphibious_Capable);
    chkDeployingChaff.Checked := Boolean(FDef.Chaff_Capable_Gun);
    chkAutofireMode.Checked := Boolean(FDef.Automode_Capable);
    chkNavalGunSupport.Checked := Boolean(FDef.NGS_Capable);

    trckbrLethality.Position := FDef.Lethality_per_Round;
    {$ENDREGION}

    {$REGION ' Naval Gunfire Support '}
    edtMinDeflectionError.Text := FormatFloat('0.0', FDef.NGS_MinDeflectionError);
    edtMaxDeflectionError.Text := FormatFloat('0.0', FDef.NGS_MaxDeflectionError);

    edtMinRangeError.Text := FormatFloat('0.0', FDef.NGS_MinRangeError);
    edtMaxRangeError.Text := FormatFloat('0.0', FDef.NGS_MaxRangeError);

    edtMaxDispersionError.Text := FormatFloat('0.0', FDef.NGS_MaxDispersionError);
    edtMaxDamageRadius.Text := FormatFloat('0.0', FDef.NGS_MaxDamageRadius);
    edtEffectiveRadius.Text := FormatFloat('0.0', FDef.NGS_EffectiveRadius);

    trckbrDamageRating.Position := FDef.NGS_DamageRating;
    {$ENDREGION}
  end;
end;

function TfrmSummaryGun.CekInput: Boolean;
var
  i, chkSpace, numSpace: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (edtClass.Text = '')then
  begin
    ShowMessage('Please insert class name');
    Exit;
  end;

  {Jika berisi spasi semua}
  if Copy(edtClass.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtClass.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtClass.Text[i] = #32 then
      numSpace := numSpace + 1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  {Jika Class Name sudah ada}
  if (dmINWO.GetGunDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedGun.FDef.Gun_Index = 0 then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end
    else if LastName <> edtClass.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummaryGun.GetNumberOfKoma(s: string): Boolean;
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

function TfrmSummaryGun.GetWeaponCategory(sValue: string): Integer;
begin
//  if sValue = 'Close-In-Weapon System' then Result := Byte(wcGunCIWS)
//  else if sValue = 'Gun' then Result := Byte(wcGunGun)
//  else if sValue = 'Rocket' then Result := Byte(wcGunRocket)
end;

function TfrmSummaryGun.SetWeaponCategory(aValue: Integer): string;
begin
//  case aValue of
//    Byte(wcGunCIWS) : Result := 'Close-In-Weapon System';
//    Byte(wcGunGun) : Result := 'Gun';
//    Byte(wcGunRocket) : Result := 'Rocket';
//  end;
end;

procedure TfrmSummaryGun.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryGun.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryGun.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryGun.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryGun.ValidationFormatInput;
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

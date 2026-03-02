unit ufrmSummaryRadar;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ComCtrls,
  Dialogs, StdCtrls, ExtCtrls, Buttons, math, Vcl.Imaging.pngimage,

  {Project Uses}
  uConstantaData, uDBAsset_Sensor, uDataModule;

type
  TfrmSummaryRadar = class(TForm)
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    lblBaselineDelectionRange: TLabel;
    lblAssociatedCrossSection: TLabel;
    lblMaxUnambigous: TLabel;
    lblNumberofFCR: TLabel;
    lblSpotNumber: TLabel;
    lblOTHRadarFactor: TLabel;
    lblMainLobeGain: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtBaselineDelectionRange: TEdit;
    edtAssociatedCrossSection: TEdit;
    edtMaxUnambigous: TEdit;
    edtNumberofFCR: TEdit;
    edtSpotNumber: TEdit;
    edtOTHRadarFactor: TEdit;
    edtMainLobeGain: TEdit;
    cbbAssociatedCrossSection: TComboBox;
    grbCapabilities: TGroupBox;
    chkAltitudeData: TCheckBox;
    chkGroundSpeedData: TCheckBox;
    chkHeadingData: TCheckBox;
    chkPlatformTypeRecognition: TCheckBox;
    chkPlatformClassRecognition: TCheckBox;
    chkSectorScan: TCheckBox;
    GroupBox2: TGroupBox;
    lblEmitterType: TLabel;
    lblECOMType: TLabel;
    lblRadarType: TLabel;
    edtEmitterType: TEdit;
    cbbECCMType: TComboBox;
    cbbRadarType: TComboBox;
    tsCharacteristic: TTabSheet;
    lblFrequency: TLabel;
    lblScanRate: TLabel;
    lblPulseRepetitionFrequency: TLabel;
    lblPulseWidth: TLabel;
    lblPower: TLabel;
    lblClutterRejection: TLabel;
    lblBeamWidth: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    edtFrequency: TEdit;
    edtScanRate: TEdit;
    edtPulseRepetitionFrequency: TEdit;
    edtPulseWidth: TEdit;
    edtPower: TEdit;
    edtClutterRejection: TEdit;
    edtBeamWidth: TEdit;
    tsAntiJamming: TTabSheet;
    grbBasicCapabilities: TGroupBox;
    lblJammerStrength: TLabel;
    lbldBbeamwidth: TLabel;
    mnlbl8: TLabel;
    mnlbl9: TLabel;
    trckbrJammerStrength: TTrackBar;
    edtJammerReduction: TEdit;
    chkTypeAJammingResistant: TCheckBox;
    chkTypeBJammingResistant: TCheckBox;
    chkTypeCJammingResistant: TCheckBox;
    grbAntiJammingCapable: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    trckbrPercentageMaxUnambigous: TTrackBar;
    edtPercentageMaxUnambigous: TEdit;
    chkCancelTypeA: TCheckBox;
    chkCancelTypeB: TCheckBox;
    chkCancelTypeC: TCheckBox;
    chkAntiJammingCapable: TCheckBox;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;

    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure CheckBoxDataClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    //Characteristic
    procedure btnVerticalCoverageCurve1Click(Sender: TObject);
    procedure btnEditVertical2Click(Sender: TObject);
    procedure btnPickClick(Sender: TObject);

    //Anti Jamming
    procedure trckbrAntiJammingChange(Sender: TObject);
    procedure edtJammerReductionChange(Sender: TObject);
    procedure edtPercentageMaxUnambigousChange(Sender: TObject);
    procedure chkAntiJammingCapableClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedRadar : TRadar_On_Board;

    function CekInput: Boolean;
    procedure UpdateRadarData;
    procedure UpdateSNRvsPODData;

  public
    LastName : string;

    property SelectedRadar : TRadar_On_Board read FSelectedRadar write FSelectedRadar;

  end;

var
  frmSummaryRadar: TfrmSummaryRadar;

implementation

{$R *.dfm}
uses
  ufrmRadarOnBoardPickList;

{$REGION ' Form Handle '}

procedure TfrmSummaryRadar.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateRadarData;

  with FSelectedRadar.FDef do
    btnApply.Enabled := Radar_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryRadar.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmRadarOnBoardPickList.UpdateRadarList;
  Close;
end;

procedure TfrmSummaryRadar.btnApplyClick(Sender: TObject);
begin
  with FSelectedRadar do
  begin
    if not CekInput then
    begin
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Radar_Identifier := edtClass.Text;
    FDef.Radar_Type := cbbRadarType.ItemIndex;
    FDef.ECCM_Type := cbbECCMType.ItemIndex;
    FDef.Radar_Emitter := edtEmitterType.Text;
    FDef.Detection_Range := StrToFloat(edtBaselineDelectionRange.Text);
    FDef.Known_Cross_Section := StrToFloat(edtAssociatedCrossSection.Text);
    FDef.Max_Unambig_Detect_Range := StrToFloat(edtMaxUnambigous.Text);
    FDef.Num_FCR_Channels := StrToInt(edtNumberofFCR.Text);
    FDef.Radar_Spot_Number := StrToInt(edtSpotNumber.Text);
    FDef.Radar_Horizon_Factor := StrToFloat(edtOTHRadarFactor.Text);
    FDef.Main_Lobe_Gain := StrToFloat(edtMainLobeGain.Text);
    FDef.Altitude_Data_Capability := chkAltitudeData.Checked;
    FDef.Plat_Type_Recog_Capability := chkPlatformTypeRecognition.Checked;
    FDef.Ground_Speed_Data_Capability := chkGroundSpeedData.Checked;
    FDef.Plat_Class_Recog_Capability := chkPlatformClassRecognition.Checked;
    FDef.Heading_Data_Capability := chkHeadingData.Checked;
    FDef.Sector_Scan_Capable := chkSectorscan.Checked;
    {$ENDREGION}

    {$REGION ' Characteristics '}
    FDef.Frequency := StrToFloat(edtFrequency.Text);
    FDef.Scan_Rate := StrToFloat(edtScanRate.Text);
    FDef.Pulse_Rep_Freq := StrToFloat(edtPulseRepetitionFrequency.Text);
    FDef.Pulse_Width := StrToFloat(edtPulseWidth.Text);
    FDef.Radar_Power := StrToFloat(edtPower.Text);
    FDef.Clutter_Rejection := StrToFloat(edtClutterRejection.Text);
    FDef.Beam_Width := StrToFloat(edtBeamWidth.Text);
    {$ENDREGION}

    {$REGION ' Anti Jamming '}
    FDef.Jamming_A_Resistant := chkTypeAJammingResistant.Checked;
    FDef.Jamming_B_Resistant := chkTypeBJammingResistant.Checked;
    FDef.Jamming_C_Resistant := chkTypeCJammingResistant.Checked;
    FDef.Off_Axis_Jammer_Reduction := trckbrJammerStrength.Position;
    FDef.Anti_Jamming_Capable := chkAntiJammingCapable.Checked;
    FDef.Anti_Jamming_A_Resistant := chkCancelTypeA.Checked;
    FDef.Anti_Jamming_B_Resistant := chkCancelTypeB.Checked;
    FDef.Anti_Jamming_C_Resistant := chkCancelTypeC.Checked;
    FDef.Anti_Jamming_Range_Reduction := trckbrPercentageMaxUnambigous.Position;
    {$ENDREGION}

    if FDef.Radar_Index = 0 then
    begin
      if dmINWO.InsertRadarDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
     if dmINWO.UpdateRadarDef(FDef) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryRadar.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSummaryRadar.btnPickClick(Sender: TObject);
begin
//  frmSNRvsPODPickList := TfrmSNRvsPODPickList.Create(Self);
//  try
//    with frmSNRvsPODPickList do
//    begin
//      SelectedPODvsSNRId := FSelectedRadar.FDef.Curve_Definition_Index;
//      ShowModal;
//      FSelectedRadar.FDef.Curve_Definition_Index := SelectedPODvsSNRId;
//    end;
//  finally
//    frmSNRvsPODPickList.Free;
//  end;
//
//  UpdateSNRvsPODData;
end;

procedure TfrmSummaryRadar.btnVerticalCoverageCurve1Click(Sender: TObject);
begin
// frmRadarCoverageGraphic := TfrmRadarCoverageGraphic.Create(Self);
//  try
//    with frmRadarCoverageGraphic do
//    begin
//      SelectedRadar := FSelectedRadar;
//      SelectedCurve := vcCurve1;
////      ProbabilityGraph := pgRadarVertical1;
////      SelectedProbObj := FSelectedRadar;
//      ShowModal;
//    end;
//    AfterClose := frmRadarCoverageGraphic.AfterClose;
//  finally
//    frmRadarCoverageGraphic.Free;
//  end;

end;

procedure TfrmSummaryRadar.chkAntiJammingCapableClick(Sender: TObject);
begin
  grbAntiJammingCapable.Enabled := chkAntiJammingCapable.Checked;

  if not chkAntiJammingCapable.Checked then
  begin
    chkCancelTypeA.Checked := False;
    chkCancelTypeB.Checked := False;
    chkCancelTypeC.Checked := False;
    trckbrPercentageMaxUnambigous.Position := 0;
    edtPercentageMaxUnambigous.Text := '0';
  end;

  btnApply.Enabled := True;

end;

procedure TfrmSummaryRadar.btnEditVertical2Click(Sender: TObject);
begin
//  frmRadarCoverageGraphic := TfrmRadarCoverageGraphic.Create(Self);
//  try
//    with frmRadarCoverageGraphic do
//    begin
//      SelectedRadar := FSelectedRadar;
////      ProbabilityGraph := pgRadarVertical2;
////      SelectedProbObj := FSelectedRadar;
//      ShowModal;
//    end;
//    AfterClose := frmRadarCoverageGraphic.AfterClose;
//  finally
//    frmRadarCoverageGraphic.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryRadar.trckbrAntiJammingChange(Sender: TObject);
begin
  case TTrackBar(Sender).Tag of
    0: {Jammer Strength Reduction per Off-Axis Beam :}
    begin
      edtJammerReduction.Text := IntToStr(TTrackBar(Sender).Position);
    end;
    1: {Precentage of Maximum Unambigous Range}
    begin
      edtPercentageMaxUnambigous.Text := IntToStr(TTrackBar(Sender).Position);
    end;
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadar.UpdateRadarData;
begin
  with FSelectedRadar do
  begin
    if FDef.Radar_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Radar_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    cbbRadarType.ItemIndex := FDef.Radar_Type;
    cbbECCMType.ItemIndex := FDef.ECCM_Type;
    edtEmitterType.Text := FDef.Radar_Emitter;
    edtBaselineDelectionRange.Text := FormatFloat('0.00', FDef.Detection_Range);
    edtAssociatedCrossSection.Text := FormatFloat('0.00', FDef.Known_Cross_Section);
    edtMaxUnambigous.Text := FormatFloat('0.00', FDef.Max_Unambig_Detect_Range);
    edtNumberofFCR.Text := IntToStr(FDef.Num_FCR_Channels);
    edtSpotNumber.Text := IntToStr(FDef.Radar_Spot_Number);
    edtOTHRadarFactor.Text := FormatFloat('0.0', FDef.Radar_Horizon_Factor);
    edtMainLobeGain.Text := FormatFloat('0.0', FDef.Main_Lobe_Gain);
    chkAltitudeData.Checked := FDef.Altitude_Data_Capability;
    chkPlatformTypeRecognition.Checked := FDef.Plat_Type_Recog_Capability;
    chkGroundSpeedData.Checked := FDef.Ground_Speed_Data_Capability;
    chkPlatformClassRecognition.Checked := FDef.Plat_Class_Recog_Capability;
    chkHeadingData.Checked := FDef.Heading_Data_Capability;
    chkSectorscan.Checked := FDef.Sector_Scan_Capable;
    {$ENDREGION}

    {$REGION ' Characteristics '}
    edtFrequency.Text := FormatFloat('0.0', FDef.Frequency);
    edtScanRate.Text := FormatFloat('0.0', FDef.Scan_Rate);
    edtPulseRepetitionFrequency.Text := FormatFloat('0.000', FDef.Pulse_Rep_Freq);
    edtPulseWidth.Text := FormatFloat('0.00', FDef.Pulse_Width);
    edtPower.Text := FormatFloat('0', FDef.Radar_Power);
    edtClutterRejection.Text := FormatFloat('0.0', FDef.Clutter_Rejection);
    edtBeamWidth.Text := FormatFloat('0', FDef.Beam_Width);

    {$ENDREGION}

    {$REGION ' Anti Jamming '}
    chkTypeAJammingResistant.Checked := FDef.Jamming_A_Resistant;
    chkTypeBJammingResistant.Checked := FDef.Jamming_B_Resistant;
    chkTypeCJammingResistant.Checked := FDef.Jamming_C_Resistant;
    trckbrJammerStrength.Position := Round(FDef.Off_Axis_Jammer_Reduction);
    chkAntiJammingCapable.Checked := FDef.Anti_Jamming_Capable;
    chkCancelTypeA.Checked := FDef.Anti_Jamming_A_Resistant;
    chkCancelTypeB.Checked := FDef.Anti_Jamming_B_Resistant;
    chkCancelTypeC.Checked := FDef.Anti_Jamming_C_Resistant;
    trckbrPercentageMaxUnambigous.Position := Round(FDef.Anti_Jamming_Range_Reduction);
    {$ENDREGION}

  end;
end;

procedure TfrmSummaryRadar.UpdateSNRvsPODData;
begin
//  with FSelectedRadar do
//  begin
//    if dmINWO.GetPODvsSNRCurveDef(FDef.Curve_Definition_Index, FPOD) then
//      edtSignalToNoise.Text := FPOD.Curve_Definition_Identifier
//    else
//      edtSignalToNoise.Text := '(None)';
//  end;
//
//  btnApply.Enabled := True;
end;

function TfrmSummaryRadar.CekInput: Boolean;
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
  if (dmINWO.GetRadarDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedRadar.FDef.Radar_Index = 0 then
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

//  Jika inputan SNR vs POD of Detection Curve masih kosong}
//  if FSelectedRadar.FDef.Curve_Definition_Index = 0 then
//  begin
//    ShowMessage('Select SNR vs POD of Detection Curve');
//    Exit;
//  end;

  Result := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummaryRadar.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryRadar.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryRadar.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadar.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadar.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadar.edtJammerReductionChange(Sender: TObject);
begin
  if edtJammerReduction.Text = '' then
    edtJammerReduction.Text := '1';

  if (StrToInt(edtJammerReduction.Text) < 1) then
    edtJammerReduction.Text := '1'
  else if (StrToInt(edtJammerReduction.Text) > 500) then
    edtJammerReduction.Text := '500';

  trckbrJammerStrength.Position := StrToInt(edtJammerReduction.Text);
  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadar.edtPercentageMaxUnambigousChange(Sender: TObject);
begin
  if edtPercentageMaxUnambigous.Text = '' then
    edtPercentageMaxUnambigous.Text := '0';

  if (StrToInt(edtPercentageMaxUnambigous.Text) > 100) then
    edtPercentageMaxUnambigous.Text := '100';

  trckbrPercentageMaxUnambigous.Position := StrToInt(edtPercentageMaxUnambigous.Text);
  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadar.ValidationFormatInput;
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

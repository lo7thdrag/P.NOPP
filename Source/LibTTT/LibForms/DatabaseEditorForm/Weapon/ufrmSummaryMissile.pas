unit ufrmSummaryMissile;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Vcl.Imaging.pngimage,

  {Project Uses}
  uDBAsset_Weapon{, tttData};

type
  TfrmSummaryMissile = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    lblDetectabilityType: TLabel;
    lblMidCourseUpdateMode: TLabel;
    lbl1: TLabel;
    lblMaxAltitudeDiff: TLabel;
    grbCapabilities: TGroupBox;
    lblPrimaryTargetDomain: TLabel;
    chkAntiAir: TCheckBox;
    chkAntiSurface: TCheckBox;
    chkSeaStateModelling: TCheckBox;
    chkAntiSubsurface: TCheckBox;
    chkAntiLand: TCheckBox;
    chkAntiAmphibious: TCheckBox;
    cbbPrimaryTargetDomain: TComboBox;
    grbHomeOnJammer: TGroupBox;
    chkTypeA: TCheckBox;
    chkTypeB: TCheckBox;
    chkTypeC: TCheckBox;
    grbLaunchSettingGeneral: TGroupBox;
    lblMethod: TLabel;
    lblInitialCommandedSpeed: TLabel;
    cbbMethod: TComboBox;
    cbbInitialCommandedSpeed: TComboBox;
    cbbDetectabilityType: TComboBox;
    cbbMidCourseUpdateMode: TComboBox;
    edtMaxAltitudeDiff: TEdit;
    grpLethality: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    trckbrLethality: TTrackBar;
    edtLethality: TEdit;
    grbDamageSustainability: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    trckbrDamageSustainability: TTrackBar;
    edtDamageSustainability: TEdit;
    grbProbabilityofHit: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    edtProbabilityofHit: TEdit;
    trckbrProbabilityofHit: TTrackBar;
    tsPhysical: TTabSheet;
    lblCroosSection: TLabel;
    grbDimensions: TGroupBox;
    lblLengthDimensions: TLabel;
    Label46: TLabel;
    lblWidthDimensions: TLabel;
    Label47: TLabel;
    Label10: TLabel;
    lblEngagementRangeDimensions: TLabel;
    Label12: TLabel;
    lblHeightDimensions: TLabel;
    edtLengthDimensions: TEdit;
    edtWidthDimensions: TEdit;
    edtHeightDimensions: TEdit;
    edtEngagementRangeDimensions: TEdit;
    grbBoosterSeparation: TGroupBox;
    lblRangeBooster: TLabel;
    lblBoxWidthBooster: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    lblBoxHeightBooster: TLabel;
    edtRangeBooster: TEdit;
    edtBoxWidthBooster: TEdit;
    edtBoxHeightBooster: TEdit;
    chkBoosterSeparation: TCheckBox;
    grbRadarPhysical: TGroupBox;
    lblFrontRadarPhysical: TLabel;
    lblSideRadarPhysical: TLabel;
    edtFrontRadarPhysical: TEdit;
    edtSideRadarPhysical: TEdit;
    cbbFrontRadarPhysical: TComboBox;
    cbbSideRadarPhysical: TComboBox;
    grbVisualPhysical: TGroupBox;
    lblFrontVisualPhysical: TLabel;
    lblSideVisualPhysical: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtFrontVisualPhysical: TEdit;
    edtSideVisualPhysical: TEdit;
    grbInfraredPhysical: TGroupBox;
    lblFrontInfraredPhysical: TLabel;
    lblSideInfraredPhysical: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    edtFrontInfraredPhysical: TEdit;
    edtSideInfraredPhysical: TEdit;
    tsPOHModifier: TTabSheet;
    grbMissile: TGroupBox;
    lblAntiRadiationMissile: TLabel;
    lblInfraredMissile: TLabel;
    lblSARHMissile: TLabel;
    lblTARHMissile: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    trckbrAntiRadiationMissile: TTrackBar;
    edtAntiRadiationMissile: TEdit;
    trckbrInfraredMissile: TTrackBar;
    edtInfraredMissile: TEdit;
    trckbrSARHMissile: TTrackBar;
    edtSARHMissile: TEdit;
    trckbrTARHMissile: TTrackBar;
    edtTARHMissile: TEdit;
    tsGuidance: TTabSheet;
    Label76: TLabel;
    lblMaxFiringGuidance: TLabel;
    lblDefaultCruiseGuidance: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    grbRangeGuindance: TGroupBox;
    lblMinRangeGuide: TLabel;
    lblMaxRangeGuide: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    edtMinRangeGuide: TEdit;
    edtMaxRangeGuide: TEdit;
    grbFlyGuindance: TGroupBox;
    lblRangeFlyGuide: TLabel;
    lblAltitudeFlyGuide: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    edtRangeFlyGuide: TEdit;
    edtAltitudeFlyGuide: TEdit;
    chkFlyOutRequired: TCheckBox;
    grpTerminalGuidance: TGroupBox;
    lblCapabilityTerminalGuidance: TLabel;
    lblStartRangeTerminalGuidance: TLabel;
    lblAltitudeTerminalGuidance: TLabel;
    lblPeriodTerminalGuidance: TLabel;
    lblAmplitudeTerminalGuidance: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    cbbCapabilityTerminalGuidance: TComboBox;
    edtStartRangeTerminalGuidance: TEdit;
    edtAltitudeTerminalGuidance: TEdit;
    edtPeriodTerminalGuidance: TEdit;
    edtAmplitudeTerminalGuidance: TEdit;
    grpSeekerTurnOnGuidance: TGroupBox;
    lblRangeSeekerTurnGuidance: TLabel;
    Label60: TLabel;
    edtRangeSeekerTurnGuidance: TEdit;
    chkRangeSeekerTurnGuidance: TCheckBox;
    grpSeekerDetectionEnvelopeGuidance: TGroupBox;
    lblRangeSeekerDetectionGuidance: TLabel;
    Label62: TLabel;
    lblAzimuthSeekerDetectionGuidance: TLabel;
    Label66: TLabel;
    lblElevationSeekerDetectionGuidance: TLabel;
    Label70: TLabel;
    edtRangeSeekerDetectionGuidance: TEdit;
    edtAzimuthSeekerDetectionGuidance: TEdit;
    edtElevationSeekerDetectionGuidance: TEdit;
    grbTerminalAcquisition: TGroupBox;
    lblCommandAltitudeGuidance: TLabel;
    Label73: TLabel;
    edtCommandAltitudeGuidance: TEdit;
    chkTerminalAcqGuidance: TCheckBox;
    grbchkWaypointUserGuidance: TGroupBox;
    lblmaxNumWaypointGuidance: TLabel;
    Label74: TLabel;
    lblMinFinalWaypointGuidance: TLabel;
    edtmaxNumWaypointGuidance: TEdit;
    edtMinFinalWaypointGuidance: TEdit;
    chkWaypointUserGuidance: TCheckBox;
    grpLaunchSettingGuidance: TGroupBox;
    lblPrimaryLaunchGuindance: TLabel;
    lblSecondaryLaunchGuindance: TLabel;
    lblPursuitLaunchGuindance: TLabel;
    cbbPrimaryLaunchGuidance: TComboBox;
    cbbSecondaryLaunchGuidance: TComboBox;
    cbbPursuitLaunchGuidance: TComboBox;
    edtMaxFiringGuidance: TEdit;
    edtDefaultCruiseGuidance: TEdit;
    tsSeekerSetting: TTabSheet;
    lblPrimaryTARH: TLabel;
    lblRangeTARH: TLabel;
    cbbPrimaryTARH: TComboBox;
    grpECM: TGroupBox;
    lblDetonationECMTARH: TLabel;
    lblDetectionECMTARH: TLabel;
    cbbDetonationECMTARH: TComboBox;
    cbbDetectionECMTARH: TComboBox;
    edtRangeTARH: TEdit;
    grpIRCM: TGroupBox;
    Label81: TLabel;
    Label82: TLabel;
    cbbDetonationIRCM: TComboBox;
    cbbDetectionIRCM: TComboBox;
    grpTerminalGuidanceTARH: TGroupBox;
    lblFreqTerminalTARH: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    edtFreqTerminalTARH: TEdit;
    edtPulseRepTerminalTARH: TEdit;
    edtScanRateTerminalTARH: TEdit;
    edtTransmitterPowerTerminalTARH: TEdit;
    edtPulseWidthTerminalTARH: TEdit;
    GroupBox26: TGroupBox;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    edtUpperLimitReceivedFreqTARH: TEdit;
    edtLowerLimitReceivedFreqTARH: TEdit;
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

    //General
    procedure UpdatePrimaryTargetDomainItems(Sender: TObject);
    procedure chkHybridTorpedoDefClick(Sender: TObject);
    procedure btnHybridTorpedoDefClick(Sender: TObject);
    procedure trckbrGeneralChange(Sender: TObject);
    procedure edtGeneralChange(Sender: TObject);
    procedure edtProbabilityofHitChange(Sender: TObject);

    //Physical
    procedure btnMotionCharacteristicClick(Sender: TObject);
    procedure chkBoosterSeparationClick(Sender: TObject);

    //POH Modifier
    procedure trckbrPOHModifierChange(Sender: TObject);
    procedure edtPOHModifierChange(Sender: TObject);

    //Guidance
    procedure cbbCapabilityTerminalGuidanceChange(Sender: TObject);
    procedure chkTerminalAcqGuidanceClick(Sender: TObject);
    procedure chkWaypointUserGuidanceClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure chkFlyOutRequiredClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    FSelectedMissile : TMissile_On_Board;
//    FSelectedHybrid : THybrid_On_Board;

    function CekInput: Boolean;
    function GetWeaponCategory(sValue : string): Integer;
    function SetWeaponCategory(aValue : Integer): string;

    procedure UpdateMissileData;
    procedure UpdateHybridData;
    procedure UpdateMotionData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedMissile : TMissile_On_Board read FSelectedMissile write FSelectedMissile;
  end;

var
  frmSummaryMissile: TfrmSummaryMissile;

implementation

uses
{Form Uses}
  uDataModule,  ufrmMissileOnBoardPickList{, ufrmTorpedoPickList, ufrmMotionPickList, uDBAsset_MotionCharacteristics};

{$R *.dfm}


{$REGION ' Form Handle '}

procedure TfrmSummaryMissile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FSelectedHybrid.Free;

end;

procedure TfrmSummaryMissile.FormShow(Sender: TObject);
begin

//  tsGeneral.Show;
//  UpdateMissileData;
//
//  with FSelectedMissile.FDef do
//    btnApply.Enabled := Missile_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;

end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryMissile.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmMissileOnBoardPickList.UpdateMissileList;
  Close;
end;

procedure TfrmSummaryMissile.btnApplyClick(Sender: TObject);
begin

  with FSelectedMissile do
  begin

    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Class_Identifier := edtClass.Text;

    FDef.Launch_Method := cbbMethod.ItemIndex;
    FDef.Launch_Speed := cbbInitialCommandedSpeed.ItemIndex;

    FDef.Home_On_Jam_Type_A_Capable := Ord(chkTypeA.Checked);
    FDef.Home_On_Jam_Type_B_Capable := Ord(chkTypeB.Checked);
    FDef.Home_On_Jam_Type_C_Capable := Ord(chkTypeC.Checked);

    FDef.Anti_Air_Capable := Ord(chkAntiAir.Checked);
    FDef.Anti_Sur_Capable := Ord(chkAntiSurface.Checked);
    FDef.Anti_SubSur_Capable := Ord(chkAntiSubsurface.Checked);
    FDef.Anti_Land_Capable := Ord(chkAntiLand.Checked);
    FDef.Anti_Amphibious_Capable := Ord(chkAntiAmphibious.Checked);
    FDef.Sea_State_Modelling_Capable := Ord(chkSeaStateModelling.Checked);

    FDef.Primary_Target_Domain := GetWeaponCategory(cbbPrimaryTargetDomain.Text);

    FDef.Max_Target_Altitude_Delta := StrToInt(edtMaxAltitudeDiff.Text);

    FDef.Detectability_Type := cbbDetectabilityType.ItemIndex;
    FDef.Mid_Course_Update_Mode := cbbMidCourseUpdateMode.ItemIndex;

    FDef.Lethality := trckbrLethality.Position;
    FDef.Damage_Capacity := trckbrDamageSustainability.Position;
    FDef.Prob_of_Hit := trckbrProbabilityOfHit.Position/100;

    {$ENDREGION}

    {$REGION ' Physical '}
    FDef.Length := StrToFloat(edtLengthDimensions.Text);
    FDef.Width := StrToFloat(edtWidthDimensions.Text);
    FDef.Height := StrToFloat(edtHeightDimensions.Text);
    FDef.Engagement_Range := StrToFloat(edtEngagementRangeDimensions.Text);

    FDef.Front_Radar_Cross := StrToFloat(edtFrontRadarPhysical.Text);
    FDef.Side_Radar_Cross := StrToFloat(edtSideRadarPhysical.Text);

    FDef.Booster_Separation_Required := Ord(chkBoosterSeparation.Checked);
    FDef.Booster_Separation_Range := StrToFloat(edtRangeBooster.Text);
    FDef.Booster_Separation_Box_Width := StrToFloat(edtBoxWidthBooster.Text);
    FDef.Booster_Separation_Box_Length := StrToFloat(edtBoxHeightBooster.Text);

    FDef.Front_Infrared_Cross := StrToFloat(edtFrontInfraredPhysical.Text);
    FDef.Side_Infrared_Cross := StrToFloat(edtSideInfraredPhysical.Text);

    FDef.Front_Visual_Cross := StrToFloat(edtFrontVisualPhysical.Text);
    FDef.Side_Visual_Cross := StrToFloat(edtSideVisualPhysical.Text);

    {$ENDREGION}

    {$REGION ' POH modifier '}
    FDef.AR_POH_Modifier := trckbrAntiRadiationMissile.Position / 100;
    FDef.IR_POH_Modifier := trckbrInfraredMissile.Position / 100;
    FDef.TARH_POH_Modifier := trckbrTARHMissile.Position / 100;
    FDef.SARH_POH_Modifier := trckbrSARHMissile.Position / 100;
    {$ENDREGION}

    {$REGION ' Guidance '}
    FDef.Primary_Guide_Type := cbbPrimaryLaunchGuidance.ItemIndex;
    FDef.Secondary_Guide_Type := cbbSecondaryLaunchGuidance.ItemIndex;
    FDef.Pursuit_Guide_Type := cbbPursuitLaunchGuidance.ItemIndex;
    FDef.Min_Range := StrToFloat(edtMinRangeGuide.Text);
    FDef.Max_Range := StrToFloat(edtMaxRangeGuide.Text);
    FDef.Fly_Out_Required := Ord(chkFlyOutRequired.Checked);
    FDef.Fly_Out_Range := StrToFloat(edtRangeFlyGuide.Text);
    FDef.Fly_Out_Altitude := StrToFloat(edtAltitudeFlyGuide.Text);

    FDef.Terminal_Guidance_Capability := cbbCapabilityTerminalGuidance.ItemIndex;

    case cbbCapabilityTerminalGuidance.ItemIndex of
      0: ; //none
      1: //pop-up
      begin
        FDef.Terminal_Pop_Up_Range := StrToFloat(edtStartRangeTerminalGuidance.Text);
        FDef.Terminal_Pop_Up_Altitude := StrToFloat(edtAltitudeTerminalGuidance.Text);
      end;
      2: //sinuation
      begin
        FDef.Terminal_Sinuation_Start_Range := StrToFloat(edtStartRangeTerminalGuidance.Text);
        FDef.Terminal_Sinuation_Period := StrToFloat(edtPeriodTerminalGuidance.Text);
        FDef.Terminal_Sinuation_Amplitude := StrToFloat(edtAmplitudeTerminalGuidance.Text);
      end;
    end;

    FDef.Seeker_TurnOn_Range := StrToFloat(edtRangeSeekerTurnGuidance.Text);
    FDef.Fixed_Seeker_Turn_On_Range := Ord(chkRangeSeekerTurnGuidance.Checked);
    FDef.Term_Guide_Range := StrToFloat(edtRangeSeekerDetectionGuidance.Text);
    FDef.Term_Guide_Azimuth := StrToFloat(edtAzimuthSeekerDetectionGuidance.Text);
    FDef.Term_Guide_Elevation := StrToFloat(edtElevationSeekerDetectionGuidance.Text);
    FDef.Terminal_Altitude_Required := Ord(chkTerminalAcqGuidance.Checked);
    FDef.Terminal_Acquisition_Altitude := StrToFloat(edtCommandAltitudeGuidance.Text);
    FDef.Wpt_Capable := Ord(chkWaypointUserGuidance.Checked);
    FDef.Max_Num_Wpts := StrToInt(edtmaxNumWaypointGuidance.Text);
    FDef.Min_Final_Leg_Length := StrToFloat(edtMinFinalWaypointGuidance.Text);
    FDef.Max_Firing_Depth := StrToFloat(edtMaxFiringGuidance.Text);
    FDef.Default_Altitude := StrToFloat(edtDefaultCruiseGuidance.Text);

    {$ENDREGION}

    {$REGION ' Seeker Setting '}
    FDef.ECCM_Type := cbbPrimaryTARH.ItemIndex;
    FDef.Spot_Number := StrToInt(edtRangeTARH.Text);
    FDef.ECM_Detonation := cbbDetonationECMTARH.ItemIndex;
    FDef.ECM_Detection := cbbDetectionECMTARH.ItemIndex;
    FDef.IRCM_Detonation := cbbDetonationIRCM.ItemIndex;
    FDef.IRCM_Detection := cbbDetectionIRCM.ItemIndex;
    FDef.Transmitted_Frequency := StrToFloat(edtFreqTerminalTARH.Text);
    FDef.Pulse_Rep_Freq := StrToFloat(edtPulseRepTerminalTARH.Text);
    FDef.Pulse_Width := StrToFloat(edtPulseWidthTerminalTARH.Text);
    FDef.Scan_Rate := StrToFloat(edtScanRateTerminalTARH.Text);
    FDef.Xmit_Power := StrToFloat(edtTransmitterPowerTerminalTARH.Text);
    FDef.Upper_Received_Freq := StrToFloat(edtUpperLimitReceivedFreqTARH.Text);
    FDef.Lower_Received_Freq := StrToFloat(edtLowerLimitReceivedFreqTARH.Text);
    {$ENDREGION}
    if FDef.Missile_Index = 0 then
    begin
      if dmINWO.InsertMissileDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateMissileDef(FDef) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

//  isOK := True;
//  AfterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryMissile.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryMissile.btnHybridTorpedoDefClick(Sender: TObject);
begin
//  frmTorpedoPickList := TfrmTorpedoPickList.Create(Self);
//  try
//    with frmTorpedoPickList do
//    begin
//      SelectedHybrid := FSelectedHybrid;
//      ShowModal;
//      FSelectedHybrid := SelectedHybrid;
//    end;
//
//  finally
//    frmTorpedoPickList.Free;
//  end;
//
//  UpdateHybridData;
end;

procedure TfrmSummaryMissile.chkBoosterSeparationClick(Sender: TObject);
begin
  grbBoosterSeparation.Enabled := chkBoosterSeparation.Checked;

  if not chkBoosterSeparation.Checked then
  begin
    edtRangeBooster.Text := '0.00';
    edtBoxWidthBooster.Text := '0.00';
    edtBoxHeightBooster.Text := '0.00';
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.chkFlyOutRequiredClick(Sender: TObject);
begin
  grbFlyGuindance.Enabled := chkFlyOutRequired.Checked;

  if not chkFlyOutRequired.Checked then
  begin
    edtRangeFlyGuide.Text := '0.00';
    edtAltitudeFlyGuide.Text := '0';
  end;
end;

procedure TfrmSummaryMissile.chkHybridTorpedoDefClick(Sender: TObject);
begin
//  grbHybridTorpedoDefinition.Enabled := chkHybridTorpedoDefinition.Checked;
//
//  if not chkHybridTorpedoDefinition.Checked then
//  begin
//    edtHybridTorpedoDef.Text := '(None)';
//    FSelectedHybrid.FTorpedo_Def.Torpedo_Index := 0;
//  end;
//
//  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.chkTerminalAcqGuidanceClick(Sender: TObject);
begin
  grbTerminalAcquisition.Enabled := chkTerminalAcqGuidance.Checked;

  if not chkTerminalAcqGuidance.Checked then
  begin
    edtCommandAltitudeGuidance.Text := '0';
  end;
end;

procedure TfrmSummaryMissile.chkWaypointUserGuidanceClick(Sender: TObject);
begin
  grbchkWaypointUserGuidance.Enabled := chkWaypointUserGuidance.Checked;

  if not chkWaypointUserGuidance.Checked then
  begin
    edtmaxNumWaypointGuidance.Text := '0';
    edtMinFinalWaypointGuidance.Text := '0';
  end;
end;

procedure TfrmSummaryMissile.edtGeneralChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 100000) then
    TEdit(Sender).Text := '100000';

  if TEdit(Sender).Name = 'edtDamageSustainability' then
    trckbrDamageSustainability.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtLethality' then
    trckbrLethality.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.edtProbabilityofHitChange(Sender: TObject);
begin
  if edtProbabilityofHit.Text = '' then
    edtProbabilityofHit.Text := '0';

  if (StrToInt(edtProbabilityofHit.Text) > 100) then
    edtProbabilityofHit.Text := '100';

  trckbrProbabilityofHit.Position := StrToInt(edtProbabilityofHit.Text);
  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.edtPOHModifierChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 100) then
    TEdit(Sender).Text := '100';

  if TEdit(Sender).Name = 'edtAntiRadiationMissile' then
    trckbrAntiRadiationMissile.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtInfraredMissile' then
    trckbrInfraredMissile.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtSARHMissile' then
    trckbrSARHMissile.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtTARHMissile' then
    trckbrTARHMissile.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.btnMotionCharacteristicClick(Sender: TObject);
begin
//  frmMotionPickList := TfrmMotionPickList.Create(Self);
//  try
//    with frmMotionPickList do
//    begin
//      SelectedMotionId := FSelectedMissile.FDef.Motion_Index;
//      ShowModal;
//      FSelectedMissile.FDef.Motion_Index := SelectedMotionId;
//    end;
//
//  finally
//    frmMotionPickList.Free;
//  end;
//
//  UpdateMotionData;
//  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.cbbCapabilityTerminalGuidanceChange(Sender: TObject);
begin
  case TComboBox(Sender).ItemIndex of
    0: //none
    begin
      edtStartRangeTerminalGuidance.Enabled := False;
      edtStartRangeTerminalGuidance.Text := '0.00';

      edtAltitudeTerminalGuidance.Enabled := False;
      edtAltitudeTerminalGuidance.Text := '0';

      edtPeriodTerminalGuidance.Enabled := False;
      edtPeriodTerminalGuidance.Text := '0.00';

      edtAmplitudeTerminalGuidance.Enabled := False;
      edtAmplitudeTerminalGuidance.Text := '0.00';

    end;
    1: //pop-up
    begin
      edtStartRangeTerminalGuidance.Enabled := True;

      edtAltitudeTerminalGuidance.Enabled := True;

      edtPeriodTerminalGuidance.Enabled := False;
      edtPeriodTerminalGuidance.Text := '0.00';

      edtAmplitudeTerminalGuidance.Enabled := False;
      edtAmplitudeTerminalGuidance.Text := '0.00';

    end;
    2: //sinuation
    begin
      edtStartRangeTerminalGuidance.Enabled := True;

      edtAltitudeTerminalGuidance.Enabled := False;
      edtAltitudeTerminalGuidance.Text := '0';

      edtPeriodTerminalGuidance.Enabled := True;

      edtAmplitudeTerminalGuidance.Enabled := True;

    end;
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.UpdatePrimaryTargetDomainItems(Sender: TObject);
begin
  cbbPrimaryTargetDomain.Items.Clear;

  if chkAntiSurface.Checked or chkAntiSubsurface.Checked or chkAntiAmphibious.Checked then
  begin
    cbbPrimaryTargetDomain.Items.Add('Air to Surface/Subsurface');
    cbbPrimaryTargetDomain.Items.Add('Surface/Subsurface to Surface/Subsurface');
  end;

  if chkAntiAir.Checked then
  begin
    cbbPrimaryTargetDomain.Items.Add('Surface/Subsurface to Air');
    cbbPrimaryTargetDomain.Items.Add('Air to Air');
  end;

  if chkAntiLand.Checked then
    cbbPrimaryTargetDomain.Items.Add('Land Attack');

  if chkAntiSurface.Checked and chkAntiSubSurface.Checked and chkAntiAir.Checked and chkAntiLand.Checked = false then
    cbbPrimaryTargetDomain.Text := ' ';

  if cbbPrimaryTargetDomain.Items.Count > 0 then
    cbbPrimaryTargetDomain.ItemIndex := 0
  else
    cbbPrimaryTargetDomain.ItemIndex := -1;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.UpdateMissileData;
//var
//  hybrid : THybrid_On_Board;

begin
  with FSelectedMissile do
  begin

    if FDef.Missile_Index = 0 then
        edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Class_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    cbbMethod.ItemIndex := FDef.Launch_Method;
    cbbInitialCommandedSpeed.ItemIndex := FDef.Launch_Speed;

    chkTypeA.Checked := Boolean(FDef.Home_On_Jam_Type_A_Capable);
    chkTypeB.Checked := Boolean(FDef.Home_On_Jam_Type_B_Capable);
    chkTypeC.Checked := Boolean(FDef.Home_On_Jam_Type_C_Capable);

    chkAntiAir.Checked := Boolean(FDef.Anti_Air_Capable);
    chkAntiSubsurface.Checked := Boolean(FDef.Anti_SubSur_Capable);
    chkAntiSurface.Checked := Boolean(FDef.Anti_Sur_Capable);
    chkAntiLand.Checked := Boolean(FDef.Anti_Land_Capable);
    chkSeaStateModelling.Checked := Boolean(FDef.Sea_State_Modelling_Capable);
    chkAntiAmphibious.Checked := Boolean(FDef.Anti_Amphibious_Capable);

    UpdatePrimaryTargetDomainItems(nil);
    cbbPrimaryTargetDomain.Text := SetWeaponCategory(FDef.Primary_Target_Domain);

    edtMaxAltitudeDiff.Text := FormatFloat('0', FDef.Max_Target_Altitude_Delta);

    cbbDetectabilityType.ItemIndex := FDef.Detectability_Type;
    cbbMidCourseUpdateMode.ItemIndex := FDef.Mid_Course_Update_Mode;

    trckbrLethality.Position := FDef.Lethality;
    trckbrDamageSustainability.Position := FDef.Damage_Capacity;
    trckbrProbabilityOfHit.Position := Round(FDef.Prob_of_Hit * 100);

    {$ENDREGION}

    {$REGION ' Physical '}
    edtLengthDimensions.Text := FormatFloat('0', FDef.Length);
    edtWidthDimensions.Text := FormatFloat('0', FDef.Width);
    edtHeightDimensions.Text := FormatFloat('0', FDef.Height);
    edtEngagementRangeDimensions.Text := FormatFloat('0', FDef.Engagement_Range);

    edtFrontRadarPhysical.Text := FormatFloat('0.00', FDef.Front_Radar_Cross);
    edtSideRadarPhysical.Text := FormatFloat('0.00', FDef.Side_Radar_Cross);

    chkBoosterSeparation.Checked := Boolean(FDef.Booster_Separation_Required);;

    edtRangeBooster.Text := FormatFloat('0.00', FDef.Booster_Separation_Range);
    edtBoxWidthBooster.Text := FormatFloat('0.00', FDef.Booster_Separation_Box_Width);
    edtBoxHeightBooster.Text := FormatFloat('0.00', FDef.Booster_Separation_Box_Length);

    edtFrontVisualPhysical.Text := FormatFloat('0.00', FDef.Front_Visual_Cross);
    edtSideVisualPhysical.Text := FormatFloat('0.00', FDef.Side_Visual_Cross);
    edtFrontInfraredPhysical.Text := FormatFloat('0.00', FDef.Front_Infrared_Cross);
    edtSideInfraredPhysical.Text := FormatFloat('0.00', FDef.Side_Infrared_Cross);
    {$ENDREGION}

    {$REGION ' POH Modifier '}

    trckbrAntiRadiationMissile.Position := Round(FDef.AR_POH_Modifier * 100);
    trckbrInfraredMissile.Position := Round(FDef.IR_POH_Modifier * 100);
    trckbrTARHMissile.Position := Round(FDef.TARH_POH_Modifier * 100);
    trckbrSARHMissile.Position := Round(FDef.SARH_POH_Modifier * 100);

    {$ENDREGION}

    {$REGION ' Guidance '}

    cbbPrimaryLaunchGuidance.ItemIndex := FDef.Primary_Guide_Type;
    cbbSecondaryLaunchGuidance.ItemIndex := FDef.Secondary_Guide_Type;
    cbbPursuitLaunchGuidance.ItemIndex := FDef.Pursuit_Guide_Type;

    edtMinRangeGuide.Text := FormatFloat('0.00', FDef.Min_Range);
    edtMaxRangeGuide.Text := FormatFloat('0.00', FDef.Max_Range);

    chkFlyOutRequired.Checked := Boolean(FDef.Fly_Out_Required);
    edtRangeFlyGuide.Text := FormatFloat('0.00', FDef.Fly_Out_Range);
    edtAltitudeFlyGuide.Text := FormatFloat('0.00', FDef.Fly_Out_Altitude);

    cbbCapabilityTerminalGuidance.ItemIndex := FDef.Terminal_Guidance_Capability;
    cbbCapabilityTerminalGuidanceChange(cbbCapabilityTerminalGuidance);

    case FDef.Terminal_Guidance_Capability of
      0: //none
      begin
        edtStartRangeTerminalGuidance.Text := FormatFloat('0.00', 0);
        edtAltitudeTerminalGuidance.Text := FormatFloat('0', FDef.Terminal_Pop_Up_Altitude);
        edtPeriodTerminalGuidance.Text := FormatFloat('0.00', FDef.Terminal_Sinuation_Period);
        edtAmplitudeTerminalGuidance.Text := FormatFloat('0.0', FDef.Terminal_Sinuation_Amplitude);
      end;
      1: //pop-up
      begin
        edtStartRangeTerminalGuidance.Text := FormatFloat('0.00', FDef.Terminal_Pop_Up_Range);
        edtAltitudeTerminalGuidance.Text := FormatFloat('0', FDef.Terminal_Pop_Up_Altitude);
      end;
      2: //sinuation
      begin
        edtStartRangeTerminalGuidance.Text := FormatFloat('0.00', FDef.Terminal_Sinuation_Start_Range);
        edtPeriodTerminalGuidance.Text := FormatFloat('0.00', FDef.Terminal_Sinuation_Period);
        edtAmplitudeTerminalGuidance.Text := FormatFloat('0.0', FDef.Terminal_Sinuation_Amplitude);
      end;
    end;

    edtRangeSeekerTurnGuidance.Text := FormatFloat('0.00', FDef.Seeker_TurnOn_Range);
    chkRangeSeekerTurnGuidance.Checked := Boolean(FDef.Fixed_Seeker_Turn_On_Range);

    edtRangeSeekerDetectionGuidance.Text := FormatFloat('0.00', FDef.Term_Guide_Range);
    edtAzimuthSeekerDetectionGuidance.Text := FormatFloat('0.0', FDef.Term_Guide_Azimuth);
    edtElevationSeekerDetectionGuidance.Text := FormatFloat('0.0', FDef.Term_Guide_Elevation);

    chkTerminalAcqGuidance.Checked := Boolean(FDef.Terminal_Altitude_Required);
    edtCommandAltitudeGuidance.Text := FormatFloat('0', FDef.Terminal_Acquisition_Altitude);

    chkWaypointUserGuidance.Checked := Boolean(FDef.Wpt_Capable);
    edtmaxNumWaypointGuidance.Text := IntToStr(FDef.Max_Num_Wpts);
    edtMinFinalWaypointGuidance.Text := FormatFloat('0.0', FDef.Min_Final_Leg_Length);

    edtMaxFiringGuidance.Text := FormatFloat('0.00', FDef.Max_Firing_Depth);
    edtDefaultCruiseGuidance.Text := FormatFloat('0', FDef.Default_Altitude);
    {$ENDREGION}

    {$REGION ' Seeker Setting '}

    cbbPrimaryTARH.ItemIndex := FDef.ECCM_Type;
    edtRangeTARH.Text := IntToStr(FDef.Spot_Number);

    cbbDetonationECMTARH.ItemIndex := FDef.ECM_Detonation;
    cbbDetectionECMTARH.ItemIndex := FDef.ECM_Detection;

    cbbDetonationIRCM.ItemIndex := FDef.IRCM_Detonation;
    cbbDetectionIRCM.ItemIndex := FDef.IRCM_Detection;

    edtFreqTerminalTARH.Text := FormatFloat('0.000', FDef.Transmitted_Frequency);
    edtPulseRepTerminalTARH.Text := FormatFloat('0.000', FDef.Pulse_Rep_Freq);
    edtPulseWidthTerminalTARH.Text := FormatFloat('0.00', FDef.Pulse_Width);
    edtScanRateTerminalTARH.Text := FormatFloat('0.00', FDef.Scan_Rate);
    edtTransmitterPowerTerminalTARH.Text := FormatFloat('0.00', FDef.Xmit_Power);

    edtUpperLimitReceivedFreqTARH.Text := FormatFloat('0.000', FDef.Upper_Received_Freq);
    edtLowerLimitReceivedFreqTARH.Text := FormatFloat('0.000', FDef.Lower_Received_Freq);

    {$ENDREGION}
  end;
end;

procedure TfrmSummaryMissile.UpdateHybridData;
begin
//  if FSelectedHybrid.FTorpedo_Def.Torpedo_Index = 0 then
//    edtHybridTorpedoDef.Text := '(None)'
//  else
//    edtHybridTorpedoDef.Text := FSelectedHybrid.FTorpedo_Def.Class_Identifier;
//
//  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.UpdateMotionData;
//var
//  motion : TMotion_Characteristics;
begin
//  with FSelectedMissile do
//  begin
//    dmTTT.GetMotionCharacteristicDef(FDef.Motion_Index, motion);
//
//    if Assigned(motion) then
//      edtMotionCharacteristic.Text := motion.FData.Motion_Identifier
//    else
//      edtMotionCharacteristic.Text := '(None)';
//
//    motion.Free;
//  end;
end;

function TfrmSummaryMissile.CekInput: Boolean;
var
 i, chkSpace, numSpace: Integer;
begin
//  Result := False;
//
//  {Jika inputan class name kosong}
//  if (edtClass.Text = '')then
//  begin
//    ShowMessage('Please insert class name');
//    Exit;
//  end;
//
//  {Jika berisi spasi semua}
//  if Copy(edtClass.Text, 1, 1) = ' ' then
//  begin
//    chkSpace := Length(edtClass.Text);
//    numSpace := 0;
//
//    for i := 1 to chkSpace do
//    begin
//      if edtClass.Text[i] = #32 then
//      numSpace := numSpace + 1;
//    end;
//
//    if chkSpace = numSpace then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end;
//  end;
//
//  {Jika Class Name sudah ada}
//  if (dmTTT.GetMissileDef(edtClass.Text)>0) then
//  begin
//    {Jika inputan baru}
//    if FSelectedMissile.FDef.Missile_Index = 0 then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end
//    else if LastName <> edtClass.Text then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end;
//  end;
//
//  {Jika Hybrid tercentang, Torpedo Definition tidak boleh kosong}
//  if chkHybridTorpedoDefinition.Checked and (FSelectedHybrid.FTorpedo_Def.Torpedo_Index = 0) then
//  begin
//    ShowMessage('Torpedo Definition not selected');
//    Exit;
//  end;
//
//  {Jika inputan Motion Characteristic masih kosong}
//  if FSelectedMissile.FDef.Motion_Index = 0 then
//  begin
//    ShowMessage('Motion Characteristics not selected');
//    Exit;
//  end;
//
//  Result := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummaryMissile.GetNumberOfKoma(s: string): Boolean;
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

function TfrmSummaryMissile.GetWeaponCategory(sValue: string): Integer;
begin
//  if sValue = 'Air to Surface/Subsurface' then Result := Byte(wcMissileAirToSurfaceSubsurface)
//  else if sValue = 'Surface/Subsurface to Surface/Subsurface' then Result := Byte(wcMissileSurfaceSubsurfaceToSurfaceSubsurface)
//  else if sValue = 'Surface/Subsurface to Air' then Result := Byte(wcMissileSurfaceSubsurfaceToAir)
//  else if sValue = 'Air to Air' then Result := Byte(wcMissileAirToAir)
//  else if sValue = 'Land Attack' then Result := Byte(wcMissileLandAttack);
end;

function TfrmSummaryMissile.SetWeaponCategory(aValue: Integer): string;
begin
//  case aValue of
//    Byte(wcMissileAirToSurfaceSubsurface) : Result := 'Air to Surface/Subsurface';
//    Byte(wcMissileSurfaceSubsurfaceToSurfaceSubsurface) : Result := 'Surface/Subsurface to Surface/Subsurface';
//    Byte(wcMissileSurfaceSubsurfaceToAir) : Result := 'Surface/Subsurface to Air';
//    Byte(wcMissileAirToAir) : Result := 'Air to Air';
//    Byte(wcMissileLandAttack) : Result := 'Land Attack';
//  end;
end;

procedure TfrmSummaryMissile.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryMissile.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.trckbrGeneralChange(Sender: TObject);
begin
  case TTrackBar(Sender).Tag of
    0: {Damage Sustainability}
    begin
      edtDamageSustainability.Text := IntToStr(TTrackBar(Sender).Position);
    end;
    1: {Lethality}
    begin
      edtLethality.Text := IntToStr(TTrackBar(Sender).Position);
    end;
    2: {Probability Of Hit}
    begin
      edtProbabilityofHit.Text := IntToStr(TTrackBar(Sender).Position);
    end;
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.trckbrPOHModifierChange(Sender: TObject);
begin
  case TTrackBar(Sender).Tag of
    0: {Anti Radiation}
    begin
      edtAntiRadiationMissile.Text := IntToStr(TTrackBar(Sender).Position);
    end;
    1: {Infrared}
    begin
      edtInfraredMissile.Text := IntToStr(TTrackBar(Sender).Position);
    end;
    2: {SARH}
    begin
      edtSARHMissile.Text := IntToStr(TTrackBar(Sender).Position);
    end;
    3: {TARH}
    begin
      edtTARHMissile.Text := IntToStr(TTrackBar(Sender).Position);
    end;
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryMissile.ValidationFormatInput;
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

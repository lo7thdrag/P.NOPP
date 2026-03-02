unit ufrmSummaryVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, Vcl.Mask, Grids, Math, Vcl.Imaging.pngimage,
  uSimContainers, {uDBAssetObject, uDBAsset_Vehicle,  uDBAsset_MotionCharacteristics, uDBAsset_Logistics,
  uDBAsset_Transport, uDBBlind_Zone, uDBAsset_Countermeasure, uDBAsset_Weapon, uDBAsset_Sonobuoy, tttData,
  uDBAsset_Sonar, uDBAsset_ESM, uDBAsset_Radar, uDBAsset_Sensor, uDBPattern,
  newClassASTT, uDBAsset_Fitted,} uBaseCoordSystem ;

const
  UM_DESTROYCONTROL = WM_USER +230;

type
  TfrmSummaryVehicle = class(TForm)
    pnl2ControlPage: TPanel;
    pgc: TPageControl;
    tsGeneral: TTabSheet;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    cbbCategory: TComboBox;
    cbbType: TComboBox;
    cbbDetectabilityType: TComboBox;
    lstName: TListBox;
    tsPhysical: TTabSheet;
    tsCharacteristic: TTabSheet;
    tsPOH: TTabSheet;
    tsAssets: TTabSheet;
    tsPeriscope: TTabSheet;
    tsNotes: TTabSheet;
    grpBasing: TGroupBox;
    btnHelicopterLimitations: TButton;
    cmbBasingType: TComboBox;
    grpReadyingTime: TGroupBox;
    labelRefuel: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    cbbDomain: TComboBox;
    lbl12: TLabel;
    edtQuantityGroupPersonal: TEdit;
    lbl13: TLabel;
    grbCapabilities: TGroupBox;
    chkNavigation: TCheckBox;
    chkBarrier: TCheckBox;
    grbCommunication: TGroupBox;
    lblAntennaHeight: TLabel;
    lblAntennaAboveWater: TLabel;
    lblMaxCommDepth: TLabel;
    mn1: TLabel;
    mn2: TLabel;
    mn3: TLabel;
    lblLink: TLabel;
    lblVoice: TLabel;
    lblMessage: TLabel;
    chkHFLink: TCheckBox;
    chkUHFLink: TCheckBox;
    chkHFVoice: TCheckBox;
    chkUHFVoice: TCheckBox;
    chkSatcom: TCheckBox;
    chkUnderwater: TCheckBox;
    chkHFMessageHandling: TCheckBox;
    chkUHFMessageHandling: TCheckBox;
    chkSATCOMMessageHAndling: TCheckBox;
    edtAntennaHeight: TEdit;
    edtAntennaAboveWater: TEdit;
    edtMaxCom: TEdit;
    grbDamage: TGroupBox;
    mnlbl10: TLabel;
    mnlbl11: TLabel;
    trckbrDamageSustainability: TTrackBar;
    edtDamageSustainability: TEdit;
    lblNames: TLabel;
    imgInsert: TImage;
    imgRemove: TImage;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    edtLengthDimension: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    edtWidthDimension: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    edtHeightDimension: TEdit;
    lbl26: TLabel;
    lbl27: TLabel;
    edtWeightDimension: TEdit;
    Label10: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    lbl28: TLabel;
    Label17: TLabel;
    edtEngagementRangeDimension: TEdit;
    Label19: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtDraftDimension: TEdit;
    Label25: TLabel;
    lbl22: TLabel;
    lbl29: TLabel;
    lblMotionCharacteristic: TLabel;
    edtMotionCharacterictic: TEdit;
    btnMotionCharacteristic: TButton;
    grbAcousticIntensityPhysical: TGroupBox;
    lblMinimumSpeed: TLabel;
    lblBelowCavitation: TLabel;
    lblAboveCavitation: TLabel;
    lblMaximumSpeed: TLabel;
    mn10: TLabel;
    mn11: TLabel;
    mn12: TLabel;
    mn13: TLabel;
    lblCavitationSpeed: TLabel;
    mn14: TLabel;
    edtMinSpeedAcousticPhysical: TEdit;
    edtBelowCavitationAcousticPhysical: TEdit;
    edtAboveCavitationAcousticPhysical: TEdit;
    edtMaxSpeedAcousticPhysical: TEdit;
    edtCavitationSpeedAcousticPhysical: TEdit;
    lblCroosSection: TLabel;
    grbRadarPhysical: TGroupBox;
    lblRadarFront: TLabel;
    lblRadarSide: TLabel;
    edtFrontRadarPhysical: TEdit;
    cbbFrontRadarPhysical: TComboBox;
    edtSideRadarPhysical: TEdit;
    cbbSideRadarPhysical: TComboBox;
    grbAcousticPhysical: TGroupBox;
    lblAcousticFront: TLabel;
    lblAcousticSide: TLabel;
    mn4: TLabel;
    mn5: TLabel;
    edtFrontAcousticPhysical: TEdit;
    edtSideAcousticPhysical: TEdit;
    grbVisualPhysical: TGroupBox;
    lblVisualEOFront: TLabel;
    lblVisualEOSide: TLabel;
    mn6: TLabel;
    mn7: TLabel;
    edtFrontVisualPhysical: TEdit;
    edtSideVisualPhysical: TEdit;
    grbInfraredPhysical: TGroupBox;
    lblInfraredFront: TLabel;
    lblInfraredSide: TLabel;
    mn8: TLabel;
    mn9: TLabel;
    edtFrontInfraredPhysical: TEdit;
    edtSideInfraredPhysical: TEdit;
    grbMagneticPhysical: TGroupBox;
    edtMagneticPhysical: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    grbMissile: TGroupBox;
    lblARHoming: TLabel;
    lblIRHoming: TLabel;
    lblSARH: TLabel;
    lblTARH: TLabel;
    mn28: TLabel;
    mn29: TLabel;
    edtAntiRadiationMissile: TEdit;
    edtInfraredHomingMissile: TEdit;
    edtSemiActiveMissile: TEdit;
    edtTerminalActiveMissile: TEdit;
    trckbrAntiRadiationMissile: TTrackBar;
    trckbrInfraredMissile: TTrackBar;
    trckbrSemiActiveMissile: TTrackBar;
    trckbrTerminalActiveMissile: TTrackBar;
    grbMine: TGroupBox;
    lblAcousticMine: TLabel;
    lblImpactMine: TLabel;
    lblMagneticMine: TLabel;
    lblPressureMine: TLabel;
    mn32: TLabel;
    mn33: TLabel;
    edtAcousticMine: TEdit;
    edtImpactMine: TEdit;
    edtMagneticMine: TEdit;
    edtPressureMine: TEdit;
    trckbrAcousticMine: TTrackBar;
    trckbrImpactMine: TTrackBar;
    trckbrMagneticMine: TTrackBar;
    trckbrPressureMine: TTrackBar;
    grbTorpedo: TGroupBox;
    lblActiveHoming: TLabel;
    lblPassiveHoming: TLabel;
    lblActivePassiveHoming: TLabel;
    lblWireGuided: TLabel;
    mn30: TLabel;
    mn31: TLabel;
    lblWakeHoming: TLabel;
    edtActiveAcousticTorpedo: TEdit;
    edtPassiveAcousticTorpedo: TEdit;
    edtActivePassiveAcousticTorpedo: TEdit;
    edtWireGuidedTorpedo: TEdit;
    trckbrActiveAcousticTorpedo: TTrackBar;
    trckbrPassiveAcousticTorpedo: TTrackBar;
    trckbrActivePassiveAcousticTorpedo: TTrackBar;
    trckbrWireGuidedTorpedo: TTrackBar;
    edtWakeHomingTorpedo: TEdit;
    trckbrWakeHomingTorpedo: TTrackBar;
    grbSensor: TGroupBox;
    btnRadar: TButton;
    btnMAD: TButton;
    btnESM: TButton;
    btnSonar: TButton;
    btnElectroOpticalDetector: TButton;
    btnIFF: TButton;
    btnVisualDetector: TButton;
    btnSonobuoy: TButton;
    grbWeapons: TGroupBox;
    btnMissiles: TButton;
    btnTorpedos: TButton;
    btnMines: TButton;
    btnGuns: TButton;
    btnBomb_DepthCharges: TButton;
    grbCountermeasures: TGroupBox;
    btnRadarJummer: TButton;
    btnAirBubble: TButton;
    btnAccousticDecoy: TButton;
    btnDefensiveJummer: TButton;
    btnTowedJummer_Decoy: TButton;
    btnFloatingDecoy: TButton;
    btnChaff: TButton;
    btnInfraredDecoy: TButton;
    edtRefuelTime: TMaskEdit;
    edtLaunchAlertTime: TMaskEdit;
    edtDefaultLogistics: TEdit;
    btnDefaultLogistics: TSpeedButton;
    lbl20: TLabel;
    lbl21: TLabel;
    edtDefaultCarryingCap: TEdit;
    btnCCapability: TSpeedButton;
    btnEmbarkedPlatforms: TButton;
    grbPeriscope: TGroupBox;
    lblMaxOperatingDepth: TLabel;
    mn37: TLabel;
    mn38: TLabel;
    lblHighAboveWater: TLabel;
    edtMaxOperatPeriscope: TEdit;
    edtHighAbovePeriscope: TEdit;
    lblPeriscopeRadarMastCrossSection: TLabel;
    grbRadar: TGroupBox;
    lblPeriscopeRadarFront: TLabel;
    lblPeriscopeRadarSide: TLabel;
    edtFrontRadar: TEdit;
    edtSideRadar: TEdit;
    cbbFontRadar: TComboBox;
    cbbSideRadar: TComboBox;
    grbInfrared: TGroupBox;
    lblPeriscopeInfraredFront: TLabel;
    lblPeriscopeInfraredSide: TLabel;
    mn39: TLabel;
    mn40: TLabel;
    edtFrontInfrared: TEdit;
    edtSideInfrared: TEdit;
    grbVisual: TGroupBox;
    lblPeriscopeVisualFront: TLabel;
    lblPeriscopeVisualSide: TLabel;
    mn41: TLabel;
    mn42: TLabel;
    edtFrontVisual: TEdit;
    edtSideVisual: TEdit;
    mmoNotes: TMemo;
    grbAirDropLimitation: TGroupBox;
    lblMaxDropAltitude: TLabel;
    lblMinDropAltitude: TLabel;
    lblMaxDropSpeed: TLabel;
    mn20: TLabel;
    mn21: TLabel;
    mn22: TLabel;
    edtMaxDropAltitude: TEdit;
    edtMinDropAltitude: TEdit;
    edtMaxDropSpeed: TEdit;
    chkSonobuoyCapable: TCheckBox;
    grbSonobuoyCapable: TGroupBox;
    mnMaxNumToMonitor: TLabel;
    mnMaxDeployAltitude: TLabel;
    mnMinDeployAltitude: TLabel;
    mn25: TLabel;
    mn26: TLabel;
    lblMaxDeploySpeed: TLabel;
    mn27: TLabel;
    edtMaxNumbToMonitor: TEdit;
    edtMaxDeployAltitude: TEdit;
    edtMinDeployAltitude: TEdit;
    edtMaxDeploySpeed: TEdit;
    grbFlowNoiseFactors: TGroupBox;
    lblHMS: TLabel;
    mnTAS: TLabel;
    mn23: TLabel;
    mn24: TLabel;
    edtHullMounted: TEdit;
    edtTowedArray: TEdit;
    tsModel: TTabSheet;
    grp2: TGroupBox;
    btnTacticalSymbol: TSpeedButton;
    lbl14: TLabel;
    lbl24: TLabel;
    cbbFontType: TComboBox;
    edtFontID: TEdit;
    lbl23: TLabel;
    grp1: TGroupBox;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    edtSymbolID: TEdit;
    edtVBSClassName: TEdit;
    Image: TImage;
    btnOK: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    ImgHeader: TImage;
    ImgBackgroundForm: TImage;
    Label1: TLabel;
    imgEdit: TImage;
    lblFontTaktis: TLabel;
    lblKeteranganSymbol: TLabel;
    Label2: TLabel;
    edtModelPath: TEdit;
    sButton1: TSpeedButton;
    cbGangwayFront: TCheckBox;
    cbGangwayRear: TCheckBox;
    cbGangwayPort: TCheckBox;
    cbGangwayStarboard: TCheckBox;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure CheckBoxDataClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    //General
    procedure InsertMemberOfClassClick(Sender: TObject);
    procedure EditMemberOfClassClick(Sender: TObject);
    procedure RemoveMemberOfClassClick(Sender: TObject);
    procedure lstNameClick(Sender: TObject);
    procedure trckbrGeneralChange(Sender: TObject);
    procedure edtGeneralChange(Sender: TObject);
    procedure cbbDomainChange(Sender: TObject);
    procedure cbbCategoryChange(Sender: TObject);

    //Model
    procedure btnOpenDialogImageClick(Sender: TObject);
    procedure btnTacticalSymbolClick(Sender: TObject);

    //Physical
    procedure btnMotionCharacteristicClick(Sender: TObject);

    //POH Modifier
    procedure trckbrPOHModifierChange(Sender: TObject);
    procedure edtPOHModifierChange(Sender: TObject);

    //Assets
    procedure btnRadarClick(Sender: TObject);
    procedure btnMADClick(Sender: TObject);
    procedure btnESMClick(Sender: TObject);
    procedure btnSonarClick(Sender: TObject);
    procedure btnEODClick(Sender: TObject);
    procedure btnIFFClick(Sender: TObject);
    procedure btnVisualDetectorClick(Sender: TObject);
    procedure btnSonobuoyClick(Sender: TObject);

    procedure btnMissilesClick(Sender: TObject);
    procedure btnTorpedosClick(Sender: TObject);
    procedure btnMinesClick(Sender: TObject);
    procedure btnGunsClick(Sender: TObject);
    procedure btnBomb_DepthChargesClick(Sender: TObject);

    procedure btnRadarJummerClick(Sender: TObject);
    procedure btnAirBubbleClick(Sender: TObject);
    procedure btnAccousticDecoyClick(Sender: TObject);
    procedure btnDefensiveJummerClick(Sender: TObject);
    procedure btnTowedJummer_DecoyClick(Sender: TObject);
    procedure btnFloatingDecoyClick(Sender: TObject);
    procedure btnChaffClick(Sender: TObject);
    procedure btnInfraredDecoyClick(Sender: TObject);
    procedure btnEmbarkedPlatformsClick(Sender: TObject);

    procedure btnDefaultLogisticsClick(Sender: TObject);
    procedure btnTransportClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

    procedure Button1Click(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
    procedure cbbFontTypeChange(Sender: TObject);
    procedure chkSonobuoyCapableClick(Sender: TObject);

  private
//    FSelectedVehicle : TVehicle_Definition;

    FPlatInstList : TList;
//    FSelectedPIIdent : TPlatform_Instance_Identifier;

    // baru
    function CekInput: Boolean;
    procedure UpdateVehicleData;
    procedure UpdateMotionData;
    procedure UpdateModelData;
    procedure UpdateLogisticData;
    procedure UpdateTransportData;

//    procedure UpdatePlatformInstanceTools;
    procedure UpdatePlatformInstanceIdentifierList;
    procedure UpdateCbbCategoryItems(const aDomain, IdCategory: Byte);
    procedure UpdateCbbTypeItems(const aDomain, aCategory, IdType: Byte);
//    procedure UpdateVehicleAssetTools;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

//    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;

  end;

var
  frmSummaryVehicle: TfrmSummaryVehicle;

implementation

{$R *.dfm}
uses
  uDataModule,
  ufrmAvailableVehicle
//  ufrmMotionPickList,  ufrmLogisticPickList, ufrmTransportPickList,
//  ufrmPlatformInstanceInput,

//  ufrmRadarOnBoardPickList, ufrmSonarOnBoardPickList, ufrmMADOnBoardPickList,
//  ufrmESMOnBoardPickList,  ufrmEODOnBoardPickList, ufrmIFFOnBoardPickList,
//  ufrmVisualDetectorOnBoardPickList, ufrmSonobuoyOnBoardPickList,
//
//  ufrmMissileOnBoardPickList, ufrmTorpedoOnBoardPickList, ufrmMineOnBoardPickList,
//  ufrmGunOnBoardPickList, ufrmBombOnBoardPickList,
//
//  ufrmAcousticDecoyOnBoardPickList, ufrmAirBubbleOnBoardPickList, ufrmChaffOnBoardPickList,
//  ufrmSelfDefensiveJammerOnBoardPickList, ufrmRadarNoiseJammerOnBoardPickList,
//  ufrmTowedJammerDecoyOnBoardPickList, ufrmFloatingDecoyOnBoardPickList,ufrmInfraredDecoyOnBoardPickList

//  ufrmChaffAssets, ufrmEmbarkedOnBoardPickList,
//  ufrmSummaryResourceAllocation, uEmbarkedSelect, uHelicopterLimitations, ufrmAvailableLogistic,
  {ufrmTacticalSymbol, uSimbolTaktis, uDBAsset_FontTaktis};


{$REGION ' Form Handle '}

procedure TfrmSummaryVehicle.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FPlatInstList);
//  FreeItemsAndFreeList(iList);
//  FreeItemsAndFreeList(PIList);
//  FreeItemsAndFreeList(embarkedList);
  Action := cafree;
end;

procedure TfrmSummaryVehicle.FormCreate(Sender: TObject);
begin
  FPlatInstList := TList.Create;
end;

procedure TfrmSummaryVehicle.FormShow(Sender: TObject);
begin
//  tsGeneral.Show;
//  UpdateVehicleData;
//
//  with FSelectedVehicle.FData do
//    btnApply.Enabled := Vehicle_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;

end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryVehicle.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  if isOk then
    Close;
end;

procedure TfrmSummaryVehicle.btnApplyClick(Sender: TObject);
var
  second : Integer;

begin
//  with FSelectedVehicle do
//  begin
//    if not CekInput then
//    begin
//      isOK := False;
//      Exit;
//    end;
//
//    ValidationFormatInput;
//
//    {$REGION ' General '}
//    LastName := edtClass.Text;
//    FData.Vehicle_Identifier := edtClass.Text;
//
//    FData.Platform_Domain := cbbDomain.ItemIndex;
//    FData.Platform_Category := cbbCategory.ItemIndex;
//    FData.Platform_Type := cbbType.ItemIndex;
//    FData.Detectability_Type := cbbDetectabilityType.ItemIndex;
//
//    FData.Chaff_Capability := chkBarrier.Checked;
//    FData.Nav_Light_Capable := chkNavigation.Checked;
//
//    FData.HF_Link_Capable := chkHFLink.Checked;
//    FData.UHF_Link_Capable := chkUHFLink.Checked;
//    FData.HF_Voice_Capable := chkHFVoice.Checked;
//    FData.UHF_Voice_Capable := chkUHFVoice.Checked;
//    FData.SATCOM_Voice_Capable := chkSatcom.Checked;
//    FData.UWT_Voice_Capable := chkUnderwater.Checked;
//    FData.HF_MHS_Capable := chkHFMessageHandling.Checked;
//    FData.UHF_MHS_Capable := chkUHFMessageHandling.Checked;
//    FData.SATCOM_MHS_Capable := chkSATCOMMessageHAndling.Checked;
//
//    FData.Rel_Comm_Antenna_Height := StrToFloat(edtAntennaHeight.Text);
//    FData.Sub_Comm_Antenna_Height := StrToFloat(edtAntennaAboveWater.Text);
//    FData.Max_Comm_Operating_Depth := StrToFloat(edtMaxCom.Text);
//
//    FData.Damage_Capacity := trckbrDamageSustainability.Position;
//    {$ENDREGION}
//
//    {$REGION ' Model '}
//    FData.Font_id := StrToInt(edtFontID.Text);
//    FData.Vbs_Class_Name := edtModelPath.Text;
//    {$ENDREGION}
//
//    {$REGION ' Physical '}
//    FData.Length := StrToFloat(edtLengthDimension.Text);
//    FData.Width := StrToFloat(edtWidthDimension.Text);
//    FData.Height := StrToFloat(edtHeightDimension.Text);
//    FData.Engagement_Range := StrToFloat(edtEngagementRangeDimension.Text);
//    FData.Draft := StrToFloat(edtDraftDimension.Text);
//    FData.DWT := StrToFloat(edtWeightDimension.Text);
//
//    FData.FrontGangway := cbGangwayFront.Checked;
//    FData.RearGangway := cbGangwayRear.Checked;
//    FData.PortGangway := cbGangwayPort.Checked;
//    FData.StarBoardGangway := cbGangwayStarboard.Checked;
//
//    FData.LSpeed_Acoustic_Intens := StrToFloat(edtMinSpeedAcousticPhysical.Text);
//    FData.Below_Cav_Acoustic_Intens := StrToFloat(edtBelowCavitationAcousticPhysical.Text);
//    FData.Above_Cav_Acoustic_Intens := StrToFloat(edtAboveCavitationAcousticPhysical.Text);
//    FData.HSpeed_Acoustic_Intens := StrToFloat(edtMaxSpeedAcousticPhysical.Text);
//    FData.Cavitation_Speed_Switch := StrToFloat(edtCavitationSpeedAcousticPhysical.Text);
//
//    FData.Front_Radar_Cross := StrToFloat(edtFrontRadarPhysical.Text);
//    FData.Side_Radar_Cross := StrToFloat(edtSideRadarPhysical.Text);
//
//    FData.Front_Acoustic_Cross := StrToFloat(edtFrontAcousticPhysical.Text);
//    FData.Side_Acoustic_Cross := StrToFloat(edtSideAcousticPhysical.Text);
//
//    FData.Front_Visual_EO_Cross := StrToFloat(edtFrontVisualPhysical.Text);
//    FData.Side_Visual_EO_Cross := StrToFloat(edtSideVisualPhysical.Text);
//
//    FData.Front_Infrared_Cross := StrToFloat(edtFrontInfraredPhysical.Text);
//    FData.Side_Infrared_Cross := StrToFloat(edtSideInfraredPhysical.Text);
//
//    FData.Magnetic_Cross := StrToFloat(edtMagneticPhysical.Text);
//    {$ENDREGION}
//
//    {$REGION ' Characteristic '}
//    FData.Air_Drop_Torpedo_Max_Altitude := StrToInt(edtMaxDropAltitude.Text);
//    FData.Air_Drop_Torpedo_Min_Altitude := StrToInt(edtMinDropAltitude.Text);
//    FData.Air_Drop_Torpedo_Max_Speed := StrToInt(edtMaxDropSpeed.Text);
//
//    FData.HMS_Noise_Reduction_Factor := StrToFloat(edtHullMounted.Text);
//    FData.TAS_Noise_Reduction_Factor := StrToFloat(edtTowedArray.Text);
//
//    FData.Max_Sonobuoys_To_Monitor := StrToInt(edtMaxNumbToMOnitor.Text);
//    FData.Sonobuoy_Deploy_Max_Altitude := StrToInt(edtMaxDeployAltitude.Text);
//    FData.Sonobuoy_Deploy_Min_Altitude := StrToInt(edtMinDeployAltitude.Text);
//    FData.Sonobuoy_Deploy_Max_Speed := StrToInt(edtMaxDeploySpeed.Text);
//    {$ENDREGION}
//
//    {$REGION ' POH modifier '}
//    FData.AR_POH_Modifier := trckbrAntiRadiationMissile.Position / 100;
//    FData.IR_POH_Modifier := trckbrInfraredMissile.Position / 100;
//    FData.SARH_POH_Modifier := trckbrSemiActiveMissile.Position / 100;
//    FData.TARH_POH_Modifier := trckbrTerminalActiveMissile.Position / 100;
//
//    FData.Active_Acoustic_Tor_POH_Mod := trckbrActiveAcousticTorpedo.Position /100;
//    FData.Passive_Acoustic_Tor_POH_Mod := trckbrPassiveAcousticTorpedo.Position /100;
//    FData.Active_Passive_Tor_POH_Mod := trckbrActivePassiveAcousticTorpedo.Position /100;
//    FData.Wake_Home_POH_Modifier := trckbrWakeHomingTorpedo.Position / 100;
//    FData.Wire_Guide_POH_Modifier := trckbrWireGuidedTorpedo.Position / 100;
//
//    FData.Acoustic_Mine_POH_Modifier := trckbrAcousticMine.Position / 100;
//    FData.Impact_Mine_POH_Modifier := trckbrImpactMine.Position / 100;
//    FData.Mag_Mine_POH_Modifier := trckbrMagneticMine.Position / 100;
//    FData.Press_Mine_POH_Modifier := trckbrPressureMine.Position / 100;
//    {$ENDREGION}
//
//    {$REGION ' Assets '}
//    TimeToSecond(edtRefuelTime.Text, second);
//    FData.Readying_Time := second;
//
//    TimeToSecond(edtLaunchAlertTime.Text, second);
//    FData.Alert_State_Time := second;
//
//    {Catatan : cbbBasingType tidak disimpan}
//    {$ENDREGION}
//
//    {$REGION ' Periscope '}
//    FData.Periscope_Depth := StrToFloat(edtMaxOperatPeriscope.Text);
//    FData.Periscope_Height_Above_Water := StrToFloat(edtHighAbovePeriscope.Text);
//    FData.Periscope_Front_Radar_Xsection := StrToFloat(edtFrontRadar.Text);
//    FData.Periscope_Side_Radar_Xsection := StrToFloat(edtSideRadar.Text);
//    FData.Periscope_Front_IR_Xsection := StrToFloat(edtFrontInfrared.Text);
//    FData.Periscope_Side_IR_Xsection := StrToFloat(edtSideInfrared.Text);
//    FData.Periscope_Front_Vis_Xsection := StrToFloat(edtFrontVisual.Text);
//    FData.Periscope_Side_Vis_Xsection := StrToFloat(edtSideVisual.Text);
//    {$ENDREGION}
//
//    {$REGION ' Notes '}
//    FNote.Notes := mmoNotes.Text;
//    {$ENDREGION}
//
//    if FData.Vehicle_Index = 0 then
//    begin
//      if dmTTT.InsertVehicleDef(FData) then
//      begin
//        dmTTT.InsertNoteStorage(1, FData.Vehicle_Index, FNote);
//        ShowMessage('Data has been saved');
//      end;
//    end
//    else
//    begin
//      if dmTTT.UpdateVehicleDef(FData) then
//      begin
//        dmTTT.UpdateNoteStorage(FData.Vehicle_Index, FNote);
//        ShowMessage('Data has been updated');
//      end;
//    end;
//  end;
//
////  UpdatePlatformInstanceTools;
////  UpdateVehicleAssetTools;
//
//  isOK := True;
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;

end;

procedure TfrmSummaryVehicle.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

{$REGION ' General '}

procedure TfrmSummaryVehicle.InsertMemberOfClassClick(Sender: TObject);
begin

//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before Add/ Edit member of class  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmPlatformInstanceInput := TfrmPlatformInstanceInput.Create(Self);
//  try
//    with frmPlatformInstanceInput do
//    begin
//      SelectedPIIdent := TPlatform_Instance_Identifier.Create;
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//
//    btnApply.Enabled := frmPlatformInstanceInput.AfterClose;
//    btnCancel.Enabled := not frmPlatformInstanceInput.AfterClose;
//
//  finally
//    frmPlatformInstanceInput.Free;
//  end;
//
//  UpdatePlatformInstanceIdentifierList;
end;

procedure TfrmSummaryVehicle.EditMemberOfClassClick(Sender: TObject);
begin
//  if lstName.ItemIndex = -1 then
//    Exit;
//
//  frmPlatformInstanceInput := TfrmPlatformInstanceInput.Create(Self);
//  try
//    with frmPlatformInstanceInput do
//    begin
//      SelectedPIIdent := FSelectedPIIdent;
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//
//    btnApply.Enabled := frmPlatformInstanceInput.AfterClose;
//    btnCancel.Enabled := not frmPlatformInstanceInput.AfterClose;
//
//  finally
//    frmPlatformInstanceInput.Free;
//  end;
//
//  UpdatePlatformInstanceIdentifierList;
end;

procedure TfrmSummaryVehicle.RemoveMemberOfClassClick(Sender: TObject);
var
  warning: Integer;
  tempList: TList;
begin
//  if lstName.ItemIndex = -1 then
//    Exit;
//
//  with FSelectedPIIdent.FData do
//  begin
//    tempList := TList.Create;
//
//    {Pengecekan Relasi Dengan Resource Allocation}
//    if dmTTT.GetPlatformInstanceIdentifierAtResourceAllocation(FSelectedPIIdent.FData.Instance_Ident_Index, tempList) then
//    begin
//      warning := MessageDlg('This Platform is already in used by some resource allocation, please chek usage at Vehicle Definition.' + Char(13) +
//      'Are you sure to delete this Vehicle Data ?', mtConfirmation, mbOKCancel, 0);
//
//      FreeItemsAndFreeList(tempList);
//      if warning = mrOK then
//        dmTTT.DeletePlatformInstance(Instance_Ident_Index)
//      else
//        Exit;
//    end;
//
//    dmTTT.DeletePlatformInstanceIdentifier(2, Instance_Ident_Index);
//  end;
//
//  UpdatePlatformInstanceIdentifierList;
end;

procedure TfrmSummaryVehicle.lstNameClick(Sender: TObject);
begin
//  if lstName.ItemIndex = -1 then
//    Exit;
//
//  FSelectedPIIdent := TPlatform_Instance_Identifier(lstName.Items.Objects[lstName.ItemIndex]);
end;

procedure TfrmSummaryVehicle.trckbrGeneralChange(Sender: TObject);
begin
  edtDamageSustainability.Text := IntToStr(TTrackBar(Sender).Position);
  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.edtGeneralChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 100000) then
    TEdit(Sender).Text := '100000';

  trckbrDamageSustainability.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.cbbCategoryChange(Sender: TObject);
begin
  UpdateCbbTypeItems(cbbDomain.ItemIndex, cbbCategory.ItemIndex, 0);
//  cbbType.ItemIndex := 0;

  lbl13.Visible := cbbType.Text = 'Group Personel';
  edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';
end;

procedure TfrmSummaryVehicle.cbbDomainChange(Sender: TObject);
begin
  UpdateCbbCategoryItems(cbbDomain.ItemIndex, 0);
  UpdateCbbTypeItems(cbbDomain.ItemIndex, 0, 0);

  lbl13.Visible := cbbType.Text = 'Group Personel';
  edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';

  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.cbbTypeChange(Sender: TObject);
begin
  lbl13.Visible := cbbType.Text = 'Group Personel';
  edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';

  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Model '}

procedure TfrmSummaryVehicle.btnOpenDialogImageClick(Sender: TObject);
//var
//  opDialog : TOpenDialog;
begin
  if edtModelPath.Text = '' then
  begin
    ShowMessage('Please insert vehicle id');
  end;

  try
    Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + edtModelPath.Text + '.PNG');
  except
    ShowMessage('Model is not found');
  end;

//  opDialog := TOpenDialog.Create(Self);
//  opDialog.InitialDir := GetCurrentDir;
//
//  opDialog.Options := [ofFileMustExist];

//  opDialog.Filter := 'bitmap|*.bmp';

//  if opDialog.Execute then
//  begin
//    edtModelPath.Text := opDialog.FileName;

//    Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + edtModelPath.Text + '.PNG');
//    Image.Picture.LoadFromFile(opDialog.FileName);
//  end
//  else
//    ShowMessage('Open file was canceled');

//  opDialog.Free;
end;

procedure TfrmSummaryVehicle.cbbFontTypeChange(Sender: TObject);
begin
  if cbbFontType.ItemIndex = -1 then
    cbbFontType.ItemIndex := 0;
end;

procedure TfrmSummaryVehicle.btnTacticalSymbolClick(Sender: TObject);
begin
//  if cbbFontType.ItemIndex = -1 then
//    Exit;
//
//  frmSimbolTaktis := TfrmSimbolTaktis.Create(Self);
//  try
//    with frmSimbolTaktis do
//    begin
//      frmSimbolTaktis.FontType := cbbFontType.ItemIndex;
//
//      if cbbFontType.ItemIndex = 0 then
//        frmSimbolTaktis.drwgrdFontTaktis.RowCount := 184
//      else if cbbFontType.ItemIndex = 1 then
//        frmSimbolTaktis.drwgrdFontTaktis.RowCount := 211
//      else if cbbFontType.ItemIndex = 2 then
//        frmSimbolTaktis.drwgrdFontTaktis.RowCount := 135;
//      ShowModal;
//
//    end;
//  finally
//    frmSimbolTaktis.Free;
//  end;
end;

{$ENDREGION}

{$REGION ' Physical '}

procedure TfrmSummaryVehicle.btnMotionCharacteristicClick(Sender: TObject);
begin
//  frmMotionPickList := TfrmMotionPickList.Create(Self);
//  try
//    with frmMotionPickList do
//    begin
//      SelectedMotionId := FSelectedVehicle.FData.Motion_Characteristics;
//      ShowModal;
//      FSelectedVehicle.FData.Motion_Characteristics := SelectedMotionId;
//    end;
//  finally
//    frmMotionPickList.Free;
//  end;
//
//  UpdateMotionData;
//  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION ' POH Modifier '}

procedure TfrmSummaryVehicle.trckbrPOHModifierChange(Sender: TObject);
begin

  case TTrackBar(Sender).Tag of
    0: edtAntiRadiationMissile.Text := IntToStr(TTrackBar(Sender).Position);
    1: edtInfraredHomingMissile.Text := IntToStr(TTrackBar(Sender).Position);
    2: edtSemiActiveMissile.Text := IntToStr(TTrackBar(Sender).Position);
    3: edtTerminalActiveMissile.Text := IntToStr(TTrackBar(Sender).Position);

    4: edtActiveAcousticTorpedo.Text := IntToStr(TTrackBar(Sender).Position);
    5: edtPassiveAcousticTorpedo.Text := IntToStr(TTrackBar(Sender).Position);
    6: edtActivePassiveAcousticTorpedo.Text := IntToStr(TTrackBar(Sender).Position);
    7: edtWakeHomingTorpedo.Text := IntToStr(TTrackBar(Sender).Position);
    8: edtWireGuidedTorpedo.Text := IntToStr(TTrackBar(Sender).Position);

    9: edtAcousticMine.Text := IntToStr(TTrackBar(Sender).Position);
    10: edtImpactMine.Text := IntToStr(TTrackBar(Sender).Position);
    11: edtMagneticMine.Text := IntToStr(TTrackBar(Sender).Position);
    12: edtPressureMine.Text := IntToStr(TTrackBar(Sender).Position);
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.edtPOHModifierChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 100) then
    TEdit(Sender).Text := '100';

  if TEdit(Sender).Name = 'edtAntiRadiationMissile' then
    trckbrAntiRadiationMissile.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtInfraredHomingMissile' then
    trckbrInfraredMissile.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtSemiActiveMissile' then
    trckbrSemiActiveMissile.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtTerminalActiveMissile' then
    trckbrTerminalActiveMissile.Position := StrToInt(TEdit(Sender).Text)

  else if TEdit(Sender).Name = 'edtActiveAcousticTorpedo' then
    trckbrActiveAcousticTorpedo.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtPassiveAcousticTorpedo' then
    trckbrPassiveAcousticTorpedo.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtActivePassiveAcousticTorpedo' then
    trckbrActivePassiveAcousticTorpedo.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtWakeHomingTorpedo' then
    trckbrWakeHomingTorpedo.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtWireGuidedTorpedo' then
    trckbrWireGuidedTorpedo.Position := StrToInt(TEdit(Sender).Text)

  else if TEdit(Sender).Name = 'edtAcousticMine' then
    trckbrAcousticMine.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtImpactMine' then
    trckbrImpactMine.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtMagneticMine' then
    trckbrMagneticMine.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtPressureMine' then
    trckbrPressureMine.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Assets '}

procedure TfrmSummaryVehicle.btnRadarClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmRadarOnBoardPickList := TfrmRadarOnBoardPickList.Create(Self);
//  try
//    with frmRadarOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//
//    AfterClose := frmRadarOnBoardPickList.AfterClose;
//  finally
//    frmRadarOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnSonarClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmSonarOnBoardPickList := TfrmSonarOnBoardPickList.Create(Self);
//  try
//    with frmSonarOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmSonarOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnESMClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmESMOnBoardPickList := TfrmESMOnBoardPickList.Create(Self);
//  try
//    with frmESMOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmESMOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnEODClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmEODOnBoardPickList := TfrmEODOnBoardPickList.Create(Self);
//  try
//    with frmEODOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmEODOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnSonobuoyClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmSonobuoyOnBoardPickList := TfrmSonobuoyOnBoardPickList.Create(Self);
//  try
//    with frmSonobuoyOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmSonobuoyOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnMADClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmMADOnBoardPickList := TfrmMADOnBoardPickList.Create(Self);
//  try
//    with frmMADOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmMADOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnIFFClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmIFFOnBoardPickList := TfrmIFFOnBoardPickList.Create(Self);
//  try
//    with frmIFFOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmIFFOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnVisualDetectorClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmVisualDetectorOnBoardPickList := TfrmVisualDetectorOnBoardPickList.Create(Self);
//  try
//    with frmVisualDetectorOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmVisualDetectorOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;


procedure TfrmSummaryVehicle.btnMissilesClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmMissileOnBoardPickList := TfrmMissileOnBoardPickList.Create(Self);
//  try
//    with frmMissileOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmMissileOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnTorpedosClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmTorpedoOnBoardPickList := TfrmTorpedoOnBoardPickList.Create(Self);
//  try
//    with frmTorpedoOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmTorpedoOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnMinesClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmMineOnBoardPickList := TfrmMineOnBoardPickList.Create(Self);
//  try
//    with frmMineOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmMineOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnBomb_DepthChargesClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmBombOnBoardPickList := TfrmBombOnBoardPickList.Create(Self);
//  try
//    with frmBombOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmBombOnBoardPickList.Free;
//  end;
//
////  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnGunsClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmGunOnBoardPickList := TfrmGunOnBoardPickList.Create(Self);
//  try
//    with frmGunOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmGunOnBoardPickList.Free;
//  end;
//
////  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;


procedure TfrmSummaryVehicle.btnAccousticDecoyClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmAcousticDecoyOnBoardPickList := TfrmAcousticDecoyOnBoardPickList.Create(Self);
//  try
//    with frmAcousticDecoyOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmAcousticDecoyOnBoardPickList.Free;
//  end;
//
////  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnAirBubbleClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmAirBubbleOnBoardPickList := TfrmAirBubbleOnBoardPickList.Create(Self);
//  try
//    with frmAirBubbleOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmAirBubbleOnBoardPickList.Free;
//  end;
//
////  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnChaffClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmChaffAssets := TfrmChaffAssets.Create(Self);
//  try
//    with frmChaffAssets do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmChaffAssets.Free;
//  end;
//
////  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;

end;

procedure TfrmSummaryVehicle.btnInfraredDecoyClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmInfraredDecoyOnBoardPickList := TfrmInfraredDecoyOnBoardPickList.Create(Self);
//  try
//    with frmInfraredDecoyOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmInfraredDecoyOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnFloatingDecoyClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmFloatingDecoyOnBoardPickList := TfrmFloatingDecoyOnBoardPickList.Create(Self);
//  try
//    with frmFloatingDecoyOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmFloatingDecoyOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnDefensiveJummerClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmSelfDefensiveJammerOnBoardPickList := TfrmSelfDefensiveJammerOnBoardPickList.Create(Self);
//  try
//    with frmSelfDefensiveJammerOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmSelfDefensiveJammerOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnTowedJummer_DecoyClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmTowedJammerDecoyOnBoardPickList := TfrmTowedJammerDecoyOnBoardPickList.Create(Self);
//  try
//    with frmTowedJammerDecoyOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmTowedJammerDecoyOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnRadarJummerClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmRadarNoiseJammerOnBoardPickList := TfrmRadarNoiseJammerOnBoardPickList.Create(Self);
//  try
//    with frmRadarNoiseJammerOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmRadarNoiseJammerOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryVehicle.btnDefaultLogisticsClick(Sender: TObject);
begin
//  frmLogisticPickList := TfrmLogisticPickList.Create(Self);
//  try
//    with frmLogisticPickList do
//    begin
//      SelectedLogisticId := FSelectedVehicle.FData.Logistics_Index;
//      ShowModal;
//      FSelectedVehicle.FData.Logistics_Index := SelectedLogisticId;
//    end;
//  finally
//    frmLogisticPickList.Free;
//  end;
//
//  UpdateLogisticData;
//  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.btnTransportClick(Sender: TObject);
begin
//  frmTransportPickList := TfrmTransportPickList.Create(Self);
//  try
//    with frmTransportPickList do
//    begin
//      SelectedTransportId := FSelectedVehicle.FData.Platform_Capability_Index;
//      ShowModal;
//      FSelectedVehicle.FData.Platform_Capability_Index := SelectedTransportId;
//    end;
//  finally
//    frmTransportPickList.Free;
//  end;
//
//  UpdateTransportData;
//  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.btnEmbarkedPlatformsClick(Sender: TObject);
begin
//  {$REGION ' Jika class belum tersimpan '}
//  if FSelectedVehicle.FData.Vehicle_Index = 0 then
//  begin
//    ShowMessage('Save data Class before continue  ');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  frmEmbarkedOnBoardPickList := TfrmEmbarkedOnBoardPickList.Create(Self);
//  try
//    with frmEmbarkedOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//  finally
//    frmEmbarkedOnBoardPickList.Free;
//  end;
//
//  btnApply.Enabled := True;
end;

{$ENDREGION}


function TfrmSummaryVehicle.CekInput: Boolean;
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
//  if (dmTTT.GetvehicleDef(edtClass.Text)>0) then
//  begin
//    {Jika inputan baru}
//    if FSelectedVehicle.FData.Vehicle_Index = 0 then
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
//  {Jika inputan Motion Characteristic masih kosong}
//  if FSelectedVehicle.FData.Motion_Characteristics = 0 then
//  begin
//    ShowMessage('Motion Characteristics not selected');
//    Exit;
//  end;
//
//  {Jika inputan Logistic masih kosong}
//  if FSelectedVehicle.FData.Logistics_Index = 0 then
//  begin
//    ShowMessage('Logistic Characteristics not selected');
//    Exit;
//  end;
//
//  {Jika inputan Transport masih kosong}
//  if FSelectedVehicle.FData.Platform_Capability_Index = 0 then
//  begin
//    ShowMessage('Transport Characteristics not selected');
//    Exit;
//  end;
//
//  Result := True;
end;

procedure TfrmSummaryVehicle.UpdateVehicleData;
var
  i : Integer;
//  piIdent : TPlatform_Instance_Identifier;
  hostPlatList : TList;
//  hostPlat : THosted_Platform;
  timeStr : string;

begin
//  with FSelectedVehicle do
//  begin
//    if FData.Vehicle_Index = 0 then
//      edtClass.Text := '(Unnamed)'
//    else
//      edtClass.Text := FData.Vehicle_Identifier;
//
//    {$REGION ' General '}
//    LastName := edtClass.Text;
//
//    UpdatePlatformInstanceIdentifierList;
//
////    cbbDomain.ItemIndex := FData.Platform_Domain;
////    cbbCategory.ItemIndex := FData.Platform_Category;
////    cbbType.ItemIndex := FData.Platform_Type;
//
//    UpdateCbbCategoryItems(FData.Platform_Domain, FData.Platform_Category);
//    UpdateCbbTypeItems(FData.Platform_Domain, FData.Platform_Category, FData.Platform_Type);
//
//    cbbDomain.ItemIndex := FData.Platform_Domain;
//    cbbCategory.ItemIndex := FData.Platform_Category;
//    cbbType.ItemIndex := FData.Platform_Type;
//
//    lbl13.Visible := cbbType.Text = 'Group Personel';
//    edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';
//    edtQuantityGroupPersonal.Text := FormatFloat('0', FData.Quantity_Group_Personal);
//
//    cbbDetectabilityType.ItemIndex := FData.Detectability_Type;
//
//    chkBarrier.Checked := FData.Chaff_Capability;
//    chkNavigation.Checked := FData.Nav_Light_Capable;
//
//    chkHFLink.Checked := FData.HF_Link_Capable;
//    chkUHFLink.Checked := FData.UHF_Link_Capable;
//    chkHFVoice.Checked := FData.HF_Voice_Capable;
//    chkUHFVoice.Checked := FData.UHF_Voice_Capable;
//    chkSatcom.Checked := FData.SATCOM_Voice_Capable;
//    chkUnderwater.Checked := FData.UWT_Voice_Capable;
//    chkHFMessageHandling.Checked := FData.HF_MHS_Capable;
//    chkUHFMessageHandling.Checked := FData.UHF_MHS_Capable;
//    chkSATCOMMessageHAndling.Checked := FData.SATCOM_MHS_Capable;
//
//    edtAntennaHeight.Text := FormatFloat('0', FData.Rel_Comm_Antenna_Height);
//    edtAntennaAboveWater.Text := FormatFloat('0', FData.Sub_Comm_Antenna_Height);
//    edtMaxCom.Text := FormatFloat('0', FData.Max_Comm_Operating_Depth);
//
//    trckbrDamageSustainability.Position := FData.Damage_Capacity;
//    {$ENDREGION}
//
//    {$REGION ' Model '}
//    edtFontID.Text := IntToStr(FData.Font_id);
//    edtModelPath.Text := FData.Vbs_Class_Name;
//
//    UpdateModelData;
//    {$ENDREGION}
//
//    {$REGION ' Physical '}
//    UpdateMotionData;
//
//    edtLengthDimension.Text := FormatFloat('0', FData.Length);
//    edtWidthDimension.Text := FormatFloat('0', FData.Width);
//    edtHeightDimension.Text := FormatFloat('0', FData.Height);
//    edtEngagementRangeDimension.Text := FormatFloat('0', FData.Engagement_Range);
//    edtDraftDimension.Text := FormatFloat('0', FData.Draft);
//    edtWeightDimension.Text := FormatFloat('0.0', FData.DWT);
//
//    cbGangwayFront.Checked := FData.FrontGangway;
//    cbGangwayRear.Checked := FData.RearGangway;
//    cbGangwayPort.Checked := FData.PortGangway;
//    cbGangwayStarboard.Checked := FData.StarBoardGangway;
//
//    edtMinSpeedAcousticPhysical.Text := FormatFloat('0.0', FData.LSpeed_Acoustic_Intens);
//    edtBelowCavitationAcousticPhysical.Text := FormatFloat('0.0', FData.Below_Cav_Acoustic_Intens);
//    edtAboveCavitationAcousticPhysical.Text := FormatFloat('0.0', FData.Above_Cav_Acoustic_Intens);
//    edtMaxSpeedAcousticPhysical.Text := FormatFloat('0.0', FData.HSpeed_Acoustic_Intens);
//    edtCavitationSpeedAcousticPhysical.Text := FormatFloat('0.00', FData.Cavitation_Speed_Switch);
//
//    edtFrontRadarPhysical.Text := FormatFloat('0.00', FData.Front_Radar_Cross);
//    edtSideRadarPhysical.Text := FormatFloat('0.00', FData.Side_Radar_Cross);
//
//    edtFrontAcousticPhysical.Text := FormatFloat('0.00', FData.Front_Acoustic_Cross);
//    edtSideAcousticPhysical.Text := FormatFloat('0.00', FData.Side_Acoustic_Cross);
//
//    edtFrontVisualPhysical.Text := FormatFloat('0.0', FData.Front_Visual_EO_Cross);
//    edtSideVisualPhysical.Text := FormatFloat('0.0', FData.Side_Visual_EO_Cross);
//
//    edtFrontInfraredPhysical.Text := FormatFloat('0.0', FData.Front_Infrared_Cross);
//    edtSideInfraredPhysical.Text := FormatFloat('0.0', FData.Side_Infrared_Cross);
//
//    edtMagneticPhysical.Text := FormatFloat('0.00', FData.Magnetic_Cross);
//    {$ENDREGION}
//
//    {$REGION ' Characteristic '}
//    edtMaxDropAltitude.Text := IntToStr(FData.Air_Drop_Torpedo_Max_Altitude);
//    edtMinDropAltitude.Text := IntToStr(FData.Air_Drop_Torpedo_Min_Altitude);
//    edtMaxDropSpeed.Text := IntToStr(FData.Air_Drop_Torpedo_Max_Speed);
//
//    edtHullMounted.Text := FormatFloat('0.0', FData.HMS_Noise_Reduction_Factor);
//    edtTowedArray.Text := FormatFloat('0.0', FData.TAS_Noise_Reduction_Factor);
//
//    edtMaxNumbToMOnitor.Text := IntToStr(FData.Max_Sonobuoys_To_Monitor);
//    edtMaxDeployAltitude.Text := IntToStr(FData.Sonobuoy_Deploy_Max_Altitude);
//    edtMinDeployAltitude.Text := IntToStr(FData.Sonobuoy_Deploy_Min_Altitude);
//    edtMaxDeploySpeed.Text := IntToStr(FData.Sonobuoy_Deploy_Max_Speed);
//    {$ENDREGION}
//
//    {$REGION ' POH modifier '}
//    trckbrAntiRadiationMissile.Position := Round(FData.AR_POH_Modifier * 100);
//    trckbrInfraredMissile.Position := Round(FData.IR_POH_Modifier * 100);
//    trckbrSemiActiveMissile.Position := Round(FData.SARH_POH_Modifier * 100);
//    trckbrTerminalActiveMissile.Position := Round(FData.TARH_POH_Modifier * 100);
//
//    trckbrActiveAcousticTorpedo.Position := Round(FData.Active_Acoustic_Tor_POH_Mod * 100);
//    trckbrPassiveAcousticTorpedo.Position := Round(FData.Passive_Acoustic_Tor_POH_Mod * 100);
//    trckbrActivePassiveAcousticTorpedo.Position := Round(FData.Active_Passive_Tor_POH_Mod * 100);
//    trckbrWakeHomingTorpedo.Position := Round(FData.Wake_Home_POH_Modifier * 100);
//    trckbrWireGuidedTorpedo.Position := Round(FData.Wire_Guide_POH_Modifier * 100);
//
//    trckbrAcousticMine.Position := Round(FData.Acoustic_Mine_POH_Modifier * 100);
//    trckbrImpactMine.Position := Round(FData.Impact_Mine_POH_Modifier * 100);
//    trckbrMagneticMine.Position := Round(FData.Mag_Mine_POH_Modifier * 100);
//    trckbrPressureMine.Position := Round(FData.Press_Mine_POH_Modifier * 100);
//    {$ENDREGION}
//
//    {$REGION ' Assets '}
//    UpdateLogisticData;
//    UpdateTransportData;
//
//    SecondToTime(FData.Readying_Time, timeStr);
//    edtRefuelTime.Text := timeStr;
//
//    SecondToTime(Round(FData.Alert_State_Time), timeStr);
//    edtLaunchAlertTime.Text := timeStr;
//
//    {$ENDREGION}
//
//    {$REGION ' Periscope '}
//    edtMaxOperatPeriscope.Text := FormatFloat('0', FData.Periscope_Depth);
//    edtHighAbovePeriscope.Text := FormatFloat('0', FData.Periscope_Height_Above_Water);
//    edtFrontRadar.Text := FormatFloat('0.00', FData.Periscope_Front_Radar_Xsection);
//    edtSideRadar.Text := FormatFloat('0.00', FData.Periscope_Side_Radar_Xsection);
//    edtFrontInfrared.Text := FormatFloat('0.0', FData.Periscope_Front_IR_Xsection);
//    edtSideInfrared.Text := FormatFloat('0.0', FData.Periscope_Side_IR_Xsection);
//    edtFrontVisual.Text := FormatFloat('0.0', FData.Periscope_Front_Vis_Xsection);
//    edtSideVisual.Text := FormatFloat('0.0', FData.Periscope_Side_Vis_Xsection);
//    {$ENDREGION}
//
//    {$REGION ' Notes '}
//    mmoNotes.Text := FNote.Notes;
//    {$ENDREGION}
//
//  end;
end;

procedure TfrmSummaryVehicle.UpdateModelData;
//var
//  aFontTaktis : TFontTaktis;
begin
//  aFontTaktis := TFontTaktis.Create;
//
//  dmTTT.getFontByID(StrToInt(edtFontID.Text), aFontTaktis);
//  with FSelectedVehicle.FData do
//  begin
//    lblFontTaktis.Font.Name := aFontTaktis.FData.FONT_NAME;
//    lblFontTaktis.Font.Size := 30;
//    lblFontTaktis.Font.Style := [fsBold];
//    lblFontTaktis.Caption := Char(aFontTaktis.FData.FONT_INDEX);
//    lblKeteranganSymbol.Caption := aFontTaktis.FData.KETERANGAN;
//
//    try
//      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + Vbs_Class_Name + '.PNG');
//    except
//      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\NoModel.bmp');
//    end;
//
//  end;
//
//  aFontTaktis.Free
end;

procedure TfrmSummaryVehicle.UpdateMotionData;
//var
//  motion : TMotion_Characteristics;
begin
//  with FSelectedVehicle.FData do
//    dmTTT.GetMotionCharacteristicDef(Motion_Characteristics, motion);
//
//  if Assigned(motion) then
//    edtMotionCharacterictic.Text := motion.FData.Motion_Identifier
//  else
//    edtMotionCharacterictic.Text := '(None)';
//
//  motion.Free;
end;

procedure TfrmSummaryVehicle.UpdatePlatformInstanceIdentifierList;
var
  i : Integer;
//  PIIdentifer : TPlatform_Instance_Identifier;
begin
//  lstName.Items.Clear;
//
//  dmTTT.GetAllPlatformInstanceIdentifier(FSelectedVehicle.FData.Vehicle_Index, FPlatInstList);
//
//  for i := 0 to FPlatInstList.Count - 1 do
//  begin
//    PIIdentifer := FPlatInstList.Items[i];
//    lstName.Items.AddObject(PIIdentifer.FData.Instance_Identifier, PIIdentifer);
//  end;
end;

procedure TfrmSummaryVehicle.UpdateLogisticData;
//var
//  logistic : TLogistics;
begin
//  with FSelectedVehicle.FData do
//    dmTTT.GetLogisticDef(Logistics_Index, logistic);
//
//  if Assigned(logistic) then
//    edtDefaultLogistics.Text := logistic.FData.Logistic_Identifier
//  else
//    edtDefaultLogistics.Text := '(None)';
end;

procedure TfrmSummaryVehicle.UpdateTransportData;
//var
//  transport : TTransport;
begin
//  with FSelectedVehicle.FData do
//    dmTTT.GetTransportDef(Platform_Capability_Index, transport);
//
//  if Assigned(transport) then
//    edtDefaultCarryingCap.Text := transport.FData.Transport_Identifier
//  else
//    edtDefaultCarryingCap.Text := '(None)';
end;

procedure TfrmSummaryVehicle.UpdateCbbCategoryItems(const aDomain, IdCategory: Byte);
begin
  case aDomain of
    0: //Air
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Military');
      cbbCategory.Items.Add('Civilian');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    1: //Surface
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Combatant');
      cbbCategory.Items.Add('Non-combatant');
      cbbCategory.Items.Add('Non-naval');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    2: //Subsurface
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Submarine');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    3: //Land
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Armoured Vehicle');
      cbbCategory.Items.Add('Transport Vehicle');
      cbbCategory.Items.Add('Infantry');
      cbbCategory.Items.Add('Artillery');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    4: //Amphibious
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Amphibious');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.UpdateCbbTypeItems(const aDomain, aCategory, IdType: Byte);
begin

  {$REGION ' Air '}
  if aDomain = 0 then
  begin
    case aCategory of
      0,1,2: {Military, Civilian, Other }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Fixed Wing');
        cbbType.Items.Add('Rotary Wing');
        cbbType.Items.Add('Seaplane');
        cbbType.Items.Add('Other');

        cbbType.ItemIndex := IdType;
      end;
    end;
  end
  {$ENDREGION}

  {$REGION ' Surface '}
  else if aDomain = 1 then
  begin
    case aCategory of
      0: {Combatant }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Frigate');
        cbbType.Items.Add('Destroyer');
        cbbType.Items.Add('Corvettes');
        cbbType.Items.Add('Amphibious Forces');
        cbbType.Items.Add('Aircraft Carrier');
        cbbType.Items.Add('Patrol Forces');
        cbbType.Items.Add('Mine Warfare Forces');
        cbbType.Items.Add('Auxillaries');
      end;
      1: {Non-Combatant }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Auxiliary');
        cbbType.Items.Add('Merchant');
      end;
      2: {Non Naval}
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Passanger Ship');
        cbbType.Items.Add('Carge');
        cbbType.Items.Add('Tanker');
      end;
      3: {Other }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Other');
      end;
    end;

    cbbType.ItemIndex := 0;
  end
  {$ENDREGION}

  {$REGION ' Subsurface '}
  else if aDomain = 2 then
  begin
    case aCategory of
      0: {Submarine }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Diesel');
        cbbType.Items.Add('Nuclear');
      end;
      1: {Other }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Other');
      end;
    end;

    cbbType.ItemIndex := 0;
  end
  {$ENDREGION}

  {$REGION ' Land '}
  else if aDomain = 3 then
  begin
    case aCategory of
      0: {Armoured Vehicle }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Main Battle Tank');
        cbbType.Items.Add('Armoured Personel Carrier');
      end;
      1: {Transport Vehicle }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Truck');
        cbbType.Items.Add('Utility Vehicle');
      end;
      2: {Infantry }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Group Personel');
        cbbType.Items.Add('Other');
      end;
      3: {Artillery }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Field Artillery');
        cbbType.Items.Add('Anti Aircraft Artillery');
        cbbType.Items.Add('Coastal Defense Artillery');
        cbbType.Items.Add('Other');
      end;
      4: {Other }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Other');
      end;
    end;

    cbbType.ItemIndex := 0;
  end
  {$ENDREGION}

  {$REGION ' Amphibious '}
  else if aDomain = 4 then
  begin
    case aCategory of
      0: {Amphibious }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Amphibious Tank');
        cbbType.Items.Add('Amphibious Personel Carrier');
        cbbType.Items.Add('Hovercraft');
      end;
      1: {Other }
      begin
        cbbType.Items.Clear;
        cbbType.Items.Add('Other');
      end;
    end;

    cbbType.ItemIndex := 0;
  end;
  {$ENDREGION}

  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummaryVehicle.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryVehicle.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryVehicle.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.chkSonobuoyCapableClick(Sender: TObject);
begin
  grbSonobuoyCapable.Enabled := chkSonobuoyCapable.Checked;

  if not chkSonobuoyCapable.Checked then
  begin
    edtMaxNumbToMOnitor.Text  := '0';
    edtMaxDeployAltitude.Text := '0';
    edtMinDeployAltitude.Text := '0';
    edtMaxDeploySpeed.Text    := '0.00';
  end;
end;

procedure TfrmSummaryVehicle.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryVehicle.ValidationFormatInput;
var
  i, j: Integer;
  value : Double;
  hStr, mStr, sStr, hmSeparator, msSeparator : string;
  h, m, s : Integer;
  aTimeStr : string;
  flag : Boolean;

begin
  for i:= 0 to ComponentCount-1 do
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

      Continue;
    end;

    if Components[i] is TMaskEdit then
    begin
      aTimeStr := TMaskEdit(Components[i]).Text;
      flag := False;

      hStr := Copy(aTimeStr, 1, 2);
      TryStrToInt(hStr, h);

      mStr := Copy(aTimeStr, 4, 2);
      TryStrToInt(mStr, m);

      sStr := Copy(aTimeStr, 7, 2);
      TryStrToInt(sStr, s);

      if h > 23 then
      begin
        hStr := '23';
        flag := True;
      end;

      if m > 59 then
      begin
        mStr := '59';
        flag := True;
      end;

      if s > 59 then
      begin
        sStr := '59';
        flag := True;
      end;

      if flag then
        TMaskEdit(Components[i]).Text := hStr + ':' + mStr + ':' + sStr;

    end;
  end;
end;

procedure TfrmSummaryVehicle.Button1Click(Sender: TObject);
var
  RSRF, Displacement, Lengt, Width, Height, HGS, SideRCS, tonsToKgs : Double;
  FrontRCS, VCSFront, VCSSide, ACSFront, ACSSide, IRCSFront, IRCSSide, MCS : Double;
begin
  case cbbDomain.ItemIndex of
     0: //Air
      begin
        Lengt := StrToFloat(edtLengthDimension.Text);
        Width := StrToFloat(edtWidthDimension.Text);
        Height := StrToFloat(edtHeightDimension.Text);
        HGS := StrToFloat(Edit1.Text);
        Displacement := (StrToFloat(edtWeightDimension.Text))*1000;

        //----------------------Radar Crossection---------------//
        FrontRCS := (10 * (Log10((Displacement/11167))));
        SideRCS := FrontRCS + (10 * Log10(Lengt/Width));

        //----------------------Visual Crossection-------------//
        VCSFront := (16 * (Log10((Lengt * Width * Height)/3461.47)));
        VCSSide := VCSFront;

        //----------------------Acoustic Crossection-----------//
        ACSFront := (10 * (Log10(Displacement/145)));
        ACSSide := (ACSFront + (10 * (Log10(Lengt/width))));

        //----------------------Infrared Crossection-----------//
        IRCSFront := (50 * (Log10(HGS/50)));
        IRCSSide := IRCSFront;

        //---------------------Magnetic Crossection------------//
        MCS := ((50 * (Log10(Displacement/1500))) + 50);


        edtFrontRadarPhysical.Text  := FormatFloat('0.00', FrontRCS);
        edtSideRadarPhysical.Text   := FormatFloat('0.00', SideRCS);

        edtFrontVisualPhysical.Text := FormatFloat('0.00', VCSFront);
        edtSideVisualPhysical.Text  := FormatFloat('0.00', VCSSide);

        edtFrontAcousticPhysical.Text := FormatFloat('0.00', ACSFront);
//        edtFrontSidePhysical.Text   := FormatFloat('0.00', ACSSide);

        edtFrontInfraredPhysical.Text := FormatFloat('0.00', IRCSFront);
        edtSideInfraredPhysical.Text  := FormatFloat('0.00', IRCSSide);

        edtMagneticPhysical.Text    := FormatFloat('0.00', MCS);
      end;
    1, 4 : //Surface, Amphibious
      begin
        RSRF := 1.0; //Radar Signature Reduction Factor
        Lengt := StrToFloat(edtLengthDimension.Text);
        Width := StrToFloat(edtWidthDimension.Text);
        Displacement := StrToFloat(edtWeightDimension.Text);

        //----------------------Radar Crossection---------------//
        FrontRCS := (10 * (Log10(RSRF * (Displacement/4.305))));
        SideRCS := FrontRCS + (10 * Log10(Lengt/Width));

        //----------------------Visual Crossection-------------//
        VCSFront := (20 * ((Log10(Displacement)) + 1));
        VCSSide := VCSFront;

        //----------------------Acoustic Crossection-----------//
        ACSFront := (10 * (Log10(Displacement/145)));
        ACSSide := (ACSFront + (10 * (Log10(Lengt/width))));

        //----------------------Infrared Crossection-----------//
        IRCSFront := (10 * (Log10(Displacement/3000)) + 50) * 1.0;
        IRCSSide := IRCSFront;

        //---------------------Magnetic Crossection------------//
        MCS := ((50 * (Log10(Displacement/1500))) + 50);


        edtFrontRadarPhysical.Text  := FormatFloat('0.00', FrontRCS);
        edtSideRadarPhysical.Text   := FormatFloat('0.00', SideRCS);

        edtFrontVisualPhysical.Text := FormatFloat('0.00', VCSFront);
        edtSideVisualPhysical.Text  := FormatFloat('0.00', VCSSide);

        edtFrontAcousticPhysical.Text := FormatFloat('0.00', ACSFront);
//        edtFrontSidePhysical.Text   := FormatFloat('0.00', ACSSide);

        edtFrontInfraredPhysical.Text := FormatFloat('0.00', IRCSFront);
        edtSideInfraredPhysical.Text  := FormatFloat('0.00', IRCSSide);

        edtMagneticPhysical.Text    := FormatFloat('0.00', MCS);
      end;
    2 : //Subsurface
      begin
        RSRF := 0.1; //Radar Signature Reduction Factor
        Lengt := StrToFloat(edtLengthDimension.Text);
        Width := StrToFloat(edtWidthDimension.Text);
        Displacement := StrToFloat(edtWeightDimension.Text);

        //----------------------Radar Crossection---------------//
        FrontRCS := (10 * (Log10(RSRF * (Displacement/4.305))));
        SideRCS := FrontRCS + (10 * Log10(Lengt/Width));

        //----------------------Visual Crossection-------------//
        VCSFront := (20 * ((Log10(Displacement)) + 1));
        VCSSide := VCSFront;

        //----------------------Acoustic Crossection-----------//
        ACSFront := (10 * (Log10(Displacement/145)));
        ACSSide := (ACSFront + (10 * (Log10(Lengt/width))));

        //----------------------Infrared Crossection-----------//
        IRCSFront := (10 * (Log10(Displacement/3000)) + 50) * 0.3;
        IRCSSide := IRCSFront;

        //---------------------Magnetic Crossection------------//
        MCS := ((50 * (Log10(Displacement/1500))) + 50);


        edtFrontRadarPhysical.Text  := FormatFloat('0.00', FrontRCS);
        edtSideRadarPhysical.Text   := FormatFloat('0.00', SideRCS);

        edtFrontVisualPhysical.Text := FormatFloat('0.00', VCSFront);
        edtSideVisualPhysical.Text  := FormatFloat('0.00', VCSSide);

        edtFrontAcousticPhysical.Text := FormatFloat('0.00', ACSFront);
//        edtFrontSidePhysical.Text   := FormatFloat('0.00', ACSSide);

        edtFrontInfraredPhysical.Text := FormatFloat('0.00', IRCSFront);
        edtSideInfraredPhysical.Text  := FormatFloat('0.00', IRCSSide);

        edtMagneticPhysical.Text    := FormatFloat('0.00', MCS);
      end;
  end;
end;

{$ENDREGION}

end.

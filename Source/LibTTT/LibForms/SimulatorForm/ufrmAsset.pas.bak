unit ufrmAsset;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ComCtrls,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uRecordData, uDBAsset_Vehicle;

type
  TfrmAsset = class(TForm)
    pnlMain: TPanel;
    imgBackgroundForm: TImage;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    lblPlatform: TLabel;
    btnOK: TImage;
    btnApply: TImage;
    btnCancel: TImage;
    pgc: TPageControl;
    tsGeneral: TTabSheet;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl1: TLabel;
    Label3: TLabel;
    cbbCategory: TComboBox;
    cbbType: TComboBox;
    cbbDomain: TComboBox;
    edtQuantityGroupPersonal: TEdit;
    edtNoLambung: TEdit;
    tsModel: TTabSheet;
    lbl23: TLabel;
    Image: TImage;
    grp1: TGroupBox;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    edtSymbolID: TEdit;
    edtVBSClassName: TEdit;
    grp2: TGroupBox;
    btnTacticalSymbol: TSpeedButton;
    lbl14: TLabel;
    lbl24: TLabel;
    lblFontTaktis: TLabel;
    lblKeteranganSymbol: TLabel;
    Label2: TLabel;
    sButton1: TSpeedButton;
    cbbFontType: TComboBox;
    edtFontID: TEdit;
    edtModelPath: TEdit;
    tsPhysical: TTabSheet;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    lbl28: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    lbl22: TLabel;
    lbl29: TLabel;
    edtLengthDimension: TEdit;
    edtWidthDimension: TEdit;
    edtHeightDimension: TEdit;
    edtWeightDimension: TEdit;
    edtEngagementRangeDimension: TEdit;
    edtDraftDimension: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    cbGangwayFront: TCheckBox;
    cbGangwayRear: TCheckBox;
    cbGangwayPort: TCheckBox;
    cbGangwayStarboard: TCheckBox;
    tsAssets: TTabSheet;
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
    btnEmbarkedPlatforms: TButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtMaxOperatPeriscope: TEdit;
    edtHighAbovePeriscope: TEdit;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtkecepatanJelajah: TEdit;
    edtKecepatanEkonomis: TEdit;
    edtKecepatanMaksimal: TEdit;
    Label28: TLabel;
    edtKonsumsiFuel: TEdit;
    Label32: TLabel;
    edtEndurance: TEdit;
    GroupBox4: TGroupBox;
    Label29: TLabel;
    edtKapasitasAT: TEdit;
    edtkapasitasBB: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    edtKapasitasML: TEdit;
    Label33: TLabel;
    edtFood: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Edit2: TEdit;
    Label43: TLabel;
    Label44: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure cbbDomainChange(Sender: TObject);
    procedure cbbCategoryChange(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
    procedure cbbFontTypeChange(Sender: TObject);
    procedure btnTacticalSymbolClick(Sender: TObject);
    procedure btnOpenDialogImageClick(Sender: TObject);
    procedure btnRadarClick(Sender: TObject);
    procedure btnSonarClick(Sender: TObject);
    procedure btnESMClick(Sender: TObject);
    procedure btnEODClick(Sender: TObject);
    procedure btnMADClick(Sender: TObject);
    procedure btnSonobuoyClick(Sender: TObject);
    procedure btnVisualDetectorClick(Sender: TObject);
    procedure btnIFFClick(Sender: TObject);
    procedure btnMissilesClick(Sender: TObject);
    procedure btnTorpedosClick(Sender: TObject);
    procedure btnMinesClick(Sender: TObject);
    procedure btnGunsClick(Sender: TObject);
    procedure btnBomb_DepthChargesClick(Sender: TObject);
    procedure btnAccousticDecoyClick(Sender: TObject);
    procedure btnAirBubbleClick(Sender: TObject);
    procedure btnChaffClick(Sender: TObject);
    procedure btnFloatingDecoyClick(Sender: TObject);
    procedure btnInfraredDecoyClick(Sender: TObject);
    procedure btnRadarJummerClick(Sender: TObject);
    procedure btnDefensiveJummerClick(Sender: TObject);
    procedure btnTowedJummer_DecoyClick(Sender: TObject);
    procedure btnEmbarkedPlatformsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure ValidationFormatInput();
    procedure Button1Click(Sender: TObject);
    procedure edtNumeralkeyPress(Sender: TObject; var Key: Char);
    function GetNumberOfKoma(s : string): Boolean;
    procedure CheckBoxDataClick(Sender: TObject);

  private
    FSelectedAsset : TAsset ;

    function CekInput : Boolean;
    procedure UpdateVehicleData;
    procedure UpdateModelData;

    procedure UpdateCbbCategoryItems(const aDomain, IdCategory: Byte);
    procedure UpdateCbbTypeItems(const aDomain, aCategory, IdType: Byte);

  public
    isOK : Boolean;
    afterClose : Boolean;
    LastName : string;

    property SelectedAsset : TAsset read FSelectedAsset write FSelectedAsset;
  end;

var
  frmAsset: TfrmAsset;

implementation

{$R *.dfm}
uses
  ufrmRadarOnBoardPickList, ufrmSonarOnBoardPickList, ufrmESMOnBoardPickList,
  ufrmEODOnBoardPickList, ufrmMADOnBoardPickList, ufrmSonobuoyOnBoardPickList,
  ufrmVisualDetectorOnBoardPickList, ufrmIFFOnBoardPickList, ufrmMissileOnBoardPickList,
  ufrmTorpedoOnBoardPickList, ufrmMineOnBoardPickList, ufrmGunOnBoardPickList,
  ufrmBombOnBoardPickList, ufrmAcousticDecoyOnBoardPickList, ufrmAirBubbleOnBoardPickList,
  ufrmChaffOnBoardPickList, ufrmFloatingDecoyOnBoardPickList, ufrmInfraredDecoyOnBoardPickList,
  ufrmRadarNoiseJammerOnBoardPickList, ufrmSelfDefensiveJammerOnBoardPickList,
  ufrmTowedJammerDecoyOnBoardPickList, ufrmEmbarkedOnBoardPickList, uSimbolTaktis;

procedure TfrmAsset.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateVehicleData;

  with FSelectedAsset.FData do
    btnApply.Enabled := Vehicle_Index = 0;

  isOK := True;
  afterClose := True;
  btnCancel.Enabled := True;
end;

procedure TfrmAsset.btnApplyClick(Sender: TObject);
begin
  with FSelectedAsset do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION 'General'}
    LastName := edtClass.Text;
    FData.Vehicle_Identifier := edtClass.Text;

    FData.Platform_Domain := cbbDomain.ItemIndex;
    FData.Platform_Category := cbbCategory.ItemIndex;
    FData.Platform_Type := cbbType.ItemIndex;
//    FData.HullNumber := edtNoLambung.Text;
//    FData.CallSign := edtCallSign.Text;
    {$ENDREGION}

    {$REGION 'Model'}
    FData.Font_id := StrToInt(edtFontID.Text);
    FData.Vbs_Class_Name := edtModelPath.Text;
    {$ENDREGION}

    {$REGION 'Physical'}
    FData.Length := StrToFloat(edtLengthDimension.Text);
    FData.Width := StrToFloat(edtWidthDimension.Text);
    FData.Height := StrToFloat(edtHeightDimension.Text);
    FData.Engagement_Range := StrToFloat(edtEngagementRangeDimension.Text);
    FData.Draft := StrToFloat(edtDraftDimension.Text);
    FData.DWT := StrToFloat(edtWeightDimension.Text);

    FData.FrontGangway := cbGangwayFront.Checked;
    FData.RearGangway := cbGangwayRear.Checked;
    FData.PortGangway := cbGangwayPort.Checked;
    FData.StarBoardGangway := cbGangwayStarboard.Checked;
    {$ENDREGION}

    {$REGION 'Assets'}
    FData.Periscope_Depth := StrToFloat(edtMaxOperatPeriscope.Text);
    FData.Periscope_Height_Above_Water := StrToFloat(edtHighAbovePeriscope.Text);
    {$ENDREGION}

    {$REGION 'Notes'}
    FNote.Notes := mmoNotes.Text;
    {$ENDREGION}


    if FData.Vehicle_Index = 0 then
    begin
      if dmINWO.InsertVehicleDef(FData) then
      begin
        dmINWO.InsertNoteStorage(1, FData.Vehicle_Index, FNote);
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateVehicleDef(FData) then
      begin
        dmINWO.UpdateNoteStorage(FData.Vehicle_Index, FNote);
        ShowMessage('Data has been updated');;
      end;
    end;
  end;

  isOK := True;
  afterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;

end;

procedure TfrmAsset.btnCancelClick(Sender: TObject);
begin
  afterClose := False;
  Close;
end;

procedure TfrmAsset.btnOKClick(Sender: TObject);
begin
//  if btnApply.Enabled then
//    btnApply.Click;

  if isOK then
    Close;
end;

{$REGION 'General'}
procedure TfrmAsset.cbbCategoryChange(Sender: TObject);
begin
  UpdateCbbTypeItems(cbbDomain.ItemIndex, cbbCategory.ItemIndex, 0);

  lbl13.Visible := cbbType.Text = 'Group Personel';
  edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';
end;

procedure TfrmAsset.cbbDomainChange(Sender: TObject);
begin
  UpdateCbbCategoryItems(cbbDomain.ItemIndex, 0);
  UpdateCbbTypeItems(cbbDomain.ItemIndex,0 ,0);

  lbl13.Visible := cbbType.Text = 'Group Personel';
  edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';

  btnApply.Enabled := True;
end;

procedure TfrmAsset.cbbTypeChange(Sender: TObject);
begin
  lbl13.Visible := cbbType.Text = 'Group Personel';
  edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';

  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION 'Model'}
procedure TfrmAsset.cbbFontTypeChange(Sender: TObject);
begin
  if cbbFontType.ItemIndex = -1 then
    cbbFontType.ItemIndex := 0;
end;

procedure TfrmAsset.btnTacticalSymbolClick(Sender: TObject);
begin
  if cbbFontType.ItemIndex = -1 then
    Exit;

  SimbolTaktis := TSimbolTaktis.Create(Self);
  try
    with SimbolTaktis do
    begin
      SimbolTaktis.FontType := cbbFontType.ItemIndex;

      if cbbFontType.ItemIndex = 0 then
        SimbolTaktis.drwgrdFonttaktis.RowCount := 184
      else if cbbFontType.ItemIndex = 1 then
        SimbolTaktis.drwgrdFonttaktis.RowCount := 211
      else if cbbFontType.ItemIndex = 2 then
        SimbolTaktis.drwgrdFonttaktis.RowCount := 135;
      ShowModal;

    end;
  finally
    SimbolTaktis.Free;
  end;
end;

procedure TfrmAsset.btnOpenDialogImageClick(Sender: TObject);
begin
  if edtModelPath.Text = '' then
  begin
    ShowMessage('Please inser vehicle id');
  end;

  try
    Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + edtModelPath.Text + '.PNG');
  except
    ShowMessage('Model is not found');
  end;
end;

{$ENDREGION}

{$REGION 'Physical'}
procedure TfrmAsset.Button1Click(Sender: TObject);
var
  Lengt, Width, Height, HGS, Displacement : Double;
begin
  case cbbDomain.ItemIndex of
    0:
    begin
      Lengt := StrToFloat(edtLengthDimension.Text);
      Width := StrToFloat(edtWidthDimension.Text);
      Height := StrToFloat(edtHeightDimension.Text);
      HGS := StrToFloat(Edit1.Text);
      Displacement := (StrToFloat(edtWeightDimension.Text))*1000;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Assets'}
procedure TfrmAsset.btnRadarClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmRadarOnBoardPickList := TfrmRadarOnBoardPickList.Create(Self);
  try
    with frmRadarOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmRadarOnBoardPickList.AfterClose;
  finally
    frmRadarOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not AfterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnSonarClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmSonarOnBoardPickList := TfrmSonarOnBoardPickList.Create(Self);
  try
    with frmSonarOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmSonarOnBoardPickList.AfterClose;
  finally
    frmSonarOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnSonobuoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmSonobuoyOnBoardPickList := TfrmSonobuoyOnBoardPickList.Create(Self);
  try
    with frmSonobuoyOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmSonobuoyOnBoardPickList.AfterClose;
  finally
    frmSonobuoyOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnESMClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmESMOnBoardPickList := TfrmESMOnBoardPickList.Create(Self);
  try
    with frmESMOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmESMOnBoardPickList.AfterClose;
  finally
    frmESMOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnIFFClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmIFFOnBoardPickList := TfrmIFFOnBoardPickList.Create(Self);
//  try
//    with frmIFFOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmIFFOnBoardPickList.AfterClose;
//  finally
//    frmIFFOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnMADClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmMADOnBoardPickList := TfrmMADOnBoardPickList.Create(Self);
//  try
//    with frmMADOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmMADOnBoardPickList.AfterClose;
//  finally
//    frmMADOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnEODClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmEODOnBoardPickList := TfrmEODOnBoardPickList.Create(Self);
  try
    with frmEODOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmEODOnBoardPickList.AfterClose;
  finally
    frmEODOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnVisualDetectorClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmVisualDetectorOnBoardPickList := TfrmVisualDetectorOnBoardPickList.Create(Self);
//  try
//    with frmVisualDetectorOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmVisualDetectorOnBoardPickList.AfterClose;
//  finally
//    frmVisualDetectorOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;


procedure TfrmAsset.btnMissilesClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmMissileOnBoardPickList := TfrmMissileOnBoardPickList.Create(Self);
//  try
//    with frmMissileOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmMissileOnBoardPickList.AfterClose;
//  finally
//    frmMissileOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnTorpedosClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmTorpedoOnBoardPickList := TfrmTorpedoOnBoardPickList.Create(Self);
//  try
//    with frmTorpedoOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmTorpedoOnBoardPickList.AfterClose;
//  finally
//    frmTorpedoOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnMinesClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmMineOnBoardPickList := TfrmMineOnBoardPickList.Create(Self);
//  try
//    with frmMineOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmMineOnBoardPickList.AfterClose;
//  finally
//    frmMineOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnGunsClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmGunOnBoardPickList := TfrmGunOnBoardPickList.Create(Self);
//  try
//    with frmGunOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmGunOnBoardPickList.AfterClose;
//  finally
//    frmGunOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnBomb_DepthChargesClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmBombOnBoardPickList := TfrmBombOnBoardPickList.Create(Self);
//  try
//    with frmBombOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmBombOnBoardPickList.AfterClose;
//  finally
//    frmBombOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;


procedure TfrmAsset.btnAccousticDecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmAcousticDecoyOnBoardPickList := TfrmAcousticDecoyOnBoardPickList.Create(Self);
//  try
//    with frmAcousticDecoyOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmAcousticDecoyOnBoardPickList.AfterClose;
//  finally
//    frmAcousticDecoyOnBoardPickList.Free;
//  end;
//
////  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnAirBubbleClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmAirBubbleOnBoardPickList := TfrmAirBubbleOnBoardPickList.Create(Self);
//  try
//    with frmAirBubbleOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmAirBubbleOnBoardPickList.AfterClose;
//  finally
//    frmAirBubbleOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnChaffClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmChaffOnBoardPickList := TfrmChaffOnBoardPickList.Create(Self);
//  try
//    with frmChaffOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmChaffOnBoardPickList.AfterClose;
//  finally
//    frmChaffOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnDefensiveJummerClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmSelfDefensiveJammerOnBoardPickList := TfrmSelfDefensiveJammerOnBoardPickList.Create(Self);
//  try
//    with frmSelfDefensiveJammerOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmSelfDefensiveJammerOnBoardPickList.AfterClose;
//  finally
//    frmSelfDefensiveJammerOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnFloatingDecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmFloatingDecoyOnBoardPickList := TfrmFloatingDecoyOnBoardPickList.Create(Self);
//  try
//    with frmFloatingDecoyOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmFloatingDecoyOnBoardPickList.AfterClose;
//  finally
//    frmFloatingDecoyOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnInfraredDecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmInfraredDecoyOnBoardPickList := TfrmInfraredDecoyOnBoardPickList.Create(Self);
//  try
//    with frmInfraredDecoyOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmInfraredDecoyOnBoardPickList.AfterClose;
//  finally
//    frmInfraredDecoyOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnRadarJummerClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmRadarNoiseJammerOnBoardPickList := TfrmRadarNoiseJammerOnBoardPickList.Create(Self);
//  try
//    with frmRadarNoiseJammerOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmRadarNoiseJammerOnBoardPickList.AfterClose;
//  finally
//    frmRadarNoiseJammerOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnTowedJummer_DecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmTowedJammerDecoyOnBoardPickList := TfrmTowedJammerDecoyOnBoardPickList.Create(Self);
//  try
//    with frmTowedJammerDecoyOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmTowedJammerDecoyOnBoardPickList.AfterClose;
//  finally
//    frmTowedJammerDecoyOnBoardPickList.Free;
//  end;
//
//  btnCancel.Enabled := not afterClose;
//  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnEmbarkedPlatformsClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

//  frmEmbarkedOnBoardPickList := TfrmEmbarkedOnBoardPickList.Create(Self);
//  try
//    with frmEmbarkedOnBoardPickList do
//    begin
//      SelectedAsset := FSelectedAsset;
//      ShowModal;
//    end;
//
//    AfterClose := frmEmbarkedOnBoardPickList.AfterClose;
//  finally
//    frmEmbarkedOnBoardPickList.Free;
//  end;

  btnApply.Enabled := True;
end;

{$ENDREGION}

function TfrmAsset.CekInput: Boolean;
var
  i, chkSpace, numSpace : Integer;
begin
  Result := False;

  {jika inputan kosong}
  if (edtClass.Text = '') then
  begin
    ShowMessage('Please insert class name');
    Exit;
  end;

  {jika inputan spasi semua}
  if Copy(edtClass.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtClass.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtClass.Text[i] = #32 then
      numSpace := numSpace +1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('please use another class name');
      Exit;
    end;
  end;

  {jika class name sudah ada}
  if (dmINWO.GetVehicleDef(edtClass.Text)>0) then
  begin
    {jika inputan baru}
    if FSelectedAsset.FData.Vehicle_Index = 0 then
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
end;

procedure TfrmAsset.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmAsset.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

function TfrmAsset.GetNumberOfKoma(s: string): Boolean;
var
  a, i : Integer;
begin
  Result := False;
  a := 0;

  for i := 1 to Length(s) do
  begin
    if s[i] = '.' then
      a := a + 1;
  end;

  if a > 0 then
    Result := True;
end;

procedure TfrmAsset.edtNumeralkeyPress(Sender: TObject; var Key: Char);
var
  value : Double;
begin
  if not (Key in[#48 .. #57, #8, #13, #46]) then
  begin
    Key := #0;
    Exit;
  end;

  if GetNumberOfKoma(TEdit(Sender).Text) then
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

procedure TfrmAsset.UpdateCbbCategoryItems(const aDomain, IdCategory: Byte);
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

procedure TfrmAsset.UpdateCbbTypeItems(const aDomain, aCategory, IdType: Byte);
begin
  {$REGION 'Air'}
  if aDomain = 0 then
  begin
    case aCategory of
      0,1,2:
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

  {$REGION 'Surface'}
  else if aDomain = 1 then
  begin
    case aCategory of
      0:  {combatant}
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

  {$REGION 'Subsurface'}
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

  {$REGION 'Land'}
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

  {$REGION 'Amphibious'}
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

procedure TfrmAsset.UpdateModelData;
var
  aFontTaktis : TFontTaktis;
begin
  aFontTaktis := TFontTaktis.Create;

  dmINWO.getFontByID(StrToInt(edtFontID.Text), aFontTaktis);
  with FSelectedAsset.FData do
  begin
    lblFontTaktis.Font.Name := aFontTaktis.FData.FONT_NAME;
    lblFontTaktis.Font.Size := 30;
    lblFontTaktis.Font.Style := [fsBold];
    lblFontTaktis.Caption := Char(aFontTaktis.FData.FONT_INDEX);
    lblKeteranganSymbol.Caption := aFontTaktis.FData.KETERANGAN;

    try
      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + Vbs_Class_Name + '.PNG');
    except
      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\NoModel.bmp');
    end;

  end;

  aFontTaktis.Free
end;

procedure TfrmAsset.UpdateVehicleData;
begin
  with FSelectedAsset do
  begin
    if FData.Vehicle_Index = 0 then
      edtClass.Text := '(unnamed)'
    else
      edtClass.Text := FData.Vehicle_Identifier;

    {$REGION 'General'}
    LastName := edtClass.Text;

//    UpdatePlatformInstanceIdentifierList;

    UpdateCbbCategoryItems(FData.Platform_Domain, FData.Platform_Category);
    UpdateCbbTypeItems(FData.Platform_Domain, FData.Platform_Category, FData.Platform_Type);

    cbbDomain.ItemIndex := FData.Platform_Domain;
    cbbCategory.ItemIndex := FData.Platform_Category;
    cbbType.ItemIndex := FData.Platform_Type;
//    FData.HullNumber := edtNoLambung.Text;
//    FData.CallSign := edtCallSign.Text;

    lbl13.Visible := cbbType.Text = 'Group Personel';
    edtQuantityGroupPersonal.Visible := cbbType.Text = 'Group Personel';
    edtQuantityGroupPersonal.Text := FormatFloat('0', FData.Quantity_Group_Personal);

    {$ENDREGION}

    {$REGION 'Model'}
    edtFontID.Text := IntToStr(FData.Font_id);
    edtModelPath.Text := FData.Vbs_Class_Name;

    UpdateModelData;
    {$ENDREGION}

    {$REGION 'Physical'}
//    UpdateMotionData;

    edtLengthDimension.Text := FormatFloat('0', FData.Length);
    edtWidthDimension.Text := FormatFloat('0', FData.Width);
    edtHeightDimension.Text := FormatFloat('0', FData.Height);
    edtEngagementRangeDimension.Text := FormatFloat('0', FData.Engagement_Range);
    edtDraftDimension.Text := FormatFloat('0', FData.Draft);
    edtWeightDimension.Text := FormatFloat('0.0', FData.DWT);

    cbGangwayFront.Checked := FData.FrontGangway;
    cbGangwayRear.Checked := FData.RearGangway;
    cbGangwayPort.Checked := FData.PortGangway;
    cbGangwayStarboard.Checked := FData.StarBoardGangway;

//    edtkecepatanJelajah.Text := FormatFloat('0', FData);
//    edtKecepatanEkonomis.Text := FormatFloat('0', FData);
//    edtKecepatanMaksimal.Text := FormatFloat('0', FData);

//    edtKapasitasAT.Text := FormatFloat('0', FData);
//    edtKapasitasBB.Text := FormatFloat('0', FData);
//    edtKapasitasML.Text := FormatFloat('0', FData);
//    edtFood.Text := FormatFloat('0', FData);

//    edtKonsumsiFuel.Text := FormatFloat('0', FData);
//    edtEndurance.Text := FormatFloat('0', FData);

    {$ENDREGION}

    {$REGION 'Assets'}
    edtMaxOperatPeriscope.Text := FormatFloat('0', FData.Periscope_Depth);
    edtHighAbovePeriscope.Text := FormatFloat('0', FData.Periscope_Height_Above_Water);
    {$ENDREGION}

    {$REGION 'Notes'}
    mmoNotes.Text := FNote.Notes;
    {$ENDREGION}

  end;
end;

procedure TfrmAsset.ValidationFormatInput;
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

end.

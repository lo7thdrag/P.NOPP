unit ufrmAsset;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ComCtrls,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uRecordData, uDBAsset_Sensor,
   uDBAsset_Weapon, uDBAsset_Countermeasure;

type
  TfrmAsset = class(TForm)
    btnApply: TImage;
    btnCancel: TImage;
    btnOK: TImage;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
    pnl2ControlPage: TPanel;
    pgcAssets: TPageControl;
    tsGeneral: TTabSheet;
    GroupBox5: TGroupBox;
    Label49: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label4: TLabel;
    Label18: TLabel;
    edtClass: TEdit;
    edtNation: TEdit;
    edtName: TEdit;
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
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edtLengthDimension: TEdit;
    edtWidthDimension: TEdit;
    edtHeightDimension: TEdit;
    edtWeightDimension: TEdit;
    edtDraftDimension: TEdit;
    gbDefaultModel: TGroupBox;
    Image: TImage;
    btnDefaultModel: TButton;
    GroupBox3: TGroupBox;
    lbl1: TLabel;
    Label3: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    edtHullNumber: TEdit;
    edtCallSign: TEdit;
    GroupBox4: TGroupBox;
    lbl3: TLabel;
    lbl12: TLabel;
    lbl4: TLabel;
    Label134: TLabel;
    cbbDomain: TComboBox;
    cbbCategory: TComboBox;
    tsAssets: TTabSheet;
    Label5: TLabel;
    Label48: TLabel;
    Label6: TLabel;
    cbbSensors: TComboBox;
    btnSensors: TButton;
    cbbWeapons: TComboBox;
    cbbCountermeasures: TComboBox;
    btnWeapon: TButton;
    btnCountermeasures: TButton;
    tsLogistic: TTabSheet;
    Label2: TLabel;
    grbTime: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    medtMaxTime: TMaskEdit;
    grbRange: TGroupBox;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    edtMaxRange: TEdit;
    grbCapacity: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label33: TLabel;
    Label42: TLabel;
    Label55: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    edtLubricantsCapacity: TEdit;
    edtWaterCapacity: TEdit;
    edtFoodCapacity: TEdit;
    edtFuel: TEdit;
    grbConsumption: TGroupBox;
    Label1: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label56: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label7: TLabel;
    Label19: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    edtLubricantsConsumption: TEdit;
    edtWaterConsumption: TEdit;
    edtFoodConsumption: TEdit;
    edtMinFuelConsumption: TEdit;
    edtMaxFuelConsumption: TEdit;
    edtCruiseFuelConsumption: TEdit;
    edtHighFuelConsumption: TEdit;
    cbbEnduranceType: TComboBox;
    tsTransport: TTabSheet;
    grpDeckUnitCarried: TGroupBox;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    edtMaxWeightDeck: TEdit;
    edtWidthDeck: TEdit;
    edtLengthDeck: TEdit;
    chkAmphibiousCarried: TCheckBox;
    chkLandCarried: TCheckBox;
    grpPersonelUnitCarried: TGroupBox;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    edtMaxPersonelCapacity: TEdit;
    chkCarriableUnit: TCheckBox;
    chkPersonelUnitCarried: TCheckBox;
    grpHangarUnitCarried: TGroupBox;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    edtMaxCapacityHangar: TEdit;
    edtMaxWeightHangar: TEdit;
    chkFixWingCarried: TCheckBox;
    chkRotaryCarried: TCheckBox;
    chkHangarUnitCarried: TCheckBox;
    chkDeckUnitCarried: TCheckBox;
    GroupBox6: TGroupBox;
    Label17: TLabel;
    Label54: TLabel;
    Label57: TLabel;
    edtOfficer: TEdit;
    GroupBox2: TGroupBox;
    lvOnboard: TListView;
    GroupBox7: TGroupBox;
    chkFrontGangway: TCheckBox;
    chkRearGangway: TCheckBox;
    chkPortGangway: TCheckBox;
    chkStarBoardGangway: TCheckBox;
    Button1: TButton;
    pnlListSensor: TPanel;
    lvSensors: TListView;
    pnlListWeapon: TPanel;
    lvWeapon: TListView;
    pnlCountermeasures: TPanel;
    lvCountermeasures: TListView;
    UploadImage: TOpenDialog;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure cbbDomainChange(Sender: TObject);
    procedure cbbCategoryChange(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
    procedure btnOpenDialogImageClick(Sender: TObject);

    procedure btnEmbarkedPlatformsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure ValidationFormatInput();
    procedure edtNumeralkeyPress(Sender: TObject; var Key: Char);
    function GetNumberOfKoma(s : string): Boolean;
    procedure CheckBoxDataClick(Sender: TObject);
    procedure cbbEnduranceTypeChange(Sender: TObject);
    procedure cbbSensorsChange(Sender: TObject);
    procedure cbbWeaponsChange(Sender: TObject);
    procedure cbbCountermeasuresChange(Sender: TObject);
    procedure btnSensorsClick(Sender: TObject);
    procedure btnWeaponClick(Sender: TObject);
    procedure btnCountermeasuresClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure chkPersonelUnitCarriedClick(Sender: TObject);
    procedure chkDeckUnitCarriedClick(Sender: TObject);
    procedure chkHangarUnitCarriedClick(Sender: TObject);
    procedure btnDefaultModelClick(Sender: TObject);

  private
    FSelectedAsset : TAsset ;

    function CekInput : Boolean;
    procedure UpdateVehicleData;
    procedure UpdateModelData;

    procedure UpdateCbbCategoryItems(const aDomain, IdCategory: Byte);

  public

    LastName : string;
    AddressPath : string;
    FileImageName : string;

    procedure UpdateSensorData;
    procedure UpdateWeaponData;
    procedure UpdateCountermeasureData;
    procedure UpdateOnBoardData;

    property SelectedAsset : TAsset read FSelectedAsset write FSelectedAsset;
  end;

var
  frmAsset: TfrmAsset;

implementation

{$R *.dfm}
uses
  ufrmDisplayArea, ufrmRadarOnBoardPickList, ufrmSonarOnBoardPickList, ufrmESMOnBoardPickList,
  ufrmEODOnBoardPickList, ufrmMADOnBoardPickList, ufrmSonobuoyOnBoardPickList,
  ufrmMissileOnBoardPickList, ufrmTorpedoOnBoardPickList, ufrmMineOnBoardPickList,
  ufrmGunOnBoardPickList, ufrmBombOnBoardPickList,
  ufrmAcousticDecoyOnBoardPickList, ufrmAirBubbleOnBoardPickList,
  ufrmChaffOnBoardPickList, ufrmFloatingDecoyOnBoardPickList, ufrmInfraredDecoyOnBoardPickList,
  ufrmRadarNoiseJammerOnBoardPickList, ufrmSelfDefensiveJammerOnBoardPickList,
  ufrmTowedJammerDecoyOnBoardPickList, ufrmEmbarkedOnBoardPickList, uSimbolTaktis;

procedure TfrmAsset.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateVehicleData;

  with FSelectedAsset.FData do
    btnApply.Enabled := VehicleIndex = 0;

//  isOK := True;
//  afterClose := True;
  btnCancel.Enabled := True;
end;

procedure TfrmAsset.btnApplyClick(Sender: TObject);
begin
  with FSelectedAsset do
  begin
    if not CekInput then
    begin
//      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtName.Text;
    FData.VehicleIdentifier := edtName.Text;
    FData.VehicleClass := edtClass.Text;

    FData.VehicleNation := edtNation.Text;

    FData.PlatformDomain   := cbbDomain.ItemIndex;
    UpdateCbbCategoryItems(FData.PlatformDomain, FData.PlatformCategory);
    FData.PlatformCategory := cbbCategory.ItemIndex;

    FData.HullNumber        := edtHullNumber.Text;
    FData.CallSign          := edtCallSign.Text;
    FData.LengthDimension   := StrToFloat(edtLengthDimension.Text);
    FData.WidthDimension    := StrToFloat(edtWidthDimension.Text);
    FData.HeightDimension   := StrToFloat(edtHeightDimension.Text);
    FData.DraftDimension    := StrToFloat(edtDraftDimension.Text);
    FData.WeightDimension   := StrToFloat(edtWeightDimension.Text);

    FData.PlatformDomain    := cbbDomain.ItemIndex;
    FData.PlatformCategory  := cbbCategory.ItemIndex;
    FData.VbsClassName      := FileImageName;
    {$ENDREGION}

    {$REGION ' Logistic '}

    FData.EnduranceType           := cbbEnduranceType.ItemIndex;
    FData.LubricantsCapacity      := StrToFloat(edtLubricantsCapacity.Text);
    FData.WaterCapacity           := StrToFloat(edtWaterCapacity.Text);
    FData.FoodCapacity            := StrToFloat(edtFoodCapacity.Text);
    FData.FuelCapacity            := StrToFloat(edtFuel.Text);
    FData.LubricantsConsumption   := StrToFloat(edtLubricantsConsumption.Text);
    FData.WaterConsumption        := StrToFloat(edtWaterConsumption.Text);
    FData.FoodConsumption         := StrToFloat(edtFoodConsumption.Text);
    FData.MinFuelConsumption      := StrToFloat(edtMinFuelConsumption.Text);
    FData.MaxFuelConsumption      := StrToFloat(edtMaxFuelConsumption.Text);
    FData.CruiseFuelConsumption   := StrToFloat(edtCruiseFuelConsumption.Text);
    FData.HighFuelConsumption     := StrToFloat(edtHighFuelConsumption.Text);
    {$ENDREGION}

    {$REGION ' Transport '}
    edtOfficer.Text             := IntToStr(FData.Officer);
    FData.FrontGangway          := chkFrontGangway.Checked;
    FData.RearGangway           := chkRearGangway.Checked;
    FData.PortGangway           := chkPortGangway.Checked;
    FData.StarBoardGangway      := chkStarBoardGangway.Checked;
    FData.CarriableUnit         := chkCarriableUnit.Checked;
    FData.PersonelUnitCarried   := chkPersonelUnitCarried.Checked;
    FData.MaxPersonelCapacity   := StrToInt(edtMaxPersonelCapacity.Text);
    FData.DeckUnitCarried       := chkDeckUnitCarried.Checked;
    FData.AmphibiousCarried     := chkAmphibiousCarried.Checked;
    FData.LandCarried           := chkLandCarried.Checked;
    FData.MaxWeightDeck         := StrToFloat(edtMaxWeightDeck.Text);
    FData.WidthDeck             := StrToFloat(edtWidthDeck.Text);
    FData.LengthDeck            := StrToFloat(edtLengthDeck.Text);
    FData.HangarUnitCarried     := chkHangarUnitCarried.Checked;
    FData.FixWingCarried        := chkFixWingCarried.Checked;
    FData.RotaryCarried         := chkRotaryCarried.Checked;
    FData.MaxCapacityHangar     := StrToInt(edtMaxCapacityHangar.Text);
    FData.MaxWeightHangar       := StrToFloat(edtMaxWeightHangar.Text);
    {$ENDREGION}

    if FData.VehicleIndex = 0 then
    begin
      if dmINWO.InsertVehicleDef(FSelectedAsset.FData) then
      begin
        CopyFile(PWideChar(AddressPath), PWideChar(vGameDataSetting.ImageModel + FileImageName), False);
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateVehicleDef(FSelectedAsset.FData) then
      begin
        CopyFile(PWideChar(AddressPath), PWideChar(vGameDataSetting.ImageModel + FileImageName), False);
        ShowMessage('Data has been updated');;
      end;
    end;
  end;

//  isOK := True;
//  afterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;

end;

procedure TfrmAsset.btnCancelClick(Sender: TObject);
begin
//  afterClose := False;
  Close;
end;

procedure TfrmAsset.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApplyClick(nil);

  frmDisplayArea_Instance.UpdateDataAset;
  Close;
end;

{$REGION ' General '}

procedure TfrmAsset.cbbCategoryChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmAsset.cbbCountermeasuresChange(Sender: TObject);
begin
  UpdateCountermeasureData;
end;

procedure TfrmAsset.cbbDomainChange(Sender: TObject);
begin
  UpdateCbbCategoryItems(cbbDomain.ItemIndex, 0);
//  UpdateCbbTypeItems(cbbDomain.ItemIndex,0 ,0);

  btnApply.Enabled := True;
end;

procedure TfrmAsset.cbbTypeChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmAsset.cbbWeaponsChange(Sender: TObject);
begin
  UpdateWeaponData;
end;

procedure TfrmAsset.cbbEnduranceTypeChange(Sender: TObject);
begin
  grbCapacity.Visible := (cbbEnduranceType.ItemIndex = 0);
  grbConsumption.Visible := (cbbEnduranceType.ItemIndex = 0);
  grbTime.Visible := (cbbEnduranceType.ItemIndex = 1);
  grbRange.Visible := (cbbEnduranceType.ItemIndex = 2);
end;

procedure TfrmAsset.cbbSensorsChange(Sender: TObject);
begin
  UpdateSensorData;
end;

procedure TfrmAsset.btnOpenDialogImageClick(Sender: TObject);
begin
//  if edtModelPath.Text = '' then
//  begin
//    ShowMessage('Please inser vehicle id');
//  end;
//
//  try
////    Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + edtModelPath.Text + '.PNG');
//  except
//    ShowMessage('Model is not found');
//  end;
end;

{$ENDREGION}

{$REGION ' Assets '}

procedure TfrmAsset.btnSensorsClick(Sender: TObject);
begin
  if FSelectedAsset.FData.VehicleIndex = 0 then
  begin
    ShowMessage('Save data before continue  ');
    Exit;
  end;

  case cbbSensors.ItemIndex of
    0:
    begin
      {$REGION ' Radar '}
      if not Assigned(frmRadarOnBoardPickList) then
        frmRadarOnBoardPickList := TfrmRadarOnBoardPickList.Create(Self);

      try
        with frmRadarOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    1:
    begin
      {$REGION ' Sonar '}
      if not Assigned(frmSonarOnBoardPickList) then
        frmSonarOnBoardPickList := TfrmSonarOnBoardPickList.Create(Self);

      try
        with frmSonarOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    2:
    begin
      {$REGION ' ESM '}
      if not Assigned(frmESMOnBoardPickList) then
        frmESMOnBoardPickList := TfrmESMOnBoardPickList.Create(Self);

      try
        with frmESMOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    3:
    begin
      {$REGION ' MAD '}
      if not Assigned(frmMADOnBoardPickList) then
        frmMADOnBoardPickList := TfrmMADOnBoardPickList.Create(Self);

      try
        with frmMADOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    4:
    begin
      {$REGION ' EOD '}
      if not Assigned(frmEODOnBoardPickList) then
        frmEODOnBoardPickList := TfrmEODOnBoardPickList.Create(Self);

      try
        with frmEODOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    5:
    begin
      {$REGION ' Sonobuoy '}
      if not Assigned(frmSonobuoyOnBoardPickList) then
        frmSonobuoyOnBoardPickList := TfrmSonobuoyOnBoardPickList.Create(Self);

      try
        with frmSonobuoyOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
  end;
end;

procedure TfrmAsset.btnCountermeasuresClick(Sender: TObject);
begin
  if FSelectedAsset.FData.VehicleIndex = 0 then
  begin
    ShowMessage('Save data before continue  ');
    Exit;
  end;

  case cbbCountermeasures.ItemIndex of
    0:
    begin
      {$REGION ' Chaff '}
      if not Assigned(frmChaffOnBoardPickList) then
        frmChaffOnBoardPickList := TfrmChaffOnBoardPickList.Create(Self);

      try
        with frmChaffOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    1:
    begin
      {$REGION ' Air Bubble '}
      if not Assigned(frmAirBubbleOnBoardPickList) then
        frmAirBubbleOnBoardPickList := TfrmAirBubbleOnBoardPickList.Create(Self);

      try
        with frmAirBubbleOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    2:
    begin
      {$REGION ' Acoustic Decoy '}
      if not Assigned(frmAcousticDecoyOnBoardPickList) then
        frmAcousticDecoyOnBoardPickList := TfrmAcousticDecoyOnBoardPickList.Create(Self);

      try
        with frmAcousticDecoyOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    3:
    begin
      {$REGION ' Floating Decoy '}
      if not Assigned(frmFloatingDecoyOnBoardPickList) then
        frmFloatingDecoyOnBoardPickList := TfrmFloatingDecoyOnBoardPickList.Create(Self);

      try
        with frmFloatingDecoyOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    4:
    begin
      {$REGION ' Infrared Decoy '}
      if not Assigned(frmInfraredDecoyOnBoardPickList) then
        frmInfraredDecoyOnBoardPickList := TfrmInfraredDecoyOnBoardPickList.Create(Self);

      try
        with frmInfraredDecoyOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    5:
    begin
      {$REGION ' Towed Decoy '}
      if not Assigned(frmTowedJammerDecoyOnBoardPickList) then
        frmTowedJammerDecoyOnBoardPickList := TfrmTowedJammerDecoyOnBoardPickList.Create(Self);

      try
        with frmTowedJammerDecoyOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    6:
    begin
      {$REGION ' Self Defensive Jammer '}
      if not Assigned(frmSelfDefensiveJammerOnBoardPickList) then
        frmSelfDefensiveJammerOnBoardPickList := TfrmSelfDefensiveJammerOnBoardPickList.Create(Self);

      try
        with frmSelfDefensiveJammerOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    7:
    begin
      {$REGION ' Radar Noise Jammer '}
      if not Assigned(frmRadarNoiseJammerOnBoardPickList) then
        frmRadarNoiseJammerOnBoardPickList := TfrmRadarNoiseJammerOnBoardPickList.Create(Self);

      try
        with frmRadarNoiseJammerOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
  end;
end;

procedure TfrmAsset.btnDefaultModelClick(Sender: TObject);
var
  saveFileTemp : TTactical_Symbol;

begin
  UploadImage := TSaveDialog.Create(self);
  UploadImage.InitialDir := GetCurrentDir;
  UploadImage.Filter := 'Image Files(*.png)|*.png';
  UploadImage.DefaultExt := 'png';
  UploadImage.FilterIndex := 1;

  if UploadImage.Execute then
  begin
    AddressPath := PWideChar(UploadImage.FileName);
    FileImageName := ExtractFileName(UploadImage.FileName);

    Image.Picture.LoadFromFile(AddressPath);

    btnApply.Enabled := True;
  end
  else
  ShowMessage('Save file was cancelled');

  UploadImage.Free;

//  CopyFile(addressTemp, PWideChar(vGameDataSetting.ImageModel + fileDataTemp.Encripted_File_Name), False);
end;

procedure TfrmAsset.btnWeaponClick(Sender: TObject);
begin
  if FSelectedAsset.FData.VehicleIndex = 0 then
  begin
    ShowMessage('Save data before continue  ');
    Exit;
  end;

  case cbbWeapons.ItemIndex of
    0:
    begin
      {$REGION ' Missiles '}
      if not Assigned(frmMissileOnBoardPickList) then
        frmMissileOnBoardPickList := TfrmMissileOnBoardPickList.Create(Self);

      try
        with frmMissileOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    1:
    begin
      {$REGION ' Torpedoes '}
      if not Assigned(frmTorpedoOnBoardPickList) then
        frmTorpedoOnBoardPickList := TfrmTorpedoOnBoardPickList.Create(Self);

      try
        with frmTorpedoOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    2:
    begin
      {$REGION ' Mines '}
      if not Assigned(frmMineOnBoardPickList) then
        frmMineOnBoardPickList := TfrmMineOnBoardPickList.Create(Self);

      try
        with frmMineOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    3:
    begin
      {$REGION ' Bombs '}
      if not Assigned(frmBombOnBoardPickList) then
        frmBombOnBoardPickList := TfrmBombOnBoardPickList.Create(Self);

      try
        with frmBombOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
    4:
    begin
      {$REGION ' Guns '}
     if not Assigned(frmGunOnBoardPickList) then
        frmGunOnBoardPickList := TfrmGunOnBoardPickList.Create(Self);

      try
        with frmGunOnBoardPickList do
        begin
          SelectedVehicle := FSelectedAsset;
          Show;
        end;
      finally
      end;
      {$ENDREGION}
    end;
  end;
end;

procedure TfrmAsset.Button1Click(Sender: TObject);
begin
  {$REGION ' Jika class belum tersimpan '}
  if FSelectedAsset.FData.VehicleIndex = 0 then
  begin
    ShowMessage('Save data Class before continue  ');
    Exit;
  end;
  {$ENDREGION}

  if not Assigned(frmEmbarkedOnBoardPickList) then
    frmEmbarkedOnBoardPickList := TfrmEmbarkedOnBoardPickList.Create(Self);

  try
    with frmEmbarkedOnBoardPickList do
    begin
      SelectedVehicle := FSelectedAsset;
      Show;
    end;
  finally
  end;

  btnApply.Enabled := True;
end;

procedure TfrmAsset.btnEmbarkedPlatformsClick(Sender: TObject);
begin
//  {$REGION 'jika class belum tersimpan'}
//  if FSelectedAsset.FData.VehicleIndex = 0 then
//  begin
//    ShowMessage('Save data class before continue');
//    Exit;
//  end;
//  {$ENDREGION}
//
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
//
//  btnApply.Enabled := True;
end;

{$ENDREGION}

function TfrmAsset.CekInput: Boolean;
var
  i, chkSpace, numSpace : Integer;
begin
  Result := False;

  {jika inputan kosong}
  if (edtName.Text = '') then
  begin
    ShowMessage('Please insert name');
    Exit;
  end;

  {jika inputan spasi semua}
  if Copy(edtName.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtName.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtName.Text[i] = #32 then
      numSpace := numSpace +1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('please use another name');
      Exit;
    end;
  end;

  {jika class name sudah ada}
  if (dmINWO.GetFilterVehicleDefByName(edtName.Text)>0) then
  begin
    {jika inputan baru}
    if FSelectedAsset.FData.VehicleIndex = 0 then
    begin
      ShowMessage('Please use another name');
      Exit;
    end
    else if LastName <> edtName.Text then
    begin
      ShowMessage('Please use another name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmAsset.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmAsset.chkDeckUnitCarriedClick(Sender: TObject);
begin
  grpDeckUnitCarried.Enabled := chkDeckUnitCarried.Checked;

  if not chkDeckUnitCarried.Checked then
  begin
    chkAmphibiousCarried.Checked := False;
    chkLandCarried.Checked := False;

    edtMaxWeightDeck.Text := '0.00';
    edtWidthDeck.Text := '0.0';
    edtLengthDeck.Text := '0.0';
  end;
end;

procedure TfrmAsset.chkHangarUnitCarriedClick(Sender: TObject);
begin
  grpHangarUnitCarried.Enabled := chkHangarUnitCarried.Checked;

  if not chkHangarUnitCarried.Checked then
  begin
    chkFixWingCarried.Checked := False;
    chkRotaryCarried.Checked := False;

    edtMaxCapacityHangar.Text := '0';
    edtMaxWeightHangar.Text := '0.00';
  end;
end;

procedure TfrmAsset.chkPersonelUnitCarriedClick(Sender: TObject);
begin

  grpPersonelUnitCarried.Enabled := chkPersonelUnitCarried.Checked;

  if not chkPersonelUnitCarried.Checked then
  begin
    edtMaxPersonelCapacity.Text := '0';
  end;

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

procedure TfrmAsset.UpdateModelData;
begin
  with FSelectedAsset.FData do
  begin
    try
      Image.Picture.LoadFromFile(vGameDataSetting.ImageModel + VbsClassName);
    except
      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\NoModel.bmp');
    end;

    FileImageName := VbsClassName;
    AddressPath := vGameDataSetting.ImageModel + FileImageName;

  end;
end;

procedure TfrmAsset.UpdateVehicleData;
begin
  with FSelectedAsset do
  begin
    if FData.VehicleIndex = 0 then
      edtName.Text := '(unnamed)'
    else
      edtName.Text := FData.VehicleIdentifier;

    {$REGION ' General '}
    LastName := edtName.Text;

    edtClass.Text  := FData.VehicleClass;
    edtNation.Text := FData.VehicleNation;

    cbbDomain.ItemIndex   := FData.PlatformDomain;
    UpdateCbbCategoryItems(FData.PlatformDomain, FData.PlatformCategory);
    cbbCategory.ItemIndex := FData.PlatformCategory;

    edtHullNumber.Text        := FData.HullNumber;
    edtCallSign.Text          := FData.CallSign;
    edtLengthDimension.Text   := FormatFloat('0', FData.LengthDimension);
    edtWidthDimension.Text    := FormatFloat('0', FData.WidthDimension);
    edtHeightDimension.Text   := FormatFloat('0', FData.HeightDimension);
    edtDraftDimension.Text    := FormatFloat('0', FData.DraftDimension);
    edtWeightDimension.Text   := FormatFloat('0.0', FData.WeightDimension);

    UpdateModelData;

    {$ENDREGION}

    {$REGION ' Assets '}
     UpdateSensorData;
     UpdateWeaponData;
     UpdateCountermeasureData;
    {$ENDREGION}

    {$REGION ' Logistic '}

    cbbEnduranceType.ItemIndex     := FData.EnduranceType;
    edtLubricantsCapacity.Text     := FormatFloat('0.00', FData.LubricantsCapacity);
    edtWaterCapacity.Text          := FormatFloat('0.00', FData.WaterCapacity);
    edtFoodCapacity.Text           := FormatFloat('0.00', FData.FoodCapacity);
    edtFuel.Text                   := FormatFloat('0.00', FData.FuelCapacity);
    edtLubricantsConsumption.Text  := FormatFloat('0.00', FData.LubricantsConsumption);
    edtWaterConsumption.Text       := FormatFloat('0.00', FData.WaterConsumption);
    edtFoodConsumption.Text        := FormatFloat('0.00', FData.FoodConsumption);
    edtMinFuelConsumption.Text     := FormatFloat('0.00', FData.MinFuelConsumption);
    edtMaxFuelConsumption.Text     := FormatFloat('0.00', FData.MaxFuelConsumption);
    edtCruiseFuelConsumption.Text  := FormatFloat('0.00', FData.CruiseFuelConsumption);
    edtHighFuelConsumption.Text    := FormatFloat('0.00', FData.HighFuelConsumption);

    {$ENDREGION}

    {$REGION ' Transport '}
    edtOfficer.Text                 := IntToStr(FData.Officer);
    chkFrontGangway.Checked         := Boolean(FData.FrontGangway);
    chkRearGangway.Checked          := Boolean(FData.RearGangway);
    chkPortGangway.Checked          := Boolean(FData.PortGangway);
    chkStarBoardGangway.Checked     := Boolean(FData.StarBoardGangway);
    chkCarriableUnit.Checked        := Boolean(FData.CarriableUnit);

    chkPersonelUnitCarried.Checked  := Boolean(FData.PersonelUnitCarried);
    edtMaxPersonelCapacity.Text     := IntToStr(FData.MaxPersonelCapacity);
    chkPersonelUnitCarriedClick(nil);

    chkDeckUnitCarried.Checked      := Boolean(FData.DeckUnitCarried);
    chkAmphibiousCarried.Checked    := Boolean(FData.AmphibiousCarried);
    chkLandCarried.Checked          := Boolean(FData.LandCarried);
    edtMaxWeightDeck.Text           := FormatFloat('0.00', FData.MaxWeightDeck);
    edtWidthDeck.Text               := FormatFloat('0.00', FData.WidthDeck);
    edtLengthDeck.Text              := FormatFloat('0.00', FData.LengthDeck);
    chkDeckUnitCarriedClick(nil);

    chkHangarUnitCarried.Checked    := Boolean(FData.HangarUnitCarried);
    chkFixWingCarried.Checked       := Boolean(FData.FixWingCarried);
    chkRotaryCarried.Checked        := Boolean(FData.RotaryCarried);
    edtMaxCapacityHangar.Text       := IntToStr(FData.MaxCapacityHangar);
    edtMaxWeightHangar.Text         := FormatFloat('0.00', FData.MaxWeightHangar);
    chkHangarUnitCarriedClick(nil);

    UpdateOnBoardData;

    {$ENDREGION}

  end;
end;

procedure TfrmAsset.UpdateSensorData;
var
  i : Integer;
  li: TListItem;
  FAssetList : TList;

  radarOnboardTemp  : TRadar_On_Board;
  sonarOnboardTemp  : TSonar_On_Board;
  esmOnboardTemp    : TESM_On_Board;
  madOnboardTemp    : TMAD_On_Board;
  eodOnboardTemp    : TEOD_On_Board;
  sonobuoyOnboardTemp  : TSonobuoy_On_Board;

begin
  lvSensors.Clear;

  FAssetList := TList.Create;

  case cbbSensors.ItemIndex of
    0:
    begin
      {$REGION ' Radar '}
      dmINWO.GetRadarOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        radarOnboardTemp := FAssetList.Items[i];

        li := lvSensors.Items.Add;
        li.Caption := radarOnboardTemp.FData.Instance_Identifier;

        li.Data := radarOnboardTemp;
      end;

      {$ENDREGION}
    end;
    1:
    begin
      {$REGION ' Sonar '}
      dmINWO.GetSonarOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        sonarOnboardTemp := FAssetList.Items[i];

        li := lvSensors.Items.Add;
        li.Caption := sonarOnboardTemp.FData.Instance_Identifier;

        li.Data := sonarOnboardTemp;
      end;
      {$ENDREGION}
    end;
    2:
    begin
      {$REGION ' ESM '}
      dmINWO.GetESMOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        esmOnboardTemp := FAssetList.Items[i];

        li := lvSensors.Items.Add;
        li.Caption := esmOnboardTemp.FData.Instance_Identifier;

        li.Data := esmOnboardTemp;
      end;
      {$ENDREGION}
    end;
    3:
    begin
      {$REGION ' MAD '}
      dmINWO.GetMADOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        madOnboardTemp := FAssetList.Items[i];

        li := lvSensors.Items.Add;
        li.Caption := madOnboardTemp.FData.Instance_Identifier;

        li.Data := madOnboardTemp;
      end;
      {$ENDREGION}
    end;
    4:
    begin
      {$REGION ' EOD '}
      dmINWO.GetEODOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        eodOnboardTemp := FAssetList.Items[i];

        li := lvSensors.Items.Add;
        li.Caption := eodOnboardTemp.FData.Instance_Identifier;

        li.Data := eodOnboardTemp;
      end;
      {$ENDREGION}
    end;
    5:
    begin
      {$REGION ' Sonobuoy '}
      dmINWO.GetSonobuoyOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        sonobuoyOnboardTemp := FAssetList.Items[i];

        li := lvSensors.Items.Add;
        li.Caption := sonobuoyOnboardTemp.FData.Instance_Identifier;

        li.Data := sonobuoyOnboardTemp;
      end;
      {$ENDREGION}
    end;
  end;

  FAssetList.Free;

end;

procedure TfrmAsset.UpdateWeaponData;
var
  i : Integer;
  li: TListItem;
  FAssetList : TList;

  missileOnboardTemp  : TMissile_On_Board;
  torpedoOnboardTemp  : TTorpedo_On_Board;
  mineOnboardTemp    : TMine_On_Board;
  bombOnboardTemp    : TBomb_On_Board;
  gunOnboardTemp    : TGun_On_Board;

begin
  lvWeapon.Clear;

  FAssetList := TList.Create;

  case cbbWeapons.ItemIndex of
    0:
    begin
      {$REGION ' Missile '}
      dmINWO.GetMissileOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        missileOnboardTemp := FAssetList.Items[i];

        li := lvWeapon.Items.Add;
        li.Caption := missileOnboardTemp.FData.Instance_Identifier;

        li.Data := missileOnboardTemp;
      end;

      {$ENDREGION}
    end;
    1:
    begin
      {$REGION ' Torpedo '}
      dmINWO.GetTorpedoOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        torpedoOnboardTemp := FAssetList.Items[i];

        li := lvWeapon.Items.Add;
        li.Caption := torpedoOnboardTemp.FData.Instance_Identifier;

        li.Data := torpedoOnboardTemp;
      end;
      {$ENDREGION}
    end;
    2:
    begin
      {$REGION ' Mine '}
      dmINWO.GetMineOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        mineOnboardTemp := FAssetList.Items[i];

        li := lvWeapon.Items.Add;
        li.Caption := mineOnboardTemp.FData.Instance_Identifier;

        li.Data := mineOnboardTemp;
      end;
      {$ENDREGION}
    end;
    3:
    begin
      {$REGION ' Bomb '}
      dmINWO.GetBombOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        bombOnboardTemp := FAssetList.Items[i];

        li := lvWeapon.Items.Add;
        li.Caption := bombOnboardTemp.FData.Instance_Identifier;

        li.Data := bombOnboardTemp;
      end;
      {$ENDREGION}
    end;
    4:
    begin
      {$REGION ' Gun '}
      dmINWO.GetGunOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        gunOnboardTemp := FAssetList.Items[i];

        li := lvWeapon.Items.Add;
        li.Caption := gunOnboardTemp.FData.Instance_Identifier;

        li.Data := gunOnboardTemp;
      end;
      {$ENDREGION}
    end;
  end;

  FAssetList.Free;
end;

procedure TfrmAsset.UpdateCountermeasureData;
var
  i : Integer;
  li: TListItem;
  FAssetList : TList;

  chaffOnboardTemp                  : TChaff_On_Board;
  airbubbleOnboardTemp              : TAir_Bubble_On_Board;
  acousticdecoyOnboardTemp          : TAcoustic_Decoy_On_Board;
  floatingdecoyOnboardTemp          : TFloating_Decoy_On_Board;
  infrareddecoyOnboardTemp          : TInfrared_Decoy_On_Board;
  toweddecoyOnboardTemp             : TTowed_Decoy_On_Board;
  selfdefensivejammerOnboardTemp    : TDefensive_Jammer_On_Board;
  radarnoisejammerOnboardTemp       : TRadar_Noise_Jammer_On_Board;

begin
  lvCountermeasures.Clear;

  FAssetList := TList.Create;

  case cbbCountermeasures.ItemIndex of
    0:
    begin
      {$REGION ' Chaff '}
      dmINWO.GetChaffOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        chaffOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := chaffOnboardTemp.FData.Instance_Identifier;

        li.Data := chaffOnboardTemp;
      end;

      {$ENDREGION}
    end;
    1:
    begin
      {$REGION ' Air Bubble '}
      dmINWO.GetAirBubbleOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        airbubbleOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := airbubbleOnboardTemp.FData.Instance_Identifier;

        li.Data := airbubbleOnboardTemp;
      end;
      {$ENDREGION}
    end;
    2:
    begin
      {$REGION ' Acoustic Decoy '}
      dmINWO.GetAcousticDecoyOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        acousticdecoyOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := acousticdecoyOnboardTemp.FData.Instance_Identifier;

        li.Data := acousticdecoyOnboardTemp;
      end;
      {$ENDREGION}
    end;
    3:
    begin
      {$REGION ' Floating Decoy '}
      dmINWO.GetFloatingDecoyOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        floatingdecoyOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := floatingdecoyOnboardTemp.FData.Instance_Identifier;

        li.Data := floatingdecoyOnboardTemp;
      end;
      {$ENDREGION}
    end;
    4:
    begin
      {$REGION ' Infrared Decoy '}
      dmINWO.GetInfraredDecoyOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        infrareddecoyOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := infrareddecoyOnboardTemp.FData.Instance_Identifier;

        li.Data := infrareddecoyOnboardTemp;
      end;
      {$ENDREGION}
    end;
    5:
    begin
      {$REGION ' Towed Decoy '}
      dmINWO.GetTowedJammerDecoyOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        toweddecoyOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := toweddecoyOnboardTemp.FData.Instance_Identifier;

        li.Data := toweddecoyOnboardTemp;
      end;
      {$ENDREGION}
    end;
    6:
    begin
      {$REGION ' Self Defensive Jammer '}
      dmINWO.GetSelfDefensiveJammerOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        selfdefensivejammerOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := selfdefensivejammerOnboardTemp.FData.Instance_Identifier;

        li.Data := selfdefensivejammerOnboardTemp;
      end;
      {$ENDREGION}
    end;
    7:
    begin
      {$REGION ' Radar Noise Jammer '}
      dmINWO.GetRadarNoiseJammerOnBoard(FSelectedAsset.FData.VehicleIndex, FAssetList);

      for i := 0 to FAssetList.Count - 1 do
      begin
        radarnoisejammerOnboardTemp := FAssetList.Items[i];

        li := lvCountermeasures.Items.Add;
        li.Caption := radarnoisejammerOnboardTemp.FData.Instance_Identifier;

        li.Data := radarnoisejammerOnboardTemp;
      end;
      {$ENDREGION}
    end;
  end;

  FAssetList.Free;
end;

procedure TfrmAsset.UpdateOnBoardData;
var
  i : Integer;
  li: TListItem;
  FAssetList : TList;

  onBoardTemp : THosted_Platform;

begin
  lvOnboard.Clear;

  FAssetList := TList.Create;

  dmINWO.GetAllVehicleAtHostPlatform(FSelectedAsset.FData.VehicleIndex, FAssetList);

  for i := 0 to FAssetList.Count - 1 do
  begin
    onBoardTemp := FAssetList.Items[i];

    li := lvOnboard.Items.Add;
    li.Caption := onBoardTemp.FVehicle.VehicleIdentifier;

    li.Data := onBoardTemp;
  end;

  FAssetList.Free;
end;

procedure TfrmAsset.ValidationFormatInput;
var
  i, j: Integer;
  value : Double;
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
  end;
end;

end.

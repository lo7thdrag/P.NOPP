unit ufrmAvailableVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage,
  {uDBAsset_Vehicle, uDBAssetObject,} uSimContainers;

type
  TfrmAvailableVehicle = class(TForm)
    lbAllVehicleDef: TListBox;
    btnCopy: TImage;
    btnDelete: TImage;
    btnEdit: TImage;
    btnNew: TImage;
    btnUsage: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    Label2: TLabel;
    edtCheat: TEdit;
    ImgBtnBack: TImage;
    lblsearch: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbSingleClick(Sender: TObject);

    procedure btnNewClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUsageClick(Sender: TObject);

    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCheatKeyPress(Sender: TObject; var Key: Char);

  private
    FUpdateList : Boolean;
    FVehicleList : TList;
//    FSelectedVehicle : TVehicle_Definition;

    procedure UpdateVehicleList;

    procedure CopyPlatformInstanceIdent(const aVehicleIndex, aNewVehicleIndex: Integer);
    procedure CopyVehicleAsset(const aVehicleIndex, aNewVehicleIndex: Integer);
    procedure CopyAssetBlindZone(const aBZType: Byte; const aParentIndex, aNewIndex: Integer);
    procedure CopyAssetWeaponLauncher(const aParentIndex, aNewIndex: Integer);
    procedure CopyAssetChaffLauncher(const aParentIndex, aNewIndex: Integer);

  public

  end;

var
  frmAvailableVehicle: TfrmAvailableVehicle;

implementation

uses
  uDataModule, ufrmSummaryVehicle{, ufrmUsage,
  uDBAsset_Sensor, uDBAsset_Radar, uDBAsset_Sonar, uDBAsset_Sonobuoy,
  uDBAsset_Weapon, uDBAsset_Countermeasure, newClassASTT, uDBBlind_Zone};

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableVehicle.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FVehicleList);
  Action := cafree;
end;

procedure TfrmAvailableVehicle.FormCreate(Sender: TObject);
begin
  FVehicleList := TList.Create;
end;

procedure TfrmAvailableVehicle.FormShow(Sender: TObject);
begin
//  UpdateFilterTypeItems;
  UpdateVehicleList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableVehicle.btnNewClick(Sender: TObject);
begin
//  frmSummaryVehicle := TfrmSummaryVehicle.Create(Self);
//  try
//    with frmSummaryVehicle do
//    begin
//      SelectedVehicle := TVehicle_Definition.Create;
//      ShowModal;
//      FUpdateList := AfterClose;
//    end;
//  finally
//    frmSummaryVehicle.Free;
//  end;
//
//  if FUpdateList then
//    UpdateVehicleList;
end;

procedure TfrmAvailableVehicle.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
  idTemp : Integer;
begin
//  if lbAllVehicleDef.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Vehicle... !');
//    Exit;
//  end;
//
//  with FSelectedVehicle do
//  begin
//    newClassName := FData.Vehicle_Identifier + ' - Copy';
//
//    count := dmTTT.GetVehicleDef(newClassName);
//
//    if count > 0 then
//      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';
//
//    FData.Vehicle_Identifier := newClassName;
//    idTemp := FData.Vehicle_Index;
//
//    dmTTT.InsertVehicleDef(FData);
//    dmTTT.InsertNoteStorage(1, FData.Vehicle_Index, FNote);
//
//    {Copy beberapa aset, perlu dicek lagi}
//    CopyPlatformInstanceIdent(idTemp, FData.Vehicle_Index);
//    CopyVehicleAsset(idTemp, FData.Vehicle_Index);
////    CopyHeliLimitation(idTemp, FData.Vehicle_Index);
//  end;
//
//  UpdateVehicleList;
end;

procedure TfrmAvailableVehicle.btnEditClick(Sender: TObject);
begin
//  if lbAllVehicleDef.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Vehicle Data... !');
//    Exit;
//  end;
//
//  frmSummaryVehicle := TfrmSummaryVehicle.Create(Self);
//  try
//    with frmSummaryVehicle do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//      FUpdateList := AfterClose;
//    end;
//  finally
//    frmSummaryVehicle.Free;
//  end;
//
//  if FUpdateList then
//    UpdateVehicleList;
end;

procedure TfrmAvailableVehicle.btnDeleteClick(Sender: TObject);
var
  warning: Integer;
  tempList: TList;

begin
//  if lbAllVehicleDef.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Vehicle Data ... !');
//    Exit;
//  end;
//
//  warning := MessageDlg('Are you sure to delete this Vehicle Data ?', mtConfirmation,
//    mbOKCancel, 0);
//
//  if warning = mrOK then
//  begin
//    with FSelectedVehicle.FData do
//    begin
//      tempList := TList.Create;
//
//      {Pengecekan Relasi Dengan Resource Allocation}
//      if dmTTT.GetPlatformInstanceAtResourceAllocation(1, Vehicle_Index, tempList) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some resource allocation');
//        FreeItemsAndFreeList(tempList);
//        Exit;
//      end;
//
//      {Pengecekan Relasi Dengan Runtime Platform Library}
//      if dmTTT.GetPlatformAtPlatformLibraryEntry(1, Vehicle_Index, tempList) > 0 then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some Runtime Platform Library');
//        FreeItemsAndFreeList(tempList);
//        Exit;
//      end;
//
//      {Pengecekan Relasi Dengan Base}
//      if dmTTT.GetAllVehicle_OnBase(Vehicle_Index, tempList) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some Base');
//        FreeItemsAndFreeList(tempList);
//        Exit;
//      end;
//
//      {Pengecekan Relasi Dengan Host Sebagai Embarked}
//      if dmTTT.GetAllVehicleAtHostPlatform(Vehicle_Index, tempList) > 0 then
//      begin
//        ShowMessage('Cannot delete, This vehicle used as Embarked Platform by some Vehicle');
//        FreeItemsAndFreeList(tempList);
//        Exit;
//      end;
//      FreeItemsAndFreeList(tempList);
//
//      dmTTT.DeleteNoteStorage(1, Vehicle_Index);
//
//      dmTTT.DeletePlatformInstanceIdentifier(1, Vehicle_Index);
//
//      dmTTT.DeleteBlindZone(Vehicle_Index);
//      dmTTT.DeleteFittedWeaponLauncherOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteChaffLauncherOnBoard(Vehicle_Index);
//
//      dmTTT.DeleteRadarOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteESMOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteEOOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteMADOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteSonobuoyOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteSonarOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteIFFOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteVisualOnBoard(1, Vehicle_Index);
//
//      dmTTT.DeleteFittedWeaponOnBoard(1, Vehicle_Index);
//      dmTTT.DeletePointEffectOnBoard(1, Vehicle_Index);
//
//      dmTTT.DeleteRadarNoiseJammerOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteAirBubbleOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteAcousticDecoyOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteSelfDefensiveJammerOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteTowedJammerDecoyOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteFloatingDecoyOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteChaffOnBoard(1, Vehicle_Index);
//      dmTTT.DeleteInfraredDecoyOnBoard(1, Vehicle_Index);
//
//      dmTTT.DeleteHostedPlatform(1, Vehicle_Index);
//
//      // Keperluan data lama
//      dmTTT.DeleteHelicopterLimit(Vehicle_Index);
//
//      if dmTTT.DeleteVehicleDef(Vehicle_Index) then
//        ShowMessage('Data has been deleted');
//    end;
//
//    UpdateVehicleList;
//  end;
end;

procedure TfrmAvailableVehicle.btnUsageClick(Sender: TObject);
begin
//  if lbAllVehicleDef.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Vehicle Data ... !');
//    Exit;
//  end;
//
//  frmUsage := TfrmUsage.Create(Self);
//  try
//    with frmUsage do
//    begin
//      UId := FSelectedVehicle.FData.Vehicle_Index;
//      name_usage := FSelectedVehicle.FData.Vehicle_Identifier;
//      UIndex := 27;
//      ShowModal;
//    end;
//  finally
//    frmUsage.Free;
//  end;
end;

procedure TfrmAvailableVehicle.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableVehicle.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
//  vehicle : TVehicle_Definition;
begin
//  if Key = #13 then
//  begin
//    lbAllVehicleDef.Items.Clear;
//
//    dmTTT.GetFilterVehicleDef(FVehicleList, edtCheat.text);
//
//    for i := 0 to FVehicleList.Count - 1 do
//    begin
//      vehicle := FVehicleList.Items[i];
//      lbAllVehicleDef.Items.AddObject(vehicle.FData.Vehicle_Identifier, vehicle);
//    end;
//  end;
end;

procedure TfrmAvailableVehicle.lbSingleClick(Sender: TObject);
begin
//  if lbAllVehicleDef.ItemIndex = -1 then
//    Exit;
//
//  FSelectedVehicle := TVehicle_Definition(lbAllVehicleDef.Items.Objects[lbAllVehicleDef.ItemIndex]);
end;

procedure TfrmAvailableVehicle.UpdateVehicleList;
var
  i : Integer;
//  vehicle : TVehicle_Definition;
begin
//  lbAllVehicleDef.Items.Clear;
//
//  dmTTT.GetAllVehicleDef(FVehicleList);
//
//  for i := 0 to FVehicleList.Count - 1 do
//  begin
//    vehicle := FVehicleList.Items[i];
//    lbAllVehicleDef.Items.AddObject(vehicle.FData.Vehicle_Identifier, vehicle);
//  end;
end;

{$ENDREGION}

{$REGION ' Copy Procedure Handle '}

procedure TfrmAvailableVehicle.CopyPlatformInstanceIdent(const aVehicleIndex, aNewVehicleIndex: Integer);
var
  platInstList : TList;
  i : Integer;
//  platInst : TPlatform_Instance_Identifier;
begin
//  platInstList := TList.Create;
//
//  dmTTT.GetAllPlatformInstanceIdentifier(aVehicleIndex, platInstList);
//  for i := 0 to platInstList.Count - 1 do
//  begin
//    platInst := platInstList.Items[i];
//
//    with platInst do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertPlatformInstanceIdentifier(FData);
//    end;
//  end;
//
//  for i := 0 to platInstList.Count - 1 do
//  begin
//    platInst := platInstList.Items[i];
//    platInst.Free;
//  end;
//
//  platInstList.Free;
end;

procedure TfrmAvailableVehicle.CopyVehicleAsset(const aVehicleIndex, aNewVehicleIndex: Integer);
var
  assetList : TList;
  i, parentIndex : Integer;

//  radar : TRadar_On_Board;
//  mad : TMAD_On_Board;
//  esm : TESM_On_Board;
//  sonar : TSonar_On_Board;
//  eo : TEOD_On_Board;
//  iff : TIFF_Sensor_On_Board;
//  visual : TVisual_Sensor_On_Board;
//  sonobuoy : TSonobuoy_On_Board;
//
//  missile : TMissile_On_Board;
//  torpedo : TTorpedo_On_Board;
//  mine : TMine_On_Board;
//  gun : TGun_Definition;
//  bomb : TBomb_Definition;
//
//  jammer : TRadar_Noise_Jammer_On_Board;
//  airBubble : TAir_Bubble_On_Board;
//  accousticDecoy : TAcoustic_Decoy_On_Board;
//  defensiveJammer : TDefensive_Jammer_On_Board;
//  towedJammer : TTowed_Jammer_Decoy_On_Board;
//  floatingDecoy : TFloating_Decoy_On_Board;
//  chaff : TChaff_On_Board;
//  infraredDecoy : TInfrared_Decoy_On_Board;
//
//  hostedPlatform : THosted_Platform;

begin

//  {$REGION ' Sensor Section '}
//
//  {$REGION ' Radar '}
//  assetList := TList.Create;
//  dmTTT.GetRadarOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    radar := assetList.Items[i];
//
//    with radar do
//    begin
//      parentIndex := FData.Radar_Instance_Index;
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertRadarOnBoard(FData);
//
//      CopyAssetBlindZone(8, parentIndex, FData.Radar_Instance_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    radar := assetList.Items[i];
//    radar.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Sonar '}
//  assetList.Clear;
//
//  dmTTT.GetSonarOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    sonar := assetList.Items[i];
//
//    with sonar do
//    begin
//      parentIndex := FData.Sonar_Instance_Index;
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertSonarOnBoard(FData);
//
//      CopyAssetBlindZone(7, parentIndex, FData.Sonar_Instance_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    sonar := assetList.Items[i];
//    sonar.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' ESM '}
//  assetList.Clear;
//  dmTTT.GetESMOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    esm := assetList.Items[i];
//
//    with esm do
//    begin
//      parentIndex := FData.ESM_Instance_Index;
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertESMOnBoard(FData);
//
//      CopyAssetBlindZone(2, parentIndex, FData.ESM_Instance_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    esm := assetList.Items[i];
//    esm.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' EOD '}
//  assetList.Clear;
//  dmTTT.GetEOOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    eo := assetList.Items[i];
//
//    with eo do
//    begin
//      parentIndex := FData.EO_Instance_Index;
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertEOOnBoard(FData);
//
//      CopyAssetBlindZone(3, parentIndex, FData.EO_Instance_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    eo := assetList.Items[i];
//    eo.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' MAD '}
//  assetList.Clear;
//  dmTTT.GetMADOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    mad := assetList.Items[i];
//
//    with mad do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertMADOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    mad := assetList.Items[i];
//    mad.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Sonobuoy '}
//  assetList.Clear;
//  dmTTT.GetSonobuoyOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    sonobuoy := assetList.Items[i];
//
//    with sonobuoy do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertSonobuoyOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    sonobuoy := assetList.Items[i];
//    sonobuoy.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' IFF '}
//  assetList.Clear;
//  dmTTT.GetIFFOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    iff := assetList.Items[i];
//
//    with iff do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertIFFOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    iff := assetList.Items[i];
//    iff.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Visual Detector '}
//  assetList.Clear;
//  dmTTT.GetVisualOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    visual := assetList.Items[i];
//
//    with visual do
//    begin
//      parentIndex := FData.Visual_Instance_Index;
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertVisualOnBoard(FData);
//
//      CopyAssetBlindZone(4, parentIndex, FData.Visual_Instance_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    visual := assetList.Items[i];
//    visual.Free;
//  end;
//  {$ENDREGION}
//
//  {$ENDREGION}
//
//  {$REGION ' Weapon '}
//
//  {$REGION ' Missile '}
//  assetList.Clear;
//  dmTTT.GetMissileOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    missile := assetList.Items[i];
//
//    with missile do
//    begin
//      parentIndex := FData.Fitted_Weap_Index;
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertFittedWeaponOnBoard(1, FData);
//
//      CopyAssetBlindZone(6, parentIndex, FData.Fitted_Weap_Index);
//      CopyAssetWeaponLauncher(parentIndex, FData.Fitted_Weap_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    missile := assetList.Items[i];
//    missile.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Torpedo '}
//  assetList.Clear;
//  dmTTT.GetTorpedoOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    torpedo := assetList.Items[i];
//
//    with torpedo do
//    begin
//      parentIndex := FData.Fitted_Weap_Index;
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertFittedWeaponOnBoard(2, FData);
//
//      CopyAssetBlindZone(6, parentIndex, FData.Fitted_Weap_Index);
//      CopyAssetWeaponLauncher(parentIndex, FData.Fitted_Weap_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    torpedo := assetList.Items[i];
//    torpedo.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Mine '}
//  assetList.Clear;
//  dmTTT.GetMineOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    mine := assetList.Items[i];
//
//    with mine do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertFittedWeaponOnBoard(3, FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    mine := assetList.Items[i];
//    mine.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Bomb '}
//  assetList.Clear;
//  dmTTT.GetBombOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    bomb := assetList.Items[i];
//
//    with bomb do
//    begin
//      FPoint.FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertPointEffectOnBoard(2, FPoint.FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    bomb := assetList.Items[i];
//    bomb.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Gun '}
//  assetList.Clear;
//  dmTTT.GetGunOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    gun := assetList.Items[i];
//
//    with gun do
//    begin
//      parentIndex := FPoint.FData.Point_Effect_Index;
//      FPoint.FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertPointEffectOnBoard(1, FPoint.FData);
//
//      CopyAssetBlindZone(5, parentIndex, FPoint.FData.Point_Effect_Index);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    gun := assetList.Items[i];
//    gun.Free;
//  end;
//  {$ENDREGION}
//
//  {$ENDREGION}
//
//  {$REGION ' Countermeasure '}
//
//  {$REGION ' Acoustic Decoy '}
//  assetList.Clear;
//  dmTTT.GetAcousticDecoyOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    accousticDecoy := assetList.Items[i];
//
//    with accousticDecoy do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertAcousticDecoyOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    accousticDecoy := assetList.Items[i];
//    accousticDecoy.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Air Bubble '}
//  assetList.Clear;
//  dmTTT.GetAirBubbleOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    airBubble := assetList.Items[i];
//
//    with airBubble do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertAirBubbleOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    airBubble := assetList.Items[i];
//    airBubble.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Chaff '}
//  assetList.Clear;
//  dmTTT.GetChaffOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    chaff := assetList.Items[i];
//
//    with chaff do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertChaffOnBoard(FData);
//      CopyAssetChaffLauncher(aVehicleIndex, aNewVehicleIndex);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    chaff := assetList.Items[i];
//    chaff.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Floating Decoy '}
//  assetList.Clear;
//  dmTTT.GetFloatingDecoyOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    floatingDecoy := assetList.Items[i];
//
//    with floatingDecoy do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertFloatingDecoyOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    floatingDecoy := assetList.Items[i];
//    floatingDecoy.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Infrared Decoy '}
//  assetList.Clear;
//  dmTTT.GetInfraredDecoyOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    infraredDecoy := assetList.Items[i];
//
//    with infraredDecoy do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertInfraredDecoyOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    infraredDecoy := assetList.Items[i];
//    infraredDecoy.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Towed Jammer Decoy '}
//  assetList.Clear;
//  dmTTT.GetTowedJammerDecoyOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    towedJammer := assetList.Items[i];
//
//    with towedJammer do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertTowedJammerDecoyOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    towedJammer := assetList.Items[i];
//    towedJammer.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Radar Noise Jammer '}
//  assetList.Clear;
//  dmTTT.GetRadarNoiseJammerOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    jammer := assetList.Items[i];
//
//    with jammer do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertRadarNoiseJammerOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    jammer := assetList.Items[i];
//    jammer.Free;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Self Defensive Jammer '}
//  assetList.Clear;
//  dmTTT.GetSelfDefensiveJammerOnBoard(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    defensiveJammer := assetList.Items[i];
//
//    with defensiveJammer do
//    begin
//      FData.Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertSelfDefensiveJammerOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    defensiveJammer := assetList.Items[i];
//    defensiveJammer.Free;
//  end;
//  {$ENDREGION}
//
//  {$ENDREGION}
//
//  {$REGION ' Embarked Platform '}
//  assetList.Clear;
//  dmTTT.GetHostedPlatform(aVehicleIndex, assetList);
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    hostedPlatform := assetList.Items[i];
//
//    with hostedPlatform do
//    begin
//      FData.Hosted_Vehicle_Index := aNewVehicleIndex;
//
//      dmTTT.InsertHostedPlatform(FData);
//    end;
//  end;
//
//  for i := 0 to assetList.Count - 1 do
//  begin
//    hostedPlatform := assetList.Items[i];
//    hostedPlatform.Free;
//  end;
//
//  assetList.Free;
//  {$ENDREGION}

end;

procedure TfrmAvailableVehicle.CopyAssetBlindZone(const aBZType: Byte; const aParentIndex, aNewIndex: Integer);
var
  blindzoneList : TList;
  i : Integer;
//  blindzone : TBlind_Zone;
begin
//  blindzoneList := TList.Create;
//
//  dmTTT.GetBlindZone(aBZType, aParentIndex, blindzoneList);
//
//  for i := 0 to blindzoneList.Count - 1 do
//  begin
//    blindzone := blindzoneList.Items[i];
//
//    with blindzone do
//    begin
//      case aBZType of
//        1: FData.FCR_Instance_Index := aNewIndex;
//        2: FData.ESM_Instance_Index := aNewIndex;
//        3: FData.EO_Instance_Index := aNewIndex;
//        4: FData.Visual_Instance_Index := aNewIndex;
//        5: FData.Point_Effect_Index := aNewIndex;
//        6: FData.Fitted_Weap_Index := aNewIndex;
//        7: FData.Sonar_Instance_Index := aNewIndex;
//        8: FData.Radar_Instance_Index := aNewIndex;
//      end;
//
//      dmTTT.InsertBlindZone(FData);
//    end;
//  end;
//
//  for i := 0 to blindzoneList.Count - 1 do
//  begin
//    blindzone := blindzoneList.Items[i];
//    blindzone.Free;
//  end;
//
//  blindzoneList.Free;

end;

procedure TfrmAvailableVehicle.CopyAssetChaffLauncher(const aParentIndex, aNewIndex: Integer);
var
  i : Integer;
  launcherList : TList;
//  launcher : TChaff_Launcher_On_Board;
begin
//  launcherList := TList.Create;
//
//  dmTTT.GetChaffLauncherOnBoard(aParentIndex, launcherList);
//
//  for i := 0 to launcherList.Count - 1 do
//  begin
//    launcher := launcherList.Items[i];
//
//    with launcher do
//    begin
//      FData.Vehicle_Index := aNewIndex;
//
//      dmTTT.InsertChaffLauncherOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to launcherList.Count - 1 do
//  begin
//    launcher := launcherList.Items[i];
//    launcher.Free;
//  end;
//
//  launcherList.Free;
end;

procedure TfrmAvailableVehicle.CopyAssetWeaponLauncher(const aParentIndex,aNewIndex: Integer);
var
  i : Integer;
  launcherList : TList;
//  launcher : TFitted_Weap_Launcher_On_Board;
begin
//  launcherList := TList.Create;
//
//  dmTTT.GetFittedWeaponLauncherOnBoard(aParentIndex, launcherList);
//
//  for i := 0 to launcherList.Count - 1 do
//  begin
//    launcher := launcherList.Items[i];
//
//    with launcher do
//    begin
//      FData.Fitted_Weap_Index := aNewIndex;
//
//      dmTTT.InsertFittedWeaponLauncherOnBoard(FData);
//    end;
//  end;
//
//  for i := 0 to launcherList.Count - 1 do
//  begin
//    launcher := launcherList.Items[i];
//    launcher.Free;
//  end;
//
//  launcherList.Free;
end;


{$ENDREGION}

end.

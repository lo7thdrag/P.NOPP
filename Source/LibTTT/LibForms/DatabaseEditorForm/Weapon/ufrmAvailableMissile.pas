unit ufrmAvailableMissile;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Weapon, uDataModule, uSimContainers, ufrmSummaryMissile{, ufrmUsage};

type
  TfrmAvailableMissile = class(TForm)
    btnCopy: TImage;
    btnDelete: TImage;
    btnEdit: TImage;
    btnNew: TImage;
    btnUsage: TImage;
    edtCheat: TEdit;
    ImgBackgroundForm: TImage;
    lblClose: TLabel;
    lblPlatform: TLabel;
    lblsearch: TLabel;
    lbxMissile: TListBox;

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
    FMissileList : TList;
    FSelectedMissile : TMissile_On_Board;
//    FSelectedHybrid : THybrid_On_Board; {yg ini biarin aja}

    procedure UpdateMissileList;

  end;

var
  frmAvailableMissile: TfrmAvailableMissile;

implementation

//uses
//  uDataModule, ufrmSummaryMissile;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableMissile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FMissileList);
  Action := caFree;
end;
//
procedure TfrmAvailableMissile.FormCreate(Sender: TObject);
begin
  FMissileList := TList.Create;
end;

procedure TfrmAvailableMissile.FormShow(Sender: TObject);
begin
  UpdateMissileList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableMissile.btnNewClick(Sender: TObject);
begin

  frmSummaryMissile := TfrmSummaryMissile.Create(Self);
  try
    with frmSummaryMissile do
    begin
//      SelectedMissile := TMissile_On_Board.Create;
      ShowModal;
//      SelectedMissile.Free;
      FUpdateList := AfterClose;
    end;
//
  finally
   frmSummaryMissile.Free;
 end;

  if FUpdateList then
    UpdateMissileList;
end;

procedure TfrmAvailableMissile.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableMissile.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
  idMissileTemp : Integer;

begin
  if lbxMissile.ItemIndex = -1 then
  begin
    ShowMessage('Select Missile... !');
    Exit;
  end;

  with FSelectedMissile do
  begin
    idMissileTemp := FDef.Missile_Index;
    newClassName := FDef.Class_Identifier + ' - Copy';

    count := dmINWO.GetMissileDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Class_Identifier := newClassName;

    dmINWO.InsertMissileDef(FDef);
    dmINWO.InsertNoteStorage(2, FDef.Missile_Index, FNote);

    {Insert data hybrid}
//    if dmINWO.GetHybridDef(idMissileTemp, FSelectedHybrid) then
//    begin
//      FSelectedHybrid.FMissile_Def.Missile_Index := FDef.Missile_Index;
//
//      if (FData.Hybrid_Index = 0) and (FSelectedHybrid.FTorpedo_Def.Torpedo_Index <> 0)then
//        dmINWO.insertHybrid(FSelectedHybrid)
//    end;

  end;

  UpdateMissileList;
end;

procedure TfrmAvailableMissile.btnEditClick(Sender: TObject);
begin

  if lbxMissile.ItemIndex = -1 then
  begin
    ShowMessage('Select Missile Data ... !');
    Exit;
  end;

  frmSummaryMissile := TfrmSummaryMissile.Create(Self);
  try
    with frmSummaryMissile do
    begin
//      SelectedMissile := FSelectedMissile;
      ShowModal;
      FUpdateList := AfterClose;
    end;

  finally
    frmSummaryMissile.Free;
  end;

  if FUpdateList then
    UpdateMissileList;
end;

procedure TfrmAvailableMissile.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;

begin
  if lbxMissile.ItemIndex = -1 then
  begin
    ShowMessage('Select Missile... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
     with FSelectedMissile.FDef do
    begin
      tempList := TList.Create;

      {Pengecekan Relasi Dengan Resource Allocation}
//      if dmINWO.GetPlatformInstanceAtResourceAllocation(2, Missile_Index, tempList) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some resource allocation');
//        tempList.Free;
//        Exit;
//      end;
//
//      {Pengecekan Relasi Dengan Runtime Platform Library}
//      if dmINWO.GetPlatformAtPlatformLibraryEntry(2, Missile_Index, tempList) > 0then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some Runtime Platform Library');
//        tempList.Free;
//        Exit;
//      end;

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetFittedWeaponAtVehicleOnBoard(7, Missile_Index, tempList) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        tempList.Free;
        Exit;
      end;
      tempList.Free;

//      dmINWO.deleteHybrid(Missile_Index);

      dmINWO.DeleteNoteStorage(2, Missile_Index);

      if dmINWO.DeleteMissileDef(Missile_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateMissileList;
  end;
end;

procedure TfrmAvailableMissile.btnUsageClick(Sender: TObject);
begin
  if lbxMissile.ItemIndex = -1 then
  begin
    ShowMessage('Select Missile... !');
    Exit;
  end;
//
//  frmUsage := TfrmUsage.Create(Self);
//  try
//    with frmUsage do
//    begin
//      AssetIndex := FSelectedMissile.FDef.Missile_Index;
//      AssetName := FSelectedMissile.FDef.Class_Identifier;
//      AssetTitle := 'On Board Vehicle : ';
//      AssetType := stMissile;
//
//      ShowModal;
//    end;
//  finally
//    frmUsage.Free;
//  end;

end;

procedure TfrmAvailableMissile.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  missile : TMissile_On_Board;
begin
  if Key = #13 then
  begin
    lbxMissile.Items.Clear;

    dmINWO.GetFilterMissileDef(FMissileList, edtCheat.text);

    for i := 0 to FMissileList.Count - 1 do
    begin
      missile := FMissileList.Items[i];
      lbxMissile.Items.AddObject(missile.FDef.Class_Identifier, missile);
    end;
  end;
end;

procedure TfrmAvailableMissile.lbSingleClick(Sender: TObject);
begin
  if lbxMissile.ItemIndex = -1 then
    Exit;

  FSelectedMissile := TMissile_On_Board(lbxMissile.Items.Objects[lbxMissile.ItemIndex]);
end;



procedure TfrmAvailableMissile.UpdateMissileList;
var
  i : Integer;
  missile : TMissile_On_Board;

begin
  lbxMissile.Items.Clear;

  dmINWO.GetAllMissileDef(FMissileList);

  for i := 0 to FMissileList.Count - 1 do
  begin
    missile := FMissileList.Items[i];
    lbxMissile.Items.AddObject(missile.FDef.Class_Identifier, missile);
  end;
end;

{$ENDREGION}

end.


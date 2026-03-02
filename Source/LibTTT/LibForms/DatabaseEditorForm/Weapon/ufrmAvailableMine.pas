unit ufrmAvailableMine;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Weapon, uDataModule, uSimContainers, ufrmSummaryMine, ufrmUsage;

type
  TfrmAvailableMine = class(TForm)
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
    lbxMine: TListBox;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbSingleClick(Sender: TObject);

    procedure btnNewClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUsageClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtCheatKeyPress(Sender: TObject; var Key: Char);

  private
    FUpdateList : Boolean;
    FMineList : TList;
    FSelectedMine : TMine_On_Board;

    procedure CopyPODvsRange(idMine, targetType: integer);
    procedure UpdateMineList;

  end;

var
  frmAvailableMine: TfrmAvailableMine;

implementation

//uses
//  uDataModule, ufrmSummaryMine;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableMine.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FMineList);
  Action := cafree;
end;

procedure TfrmAvailableMine.FormCreate(Sender: TObject);
begin
  FMineList := TList.Create;
end;

procedure TfrmAvailableMine.FormShow(Sender: TObject);
begin
  UpdateMineList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableMine.btnNewClick(Sender: TObject);
begin
  frmSummaryMine := TfrmSummaryMine.Create(Self);
  try
    with frmSummaryMine do
    begin
      SelectedMine := TMine_On_Board.Create;
      ShowModal;
      SelectedMine.Free;
      FUpdateList := AfterClose;
    end;

  finally
    frmSummaryMine.Free;
  end;

  if FUpdateList then
    UpdateMineList;
end;

procedure TfrmAvailableMine.btnCloseClick(Sender: TObject);
begin
//  Close;
end;

procedure TfrmAvailableMine.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
  idTemp : Integer;
begin
  if lbxMine.ItemIndex = -1 then
  begin
    ShowMessage('Select Mine Data... !');
    Exit;
  end;

  with FSelectedMine do
  begin
    newClassName := FDef.Mine_Identifier + ' - Copy';

    count := dmINWO.GetMineDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Mine_Identifier := newClassName;
    idTemp :=FDef.Mine_Index;

    dmINWO.InsertMineDef(FDef);
    dmINWO.InsertNoteStorage(3, FDef.Mine_Index, FNote);

    {Copy Probability of Detonation Curve}
    CopyPODvsRange(idTemp, 1);

  end;

  UpdateMineList;
end;

procedure TfrmAvailableMine.btnEditClick(Sender: TObject);
begin
  if lbxMine.ItemIndex = -1 then
  begin
    ShowMessage('Select Mine Data ... !');
    Exit;
  end;

  frmSummaryMine := TfrmSummaryMine.Create(Self);
  try
    with frmSummaryMine do
    begin
      SelectedMine := FSelectedMine;
      ShowModal;
      FUpdateList := AfterClose;
    end;

  finally
    frmSummaryMine.Free;
  end;

  if FUpdateList then
    UpdateMineList;
end;

procedure TfrmAvailableMine.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;

begin
  if lbxMine.ItemIndex = -1 then
  begin
    ShowMessage('Select Mine Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedMine.FDef do
    begin
      tempList := TList.Create;

      {Pengecekan Relasi Dengan Resource Allocation}
//      if dmINWO.GetPlatformInstanceAtResourceAllocation(5, Mine_Index, tempList) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some resource allocation');
//        tempList.Free;
//        Exit;
//      end;

      {Pengecekan Relasi Dengan Runtime Platform Library}
//      if dmINWO.GetPlatformAtPlatformLibraryEntry(4, Mine_Index, tempList) > 0then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some Runtime Platform Library');
//        tempList.Free;
//        Exit;
//      end;

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetFittedWeaponAtVehicleOnBoard(9, Mine_Index, tempList) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        tempList.Free;
        Exit;
      end;
      tempList.Free;

      {Catatan : Seharusnya ada tambahan menghapus data di Tabel Mine_POD_vs_Range}
//      dmINWO.DeleteMinePODvsRange(1, Mine_Index);

      dmINWO.DeleteNoteStorage(3, Mine_Index);

      if dmINWO.DeleteMineDef(Mine_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateMineList;
  end;
end;

procedure TfrmAvailableMine.btnUsageClick(Sender: TObject);
begin
  if lbxMine.ItemIndex = -1 then
  begin
    ShowMessage('Select Mine... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedMine.FDef.Mine_Index;
      AssetName := FSelectedMine.FDef.Mine_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stMine;

      ShowModal;
    end;

  finally
    frmUsage.Free;
  end;

end;

procedure TfrmAvailableMine.lbSingleClick(Sender: TObject);
begin
  if lbxMine.ItemIndex = -1 then
    Exit;

  FSelectedMine := TMine_On_Board(lbxMine.Items.Objects[lbxMine.ItemIndex]);
end;

procedure TfrmAvailableMine.CopyPODvsRange(idMine, targetType: integer);
//var
//  newClassName : string;
//  count, i : Integer;
//  PointList : TList;
//  data : TMine_On_Board;

begin
//  with FSelectedMine do
//  begin
//    PointList := TList.Create;
//
//    if dmINWO.GetMinePODvsRange(idMine, targetType, PointList) > 0 then
//    begin
//      for i := 0 to PointList.Count - 1 do
//      begin
//        data := PointList.Items[i];
//        data.FMine_POD.Mine_Index := FDef.Mine_Index;
//        dmINWO.InsertMinePODvsRange(data.FMine_POD)
//      end;
//    end;
//
//    PointList.Free;
//  end;
end;

procedure TfrmAvailableMine.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  mine : TMine_On_Board;
begin
  if Key = #13 then
  begin
    lbxMine.Items.Clear;

    dmINWO.GetFilterMineDef(FMineList, edtCheat.text);

    for i := 0 to FMineList.Count - 1 do
    begin
      mine := FMineList.Items[i];
      lbxMine.Items.AddObject(mine.FDef.Mine_Identifier, mine);
    end;
  end;
end;

procedure TfrmAvailableMine.UpdateMineList;
var
  i : Integer;
  mine : TMine_On_Board;

begin
  lbxMine.Items.Clear;

  dmINWO.GetAllMineDef(FMineList);

  for i := 0 to FMineList.Count - 1 do
  begin
    mine := FMineList.Items[i];
    lbxMine.Items.AddObject(mine.FDef.Mine_Identifier, mine);
  end;
end;

{$ENDREGION}

end.

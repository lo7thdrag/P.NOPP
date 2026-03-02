unit ufrmMineOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Weapon, uClassData, uSimContainers;

type
  TfrmMineOnBoardPickList = class(TForm)
    lbAllMineDef: TListBox;
    lbMineOnBoard: TListBox;
    btnAdd: TImage;
    btnEdit: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lblClose: TLabel;
    btnNew: TImage;
    btnUpdate: TImage;
    btnDelete: TImage;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllMineDefClick(Sender: TObject);
    procedure lbAllMineOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);


  private
    FAllMineDefList : TList;
    FAllMineOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedMine : TMine_On_Board;

  public
    procedure UpdateMineList;
    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmMineOnBoardPickList: TfrmMineOnBoardPickList;

implementation

uses
  uDataModule, ufrmMineMount, ufrmAsset, ufrmsummaryMine;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmMineOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllMineDefList);
//  FreeItemsAndFreeList(FAllMineOnBoardList);
//  Action := cafree;
end;

procedure TfrmMineOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllMineDefList := TList.Create;
  FAllMineOnBoardList := TList.Create;
end;

procedure TfrmMineOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateMineList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmMineOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllMineDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmMineMount) then
    frmMineMount := TfrmMineMount.Create(Self);
  try
    with frmMineMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedMine := FSelectedMine;
      Show;
    end;
  finally
  end;

//  UpdateMineList;
end;

procedure TfrmMineOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbMineOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmMineMount) then
    frmMineMount := TfrmMineMount.Create(Self);
  try
    with frmMineMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedMine := FSelectedMine;
      Show;
    end;
  finally
  end;

//  UpdateMineList;
end;

procedure TfrmMineOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryMine) then
    frmSummaryMine := TfrmSummaryMine.Create(Self);

  try
    with frmSummaryMine do
    begin
      SelectedMine := TMine_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmMineOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbMineOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedMine.FData do
  begin
    dmINWO.DeleteFittedWeaponOnBoard(2, Fitted_Weap_Index);
  end;

  UpdateMineList;
end;

procedure TfrmMineOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllMineDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Mine Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryMine) then
    frmSummaryMine := TfrmSummaryMine.Create(Self);

  try
    with frmSummaryMine do
    begin
      SelectedMine := FSelectedMine;
      Show;
    end;
  finally
  end;
end;

procedure TfrmMineOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateWeaponData;
  Close;
end;

procedure TfrmMineOnBoardPickList.btnDeleteClick(Sender: TObject);
var
   warning : Integer;
   tempList: TList;
begin
  if lbAllMineDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Mine Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedMine.FDef do
    begin
      tempList := TList.Create;

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetFittedWeaponAtVehicleOnBoard(5, Mine_Index, tempList) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        tempList.Free;
        Exit;
      end;

      if dmINWO.DeleteMineDef(Mine_Index) then
        ShowMessage('Data has been deleted');

      tempList.Free;
    end;

    UpdateMineList;
  end;
end;

procedure TfrmMineOnBoardPickList.lbAllMineDefClick(Sender: TObject);
begin
  if lbAllMineDef.ItemIndex = -1 then
    Exit;

  FSelectedMine := TMine_On_Board(lbAllMineDef.Items.Objects[lbAllMineDef.ItemIndex]);
end;

procedure TfrmMineOnBoardPickList.lbAllMineOnBoardClick(Sender: TObject);
begin
  if lbMineOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedMine := TMine_On_Board(lbMineOnBoard.Items.Objects[lbMineOnBoard.ItemIndex]);
end;

procedure TfrmMineOnBoardPickList.UpdateMineList;
var
  i : Integer;
  mine : TMine_On_Board;
begin
  lbAllMineDef.Items.Clear;
  lbMineOnBoard.Items.Clear;

  dmINWO.GetAllMineDef(FAllMineDefList);
  dmINWO.GetMineOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllMineOnBoardList);

  for i := 0 to FAllMineDefList.Count - 1 do
  begin
    mine := FAllMineDefList.Items[i];
    lbAllMineDef.Items.AddObject(mine.FDef.Mine_Identifier, mine);
  end;

  for i := 0 to FAllMineOnBoardList.Count - 1 do
  begin
    mine := FAllMineOnBoardList.Items[i];
    lbMineOnBoard.Items.AddObject(mine.FData.Instance_Identifier, mine);
  end;
end;

{$ENDREGION}

end.

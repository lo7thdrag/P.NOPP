unit ufrmMissileOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Weapon, uClassData, uSimContainers, uConstantaData ;

type
  TfrmMissileOnBoardPickList = class(TForm)
    lbAllMissileDef: TListBox;
    lbAllMissileOnBoard: TListBox;
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

    procedure lbAllMissileDefClick(Sender: TObject);
    procedure lbAllMissileOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);


  private
    FAllMissileDefList : TList;
    FAllMissileOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedMissile : TMissile_On_Board;

  public
    procedure UpdateMissileList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmMissileOnBoardPickList: TfrmMissileOnBoardPickList;

implementation

uses
  uDataModule, ufrmMissileMount, ufrmAsset, ufrmSummaryMissile;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmMissileOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllMissileDefList);
//  FreeItemsAndFreeList(FAllMissileOnBoardList);
//  Action := cafree;
end;

procedure TfrmMissileOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllMissileDefList := TList.Create;
  FAllMissileOnBoardList := TList.Create;
end;

procedure TfrmMissileOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateMissileList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmMissileOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllMissileDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmMissileMount) then
    frmMissileMount := TfrmMissileMount.Create(Self);

  try
    with frmMissileMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedMissile := FSelectedMissile;
      Show;
    end;
  finally
  end;

//  UpdateMissileList;
end;

procedure TfrmMissileOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllMissileOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmMissileMount) then
    frmMissileMount := TfrmMissileMount.Create(Self);

  try
    with frmMissileMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedMissile := FSelectedMissile;
      Show;
    end;
  finally
  end;

//  UpdateMissileList;
end;

procedure TfrmMissileOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryMissile) then
    frmSummaryMissile := TfrmSummaryMissile.Create(Self);

  try
    with frmSummaryMissile do
    begin
      SelectedMissile := TMissile_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmMissileOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllMissileOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedMissile.FData do
  begin
//    .DeleteFittedWeaponLauncherOnBoard(2, Fitted_Weap_Index);
    dmINWO.DeleteFittedWeaponOnBoard(2, Fitted_Weap_Index);
  end;

  UpdateMissileList;
end;

procedure TfrmMissileOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllMissileDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Missile Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryMissile) then
    frmSummaryMissile := TfrmSummaryMissile.Create(Self);

  try
    with frmSummaryMissile do
    begin
      SelectedMissile := FSelectedMissile;
      Show;
    end;
  finally
  end;
end;

procedure TfrmMissileOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateWeaponData;
  Close;
end;

procedure TfrmMissileOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllMissileDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Missile Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedMissile.FDef do
    begin
      tempList := TList.Create;

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetFittedWeaponAtVehicleOnBoard(1, Missile_Index, tempList) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        tempList.Free;
        Exit;
      end;

      if dmINWO.DeleteMissileDef(Missile_Index) then
        ShowMessage('Data has been deleted');

      tempList.Free;
    end;

    UpdateMissileList;
  end;
end;

procedure TfrmMissileOnBoardPickList.lbAllMissileDefClick(Sender: TObject);
begin
  if lbAllMissileDef.ItemIndex = -1 then
    Exit;

  FSelectedMissile := TMissile_On_Board(lbAllMissileDef.Items.Objects[lbAllMissileDef.ItemIndex]);
end;

procedure TfrmMissileOnBoardPickList.lbAllMissileOnBoardClick(Sender: TObject);
begin
  if lbAllMissileOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedMissile := TMissile_On_Board(lbAllMissileOnBoard.Items.Objects[lbAllMissileOnBoard.ItemIndex]);
end;

procedure TfrmMissileOnBoardPickList.UpdateMissileList;
var
  i : Integer;
  missile : TMissile_On_Board;
begin
  lbAllMissileDef.Items.Clear;
  lbAllMissileOnBoard.Items.Clear;

  dmINWO.GetAllMissileDef(FAllMissileDefList);
  dmINWO.GetMissileOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllMissileOnBoardList);

  for i := 0 to FAllMissileDefList.Count - 1 do
  begin
    missile := FAllMissileDefList.Items[i];
    lbAllMissileDef.Items.AddObject(missile.FDef.Class_Identifier, missile);
  end;

  for i := 0 to FAllMissileOnBoardList.Count - 1 do
  begin
    missile := FAllMissileOnBoardList.Items[i];
    lbAllMissileOnBoard.Items.AddObject(missile.FData.Instance_Identifier, missile);
  end;
end;

{$ENDREGION}

end.

unit ufrmGunOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Weapon, uClassData, uSimContainers ;

type
  TfrmGunOnBoardPickList = class(TForm)
    lbAllGunDef: TListBox;
    lbAllGunOnBoard: TListBox;
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
    btnDelete: TImage;
    btnUpdate: TImage;
    btnNew: TImage;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllGunDefClick(Sender: TObject);
    procedure lbAllGunOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);


  private
    FAllGunDefList : TList;
    FAllGunOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedGun : TGun_On_Board;

  public
    procedure UpdateGunList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmGunOnBoardPickList: TfrmGunOnBoardPickList;

implementation

uses
  uDataModule, ufrmGunMount, ufrmAsset, ufrmSummaryGun;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmGunOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllGunDefList);
//  FreeItemsAndFreeList(FAllGunOnBoardList);
//  Action := cafree;
end;

procedure TfrmGunOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllGunDefList := TList.Create;
  FAllGunOnBoardList := TList.Create;
end;

procedure TfrmGunOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateGunList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmGunOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllGunDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmGunMount) then
    frmGunMount := TfrmGunMount.Create(Self);
  try
    with frmGunMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedGun := FSelectedGun;
      Show;
    end;
  finally
  end;

//  UpdateGunList;
end;

procedure TfrmGunOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllGunOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmGunMount) then
    frmGunMount := TfrmGunMount.Create(Self);
  try
    with frmGunMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedGun := FSelectedGun;
      Show;
    end;
  finally
  end;

//  UpdateGunList;
end;

procedure TfrmGunOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryGun) then
    frmSummaryGun := TfrmSummaryGun.Create(Self);

  try
    with frmSummaryGun do
    begin
      SelectedGun := TGun_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmGunOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllGunOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedGun.FData do
  begin
//    dmINWO.DeleteBlindZone(Ord(bzcPointEffect), Point_Effect_Index);
    dmINWO.DeletePointEffectOnBoard(2, Point_Effect_Index);
  end;

  UpdateGunList;
end;

procedure TfrmGunOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllGunDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Gun Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryGun) then
    frmSummaryGun := TfrmSummaryGun.Create(Self);

  try
    with frmSummaryGun do
    begin
      SelectedGun := FSelectedGun;
      Show;
    end;
  finally
  end;
end;

procedure TfrmGunOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateWeaponData;
  Close;
end;

procedure TfrmGunOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllGunDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Gun Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedGun.FDef do
    begin
    TempList := TList.Create;

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetFittedWeaponAtVehicleOnBoard(5, Gun_Index, TempList ) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteGunDef(Gun_Index) then
        ShowMessage('Data has been deleted');

      tempList.Free;
    end;

    UpdateGunList;
  end;
end;

procedure TfrmGunOnBoardPickList.lbAllGunDefClick(Sender: TObject);
begin
  if lbAllGunDef.ItemIndex = -1 then
    Exit;

  FSelectedGun := TGun_On_Board(lbAllGunDef.Items.Objects[lbAllGunDef.ItemIndex]);
end;

procedure TfrmGunOnBoardPickList.lbAllGunOnBoardClick(Sender: TObject);
begin
  if lbAllGunOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedGun := TGun_On_Board(lbAllGunOnBoard.Items.Objects[lbAllGunOnBoard.ItemIndex]);
end;

procedure TfrmGunOnBoardPickList.UpdateGunList;
var
  i : Integer;
  gun : TGun_On_Board;
begin
  lbAllGunDef.Items.Clear;
  lbAllGunOnBoard.Items.Clear;

  dmINWO.GetAllGunDef(FAllGunDefList);
  dmINWO.GetGunOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllGunOnBoardList);

  for i := 0 to FAllGunDefList.Count - 1 do
  begin
    gun := FAllGunDefList.Items[i];
    lbAllGunDef.Items.AddObject(gun.FDef.Gun_Identifier, gun);
  end;

  for i := 0 to FAllGunOnBoardList.Count - 1 do
  begin
    gun := FAllGunOnBoardList.Items[i];
    lbAllGunOnBoard.Items.AddObject(gun.FData.Instance_Identifier, gun);
  end;
end;

{$ENDREGION}

end.

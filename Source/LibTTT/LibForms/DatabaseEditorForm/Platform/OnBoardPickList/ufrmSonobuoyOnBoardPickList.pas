unit ufrmSonobuoyOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers;

type
  TfrmSonobuoyOnBoardPickList = class(TForm)
    lbAllSonobuoyDef: TListBox;
    lbAllSonobuoyOnBoard: TListBox;
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

    procedure lbAllSonobuoyDefClick(Sender: TObject);
    procedure lbAllSonobuoyOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);


  private
    FAllSonobuoyDefList : TList;
    FAllSonobuoyOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedSonobuoy : TSonobuoy_On_Board;

  public
    procedure UpdateSonobuoyList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmSonobuoyOnBoardPickList: TfrmSonobuoyOnBoardPickList;

implementation

uses
  uDataModule, ufrmSonobuoyMount, ufrmAsset, ufrmSummarySonobuoy;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmSonobuoyOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllSonobuoyDefList);
//  FreeItemsAndFreeList(FAllSonobuoyOnBoardList);
//  Action := cafree;
end;

procedure TfrmSonobuoyOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllSonobuoyDefList := TList.Create;
  FAllSonobuoyOnBoardList := TList.Create;
end;

procedure TfrmSonobuoyOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateSonobuoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSonobuoyOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllSonobuoyDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmSonobuoyMount) then
    frmSonobuoyMount := TfrmSonobuoyMount.Create(Self);

  try
    with frmSonobuoyMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedSonobuoy := FSelectedSonobuoy;
      Show;
    end;
  finally
  end;

//  UpdateRadarList;
end;

procedure TfrmSonobuoyOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllSonobuoyOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmSonobuoyMount) then
    frmSonobuoyMount := TfrmSonobuoyMount.Create(Self);

  try
    with frmSonobuoyMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedSonobuoy := FSelectedSonobuoy;
      Show;
    end;
  finally
  end;

//  UpdateRadarList;
end;

procedure TfrmSonobuoyOnBoardPickList.btnNewClick(Sender: TObject);
begin
if not Assigned(frmSummarySonobuoy) then
    frmSummarySonobuoy := TfrmSummarySonobuoy.Create(Self);

  try
    with frmSummarySonobuoy do
    begin
      SelectedSonobuoy := TSonobuoy_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmSonobuoyOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllSonobuoyOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedSonobuoy.FData do
  begin
    dmINWO.DeleteSonobuoyOnBoard(2, Sonobuoy_Instance_Index);
  end;

  UpdateSonobuoyList;
end;

procedure TfrmSonobuoyOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
if lbAllSonobuoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Sonobuoy Data ... !');
    Exit;
  end;

  if not Assigned(frmSummarySonobuoy) then
    frmSummarySonobuoy := TfrmSummarySonobuoy.Create(Self);

  try
    with frmSummarySonobuoy do
    begin
      SelectedSonobuoy := FSelectedSonobuoy;
      Show;
    end;
  finally
  end;
end;

procedure TfrmSonobuoyOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateSensorData;
  Close;
end;

procedure TfrmSonobuoyOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllSonobuoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select Sonobuoy Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedSonobuoy.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetSensor_On_Board_By_Index(8, Sonobuoy_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteSonobuoyDef(Sonobuoy_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateSonobuoyList;
  end;
end;

procedure TfrmSonobuoyOnBoardPickList.lbAllSonobuoyDefClick(Sender: TObject);
begin
  if lbAllSonobuoyDef.ItemIndex = -1 then
    Exit;

  FSelectedSonobuoy := TSonobuoy_On_Board(lbAllSonobuoyDef.Items.Objects[lbAllSonobuoyDef.ItemIndex]);
end;

procedure TfrmSonobuoyOnBoardPickList.lbAllSonobuoyOnBoardClick(Sender: TObject);
begin
  if lbAllSonobuoyOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedSonobuoy := TSonobuoy_On_Board(lbAllSonobuoyOnBoard.Items.Objects[lbAllSonobuoyOnBoard.ItemIndex]);
end;

procedure TfrmSonobuoyOnBoardPickList.UpdateSonobuoyList;
var
  i : Integer;
  sonobuoy : TSonobuoy_On_Board;
begin
  lbAllSonobuoyDef.Items.Clear;
  lbAllSonobuoyOnBoard.Items.Clear;

  dmINWO.GetAllSonobuoyDef(FAllSonobuoyDefList);
  dmINWO.GetSonobuoyOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllSonobuoyOnBoardList);

  for i := 0 to FAllSonobuoyDefList.Count - 1 do
  begin
    sonobuoy := FAllSonobuoyDefList.Items[i];
    lbAllSonobuoyDef.Items.AddObject(sonobuoy.FDef.Class_Identifier, sonobuoy);
  end;

  for i := 0 to FAllSonobuoyOnBoardList.Count - 1 do
  begin
    sonobuoy := FAllSonobuoyOnBoardList.Items[i];
    lbAllSonobuoyOnBoard.Items.AddObject(sonobuoy.FData.Instance_Identifier, sonobuoy);
  end;
end;

{$ENDREGION}

end.

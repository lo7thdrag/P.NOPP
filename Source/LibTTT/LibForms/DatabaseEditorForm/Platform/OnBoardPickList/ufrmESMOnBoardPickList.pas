unit ufrmESMOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers ;

type
  TfrmESMOnBoardPickList = class(TForm)
    lbAllESMDef: TListBox;
    lbESMOnBoard: TListBox;
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

    procedure lbAllESMDefClick(Sender: TObject);
    procedure lbAllESMOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);


  private
    FAllESMDefList : TList;
    FAllESMOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedESM : TESM_On_Board;

  public
    procedure UpdateESMList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmESMOnBoardPickList: TfrmESMOnBoardPickList;

implementation

uses
  uDataModule,ufrmESMMount, ufrmAsset, ufrmSummaryESM;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmESMOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllESMDefList);
//  FreeItemsAndFreeList(FAllESMOnBoardList);
//  Action := cafree;
end;

procedure TfrmESMOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllESMDefList := TList.Create;
  FAllESMOnBoardList := TList.Create;
end;

procedure TfrmESMOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateESMList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmESMOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllESMDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmESMMount) then
    frmESMMount := TfrmESMMount.Create(Self);
  try
    with frmESMMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedESM := FSelectedESM;
      Show;
    end;
  finally
  end;

//  UpdateESMList;
end;

procedure TfrmESMOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbESMOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmESMMount) then
    frmESMMount := TfrmESMMount.Create(Self);
  try
    with frmESMMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedESM := FSelectedESM;
      Show;
    end;
  finally
  end;

//  UpdateESMList;
end;

procedure TfrmESMOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryESM) then
    frmSummaryESM := TfrmSummaryESM.Create(Self);

  try
    with frmSummaryESM do
    begin
      SelectedESM := TESM_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmESMOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbESMOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedESM.FData do
  begin
    dmINWO.DeleteESMOnBoard(2, ESM_Instance_Index);
  end;

  UpdateESMList;
end;

procedure TfrmESMOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllESMDef.ItemIndex = -1 then
  begin
    ShowMessage('Select ESM Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryESM) then
    frmSummaryESM := TfrmSummaryESM.Create(Self);

  try
    with frmSummaryESM do
    begin
      SelectedESM := FSelectedESM;
      Show;
    end;
  finally
  end;
end;

procedure TfrmESMOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateSensorData;
  Close;
end;

procedure TfrmESMOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbAllESMDef.ItemIndex = -1 then
  begin
    ShowMessage('Select ESM Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedESM.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetSensor_On_Board_By_Index(1, ESM_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteESMDef(ESM_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateESMList;
  end;
end;

procedure TfrmESMOnBoardPickList.lbAllESMDefClick(Sender: TObject);
begin
  if lbAllESMDef.ItemIndex = -1 then
    Exit;

  FSelectedESM := TESM_On_Board(lbAllESMDef.Items.Objects[lbAllESMDef.ItemIndex]);
end;

procedure TfrmESMOnBoardPickList.lbAllESMOnBoardClick(Sender: TObject);
begin
  if lbESMOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedESM := TESM_On_Board(lbESMOnBoard.Items.Objects[lbESMOnBoard.ItemIndex]);
end;

procedure TfrmESMOnBoardPickList.UpdateESMList;
var
  i : Integer;
  esm : TESM_On_Board;
begin
  lbAllESMDef.Items.Clear;
  lbESMOnBoard.Items.Clear;

  dmINWO.GetAllESMDef(FAllESMDefList);
  dmINWO.GetESMOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllESMOnBoardList);

  for i := 0 to FAllESMDefList.Count - 1 do
  begin
    esm := FAllESMDefList.Items[i];
    lbAllESMDef.Items.AddObject(esm.FDef.class_Identifier, esm);
  end;

  for i := 0 to FAllESMOnBoardList.Count - 1 do
  begin
    esm := FAllESMOnBoardList.Items[i];
    lbESMOnBoard.Items.AddObject(esm.FData.Instance_Identifier, esm);
  end;
end;

{$ENDREGION}

end.

unit ufrmEODOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers ;

type
  TfrmEODOnBoardPickList = class(TForm)
    lbAllEODef: TListBox;
    lbAllEODOnBoard: TListBox;
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

    procedure lbAllEODDefClick(Sender: TObject);
    procedure lbAlEODOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);


  private
    FAllEODDefList : TList;
    FAllEODOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedEOD : TEOD_On_Board;

  public
    procedure UpdateEODList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmEODOnBoardPickList: TfrmEODOnBoardPickList;

implementation

uses
  uDataModule, ufrmEODMount, ufrmAsset, ufrmSummaryEOD;


{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmEODOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllEODDefList);
//  FreeItemsAndFreeList(FAllEODOnBoardList);
//  Action := cafree;
end;

procedure TfrmEODOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllEODDefList := TList.Create;
  FAllEODOnBoardList := TList.Create;
end;

procedure TfrmEODOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateEODList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmEODOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllEODef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmEODMount) then
    frmEODMount := TfrmEODMount.Create(Self);
  try
    with frmEODMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedEOD := FSelectedEOD;
      Show;
    end;
  finally
  end;

//  UpdateEODList;
end;

procedure TfrmEODOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllEODOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmEODMount) then
    frmEODMount := TfrmEODMount.Create(Self);
  try
    with frmEODMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedEOD := FSelectedEOD;
      Show;
    end;
  finally
  end;

//  UpdateEODList;
end;

procedure TfrmEODOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryEOD) then
    frmSummaryEOD := TfrmSummaryEOD.Create(Self);

  try
    with frmSummaryEOD do
    begin
      SelectedEOD := TEOD_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmEODOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllEODOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedEOD.FData do
  begin
    dmINWO.DeleteEODOnBoard(2, EOD_Instance_Index);
  end;

  UpdateEODList;
end;

procedure TfrmEODOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
if lbAllEODef.ItemIndex = -1 then
  begin
    ShowMessage('Select EOD Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryEOD) then
    frmSummaryEOD := TfrmSummaryEOD.Create(Self);

  try
    with frmSummaryEOD do
    begin
      SelectedEOD := FSelectedEOD;
      Show;
    end;
  finally
  end;
end;

procedure TfrmEODOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateSensorData;
  Close;
end;

procedure TfrmEODOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllEODef.ItemIndex = -1 then
  begin
    ShowMessage('Select EOD Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedEOD.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetSensor_On_Board_By_Index(5, EOD_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteEODDef(EOD_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateEODList;
  end;
end;

procedure TfrmEODOnBoardPickList.lbAllEODDefClick(Sender: TObject);
begin
  if lbAllEODef.ItemIndex = -1 then
    Exit;

  FSelectedEOD := TEOD_On_Board(lbAllEODef.Items.Objects[lbAllEODef.ItemIndex]);
end;

procedure TfrmEODOnBoardPickList.lbAlEODOnBoardClick(Sender: TObject);
begin
  if lbAllEODOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedEOD := TEOD_On_Board(lbAllEODOnBoard.Items.Objects[lbAllEODOnBoard.ItemIndex]);
end;

procedure TfrmEODOnBoardPickList.UpdateEODList;
var
  i : Integer;
  eod : TEOD_On_Board;
begin
  lbAllEODef.Items.Clear;
  lbAllEODOnBoard.Items.Clear;

  dmINWO.GetAllEODDef(FAllEODDefList);
  dmINWO.GetEODOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllEODOnBoardList);

  for i := 0 to FAllEODDefList.Count - 1 do
  begin
    eod := FAllEODDefList.Items[i];
    lbAllEODef.Items.AddObject(eod.FDef.Class_Identifier, eod);
  end;

  for i := 0 to FAllEODOnBoardList.Count - 1 do
  begin
    eod := FAllEODOnBoardList.Items[i];
    lbAllEODOnBoard.Items.AddObject(eod.FData.Instance_Identifier, eod);
  end;
end;

{$ENDREGION}


end.

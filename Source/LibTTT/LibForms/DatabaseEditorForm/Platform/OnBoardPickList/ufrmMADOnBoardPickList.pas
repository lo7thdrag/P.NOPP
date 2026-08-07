unit ufrmMADOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers;

type
  TfrmMADOnBoardPickList = class(TForm)
    lbAllMADDef: TListBox;
    lbAllMADOnBoard: TListBox;
    ImgBackgroundForm: TImage;
    btnAdd: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundOnBoard: TImage;
    btnRemove: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    btnEdit: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lblClose: TLabel;
    btnNew: TImage;
    btnUpdate: TImage;
    btnDelete: TImage;
    edtSearch: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllMADDefClick(Sender: TObject);
    procedure lbAllMADOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);


  private
    FAllMADDefList : TList;
    FAllMADOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedMAD : TMAD_On_Board;

  public
    procedure UpdateMADList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmMADOnBoardPickList: TfrmMADOnBoardPickList;

implementation

uses
  uDataModule, ufrmMADMount, ufrmAsset, ufrmSummaryMAD;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmMADOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllMADDefList := TList.Create;
  FAllMADOnBoardList := TList.Create;
end;

procedure TfrmMADOnBoardPickList.FormDestroy(Sender: TObject);
begin
  FreeItemsAndFreeList(FAllMADDefList);
  FreeItemsAndFreeList(FAllMADOnBoardList);
end;

procedure TfrmMADOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateMADList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmMADOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllMADDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmMADMount) then
    frmMADMount := TfrmMADMount.Create(Self);
  try
    with frmMADMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedMAD := FSelectedMAD;
      Show;
    end;
  finally
  end;

//  UpdateMADList;
end;

procedure TfrmMADOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllMADOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmMADMount) then
    frmMADMount := TfrmMADMount.Create(Self);
  try
    with frmMADMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedMAD := FSelectedMAD;
      Show;
    end;
  finally
  end;

//  UpdateMADList;
end;

procedure TfrmMADOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryMAD) then
    frmSummaryMAD := TfrmSummaryMAD.Create(Self);

  try
    with frmSummaryMAD do
    begin
      SelectedMAD := TMAD_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmMADOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllMADOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedMAD.FData do
  begin
    dmINWO.DeleteMADOnBoard(2, MAD_Instance_Index);
  end;

  UpdateMADList;
end;

procedure TfrmMADOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllMADDef.ItemIndex = -1 then
  begin
    ShowMessage('Silahkan pilih salah satu data MAD ... !');
    Exit;
  end;

  if not Assigned(frmSummaryMAD) then
    frmSummaryMAD := TfrmSummaryMAD.Create(Self);

  try
    with frmSummaryMAD do
    begin
      SelectedMAD := FSelectedMAD;
      Show;
    end;
  finally
  end;
end;

procedure TfrmMADOnBoardPickList.edtSearchChange(Sender: TObject);
begin
  UpdateMADList;
end;

procedure TfrmMADOnBoardPickList.edtSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    UpdateMADList;
  end;
end;

procedure TfrmMADOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateSensorData;
  Close;
end;

procedure TfrmMADOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllMADDef.ItemIndex = -1 then
  begin
    ShowMessage('Silahkan pilih salah satu data MAD ... !');
    Exit;
  end;

  warning := MessageDlg('Apakah anda akan menghapus data ini ?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedMAD.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetSensor_On_Board_By_Index(2, MAD_Index) then
      begin
        ShowMessage('Data tidak bisa dihapus, karena sedang terhubung dengan data vehicle');
        Exit;
      end;

      if dmINWO.DeleteMADDef(MAD_Index) then
        ShowMessage('Data telah berhasil dihapus');

    end;

    UpdateMADList;
  end;
end;

procedure TfrmMADOnBoardPickList.lbAllMADDefClick(Sender: TObject);
begin
  if lbAllMADDef.ItemIndex = -1 then
    Exit;

  FSelectedMAD := TMAD_On_Board(lbAllMADDef.Items.Objects[lbAllMADDef.ItemIndex]);
end;

procedure TfrmMADOnBoardPickList.lbAllMADOnBoardClick(Sender: TObject);
begin
  if lbAllMADOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedMAD := TMAD_On_Board(lbAllMADOnBoard.Items.Objects[lbAllMADOnBoard.ItemIndex]);
end;

procedure TfrmMADOnBoardPickList.UpdateMADList;
var
  i : Integer;
  mad : TMAD_On_Board;
begin
  lbAllMADDef.Items.Clear;
  lbAllMADOnBoard.Items.Clear;

  dmINWO.GetAllMADDef(FAllMADDefList);
  dmINWO.GetMADOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllMADOnBoardList);

  for i := 0 to FAllMADDefList.Count - 1 do
  begin
    mad := FAllMADDefList.Items[i];
    lbAllMADDef.Items.AddObject(mad.FDef.Class_Identifier, mad);
  end;

  for i := 0 to FAllMADOnBoardList.Count - 1 do
  begin
    mad := FAllMADOnBoardList.Items[i];
    lbAllMADOnBoard.Items.AddObject(mad.FData.Instance_Identifier, mad);
  end;
end;

{$ENDREGION}

end.

unit ufrmAcousticDecoyOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers;

type
  TfrmAcousticDecoyOnBoardPickList = class(TForm)
    lbAllAcousticDecoyDef: TListBox;
    lbAllAcousticDecoyOnBoard: TListBox;
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
    edtSearch: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllAcousticDecoyDefClick(Sender: TObject);
    procedure lbAllAcousticDecoyOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);


  private
    FAllAcousticDecoyDefList : TList;
    FAllAcousticDecoyOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedAcousticDecoy : TAcoustic_Decoy_On_Board;

  public
    procedure UpdateAcousticDecoyList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmAcousticDecoyOnBoardPickList: TfrmAcousticDecoyOnBoardPickList;

implementation

{$R *.dfm}

uses
  uDataModule, ufrmAcousticDecoyMount, ufrmAsset, ufrmSummaryAcousticDecoy;

{$REGION ' Form Handle '}

procedure TfrmAcousticDecoyOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllAcousticDecoyDefList := TList.Create;
  FAllAcousticDecoyOnBoardList := TList.Create;
end;

procedure TfrmAcousticDecoyOnBoardPickList.FormDestroy(Sender: TObject);
begin
  FreeItemsAndFreeList(FAllAcousticDecoyDefList);
  FreeItemsAndFreeList(FAllAcousticDecoyOnBoardList);
end;

procedure TfrmAcousticDecoyOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateAcousticDecoyList;
end;


{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAcousticDecoyOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllAcousticDecoyDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmAcousticDecoyMount) then
    frmAcousticDecoyMount := TfrmAcousticDecoyMount.Create(Self);
  try
    with frmAcousticDecoyMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedAcousticDecoy := FSelectedAcousticDecoy;
      Show;
    end;
  finally
  end;

//  UpdateAcousticDecoyList;
end;

procedure TfrmAcousticDecoyOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllAcousticDecoyOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmAcousticDecoyMount) then
    frmAcousticDecoyMount := TfrmAcousticDecoyMount.Create(Self);
  try
    with frmAcousticDecoyMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedAcousticDecoy := FSelectedAcousticDecoy;
      Show;
    end;
  finally
  end;

//  UpdateAcousticDecoyList;
end;

procedure TfrmAcousticDecoyOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryAcousticDecoy) then
    frmSummaryAcousticDecoy := TfrmSummaryAcousticDecoy.Create(Self);

  try
    with frmSummaryAcousticDecoy do
    begin
      SelectedAcousticDecoy := TAcoustic_Decoy_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmAcousticDecoyOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllAcousticDecoyOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedAcousticDecoy.FData do
  begin
    dmINWO.DeleteAcousticDecoyOnBoard(2, Acoustic_Instance_Index);
  end;

  UpdateAcousticDecoyList;
end;

procedure TfrmAcousticDecoyOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllAcousticDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Silahkan pilih salah satu data Acoustic Decoy ... !');
    Exit;
  end;

  if not Assigned(frmSummaryAcousticDecoy) then
    frmSummaryAcousticDecoy := TfrmSummaryAcousticDecoy.Create(Self);

  try
    with frmSummaryAcousticDecoy do
    begin
      SelectedAcousticDecoy := FSelectedAcousticDecoy;
      Show;
    end;
  finally
  end;
end;

procedure TfrmAcousticDecoyOnBoardPickList.edtSearchChange(Sender: TObject);
begin
  UpdateAcousticDecoyList;
end;

procedure TfrmAcousticDecoyOnBoardPickList.edtSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    UpdateAcousticDecoyList;
  end;
end;

procedure TfrmAcousticDecoyOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateCountermeasureData;
  Close;
end;

procedure TfrmAcousticDecoyOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllAcousticDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Silahkan pilih salah satu data  Acoustic Decoy ... !');
    Exit;
  end;

  warning := MessageDlg('Apakah anda akan menghapus data ini ?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedAcousticDecoy.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(1, Decoy_Index) then
      begin
        ShowMessage('Data tidak bisa dihapus, karena sedang terhubung dengan data vehicle');
        Exit;
      end;

      if dmINWO.DeleteAcousticDecoyDef(Decoy_Index) then
        ShowMessage('Data telah berhasil dihapus');

    end;

    UpdateAcousticDecoyList;
  end;
end;

procedure TfrmAcousticDecoyOnBoardPickList.lbAllAcousticDecoyDefClick(Sender: TObject);
begin
  if lbAllAcousticDecoyDef.ItemIndex = -1 then
    Exit;

  FSelectedAcousticDecoy := TAcoustic_Decoy_On_Board(lbAllAcousticDecoyDef.Items.Objects[lbAllAcousticDecoyDef.ItemIndex]);
end;

procedure TfrmAcousticDecoyOnBoardPickList.lbAllAcousticDecoyOnBoardClick(Sender: TObject);
begin
  if lbAllAcousticDecoyOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedAcousticDecoy := TAcoustic_Decoy_On_Board(lbAllAcousticDecoyOnBoard.Items.Objects[lbAllAcousticDecoyOnBoard.ItemIndex]);
end;

procedure TfrmAcousticDecoyOnBoardPickList.UpdateAcousticDecoyList;
var
  i, j : Integer;
  acousticdecoy, acousticdecoyonboard : TAcoustic_Decoy_On_Board;
  found : Boolean;
begin
  lbAllAcousticDecoyDef.Items.Clear;
  lbAllAcousticDecoyOnBoard.Items.Clear;

  dmINWO.GetAllAcousticDecoyDef(FAllAcousticDecoyDefList);
  dmINWO.GetAcousticDecoyOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllAcousticDecoyOnBoardList);

  {$REGION ' Print Available '}
  for i := 0 to FAllAcousticDecoyDefList.Count - 1 do
  begin
    acousticdecoy := FAllAcousticDecoyDefList.Items[i];

    found := False;
    for j := 0 to FAllAcousticDecoyOnBoardList.Count - 1 do
    begin
      acousticdecoyonboard := FAllAcousticDecoyOnBoardList.Items[j];

      if acousticdecoyonboard.FDef.Decoy_Index = acousticdecoy.FDef.Decoy_Index then
      begin
        found := True;
        Break;
      end;
    end;

    if not found then
      lbAllAcousticDecoyDef.Items.AddObject(acousticdecoy.FDef.Decoy_Identifier, acousticdecoy);

  end;
  {$ENDREGION}

  {$REGION ' Print Onboard '}
  for j := 0 to FAllAcousticDecoyOnBoardList.Count - 1 do
  begin
    acousticdecoyonboard := FAllAcousticDecoyOnBoardList.Items[j];
    lbAllAcousticDecoyOnBoard.Items.AddObject(acousticdecoy.FData.Instance_Identifier, acousticdecoy);
  end;
  {$ENDREGION}

  for i := 0 to FAllAcousticDecoyDefList.Count - 1 do
  begin
    acousticdecoy := FAllAcousticDecoyDefList.Items[i];

  end;

  for i := 0 to FAllAcousticDecoyOnBoardList.Count - 1 do
  begin
    acousticdecoy := FAllAcousticDecoyOnBoardList.Items[i];
    lbAllAcousticDecoyOnBoard.Items.AddObject(acousticdecoy.FData.Instance_Identifier, acousticdecoy);
  end;
end;

{$ENDREGION}

end.

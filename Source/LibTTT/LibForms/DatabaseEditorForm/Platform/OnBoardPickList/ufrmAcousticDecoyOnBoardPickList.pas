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

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmAcousticDecoyOnBoardPickList.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllAcousticDecoyDefList);
//  FreeItemsAndFreeList(FAllAcousticDecoyOnBoardList);
//  Action := cafree;
end;

procedure TfrmAcousticDecoyOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllAcousticDecoyDefList := TList.Create;
  FAllAcousticDecoyOnBoardList := TList.Create;
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
    ShowMessage('Select AcousticDecoy Data ... !');
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
    ShowMessage('Select AcousticDecoy Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedAcousticDecoy.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(1, Decoy_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteAcousticDecoyDef(Decoy_Index) then
        ShowMessage('Data has been deleted');

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
  i : Integer;
  acousticdecoy : TAcoustic_Decoy_On_Board;
begin
  lbAllAcousticDecoyDef.Items.Clear;
  lbAllAcousticDecoyOnBoard.Items.Clear;

  dmINWO.GetAllAcousticDecoyDef(FAllAcousticDecoyDefList);
  dmINWO.GetAcousticDecoyOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllAcousticDecoyOnBoardList);

  for i := 0 to FAllAcousticDecoyDefList.Count - 1 do
  begin
    acousticdecoy := FAllAcousticDecoyDefList.Items[i];
    lbAllAcousticDecoyDef.Items.AddObject(acousticdecoy.FDef.Decoy_Identifier, acousticdecoy);
  end;

  for i := 0 to FAllAcousticDecoyOnBoardList.Count - 1 do
  begin
    acousticdecoy := FAllAcousticDecoyOnBoardList.Items[i];
    lbAllAcousticDecoyOnBoard.Items.AddObject(acousticdecoy.FData.Instance_Identifier, acousticdecoy);
  end;
end;

{$ENDREGION}

end.

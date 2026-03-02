unit ufrmInfraredDecoyOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers ;

type
  TfrmInfraredDecoyOnBoardPickList = class(TForm)
    lbAllInfraredDecoyDef: TListBox;
    lbAllInfraredDecoyOnBoard: TListBox;
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

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllInfraredDecoyDefClick(Sender: TObject);
    procedure lbAllInfraredDecoyOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);

  private
    FAllInfraredDecoyDefList : TList;
    FAllInfraredDecoyOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedInfraredDecoy : TInfrared_Decoy_On_Board;

  public
    procedure UpdateInfraredDecoyList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmInfraredDecoyOnBoardPickList: TfrmInfraredDecoyOnBoardPickList;

implementation

uses
  uDataModule, ufrmInfraRedmount, ufrmAsset, ufrmSummaryInfraredDecoy;


{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmInfraredDecoyOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllInfraredDecoyDefList);
//  FreeItemsAndFreeList(FAllInfraredDecoyOnBoardList);
//  Action := cafree;
end;

procedure TfrmInfraredDecoyOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllInfraredDecoyDefList := TList.Create;
  FAllInfraredDecoyOnBoardList := TList.Create;
end;

procedure TfrmInfraredDecoyOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateInfraredDecoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmInfraredDecoyOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllInfraredDecoyDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmInfraredmount) then
    frmInfraredmount := TfrmInfraredmount.Create(Self);
  try
    with frmInfraredmount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedInfraredDecoy := FSelectedInfraredDecoy;
      Show;
    end;
  finally
  end;

//  UpdateInfraredDecoyList;
end;

procedure TfrmInfraredDecoyOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllInfraredDecoyOnBoard.ItemIndex = -1 then
    Exit;

 if not Assigned(frmInfraredmount) then
    frmInfraredmount := TfrmInfraredmount.Create(Self);
  try
    with frmInfraRedmount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedInfraredDecoy := FSelectedInfraredDecoy;
      Show;
    end;
  finally
  end;

//  UpdateInfraredDecoyList;
end;

procedure TfrmInfraredDecoyOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryInfraredDecoy) then
    frmSummaryInfraredDecoy := TfrmSummaryInfraredDecoy.Create(Self);

  try
    with frmSummaryInfraredDecoy do
    begin
      SelectedInfraredDecoy := TInfrared_Decoy_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmInfraredDecoyOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllInfraredDecoyOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedInfraredDecoy.FData do
  begin
    dmINWO.DeleteInfraredDecoyOnBoard(2, Infrared_Decoy_Instance_Index);
  end;

//  UpdateInfraredDecoyList;
end;

procedure TfrmInfraredDecoyOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllInfraredDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select InfraredDecoy Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryInfraredDecoy) then
    frmSummaryInfraredDecoy := TfrmSummaryInfraredDecoy.Create(Self);

  try
    with frmSummaryInfraredDecoy do
    begin
      SelectedInfraredDecoy := FSelectedInfraredDecoy;
      Show;
    end;
  finally
  end;
end;

procedure TfrmInfraredDecoyOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateCountermeasureData;
  Close;
end;

procedure TfrmInfraredDecoyOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllInfraredDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select InfraredDecoy Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedInfraredDecoy.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(4, Infrared_Decoy_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteInfraredDecoyDef(Infrared_Decoy_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateInfraredDecoyList;
  end;
end;

procedure TfrmInfraredDecoyOnBoardPickList.lbAllInfraredDecoyDefClick(Sender: TObject);
begin
  if lbAllInfraredDecoyDef.ItemIndex = -1 then
    Exit;

  FSelectedInfraredDecoy := TInfrared_Decoy_On_Board(lbAllInfraredDecoyDef.Items.Objects[lbAllInfraredDecoyDef.ItemIndex]);
end;

procedure TfrmInfraredDecoyOnBoardPickList.lbAllInfraredDecoyOnBoardClick(Sender: TObject);
begin
  if lbAllInfraredDecoyOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedInfraredDecoy := TInfrared_Decoy_On_Board(lbAllInfraredDecoyOnBoard.Items.Objects[lbAllInfraredDecoyOnBoard.ItemIndex]);
end;

procedure TfrmInfraredDecoyOnBoardPickList.UpdateInfraredDecoyList;
var
  i : Integer;
  infrareddecoy : TInfrared_Decoy_On_Board;
begin
  lbAllInfraredDecoyDef.Items.Clear;
  lbAllInfraredDecoyOnBoard.Items.Clear;

  dmINWO.GetAllInfraredDecoyDef(FAllInfraredDecoyDefList);
  dmINWO.GetInfraredDecoyOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllInfraredDecoyOnBoardList);

  for i := 0 to FAllInfraredDecoyDefList.Count - 1 do
  begin
    infrareddecoy := FAllInfraredDecoyDefList.Items[i];
    lbAllInfraredDecoyDef.Items.AddObject(infrareddecoy.FDef.Infrared_Decoy_Identifier, infrareddecoy);
  end;

  for i := 0 to FAllInfraredDecoyOnBoardList.Count - 1 do
  begin
    infrareddecoy := FAllInfraredDecoyOnBoardList.Items[i];
    lbAllInfraredDecoyOnBoard.Items.AddObject(infrareddecoy.FData.Instance_Identifier, infrareddecoy);
  end;
end;

{$ENDREGION}

end.

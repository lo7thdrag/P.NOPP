unit ufrmFloatingDecoyOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers ;

type
  TfrmFloatingDecoyOnBoardPickList = class(TForm)
    lbAllFloatingDecoyDef: TListBox;
    lbAllFloatingDecoyOnBoard: TListBox;
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

    procedure lbAllFloatingDecoyDefClick(Sender: TObject);
    procedure lbAllFloatingDecoyOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);

  private
    FAllFloatingDecoyDefList : TList;
    FAllFloatingDecoyOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedFloatingDecoy : TFloating_Decoy_On_Board;

  public
    procedure UpdateFloatingDecoyList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmFloatingDecoyOnBoardPickList: TfrmFloatingDecoyOnBoardPickList;

implementation

uses
  uDataModule, ufrmFloatingDecoyMount, ufrmAsset, ufrmSummaryFloatingDecoy ;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmFloatingDecoyOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllFloatingDecoyDefList);
//  FreeItemsAndFreeList(FAllFloatingDecoyOnBoardList);
//  Action := cafree;
end;

procedure TfrmFloatingDecoyOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllFloatingDecoyDefList := TList.Create;
  FAllFloatingDecoyOnBoardList := TList.Create;
end;

procedure TfrmFloatingDecoyOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateFloatingDecoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmFloatingDecoyOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllFloatingDecoyDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmFloatingDecoyMount) then
    frmFloatingDecoyMount := TfrmFloatingDecoyMount.Create(Self);
  try
    with frmFloatingDecoyMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedFloatingDecoy := FSelectedFloatingDecoy;
      Show;
    end;
  finally
  end;

//  UpdateFloatingDecoyList;
end;

procedure TfrmFloatingDecoyOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllFloatingDecoyOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmFloatingDecoyMount) then
    frmFloatingDecoyMount := TfrmFloatingDecoyMount.Create(Self);
  try
    with frmFloatingDecoyMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedFloatingDecoy := FSelectedFloatingDecoy;
      Show;
    end;
  finally
  end;

//  UpdateFloatingDecoyList;
end;

procedure TfrmFloatingDecoyOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryFloatingDecoy) then
    frmSummaryFloatingDecoy := TfrmSummaryFloatingDecoy.Create(Self);

  try
    with frmSummaryFloatingDecoy do
    begin
      SelectedFloatingDecoy := TFloating_Decoy_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmFloatingDecoyOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllFloatingDecoyOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedFloatingDecoy.FData do
  begin
    dmINWO.DeleteFloatingDecoyOnBoard(2,Floating_Decoy_Instance_Index);
  end;

  UpdateFloatingDecoyList;
end;

procedure TfrmFloatingDecoyOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllFloatingDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select FloatingDecoy Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryFloatingDecoy) then
    frmSummaryFloatingDecoy := TfrmSummaryFloatingDecoy.Create(Self);

  try
    with frmSummaryFloatingDecoy do
    begin
      FSelectedFloatingDecoy := FSelectedFloatingDecoy;
      Show;
    end;
  finally
  end;
end;

procedure TfrmFloatingDecoyOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateCountermeasureData;
  Close;
end;

procedure TfrmFloatingDecoyOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllFloatingDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select FloatingDecoy Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedFloatingDecoy.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(1, Floating_Decoy_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteFloatingDecoyDef(Floating_Decoy_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateFloatingDecoyList;
  end;
end;

procedure TfrmFloatingDecoyOnBoardPickList.lbAllFloatingDecoyDefClick(Sender: TObject);
begin
  if lbAllFloatingDecoyDef.ItemIndex = -1 then
    Exit;

  FSelectedFloatingDecoy := TFloating_Decoy_On_Board(lbAllFloatingDecoyDef.Items.Objects[lbAllFloatingDecoyDef.ItemIndex]);
end;

procedure TfrmFloatingDecoyOnBoardPickList.lbAllFloatingDecoyOnBoardClick(Sender: TObject);
begin
  if lbAllFloatingDecoyOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedFloatingDecoy := TFloating_Decoy_On_Board(lbAllFloatingDecoyOnBoard.Items.Objects[lbAllFloatingDecoyOnBoard.ItemIndex]);
end;

procedure TfrmFloatingDecoyOnBoardPickList.UpdateFloatingDecoyList;
var
  i : Integer;
  floatingdecoy : TFloating_Decoy_On_Board;
begin
  lbAllFloatingDecoyDef.Items.Clear;
  lbAllFloatingDecoyOnBoard.Items.Clear;

  dmINWO.GetAllFloatingDecoyDef(FAllFloatingDecoyDefList);
  dmINWO.GetFloatingDecoyOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllFloatingDecoyOnBoardList);

  for i := 0 to FAllFloatingDecoyDefList.Count - 1 do
  begin
    floatingdecoy := FAllFloatingDecoyDefList.Items[i];
    lbAllFloatingDecoyDef.Items.AddObject(floatingdecoy.FDef.Floating_Decoy_Identifier, floatingdecoy);
  end;

  for i := 0 to FAllFloatingDecoyOnBoardList.Count - 1 do
  begin
    floatingdecoy := FAllFloatingDecoyOnBoardList.Items[i];
    lbAllFloatingDecoyOnBoard.Items.AddObject(floatingdecoy.FData.Instance_Identifier, floatingdecoy);
  end;
end;

{$ENDREGION}



end.

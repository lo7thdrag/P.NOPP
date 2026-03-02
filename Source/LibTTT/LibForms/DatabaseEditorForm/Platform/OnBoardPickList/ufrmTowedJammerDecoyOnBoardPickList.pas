unit ufrmTowedJammerDecoyOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers ;

type
  TfrmTowedJammerDecoyOnBoardPickList = class(TForm)
    lbAllTowedJammerDecoyDef: TListBox;
    lbAllTowedJammerDecoyOnBoard: TListBox;
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

    procedure lbAllTowedJammerDecoyDefClick(Sender: TObject);
    procedure lbAllTowedJammerDecoyOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);


  private
    FAllTowedJammerDecoyDefList : TList;
    FAllTowedJammerDecoyOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedTowedJammerDecoy : TTowed_Decoy_On_Board;

  public
    procedure UpdateTowedJammerDecoyList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmTowedJammerDecoyOnBoardPickList: TfrmTowedJammerDecoyOnBoardPickList;

implementation

uses
  uDataModule, ufrmTowedJammerMount, ufrmAsset, ufrmSummaryTowedJammerDecoy ;


{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmTowedJammerDecoyOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllTowedJammerDecoyDefList);
//  FreeItemsAndFreeList(FAllTowedJammerDecoyOnBoardList);
//  Action := cafree;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllTowedJammerDecoyDefList := TList.Create;
  FAllTowedJammerDecoyOnBoardList := TList.Create;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateTowedJammerDecoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmTowedJammerDecoyOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllTowedJammerDecoyDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmTowedJammerMount) then
    frmTowedJammerMount := TfrmTowedJammerMount.Create(Self);
  try
    with frmTowedJammerMount do
    begin
      SelectedVehicle := FSelectedVehicle;
       SelectedTowedJammerDecoy := FSelectedTowedJammerDecoy;
      Show;
    end;
  finally
  end;

//  UpdateTowedJammerDecoyList;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllTowedJammerDecoyOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmTowedJammerMount) then
    frmTowedJammerMount := TfrmTowedJammerMount.Create(Self);
  try
    with frmTowedJammerMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedTowedJammerDecoy := FSelectedTowedJammerDecoy;
      Show;
    end;
  finally
  end;
//  UpdateTowedJammerDecoyList;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryTowedjammerDecoy) then
    frmSummaryTowedjammerDecoy := TfrmSummaryTowedjammerDecoy.Create(Self);

  try
    with frmSummaryTowedjammerDecoy do
    begin
      SelectedTowedjammerDecoy := TTowed_Decoy_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllTowedJammerDecoyOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedTowedJammerDecoy.FData do
  begin
    dmINWO.DeleteTowedJammerDecoyOnBoard(2, Towed_Decoy_Instance_Index);
  end;

//  UpdateTowedJammerDecoyList;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllTowedjammerDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select TowedjammerDecoy Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryTowedjammerDecoy) then
    frmSummaryTowedjammerDecoy := TfrmSummaryTowedjammerDecoy.Create(Self);

  try
    with frmSummaryTowedjammerDecoy do
    begin
      SelectedTowedjammerDecoy := FSelectedTowedjammerDecoy;
      Show;
    end;
  finally
  end;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateCountermeasureData;
  Close;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllTowedjammerDecoyDef.ItemIndex = -1 then
  begin
    ShowMessage('Select TowedjammerDecoy Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedTowedjammerDecoy.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(7, Towed_Decoy_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteTowedDecoyDef(Towed_Decoy_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateTowedjammerDecoyList;
  end;
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.lbAllTowedJammerDecoyDefClick(Sender: TObject);
begin
  if lbAllTowedJammerDecoyDef.ItemIndex = -1 then
    Exit;

  FSelectedTowedJammerDecoy := TTowed_Decoy_On_Board(lbAllTowedJammerDecoyDef.Items.Objects[lbAllTowedJammerDecoyDef.ItemIndex]);
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.lbAllTowedJammerDecoyOnBoardClick(Sender: TObject);
begin
  if lbAllTowedJammerDecoyOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedTowedJammerDecoy := TTowed_Decoy_On_Board(lbAllTowedJammerDecoyOnBoard.Items.Objects[lbAllTowedJammerDecoyOnBoard.ItemIndex]);
end;

procedure TfrmTowedJammerDecoyOnBoardPickList.UpdateTowedJammerDecoyList;
var
  i : Integer;
  towedjammerdecoy : TTowed_Decoy_On_Board;
begin
  lbAllTowedJammerDecoyDef.Items.Clear;
  lbAllTowedJammerDecoyOnBoard.Items.Clear;

  dmINWO.GetAllTowedDecoyDef(FAllTowedJammerDecoyDefList);
  dmINWO.GetTowedJammerDecoyOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllTowedJammerDecoyOnBoardList);

  for i := 0 to FAllTowedJammerDecoyDefList.Count - 1 do
  begin
    towedjammerdecoy := FAllTowedJammerDecoyDefList.Items[i];
    lbAllTowedJammerDecoyDef.Items.AddObject(towedjammerdecoy.FDef.Towed_Decoy_Identifier, towedjammerdecoy);
  end;

  for i := 0 to FAllTowedJammerDecoyOnBoardList.Count - 1 do
  begin
    towedjammerdecoy := FAllTowedJammerDecoyOnBoardList.Items[i];
    lbAllTowedJammerDecoyOnBoard.Items.AddObject(towedjammerdecoy.FData.Instance_Identifier, towedjammerdecoy);
  end;
end;

{$ENDREGION}

end.

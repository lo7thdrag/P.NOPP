unit ufrmAirBubbleOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers ;

type
  TfrmAirBubbleOnBoardPickList = class(TForm)
    lbAllAirBubbleDef: TListBox;
    lbAllAirBubbleOnBoard: TListBox;
    btnAdd: TImage;
    btnEdit: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label3: TLabel;
    Label4: TLabel;
    lblClose: TLabel;
    btnUpdate: TImage;
    btnNew: TImage;
    btnDelete: TImage;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllAirBubbleDefClick(Sender: TObject);
    procedure lbAllAirBubbleOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);


  private
    FAllAirBubbleDefList : TList;
    FAllAirBubbleOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedAirBubble : TAir_Bubble_On_Board;

  public
    procedure UpdateAirBubbleList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmAirBubbleOnBoardPickList: TfrmAirBubbleOnBoardPickList;

implementation

{$R *.dfm}

uses
  uDataModule, ufrmAirBubbleMount, ufrmAsset, ufrmSummaryAirBubble;

{$REGION ' Form Handle '}

procedure TfrmAirBubbleOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllAirBubbleDefList);
//  FreeItemsAndFreeList(FAllAirBubbleOnBoardList);
//  Action := cafree;
end;

procedure TfrmAirBubbleOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllAirBubbleDefList := TList.Create;
  FAllAirBubbleOnBoardList := TList.Create;
end;

procedure TfrmAirBubbleOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateAirBubbleList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAirBubbleOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllAirBubbleDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmAirBubbleMount) then
    frmAirBubbleMount := TfrmAirBubbleMount.Create(Self);
  try
    with frmAirBubbleMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedAirBubble := FSelectedAirBubble;
      Show;
    end;
  finally
  end;

//  UpdateAirBubbleList;
end;

procedure TfrmAirBubbleOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllAirBubbleOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmAirBubbleMount) then
    frmAirBubbleMount := TfrmAirBubbleMount.Create(Self);
  try
    with frmAirBubbleMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedAirBubble := FSelectedAirBubble;
      Show;
    end;
  finally
  end;

//  UpdateAirBubbleList;
end;

procedure TfrmAirBubbleOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryAirBubble) then
    frmSummaryAirBubble := TfrmSummaryAirBubble.Create(Self);

  try
    with frmSummaryAirBubble do
    begin
      SelectedAirBubble := TAir_Bubble_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmAirBubbleOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllAirBubbleOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedAirBubble.FData do
  begin
    dmINWO.DeleteAirBubbleOnBoard(2, Air_Bubble_Instance_Index);
  end;

  UpdateAirBubbleList;
end;

procedure TfrmAirBubbleOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllAirBubbleDef.ItemIndex = -1 then
  begin
    ShowMessage('Select AirBubble Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryAirBubble) then
    frmSummaryAirBubble := TfrmSummaryAirBubble.Create(Self);

  try
    with frmSummaryAirBubble do
    begin
      SelectedAirBubble := FSelectedAirBubble;
      Show;
    end;
  finally
  end;
end;

procedure TfrmAirBubbleOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateCountermeasureData;
  Close;
end;

procedure TfrmAirBubbleOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllAirBubbleDef.ItemIndex = -1 then
  begin
    ShowMessage('Select AirBubble Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedAirBubble.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(2, Air_Bubble_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteAirBubbleDef(Air_Bubble_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateAirBubbleList;
  end;
end;

procedure TfrmAirBubbleOnBoardPickList.lbAllAirBubbleDefClick(Sender: TObject);
begin
  if lbAllAirBubbleDef.ItemIndex = -1 then
    Exit;

  FSelectedAirBubble := TAir_Bubble_On_Board(lbAllAirBubbleDef.Items.Objects[lbAllAirBubbleDef.ItemIndex]);
end;

procedure TfrmAirBubbleOnBoardPickList.lbAllAirBubbleOnBoardClick(Sender: TObject);
begin
  if lbAllAirBubbleOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedAirBubble := TAir_Bubble_On_Board(lbAllAirBubbleOnBoard.Items.Objects[lbAllAirBubbleOnBoard.ItemIndex]);
end;

procedure TfrmAirBubbleOnBoardPickList.UpdateAirBubbleList;
var
  i : Integer;
  airbubble : TAir_Bubble_On_Board;
begin
  lbAllAirBubbleDef.Items.Clear;
  lbAllAirBubbleOnBoard.Items.Clear;

  dmINWO.GetAllAirBubbleDef(FAllAirBubbleDefList);
  dmINWO.GetAirBubbleOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllAirBubbleOnBoardList);

  for i := 0 to FAllAirBubbleDefList.Count - 1 do
  begin
    airbubble := FAllAirBubbleDefList.Items[i];
    lbAllAirBubbleDef.Items.AddObject(airbubble.FDef.Air_Bubble_Identifier, airbubble);
  end;

  for i := 0 to FAllAirBubbleOnBoardList.Count - 1 do
  begin
    airbubble := FAllAirBubbleOnBoardList.Items[i];
    lbAllAirBubbleOnBoard.Items.AddObject(airbubble.FData.Instance_Identifier, airbubble);
  end;
end;

{$ENDREGION}

end.

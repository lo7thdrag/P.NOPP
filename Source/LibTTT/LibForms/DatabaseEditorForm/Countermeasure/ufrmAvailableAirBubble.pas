unit ufrmAvailableAirBubble;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Countermeasure, uDataModule, uSimContainers, ufrmSummaryAirBubble, ufrmUsage;

type
  TfrmAvailableAirBubble = class(TForm)
    btnCopy: TImage;
    btnDelete: TImage;
    btnEdit: TImage;
    btnNew: TImage;
    btnUsage: TImage;
    edtCheat: TEdit;
    ImgBackgroundForm: TImage;
    lblClose: TLabel;
    lblPlatform: TLabel;
    lblsearch: TLabel;
    lbxAirBubble: TListBox;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbSingleClick(Sender: TObject);

    procedure btnNewClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUsageClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtCheatKeyPress(Sender: TObject; var Key: Char);


  private
    FUpdateList : Boolean;
    FAirBubbleList : TList; {ini disesuaikan}
    FSelectedAirBubble : TAir_Bubble_On_Board; {ini disesuaikan}

    procedure UpdateAirbubbleList;

  end;

var
  frmAvailableAirBubble: TfrmAvailableAirBubble;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableAirBubble.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FAirBubbleList);
  Action := cafree;
end;

procedure TfrmAvailableAirBubble.FormCreate(Sender: TObject);
begin
  FAirBubbleList := TList.Create;
end;

procedure TfrmAvailableAirBubble.FormShow(Sender: TObject);
begin
  UpdateAirBubbleList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableAirBubble.btnNewClick(Sender: TObject);
begin
  frmSummaryAirBubble := TfrmSummaryAirBubble.Create(Self);
  try
    with frmSummaryAirBubble do
    begin
      SelectedAirBubble := TAir_Bubble_On_Board.Create;
      ShowModal;
      SelectedAirBubble.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryAirBubble.Free;
  end;

  if FUpdateList then
    UpdateAirBubbleList;
end;

procedure TfrmAvailableAirBubble.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableAirBubble.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;

begin
  if lbxAirBubble.ItemIndex = -1 then {ini disesuaikan}
  begin
    ShowMessage('Select Air Bubble... !');
    Exit;
  end;

  with FSelectedAirBubble do
  begin
    newClassName := FDef.Air_Bubble_Identifier + ' - Copy';

    count := dmINWO.GetAirBubbleDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Air_Bubble_Identifier := newClassName;

    dmINWO.InsertAirBubbleDef(FDef);
    dmINWO.InsertNoteStorage(Byte(stAirBubble), FDef.Air_Bubble_Index, FNote); {ini disesuaikan}
  end;

  UpdateAirBubbleList;
end;

procedure TfrmAvailableAirBubble.btnEditClick(Sender: TObject);
begin
  if lbxAirBubble.ItemIndex = -1 then
  begin
    ShowMessage('Select Air Bubble... !');
    Exit;
  end;

  frmSummaryAirBubble := TfrmSummaryAirBubble.Create(Self);
  try
    with frmSummaryAirBubble do
    begin
      SelectedAirBubble := FSelectedAirBubble;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryAirBubble.Free;
  end;

  if FUpdateList then
    UpdateAirBubbleList;
end;

procedure TfrmAvailableAirBubble.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxAirBubble.ItemIndex = -1 then
  begin
    ShowMessage('Select Air Bubble... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedAirBubble.FDef do
    begin
      {Pengecekan Relasi Dengan Tabel On Board}
//      if dmINWO.GetCountermeasure_On_Board_By_Index(2, Air_Bubble_Index) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some Vehicles');
//        Exit;
//      end;

      dmINWO.DeleteNoteStorage(21, Air_Bubble_Index);

      if dmINWO.DeleteAirBubbleDef(Air_Bubble_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateAirBubbleList;
  end;
end;

procedure TfrmAvailableAirBubble.btnUsageClick(Sender: TObject);
begin
  if lbxAirBubble.ItemIndex = -1 then
  begin
    ShowMessage('Select Air Bubble... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex  := FSelectedAirBubble.FDef.Air_Bubble_Index;
      AssetName   := FSelectedAirBubble.FDef.Air_Bubble_Identifier;
      AssetTitle  := 'On Board Vehicle:';
      AssetType   := stAirBubble;

      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;
  
end;

procedure TfrmAvailableAirBubble.edtCheatKeyPress(Sender: TObject;
  var Key: Char);
var
  i : Integer;
  airbubble : TAir_Bubble_On_Board;
begin
  if Key = #13 then
  begin
    lbxAirBubble.Items.Clear; {disesuaikan}

    dmINWO.GetFilterAirBubbleDef(FAirBubbleList, edtCheat.text);

    for i := 0 to FAirBubbleList.Count - 1 do
    begin
      airbubble := FAirBubbleList.Items[i];
      lbxAirBubble.Items.AddObject(airbubble.FDef.Air_Bubble_Identifier, airbubble);
    end;
  end;
end;

procedure TfrmAvailableAirBubble.lbSingleClick(Sender: TObject);
begin
  if lbxAirBubble.ItemIndex = -1 then {disesuaikan}
    Exit;

  FSelectedAirBubble := TAir_Bubble_On_Board(lbxAirBubble.Items.Objects[lbxAirBubble.ItemIndex]); {disesuaikan}
end;

procedure TfrmAvailableAirBubble.UpdateAirBubbleList;
var
  i : Integer;
  airbubble : TAir_Bubble_On_Board;
begin
  lbxAirBubble.Items.Clear; {disesuaikan}

  dmINWO.GetAllAirBubbleDef(FAirBubbleList);

  for i := 0 to FAirBubbleList.Count - 1 do
  begin
    airbubble := FAirBubbleList.Items[i];
    lbxAirBubble.Items.AddObject(airbubble.FDef.Air_Bubble_Identifier, airbubble);
  end;
end;

{$ENDREGION}

end.

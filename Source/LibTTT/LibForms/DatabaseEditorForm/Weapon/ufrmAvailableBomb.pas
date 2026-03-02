unit ufrmAvailableBomb;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Weapon, uDataModule, uSimContainers, ufrmSummaryBomb, ufrmUsage;

type
  TfrmAvailableBomb = class(TForm)
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
    lbxBomb: TListBox;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbSingleClick(Sender: TObject);

    procedure btnNewClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUsageClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCheatKeyPress(Sender: TObject; var Key: Char);

  private
    FUpdateList : Boolean;
    FBombList : TList;
    FSelectedBomb : TBomb_On_Board;

    procedure UpdateBombList;
  end;

var
  frmAvailableBomb: TfrmAvailableBomb;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableBomb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FBombList);
  Action := cafree;
end;

procedure TfrmAvailableBomb.FormCreate(Sender: TObject);
begin
  FBombList := TList.Create;
end;

procedure TfrmAvailableBomb.FormShow(Sender: TObject);
begin
  UpdateBombList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableBomb.btnNewClick(Sender: TObject);
begin
  frmSummaryBomb := TfrmSummaryBomb.Create(Self);
  try
    with frmSummaryBomb do
    begin
      SelectedBomb := TBomb_On_Board.Create;
      ShowModal;
      SelectedBomb.Free;
      FUpdateList := AfterClose;
    end;

  finally
    frmSummaryBomb.Free;
  end;

  if FUpdateList then
    UpdateBombList;
end;

procedure TfrmAvailableBomb.btnCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmAvailableBomb.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
  idTemp : Integer;

begin
  if lbxBomb.ItemIndex = -1 then
  begin
    ShowMessage('Select Bomb... !');
    Exit;
  end;

  with FSelectedBomb do
  begin
    newClassName := FDef.Bomb_Identifier + ' - Copy';

    count := dmINWO.GetBombDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Bomb_Identifier := newClassName;
    idTemp :=FDef.Bomb_Index;

    dmINWO.InsertBombDef(FDef);
    dmINWO.InsertNoteStorage(Byte(stBomb), FDef.Bomb_Index, FNote);

  end;

  UpdateBombList;
end;

procedure TfrmAvailableBomb.btnEditClick(Sender: TObject);
begin
  if lbxBomb.ItemIndex = -1 then
    Exit;

  frmSummaryBomb := TfrmSummaryBomb.Create(Self);
  try
    with frmSummaryBomb do
    begin
      SelectedBomb := FSelectedBomb;
      ShowModal;
      FUpdateList := AfterClose;
    end;

  finally
    frmSummaryBomb.Free;
  end;

  if FUpdateList then
    UpdateBombList;
end;

procedure TfrmAvailableBomb.btnDeleteClick(Sender: TObject);
var
  warning : Integer;

begin
  if lbxBomb.ItemIndex = -1 then
  begin
    ShowMessage('Select Bomb... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedBomb.FDef do
    begin
      dmINWO.DeleteNoteStorage(14, Bomb_Index);

      if dmINWO.DeleteBOmbDef(Bomb_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateBombList;
  end;
end;

procedure TfrmAvailableBomb.btnUsageClick(Sender: TObject);
begin
  if lbxBomb.ItemIndex = -1 then
    Exit;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedBomb.FDef.Bomb_Index;
      AssetName := FSelectedBomb.FDef.Bomb_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stBomb;

      ShowModal;
    end;

  finally
    frmUsage.Free;
  end;

end;

procedure TfrmAvailableBomb.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  bomb : TBomb_On_Board;
begin
  if Key = #13 then
  begin
    lbxBomb.Items.Clear;

    dmINWO.GetFilterBombDef(FBombList, edtCheat.text);

    for i := 0 to FBombList.Count - 1 do
    begin
      bomb := FBombList.Items[i];
      lbxBomb.Items.AddObject(bomb.FDef.Bomb_Identifier, bomb);
    end;
  end;
end;

procedure TfrmAvailableBomb.lbSingleClick(Sender: TObject);
begin
  if lbxBomb.ItemIndex = -1 then
    Exit;

  FSelectedBomb := TBomb_On_Board(lbxBomb.Items.Objects[lbxBomb.ItemIndex]);
end;

procedure TfrmAvailableBomb.UpdateBombList;
var
  i : Integer;
  bomb : TBomb_On_Board;

begin
  lbxBomb.Items.Clear;

  dmINWO.GetAllBombDef(FBombList);

  for i := 0 to FBombList.Count - 1 do
  begin
    bomb := FBombList.Items[i];
    lbxBomb.Items.AddObject(bomb.FDef.Bomb_Identifier, bomb);
  end;
end;

{$ENDREGION}

end.

unit ufrmAvailableTowedJammerDecoy;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Countermeasure, uDataModule, uSimContainers, ufrmSummaryTowedJammerDecoy, ufrmUsage;

type
  TfrmAvailableTowedJammerDecoy = class(TForm)
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
    lbxTowedDecoy: TListBox;

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
    FTowedJammerDecoyList : TList;
    FSelectedTowedJammerDecoy : TTowed_Decoy_On_Board;

    procedure UpdateTowedJammerDecoyList;

  end;

var
  frmAvailableTowedJammerDecoy: TfrmAvailableTowedJammerDecoy;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableTowedJammerDecoy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FTowedJammerDecoyList);
  Action := cafree;
end;

procedure TfrmAvailableTowedJammerDecoy.FormCreate(Sender: TObject);
begin
  FTowedJammerDecoyList := TList.Create;
end;

procedure TfrmAvailableTowedJammerDecoy.FormShow(Sender: TObject);
begin
  UpdateTowedJammerDecoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableTowedJammerDecoy.btnNewClick(Sender: TObject);
begin
  frmSummaryTowedJammerDecoy := TfrmSummaryTowedJammerDecoy.Create(Self);
  try
    with frmSummaryTowedJammerDecoy do
    begin
      SelectedTowedJammerDecoy := TTowed_Decoy_On_Board.Create;
      ShowModal;
      SelectedTowedJammerDecoy.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryTowedJammerDecoy.Free;
  end;

  if FUpdateList then
    UpdateTowedJammerDecoyList;
end;

procedure TfrmAvailableTowedJammerDecoy.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableTowedJammerDecoy.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
begin
  if lbxTowedDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Towed Jammer Decoy... !');
    Exit;
  end;

  with FSelectedTowedJammerDecoy do
  begin
    newClassName := fdef.Towed_Decoy_Identifier + ' - Copy';

    count := dmINWO.GetTowedDecoyDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Towed_Decoy_Identifier := newClassName;

    dmINWO.InsertTowedDecoyDef(FDef);
    dmINWO.InsertNoteStorage(17, FDef.Towed_Decoy_Index, FNote);
  end;

  UpdateTowedJammerDecoyList;
end;

procedure TfrmAvailableTowedJammerDecoy.btnEditClick(Sender: TObject);
begin
  if lbxTowedDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Towed Jammer Decoy... !');
    Exit;
  end;

  frmSummaryTowedJammerDecoy := TfrmSummaryTowedJammerDecoy.Create(Self);
  try
    with frmSummaryTowedJammerDecoy do
    begin
      SelectedTowedJammerDecoy := FSelectedTowedJammerDecoy;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryTowedJammerDecoy.Free;
  end;

  if FUpdateList then
    UpdateTowedJammerDecoyList;
end;

procedure TfrmAvailableTowedJammerDecoy.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxTowedDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Towed Jammer Decoy... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedTowedJammerDecoy.FDef do
    begin
//      if dmINWO.GetCountermeasure_On_Board_By_Index(7, Towed_Decoy_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some Vehicles');
        Exit;
      end;

      dmINWO.DeleteNoteStorage(17, Towed_Decoy_Index);

      if dmINWO.DeleteTowedDecoyDef(Towed_Decoy_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateTowedJammerDecoyList;
  end;
end;

procedure TfrmAvailableTowedJammerDecoy.btnUsageClick(Sender: TObject);
begin
  if lbxTowedDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Towed Jammer Decoy... !');
    Exit;
  end;

   frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedTowedJammerDecoy.FDef.Towed_Decoy_Index;
      AssetName := FSelectedTowedJammerDecoy.FDef.Towed_Decoy_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stTowedDecoy;

      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;
  
end;

procedure TfrmAvailableTowedJammerDecoy.edtCheatKeyPress(Sender: TObject;
  var Key: Char);
var
  i : Integer;
  towedjammerdecoy : TTowed_Decoy_On_Board;
begin
  if Key = #13 then
  begin
    lbxTowedDecoy.Items.Clear;

    dmINWO.GetFilterTowedDecoyDef(FTowedJammerDecoyList, edtCheat.text);

    for i := 0 to FTowedJammerDecoyList.Count - 1 do
    begin
      towedjammerdecoy := FTowedJammerDecoyList.Items[i];
      lbxTowedDecoy.Items.AddObject(towedjammerdecoy.FDef.Towed_Decoy_Identifier, towedjammerdecoy);
    end;
  end;
end;

procedure TfrmAvailableTowedJammerDecoy.lbSingleClick(Sender: TObject);
begin
  if lbxTowedDecoy.ItemIndex = -1 then
    Exit;

  FSelectedTowedJammerDecoy := TTowed_Decoy_On_Board(lbxTowedDecoy.Items.Objects[lbxTowedDecoy.ItemIndex]);
end;

procedure TfrmAvailableTowedJammerDecoy.UpdateTowedJammerDecoyList;
var
  i : Integer;
  towedjammerdecoy : TTowed_Decoy_On_Board;
begin
  lbxTowedDecoy.Items.Clear;

  dmINWO.GetAllTowedDecoyDef(FTowedJammerDecoyList);

  for i := 0 to FTowedJammerDecoyList.Count - 1 do
  begin
    towedjammerdecoy := FTowedJammerDecoyList.Items[i];
    lbxTowedDecoy.Items.AddObject(towedjammerdecoy.FDef.Towed_Decoy_Identifier, towedjammerdecoy);
  end;
end;

{$ENDREGION}

end.

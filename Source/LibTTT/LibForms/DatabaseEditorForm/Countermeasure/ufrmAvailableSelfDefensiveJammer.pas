unit ufrmAvailableSelfDefensiveJammer;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Countermeasure, uDataModule, uSimContainers, ufrmSummarySelfDefensiveJammer, ufrmUsage;

type
  TfrmAvailableSelfDefensiveJammer = class(TForm)
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
    lbxDefensiveJammer: TListBox;

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
    FSelfDefensiveJammerList : TList;
    FSelectedSelfDefensiveJammer : TDefensive_Jammer_On_Board;

    procedure UpdateSelfDefensiveJammerList;

   end;

var
  frmAvailableSelfDefensiveJammer: TfrmAvailableSelfDefensiveJammer;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableSelfDefensiveJammer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FSelfDefensiveJammerList);
  Action := cafree;
end;

procedure TfrmAvailableSelfDefensiveJammer.FormCreate(Sender: TObject);
begin
  FSelfDefensiveJammerList := TList.Create;
end;

procedure TfrmAvailableSelfDefensiveJammer.FormShow(Sender: TObject);
begin
  UpdateSelfDefensiveJammerList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableSelfDefensiveJammer.btnNewClick(Sender: TObject);
begin
  frmSummarySelfDefensiveJammer := TfrmSummarySelfDefensiveJammer.Create(Self);
  try
    with frmSummarySelfDefensiveJammer do
    begin
      SelectedDefensiveJammer := TDefensive_Jammer_On_Board.Create;
      ShowModal;
      SelectedDefensiveJammer.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummarySelfDefensiveJammer.Free;
  end;

  if FUpdateList then
    UpdateSelfDefensiveJammerList;
end;

procedure TfrmAvailableSelfDefensiveJammer.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableSelfDefensiveJammer.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;

begin
  if lbxDefensiveJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Self Defensive Jammer... !');
    Exit;
  end;

  with FSelectedSelfDefensiveJammer do
  begin
    newClassName := FDef.Defensive_Jammer_Identifier + ' - Copy';

    count := dmINWO.GetSelfDefensiveJammerDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Defensive_Jammer_Identifier := newClassName;

    dmINWO.InsertSelfDefensiveJammerDef(FDef);
    dmINWO.InsertNoteStorage(16, FDef.Defensive_Jammer_Index, FNote);
  end;

  UpdateSelfDefensiveJammerList;
end;

procedure TfrmAvailableSelfDefensiveJammer.btnEditClick(Sender: TObject);
begin
  if lbxDefensiveJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Self Defensive Jammer... !');
    Exit;
  end;

  frmSummarySelfDefensiveJammer := TfrmSummarySelfDefensiveJammer.Create(Self);
  try
    with frmSummarySelfDefensiveJammer do
    begin
      SelectedDefensiveJammer := FSelectedSelfDefensiveJammer;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummarySelfDefensiveJammer.Free;
  end;

  if FUpdateList then
    UpdateSelfDefensiveJammerList;
end;

procedure TfrmAvailableSelfDefensiveJammer.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxDefensiveJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Infrared Decoy... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedSelfDefensiveJammer.FDef do
    begin
//      if dmINWO.GetCountermeasure_On_Board_By_Index(6, Defensive_Jammer_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some Vehicles');
        Exit;
      end;

      dmINWO.DeleteNoteStorage(16, Defensive_Jammer_Index);

      if dmINWO.DeleteSelfDefensiveJammerDef(Defensive_Jammer_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateSelfDefensiveJammerList;
  end;
end;

procedure TfrmAvailableSelfDefensiveJammer.btnUsageClick(Sender: TObject);
begin
  if lbxDefensiveJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Self Defensive Jammer... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedSelfDefensiveJammer.FDef.Defensive_Jammer_Index;
      AssetName := FSelectedSelfDefensiveJammer.FDef.Defensive_Jammer_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stDefensiveJammer;

      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;

end;

procedure TfrmAvailableSelfDefensiveJammer.edtCheatKeyPress(Sender: TObject;
  var Key: Char);
var
  i : Integer;
  selfdefensivejammer : TDefensive_Jammer_On_Board;
begin
  if Key = #13 then
  begin
    lbxDefensiveJammer.Items.Clear;

    dmINWO.GetFilterSelfDefensiveJammerDef(FSelfDefensiveJammerList, edtCheat.text);

    for i := 0 to FSelfDefensiveJammerList.Count - 1 do
    begin
      selfdefensivejammer := FSelfDefensiveJammerList.Items[i];
      lbxDefensiveJammer.Items.AddObject(selfdefensivejammer.FDef.Defensive_Jammer_Identifier, selfdefensivejammer);
    end;
  end;
end;

procedure TfrmAvailableSelfDefensiveJammer.lbSingleClick(Sender: TObject);
begin
  if lbxDefensiveJammer.ItemIndex = -1 then
    Exit;

  FSelectedSelfDefensiveJammer := TDefensive_Jammer_On_Board(lbxDefensiveJammer.Items.Objects[lbxDefensiveJammer.ItemIndex]);
end;

procedure TfrmAvailableSelfDefensiveJammer.UpdateSelfDefensiveJammerList;
var
  i : Integer;
  selfdefensivejammer : TDefensive_Jammer_On_Board;
begin
  lbxDefensiveJammer.Items.Clear;

  dmINWO.GetAllSelfDefensiveJammerDef(FSelfDefensiveJammerList);

  for i := 0 to FSelfDefensiveJammerList.Count - 1 do
  begin
    selfdefensivejammer := FSelfDefensiveJammerList.Items[i];
    lbxDefensiveJammer.Items.AddObject(selfdefensivejammer.FDef.Defensive_Jammer_Identifier, selfdefensivejammer);
  end;
end;

{$ENDREGION}

end.

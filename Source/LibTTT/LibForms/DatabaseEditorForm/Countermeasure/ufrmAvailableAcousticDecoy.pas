unit ufrmAvailableAcousticDecoy;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Countermeasure, uDataModule, uSimContainers, ufrmSummaryAcousticDecoy, ufrmUsage;

type
  TfrmAvailableAcousticDecoy = class(TForm)
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
    lbxAcousticdecoy: TListBox;

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
    FAcousticDecoyList : TList;
    FSelectedAcousticDecoy : TAcoustic_Decoy_On_Board;

    procedure CopyPOHModifier(idAcousticDecoy : integer);
    procedure UpdateAcousticDecoyList;

  end;

var
  frmAvailableAcousticDecoy: TfrmAvailableAcousticDecoy;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableAcousticDecoy.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FAcousticDecoyList);
  Action := cafree;
end;

procedure TfrmAvailableAcousticDecoy.FormCreate(Sender: TObject);
begin
  FAcousticDecoyList := TList.Create;
end;

procedure TfrmAvailableAcousticDecoy.FormShow(Sender: TObject);
begin
  UpdateAcousticDecoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableAcousticDecoy.btnNewClick(Sender: TObject);
begin
  frmSummaryAcousticDecoy := TfrmSummaryAcousticDecoy.Create(Self);
  try
    with frmSummaryAcousticDecoy do
    begin
      SelectedAcousticDecoy := TAcoustic_Decoy_On_Board.Create;
      ShowModal;
      SelectedAcousticDecoy.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryAcousticDecoy.Free;
  end;

  if FUpdateList then
    UpdateAcousticDecoyList;
end;

procedure TfrmAvailableAcousticDecoy.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
  idTemp : Integer;

begin
  if lbxAcousticdecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Acoustic Decoy... !');
    Exit;
  end;

  with FSelectedAcousticDecoy do
  begin
    newClassName := fdef.Decoy_Identifier + ' - Copy';

    count := dmINWO.GetAcousticDecoyDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    Fdef.Decoy_Identifier := newClassName;
    idTemp :=Fdef.Decoy_Index;

    dmINWO.InsertAcousticDecoyDef(Fdef);
    dmINWO.InsertNoteStorage(20, Fdef.Decoy_Index, FNote);

    {Copy POH Modifier}
    CopyPOHModifier(idTemp);
  end;

  UpdateAcousticDecoyList;
end;

procedure TfrmAvailableAcousticDecoy.btnEditClick(Sender: TObject);
begin
  if lbxAcousticdecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Acoustic Decoy... !');
    Exit;
  end;

  frmSummaryAcousticDecoy := TfrmSummaryAcousticDecoy.Create(Self);
  try
    with frmSummaryAcousticDecoy do
    begin
      SelectedAcousticDecoy := FSelectedAcousticDecoy;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryAcousticDecoy.Free;
  end;

  if FUpdateList then
    UpdateAcousticDecoyList;
end;

procedure TfrmAvailableAcousticDecoy.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxAcousticdecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Acoustic Decoy... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedAcousticDecoy.Fdef do
    begin
      {Pengecekan Relasi Dengan Tabel On Board}
//      if dmINWO.GetCountermeasure_On_Board_By_Index(1, Decoy_Index) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some Vehicles');
//        Exit;
//      end;
//
//      dmINWO.DeleteAcoustic_Decoy_POH_Modifier(Decoy_Index);

      dmINWO.DeleteNoteStorage(20, Decoy_Index);

      if dmINWO.DeleteAcousticDecoyDef(Decoy_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateAcousticDecoyList;
  end;
end;

procedure TfrmAvailableAcousticDecoy.btnUsageClick(Sender: TObject);
begin
  if lbxAcousticdecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Acoustic Decoy... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedAcousticDecoy.Fdef.Decoy_Index;
      AssetName := FSelectedAcousticDecoy.Fdef.Decoy_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stAcousticDecoy;
      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;
end;

procedure TfrmAvailableAcousticDecoy.CopyPOHModifier(idAcousticDecoy: integer);
var
  i : Integer;
  PointList : TList;
//  data : TAcoustic_Decoy_POH_Modifier;

begin
  with FSelectedAcousticDecoy do
  begin
    PointList := TList.Create;

//    if dmINWO.GetAcousticDecoyPOHModifier(idAcousticDecoy, PointList) > 0 then
//    begin
//      for i := 0 to PointList.Count - 1 do
//      begin
//        data := PointList.Items[i];
//        data.FAccousticDecoy_POH.Decoy_Index := Fdef.Decoy_Index;
//        dmINWO.InsertAcoustic_Decoy_POH_Modifier(data)
//      end;
//    end;

    PointList.Destroy;
  end;
end;

procedure TfrmAvailableAcousticDecoy.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  acousticdecoy : TAcoustic_Decoy_On_Board;
begin
  if Key = #13 then
  begin
    lbxAcousticdecoy.Items.Clear;

    dmINWO.GetFilterAcousticDecoyDef(FAcousticDecoyList, edtCheat.text);

    for i := 0 to FAcousticDecoyList.Count - 1 do
    begin
      acousticdecoy := FAcousticDecoyList.Items[i];
      lbxAcousticdecoy.Items.AddObject(acousticdecoy.Fdef.Decoy_Identifier, acousticdecoy);
    end;
  end;
end;

procedure TfrmAvailableAcousticDecoy.btnCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmAvailableAcousticDecoy.lbSingleClick(Sender: TObject);
begin
  if lbxAcousticdecoy.ItemIndex = -1 then
    Exit;

  FSelectedAcousticDecoy := TAcoustic_Decoy_On_Board(lbxAcousticdecoy.Items.Objects[lbxAcousticdecoy.ItemIndex]);
end;

procedure TfrmAvailableAcousticDecoy.UpdateAcousticDecoyList;
var
  i : Integer;
  acousticdecoy : TAcoustic_Decoy_On_Board;
begin
  lbxAcousticdecoy.Items.Clear;

  dmINWO.GetAllAcousticDecoyDef(FAcousticDecoyList);

  for i := 0 to FAcousticDecoyList.Count - 1 do
  begin
    acousticdecoy := FAcousticDecoyList.Items[i];
    lbxAcousticdecoy.Items.AddObject(acousticdecoy.Fdef.Decoy_Identifier, acousticdecoy);
  end;
end;

{$ENDREGION}

end.

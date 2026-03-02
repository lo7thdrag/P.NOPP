unit ufrmAvailableEOD;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Sensor, uDataModule, uSimContainers, ufrmSummaryEOD, ufrmUsage;
type
  TfrmAvailableEOD = class(TForm)
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
    lbxEod: TListBox;

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
    FEODList : TList;
    FSelectedEOD : TEOD_On_Board;

    procedure UpdateEODList;
  end;

var
  frmAvailableEOD: TfrmAvailableEOD;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableEOD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FEODList);
  Action := cafree;
end;

procedure TfrmAvailableEOD.FormCreate(Sender: TObject);
begin
  FEODList := TList.Create;
end;

procedure TfrmAvailableEOD.FormShow(Sender: TObject);
begin
  UpdateEODList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableEOD.btnNewClick(Sender: TObject);
begin
  frmSummaryEOD := TfrmSummaryEOD.Create(Self);
  try
    with frmSummaryEOD do
    begin
      SelectedEO := TEOD_On_Board.Create;
      ShowModal;
      SelectedEO.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryEOD.Free;
  end;

  if FUpdateList then
    UpdateEODList;
end;

procedure TfrmAvailableEOD.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
begin
  if lbxEOD.ItemIndex = -1 then
  begin
    ShowMessage('Select EOD... !');
    Exit;
  end;

  with FSelectedEOD do
  begin
    newClassName := FDef.Class_Identifier + ' - Copy';

    count := dmINWO.GetEODDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Class_Identifier := newClassName;

    dmINWO.InsertEODDef(FDef);
    dmINWO.InsertNoteStorage(12, FDef.EOD_Index, FNote);
  end;

  UpdateEODList;
end;

procedure TfrmAvailableEOD.btnEditClick(Sender: TObject);
begin
  if lbxEOD.ItemIndex = -1 then
  begin
    ShowMessage('Select EOD... !');
    Exit;
  end;

  frmSummaryEOD := TfrmSummaryEOD.Create(Self);
  try
    with frmSummaryEOD do
    begin
      SelectedEO := FSelectedEOD;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryEOD.Free;
  end;

  if FUpdateList then
    UpdateEODList;
end;

procedure TfrmAvailableEOD.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxEOD.ItemIndex = -1 then
  begin
    ShowMessage('Select EOD... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedEOD.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
//      if dmINWO.GetSensor_On_Board_By_Index(5, EOD_Index) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some vehicles');
//        Exit;
//      end;

      dmINWO.DeleteNoteStorage(12, EOD_Index);

      if dmINWO.DeleteEODDef(EOD_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateEODList;
  end;
end;

procedure TfrmAvailableEOD.btnUsageClick(Sender: TObject);
begin
  if lbxEOD.ItemIndex = -1 then
  begin
    ShowMessage('Select EOD... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedEOD.FDef.EOD_Index;
      AssetName := FSelectedEOD.FDef.Class_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stEod;
      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;
end;

procedure TfrmAvailableEOD.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  eod : TEOD_On_Board;
begin
  if Key = #13 then
  begin
    lbxEOD.Items.Clear;

    dmINWO.GetFilterEODDef(FEODList, edtCheat.text);

    for i := 0 to FEODList.Count - 1 do
    begin
      eod := FEODList.Items[i];
      lbxEOD.Items.AddObject(eod.FDef.Class_Identifier, eod);
    end;
  end;
end;

procedure TfrmAvailableEOD.btnCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmAvailableEOD.lbSingleClick(Sender: TObject);
begin
  if lbxEOD.ItemIndex = -1 then
    Exit;

  FSelectedEOD := TEOD_On_Board(lbxEOD.Items.Objects[lbxEOD.ItemIndex]);
end;

procedure TfrmAvailableEOD.UpdateEODList;
var
  i : Integer;
  eod : TEOD_On_Board;
begin
  lbxEOD.Items.Clear;

  dmINWO.GetAllEODDef(FEODList);

  for i := 0 to FEODList.Count - 1 do
  begin
    eod := FEODList.Items[i];
    lbxEOD.Items.AddObject(eod.FDef.Class_Identifier, eod);
  end;
end;

{$ENDREGION}



end.

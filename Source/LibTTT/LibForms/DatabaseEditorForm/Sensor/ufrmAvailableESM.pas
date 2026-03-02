unit ufrmAvailableESM;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Sensor, uDataModule, uSimContainers, ufrmSummaryESM, ufrmUsage;

type
  TfrmAvailableESM = class(TForm)
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
    lbxEsm: TListBox;

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
    FESMList : TList;
    FSelectedESM : TESM_On_Board;

    procedure UpdateESMList;
  end;

var
  frmAvailableESM: TfrmAvailableESM;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableESM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FESMList);
  Action := cafree;
end;

procedure TfrmAvailableESM.FormCreate(Sender: TObject);
begin
  FESMList := Tlist.Create;
end;

procedure TfrmAvailableESM.FormShow(Sender: TObject);
begin
  UpdateESMList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableESM.btnNewClick(Sender: TObject);
begin
  frmSummaryESM := TfrmSummaryESM.Create(Self);
  try
    with frmSummaryESM do
    begin
      SelectedESM := TESM_On_Board.Create;
      ShowModal;
      SelectedESM.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryESM.Free;
  end;

  if FUpdateList then
    UpdateESMList;
end;

procedure TfrmAvailableESM.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
begin
  if lbxESM.ItemIndex = -1 then
  begin
    ShowMessage('Select ESM... !');
    Exit;
  end;

  with FSelectedESM do
  begin
    newClassName := FDef.Class_Identifier + ' - Copy';

    count := dmINWO.GetESMDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Class_Identifier := newClassName;

    dmINWO.InsertESMDef(FDef);
    dmINWO.InsertNoteStorage(10, FDef.ESM_Index, FNote);
  end;

  UpdateESMList;
end;

procedure TfrmAvailableESM.btnEditClick(Sender: TObject);
begin
  if lbxESM.ItemIndex = -1 then
  begin
    ShowMessage('Select ESM... !');
    Exit;
  end;

  frmSummaryESM := TfrmSummaryESM.Create(Self);
  try
    with frmSummaryESM do
    begin
      SelectedESM := FSelectedESM;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryESM.Free;
  end;

  if FUpdateList then
    UpdateESMList;
end;

procedure TfrmAvailableESM.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxESM.ItemIndex = -1 then
  begin
    ShowMessage('Select ESM... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedESM.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
//      if dmINWO.GetSensor_On_Board_By_Index(3, ESM_Index) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some vehicles');
//        Exit;
//      end;

      dmINWO.DeleteNoteStorage(10, ESM_Index);

      if dmINWO.DeleteESMDef(ESM_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateESMList;
  end;
end;

procedure TfrmAvailableESM.btnUsageClick(Sender: TObject);
begin
  if lbxESM.ItemIndex = -1 then
  begin
    ShowMessage('Select ESM... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedESM.FDef.ESM_Index;
      AssetName := FSelectedESM.FDef.Class_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stEsm;
      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;
 
end;

procedure TfrmAvailableESM.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  esm : TESM_On_Board;
begin
  if Key = #13 then
  begin
    lbxESM.Items.Clear;

    dmINWO.GetFilterESMDef(FESMList, edtCheat.text);

    for i := 0 to FESMList.Count - 1 do
    begin
      esm := FESMList.Items[i];
      lbxESM.Items.AddObject(esm.FDef.Class_Identifier, esm);
    end;
  end;
end;

procedure TfrmAvailableESM.btnCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmAvailableESM.lbSingleClick(Sender: TObject);
begin
  if lbxESM.ItemIndex = -1 then
    Exit;

  FSelectedESM := TESM_On_Board(lbxESM.Items.Objects[lbxESM.ItemIndex]);
end;

procedure TfrmAvailableESM.UpdateESMList;
var
  i : Integer;
  esm : TESM_On_Board;
begin
  lbxESM.Items.Clear;

  dmINWO.GetAllESMDef(FESMList);

  for i := 0 to FESMList.Count - 1 do
  begin
    esm := FESMList.Items[i];
    lbxESM.Items.AddObject(esm.FDef.Class_Identifier, esm);
  end;
end;

{$ENDREGION}

end.

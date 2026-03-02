unit ufrmAvailableSonar;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Sensor, uDataModule, uSimContainers, ufrmSummarySonar, ufrmUsage;

type
  TfrmAvailableSonar = class(TForm)
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
    lbxSonar: TListBox;

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
    FSonarList : TList;
    FSelectedSonar : TSonar_On_Board;

    procedure UpdateSonarList;

  end;

var
  frmAvailableSonar: TfrmAvailableSonar;

implementation


{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableSonar.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FSonarList);
  Action := cafree;
end;

procedure TfrmAvailableSonar.FormCreate(Sender: TObject);
begin
  FSonarList := TList.Create;
end;

procedure TfrmAvailableSonar.FormShow(Sender: TObject);
begin
  UpdateSonarList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableSonar.btnNewClick(Sender: TObject);
begin
  frmSummarySonar := TfrmSummarySonar.Create(Self);
  try
    with frmSummarySonar do
    begin
      SelectedSonar := TSonar_On_Board.Create;
      ShowModal;
      SelectedSonar.Free;
      FUpdateList := AfterClose;
    end;

  finally
    frmSummarySonar.Free;
  end;

  if FUpdateList then
    UpdateSonarList;
end;

procedure TfrmAvailableSonar.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
begin
  if lbxSonar.ItemIndex = -1 then
  begin
    ShowMessage('Select Sonar... !');
    Exit;
  end;

  with FSelectedSonar do
  begin
    newClassName := FDef.Sonar_Identifier + ' - Copy';

    count := dmINWO.GetSonarDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Sonar_Identifier := newClassName;

    dmINWO.InsertSonarDef(FDef);
    dmINWO.InsertNoteStorage(9, FDef.Sonar_Index, FNote);
  end;

  UpdateSonarList;
end;

procedure TfrmAvailableSonar.btnEditClick(Sender: TObject);
begin
  if lbxSonar.ItemIndex = -1 then
  begin
    ShowMessage('Select Sonar... !');
    Exit;
  end;

  frmSummarySonar := TfrmSummarySonar.Create(Self);
  try
    with frmSummarySonar do
    begin
      SelectedSonar := FSelectedSonar;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummarySonar.Free;
  end;

  if FUpdateList then
    UpdateSonarList;
end;

procedure TfrmAvailableSonar.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;

begin
  if lbxSonar.ItemIndex = -1 then
  begin
    ShowMessage('Select Sonar... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedSonar.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
//      if dmINWO.GetSensor_On_Board_By_Index(4, Sonar_Index) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some vehicles');
//        Exit;
//      end;

      {Pengecekan Relasi Dengan Tabel Sonobuoy Definition}
      tempList := TList.Create;
      if dmINWO.GetSonarAtSonobuoyDef(Sonar_Index, tempList) then
      begin
        ShowMessage('Cannot delete, because is already in used by Sonobuoy Definition');
        FreeItemsAndFreeList(tempList);
        Exit;
      end;
      FreeItemsAndFreeList(tempList);

      dmINWO.DeleteNoteStorage(9, Sonar_Index);

      if dmINWO.DeleteSonarDef(Sonar_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateSonarList;
  end;
end;

procedure TfrmAvailableSonar.btnUsageClick(Sender: TObject);
begin
  if lbxSonar.ItemIndex = -1 then
  begin
    ShowMessage('Select Sonar... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedSonar.FDef.Sonar_Index;
      AssetName := FSelectedSonar.FDef.Sonar_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stSonar;
      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;
end;

procedure TfrmAvailableSonar.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  sonar : TSonar_On_Board;

begin
  if Key = #13 then
  begin
    lbxSonar.Items.Clear;

    dmINWO.GetFilterSonarDef(FSonarList, edtCheat.text);

    for i := 0 to FSonarList.Count - 1 do
    begin
      sonar := FSonarList.Items[i];
      lbxSonar.Items.AddObject(sonar.FDef.Sonar_Identifier, sonar);
    end;
  end;
end;

procedure TfrmAvailableSonar.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableSonar.lbSingleClick(Sender: TObject);
begin
  if lbxSonar.ItemIndex = -1 then
    Exit;

  FSelectedSonar := TSonar_On_Board(lbxSonar.Items.Objects[lbxSonar.ItemIndex]);
end;

procedure TfrmAvailableSonar.UpdateSonarList;
var
  i : Integer;
  sonar : TSonar_On_Board;
begin
  lbxSonar.Items.Clear;

  dmINWO.GetAllSonarDef(FSonarList);

  for i := 0 to FSonarList.Count - 1 do
  begin
    sonar := FSonarList.Items[i];
    lbxSonar.Items.AddObject(sonar.FDef.Sonar_Identifier, sonar);
  end;
end;

{$ENDREGION}

end.

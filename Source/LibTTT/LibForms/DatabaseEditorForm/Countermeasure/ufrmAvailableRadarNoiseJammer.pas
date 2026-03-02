unit ufrmAvailableRadarNoiseJammer;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Countermeasure, uDataModule, uSimContainers, ufrmSummaryRadarNoiseJammer, ufrmUsage;

type
  TfrmAvailableRadarNoiseJammer = class(TForm)
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
    lbxRadarNoiseJammer: TListBox;

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
    procedure ImgBackgroundClick(Sender: TObject);


  private
   FUpdateList : Boolean;
   FRadarNoiseJammerList : TList;
   FSelectedRadarNoiseJammer : TRadar_Noise_Jammer_On_Board;

    procedure UpdateRadarNoiseJammerList;

   end;

var
  frmAvailableRadarNoiseJammer: TfrmAvailableRadarNoiseJammer;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableRadarNoiseJammer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FRadarNoiseJammerList);
  Action := cafree;
end;

procedure TfrmAvailableRadarNoiseJammer.FormCreate(Sender: TObject);
begin
  FRadarNoiseJammerList := TList.Create;
end;

procedure TfrmAvailableRadarNoiseJammer.FormShow(Sender: TObject);
begin
  UpdateRadarNoiseJammerList;
end;

procedure TfrmAvailableRadarNoiseJammer.ImgBackgroundClick(Sender: TObject);
begin

end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableRadarNoiseJammer.btnNewClick(Sender: TObject);
begin
  frmSummaryRadarNoiseJammer := TfrmSummaryRadarNoiseJammer.Create(Self);
  try
    with frmSummaryRadarNoiseJammer do
    begin
      SelectedRadarJammer := TRadar_Noise_Jammer_On_Board.Create;
      ShowModal;
      SelectedRadarJammer.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryRadarNoiseJammer.Free;
  end;

  if FUpdateList then
    UpdateRadarNoiseJammerList;
end;

procedure TfrmAvailableRadarNoiseJammer.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableRadarNoiseJammer.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;

begin
  if lbxRadarNoiseJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Radar Noise Jammer... !');
    Exit;
  end;

  with FSelectedRadarNoiseJammer do
  begin
    newClassName := FDef.Jammer_Identifier + ' - Copy';

    count := dmINWO.GetRadarNoiseJammerDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Jammer_Identifier := newClassName;

    dmINWO.InsertRadarNoiseJammerDef(FDef);
    dmINWO.InsertNoteStorage(15, FDef.Jammer_Index, FNote);
  end;

  UpdateRadarNoiseJammerList;
end;

procedure TfrmAvailableRadarNoiseJammer.btnEditClick(Sender: TObject);
begin
  if lbxRadarNoiseJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Radar Noise Jammer... !');
    Exit;
  end;

  frmSummaryRadarNoiseJammer := TfrmSummaryRadarNoiseJammer.Create(Self);
  try
    with frmSummaryRadarNoiseJammer do
    begin
      SelectedRadarJammer := FSelectedRadarNoiseJammer;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryRadarNoiseJammer.Free;
  end;

  if FUpdateList then
    UpdateRadarNoiseJammerList;
end;

procedure TfrmAvailableRadarNoiseJammer.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxRadarNoiseJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Radar Noise Jammer... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedRadarNoiseJammer.FDef do
    begin
//      if dmINWO.GetCountermeasure_On_Board_By_Index(8, Jammer_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some Vehicles');
        Exit;
      end;

      dmINWO.DeleteNoteStorage(15, Jammer_Index);

      if dmINWO.DeleteRadarNoiseJammerDef(Jammer_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateRadarNoiseJammerList;
  end;
end;

procedure TfrmAvailableRadarNoiseJammer.btnUsageClick(Sender: TObject);
begin
  if lbxRadarNoiseJammer.ItemIndex = -1 then
  begin
    ShowMessage('Select Radar Noise Jammer... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedRadarNoiseJammer.FDef.Jammer_Index;
      AssetName := FSelectedRadarNoiseJammer.FDef.Jammer_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType:= stRadarNoiseJammer;

      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;

end;

procedure TfrmAvailableRadarNoiseJammer.edtCheatKeyPress(Sender: TObject;
  var Key: Char);
var
  i : Integer;
  radarnoisejammer : TRadar_Noise_Jammer_On_Board;
begin
  if Key = #13 then
  begin
    lbxRadarNoiseJammer.Items.Clear;

    dmINWO.GetFilterRadarNoiseJammerDef(FRadarNoiseJammerList, edtCheat.text);

    for i := 0 to FRadarNoiseJammerList.Count - 1 do
    begin
      radarnoisejammer := FRadarNoiseJammerList.Items[i];
      lbxRadarNoiseJammer.Items.AddObject(radarnoisejammer.FDef.Jammer_Identifier, radarnoisejammer);
    end;
  end;
end;

procedure TfrmAvailableRadarNoiseJammer.lbSingleClick(Sender: TObject);
begin
  if lbxRadarNoiseJammer.ItemIndex = -1 then
    Exit;

  FSelectedRadarNoiseJammer := TRadar_Noise_Jammer_On_Board(lbxRadarNoiseJammer.Items.Objects[lbxRadarNoiseJammer.ItemIndex]);
end;

procedure TfrmAvailableRadarNoiseJammer.UpdateRadarNoiseJammerList;
var
  i : Integer;
  radarnoisejammer : TRadar_Noise_Jammer_On_Board;
begin
  lbxRadarNoiseJammer.Items.Clear;

  dmINWO.GetAllRadarNoiseJammerDef(FRadarNoiseJammerList);

  for i := 0 to FRadarNoiseJammerList.Count - 1 do
  begin
    radarnoisejammer := FRadarNoiseJammerList.Items[i];
    lbxRadarNoiseJammer.Items.AddObject(radarnoisejammer.FDef.Jammer_Identifier, radarnoisejammer);
  end;
end;

{$ENDREGION}

end.

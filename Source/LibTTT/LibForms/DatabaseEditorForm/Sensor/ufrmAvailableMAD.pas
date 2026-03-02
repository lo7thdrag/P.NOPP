unit ufrmAvailableMAD;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Sensor, uDataModule, uSimContainers, ufrmSummaryMAD, ufrmUsage;

type
  TfrmAvailableMAD = class(TForm)
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
    lbxMad: TListBox;

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
    FMADList : TList;
    FSelectedMAD : TMAD_On_Board;

    procedure UpdateMADList;
  end;

var
  frmAvailableMAD: TfrmAvailableMAD;
  sList : TList;
  isCopy : Boolean;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableMAD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FMADList);
  Action := cafree;
end;

procedure TfrmAvailableMAD.FormCreate(Sender: TObject);
begin
  FMADList := TList.Create;
end;

procedure TfrmAvailableMAD.FormShow(Sender: TObject);
begin
  UpdateMADList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableMAD.btnNewClick(Sender: TObject);
begin
  frmSummaryMAD := TfrmSummaryMAD.Create(Self);
  try
    with frmSummaryMAD do
    begin
      SelectedMAD := TMAD_On_Board.Create;
      ShowModal;
      SelectedMAD.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryMAD.Free;
  end;

  if FUpdateList then
    UpdateMADList;
end;

procedure TfrmAvailableMAD.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
begin
  if lbxMAD.ItemIndex = -1 then
  begin
    ShowMessage('Select MAD... !');
    Exit;
  end;

  with FSelectedMAD do
  begin
    newClassName := FDef.Class_Identifier + ' - Copy';

    count := dmINWO.GetMADDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Class_Identifier := newClassName;

    dmINWO.InsertMADDef(FDef);
    dmINWO.InsertNoteStorage(11, FDef.MAD_Index, FNote);
  end;

  UpdateMADList;
end;

procedure TfrmAvailableMAD.btnEditClick(Sender: TObject);
begin
  if lbxMAD.ItemIndex = -1 then
  begin
    ShowMessage('Select MAD... !');
    Exit;
  end;

  frmSummaryMAD := TfrmSummaryMAD.Create(Self);
  try
    with frmSummaryMAD do
    begin
      SelectedMAD := FSelectedMAD;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryMAD.Free;
  end;

  if FUpdateList then
    UpdateMADList;
end;

procedure TfrmAvailableMAD.btnDeleteClick(Sender: TObject);
var
  warning: Integer;
begin
  if lbxMAD.ItemIndex = -1 then
  begin
    ShowMessage('Select MAD... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedMAD.FDef do
    begin
      {Pengecekan Relasi Dengan Tabel On Board}
//      if dmINWO.GetSensor_On_Board_By_Index(2, MAD_Index) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some vehicles');
//        Exit;
//      end;

      dmINWO.DeleteNoteStorage(11, MAD_Index);

      if dmINWO.DeleteMADDef(MAD_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateMADList;
  end;
end;

procedure TfrmAvailableMAD.btnUsageClick(Sender: TObject);
begin
  if lbxMAD.ItemIndex = -1 then
  begin
    ShowMessage('Select MAD... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedMAD.FDef.MAD_Index;
      AssetName := FSelectedMAD.FDef.Class_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stMad;
      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;

end;

procedure TfrmAvailableMAD.edtCheatKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  mad : TMAD_On_Board;
begin
  if Key = #13 then
  begin
    lbxMAD.Items.Clear;

    dmINWO.GetFilterMADDef(FMADList, edtCheat.text);

    for i := 0 to FMADList.Count - 1 do
    begin
      mad := FMADList.Items[i];
      lbxMAD.Items.AddObject(mad.FDef.Class_Identifier, mad);
    end;
  end;
end;

procedure TfrmAvailableMAD.btnCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmAvailableMAD.lbSingleClick(Sender: TObject);
begin
  if lbxMAD.ItemIndex = -1 then
    Exit;

  FSelectedMAD := TMAD_On_Board(lbxMAD.Items.Objects[lbxMAD.ItemIndex]);
end;

 procedure TfrmAvailableMAD.UpdateMADList;
var
  i : Integer;
  mad : TMAD_On_Board;
begin
  lbxMAD.Items.Clear;

  dmINWO.GetAllMADDef(FMADList);

  for i := 0 to FMADList.Count - 1 do
  begin
    mad := FMADList.Items[i];
    lbxMAD.Items.AddObject(mad.FDef.Class_Identifier, mad);
  end;
end;

{$ENDREGION}



end.

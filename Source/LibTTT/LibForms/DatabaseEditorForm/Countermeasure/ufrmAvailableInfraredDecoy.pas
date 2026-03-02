unit ufrmAvailableInfraredDecoy;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,

  {Project Uses}
  uConstantaData, uRecordData, uDBAsset_Countermeasure, uDataModule, uSimContainers, ufrmSummaryInfraredDecoy, ufrmUsage;


type
  TfrmAvailableInfraredDecoy = class(TForm)
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
    lbxInfraredDecoy: TListBox;

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
    FInfraredDecoyList : TList;
    FSelectedInfraredDecoy : TInfrared_Decoy_On_Board;

    procedure UpdateInfraredDecoyList;

   end;

var
  frmAvailableInfraredDecoy: TfrmAvailableInfraredDecoy;

implementation

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableInfraredDecoy.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FInfraredDecoyList);
  Action := cafree;
end;

procedure TfrmAvailableInfraredDecoy.FormCreate(Sender: TObject);
begin
  FInfraredDecoyList := TList.Create;
end;

procedure TfrmAvailableInfraredDecoy.FormShow(Sender: TObject);
begin
  UpdateInfraredDecoyList;
end;

procedure TfrmAvailableInfraredDecoy.ImgBackgroundClick(Sender: TObject);
begin

end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableInfraredDecoy.btnNewClick(Sender: TObject);
begin
  frmSummaryInfraredDecoy := TfrmSummaryInfraredDecoy.Create(Self);
  try
    with frmSummaryInfraredDecoy do
    begin
      SelectedInfraredDecoy := TInfrared_Decoy_On_Board.Create;
      ShowModal;
      SelectedInfraredDecoy.Free;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryInfraredDecoy.Free;
  end;

  if FUpdateList then
    UpdateInfraredDecoyList;
end;

procedure TfrmAvailableInfraredDecoy.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableInfraredDecoy.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;

begin
  if lbxInfraredDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Infrared Decoy... !');
    Exit;
  end;

  with FSelectedInfraredDecoy do
  begin
    newClassName := FDef.Infrared_Decoy_Identifier + ' - Copy';

    count := dmINWO.GetInfraredDecoyDef(newClassName);

    if count > 0 then
      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';

    FDef.Infrared_Decoy_Identifier := newClassName;

    dmINWO.InsertInfraredDecoyDef(FDef);
    dmINWO.InsertNoteStorage(23, FDef.Infrared_Decoy_Index, FNote);
  end;

  UpdateInfraredDecoyList;
end;

procedure TfrmAvailableInfraredDecoy.btnEditClick(Sender: TObject);
begin
  if lbxInfraredDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Infrared Decoy... !');
    Exit;
  end;

  frmSummaryInfraredDecoy := TfrmSummaryInfraredDecoy.Create(Self);
  try
    with frmSummaryInfraredDecoy do
    begin
      SelectedInfraredDecoy := FSelectedInfraredDecoy;
      ShowModal;
      FUpdateList := AfterClose;
    end;
  finally
    frmSummaryInfraredDecoy.Free;
  end;

  if FUpdateList then
    UpdateInfraredDecoyList;
end;

procedure TfrmAvailableInfraredDecoy.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lbxInfraredDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Infrared Decoy... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
    mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedInfraredDecoy.FDef do
    begin
//      if dmINWO.GetCountermeasure_On_Board_By_Index(4, Infrared_Decoy_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some Vehicles');
        Exit;
      end;

      dmINWO.DeleteNoteStorage(23, Infrared_Decoy_Index);

      if dmINWO.DeleteInfraredDecoyDef(Infrared_Decoy_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateInfraredDecoyList;
  end;
end;

procedure TfrmAvailableInfraredDecoy.btnUsageClick(Sender: TObject);
begin
  if lbxInfraredDecoy.ItemIndex = -1 then
  begin
    ShowMessage('Select Infrared Decoy... !');
    Exit;
  end;

  frmUsage := TfrmUsage.Create(Self);
  try
    with frmUsage do
    begin
      AssetIndex := FSelectedInfraredDecoy.FDef.Infrared_Decoy_Index;
      AssetName := FSelectedInfraredDecoy.FDef.Infrared_Decoy_Identifier;
      AssetTitle := 'On Board Vehicle:';
      AssetType := stInfraredDecoy;

      ShowModal;
    end;
  finally
    frmUsage.Free;
  end;

end;

procedure TfrmAvailableInfraredDecoy.edtCheatKeyPress(Sender: TObject;
  var Key: Char);
var
  i : Integer;
   infrareddecoy : TInfrared_Decoy_On_Board;
begin
  if Key = #13 then
  begin
    lbxInfraredDecoy.Items.Clear;

    dmINWO.GetFilterInfraredDecoyDef(FInfraredDecoyList, edtCheat.text);

    for i := 0 to FInfraredDecoyList.Count - 1 do
    begin
      infrareddecoy := FInfraredDecoyList.Items[i];
      lbxInfraredDecoy.Items.AddObject(infrareddecoy.FDef.Infrared_Decoy_Identifier, infrareddecoy);
    end;
  end;
end;

procedure TfrmAvailableInfraredDecoy.lbSingleClick(Sender: TObject);
begin
  if lbxInfraredDecoy.ItemIndex = -1 then
    Exit;

  FSelectedInfraredDecoy := TInfrared_Decoy_On_Board(lbxInfraredDecoy.Items.Objects[lbxInfraredDecoy.ItemIndex]);
end;

procedure TfrmAvailableInfraredDecoy.UpdateInfraredDecoyList;
var
  i : Integer;
  infrareddecoy : TInfrared_Decoy_On_Board;
begin
  lbxInfraredDecoy.Items.Clear;

  dmINWO.GetAllInfraredDecoyDef(FInfraredDecoyList);

  for i := 0 to FInfraredDecoyList.Count - 1 do
  begin
    infrareddecoy := FInfraredDecoyList.Items[i];
    lbxInfraredDecoy.Items.AddObject(infrareddecoy.FDef.Infrared_Decoy_Identifier, infrareddecoy);
  end;
end;

{$ENDREGION}

end.

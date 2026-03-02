unit ufrmAvailableFloatingDecoy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, uSimContainers
  {uDBAsset_Countermeasure};

type
  TfrmAvailableFloatingDecoy = class(TForm)
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
    lbxFloatingDecoy: TListBox;

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
    FFloatingDecoyList : TList;
//    FSelectedFloatingDecoy : TFloating_Decoy_On_Board;

    procedure UpdateFloatingDecoyList;

   end;

var
  frmAvailableFloatingDecoy: TfrmAvailableFloatingDecoy;

implementation

uses
  uDataModule, ufrmSummaryFloatingDecoy{, ufrmUsage};

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmAvailableFloatingDecoy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FFloatingDecoyList);
  Action := cafree;
end;

procedure TfrmAvailableFloatingDecoy.FormCreate(Sender: TObject);
begin
  FFloatingDecoyList := TList.Create;
end;

procedure TfrmAvailableFloatingDecoy.FormShow(Sender: TObject);
begin
  UpdateFloatingDecoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAvailableFloatingDecoy.btnNewClick(Sender: TObject);
begin
//  frmSummaryFloatingDecoy := TfrmSummaryFloatingDecoy.Create(Self);
//  try
//    with frmSummaryFloatingDecoy do
//    begin
//      SelectedFloatingDecoy := TFloating_Decoy_On_Board.Create;
//      ShowModal;
//      SelectedFloatingDecoy.Free;
//      FUpdateList := AfterClose;
//    end;
//  finally
//    frmSummaryFloatingDecoy.Free;
//  end;
//
//  if FUpdateList then
//    UpdateFloatingDecoyList;
end;
procedure TfrmAvailableFloatingDecoy.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableFloatingDecoy.btnCopyClick(Sender: TObject);
var
  newClassName : string;
  count : Integer;
begin
//  if lstFloatingDecoy.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Floating Decoy... !');
//    Exit;
//  end;
//
//  with FSelectedFloatingDecoy do
//  begin
//    newClassName := FFloatingDecoy_Def.Floating_Decoy_Identifier + ' - Copy';
//
//    count := dmTTT.GetFloatingDecoyDef(newClassName);
//
//    if count > 0 then
//      newClassName := newClassName + ' (' + IntToStr(count + 1) + ')';
//
//    FFloatingDecoy_Def.Floating_Decoy_Identifier := newClassName;
//
//    dmTTT.InsertFloatingDecoyDef(FFloatingDecoy_Def);
//    dmTTT.InsertNoteStorage(18, FFloatingDecoy_Def.Floating_Decoy_Index, FNote);
//  end;
//
//  UpdateFloatingDecoyList;
end;

procedure TfrmAvailableFloatingDecoy.btnEditClick(Sender: TObject);
begin
//  if lstFloatingDecoy.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Floating Decoy... !');
//    Exit;
//  end;
//
//  frmSummaryFloatingDecoy := TfrmSummaryFloatingDecoy.Create(Self);
//  try
//    with frmSummaryFloatingDecoy do
//    begin
//      SelectedFloatingDecoy := FSelectedFloatingDecoy;
//      ShowModal;
//      FUpdateList := AfterClose;
//    end;
//  finally
//    frmSummaryFloatingDecoy.Free;
//  end;
//
//  if FUpdateList then
//    UpdateFloatingDecoyList;
end;

procedure TfrmAvailableFloatingDecoy.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
//  if lstFloatingDecoy.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Floating Decoy... !');
//    Exit;
//  end;
//
//  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
//    mbOKCancel, 0);
//
//  if warning = mrOK then
//  begin
//    with FSelectedFloatingDecoy.FFloatingDecoy_Def do
//    begin
//      if dmTTT.GetCountermeasure_On_Board_By_Index(5, Floating_Decoy_Index) then
//      begin
//        ShowMessage('Cannot delete, because is already in used by some Vehicles');
//        Exit;
//      end;
//
//      dmTTT.DeleteNoteStorage(18, Floating_Decoy_Index);
//
//      if dmTTT.DeleteFloatingDecoyDef(Floating_Decoy_Index) then
//        ShowMessage('Data has been deleted');
//    end;
//
//    UpdateFloatingDecoyList;
//  end;
end;

procedure TfrmAvailableFloatingDecoy.btnUsageClick(Sender: TObject);
begin
//  if lstFloatingDecoy.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Floating Decoy... !');
//    Exit;
//  end;
//
//  frmUsage := TfrmUsage.Create(Self);
//  try
//    with frmUsage do
//    begin
//     UId := FSelectedFloatingDecoy.FFloatingDecoy_Def.Floating_Decoy_Index;
//    name_usage := FSelectedFloatingDecoy.FFloatingDecoy_Def.Floating_Decoy_Identifier;
//    usage_title := 'On Board Vehicle:';
//    UIndex := 15;
//
//    ShowModal;
//    end;
//  finally
//    frmUsage.Free;
//  end;
  
end;

procedure TfrmAvailableFloatingDecoy.edtCheatKeyPress(Sender: TObject;
  var Key: Char);
var
  i : Integer;
//  floatingdecoy : TFloating_Decoy_On_Board;
begin
//  if Key = #13 then
//  begin
//    lstFloatingDecoy.Items.Clear;
//
//    dmTTT.GetFilterFloatingDecoyDef(FFloatingDecoyList, edtCheat.text);
//
//    for i := 0 to FFloatingDecoyList.Count - 1 do
//    begin
//      floatingdecoy := FFloatingDecoyList.Items[i];
//      lstFloatingDecoy.Items.AddObject(floatingdecoy.FFloatingDecoy_Def.Floating_Decoy_Identifier, floatingdecoy);
//    end;
//  end;
end;

procedure TfrmAvailableFloatingDecoy.lbSingleClick(Sender: TObject);
begin
//  if lstFloatingDecoy.ItemIndex = -1 then
//    Exit;
//
//  FSelectedFloatingDecoy := TFloating_Decoy_On_Board(lstFloatingDecoy.Items.Objects[lstFloatingDecoy.ItemIndex]);
end;

procedure TfrmAvailableFloatingDecoy.UpdateFloatingDecoyList;
var
  i : Integer;
//  floatingdecoy : TFloating_Decoy_On_Board;
begin
//  lstFloatingDecoy.Items.Clear;
//
//  dmTTT.GetAllFloatingDecoyDef(FFloatingDecoyList);
//
//  for i := 0 to FFloatingDecoyList.Count - 1 do
//  begin
//    floatingdecoy := FFloatingDecoyList.Items[i];
//    lstFloatingDecoy.Items.AddObject(floatingdecoy.FFloatingDecoy_Def.Floating_Decoy_Identifier, floatingdecoy);
//  end;
end;

{$ENDREGION}

end.

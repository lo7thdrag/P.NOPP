unit ufrmAvailableUserRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, UfrmSummaryUserRole, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  uClassData, uDataModule, uSimContainers, uConstantaData;

type
  TfrmAvailableUserRole = class(TForm)
    edtSearch: TEdit;
    lblPlatform: TLabel;
    lblsearch: TLabel;
    lblClose: TLabel;
    ImgBackgroundForm: TImage;
    btnNew: TImage;
    btnEdit: TImage;
    btnDelete: TImage;
    lvUserRole: TListView;
    cbbxFilterSearch: TComboBox;
    cbbSearchType: TComboBox;
    procedure lblCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvUserRoleSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure cbbxFilterSearchSelect(Sender: TObject);
    procedure cbbSearchTypeChange(Sender: TObject);
    procedure cbbSearchTypeSelect(Sender: TObject);
    procedure cbbxFilterSearchClick(Sender: TObject);

  private
    FUpdateList : Boolean;
    FUserRoleList : TList;
    FSelectedUserRole : TUserRole;
    procedure AddSearchTypeItems;


    procedure UpdatUserRoleList;

  public
    { Public declarations }
    flagTable : Boolean;
    SearchName : string;
    ItemSearchIndex : Integer;
  end;

var
  frmAvailableUserRole: TfrmAvailableUserRole;



implementation

{$R *.dfm}

procedure TfrmAvailableUserRole.AddSearchTypeItems;
begin
  if cbbxFilterSearch.ItemIndex = 2 then
  begin
    cbbSearchType.Items.Clear;
    cbbSearchType.Items.Add('INWO');
    cbbSearchType.Items.Add('NTWO');
    cbbSearchType.Items.Add('ATWO');
    cbbSearchType.Items.Add('LFWO');
    cbbSearchType.Items.Add('ALWO');
    cbbSearchType.Items.Add('CDWO');
    cbbSearchType.Items.Add('SUWO');
  end
  else if cbbxFilterSearch.ItemIndex = 3 then
  begin
    cbbSearchType.Items.Clear;
    cbbSearchType.Items.Add('KPL');
    cbbSearchType.Items.Add('STAFLAT');
    cbbSearchType.Items.Add('WASDAL');
    cbbSearchType.Items.Add('KOGAB');
    cbbSearchType.Items.Add('KOGASGABLA');
    cbbSearchType.Items.Add('KOGASGABFIB');
    cbbSearchType.Items.Add('PASRAT');
    cbbSearchType.Items.Add('KOGASRATMIN');
    cbbSearchType.Items.Add('KOGASHANTAI');
    cbbSearchType.Items.Add('SATGASDUK');
  end;

end;

procedure TfrmAvailableUserRole.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lvUserRole.ItemIndex = -1 then
  begin
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedUserRole.FData do
    begin
      if dmINWO.DeleteUserRole(UserRoleIndex) then
        ShowMessage('Data has been deleted');
    end;

    UpdatUserRoleList;
  end;
end;

procedure TfrmAvailableUserRole.btnEditClick(Sender: TObject);
begin
  if lvUserRole.ItemIndex = -1 then
  begin
    Exit;
  end;

  Hide;

  if not Assigned(frmSummaryUserRole) then
    frmSummaryUserRole := TfrmSummaryUserRole.Create(Self);

  try
    with frmSummaryUserRole do
    begin
      SelectedUserRole := FSelectedUserRole;
      Show;
//      FUpdateList := AfterClose;
    end;
  finally
  end;

  if FUpdateList then
    UpdatUserRoleList;

  Show;
end;

procedure TfrmAvailableUserRole.btnNewClick(Sender: TObject);
begin
  Hide;

  if not Assigned(frmSummaryUserRole) then
    frmSummaryUserRole := TfrmSummaryUserRole.Create(self) ;

  try
    with frmSummaryUserRole do
    begin
      SelectedUserRole := TUserRole.Create;
      Show;
      SelectedUserRole.Free;
//      FUpdateList := AfterClose;
    end;
  finally
  end;

  if FUpdateList then
    UpdatUserRoleList;

  Show;
end;

procedure TfrmAvailableUserRole.cbbSearchTypeChange(Sender: TObject);
begin
  AddSearchTypeItems;
  cbbSearchType.ItemIndex := 0;
end;

procedure TfrmAvailableUserRole.cbbSearchTypeSelect(Sender: TObject);
begin
  ItemSearchIndex := cbbxFilterSearch.ItemIndex;
  SearchName := IntToStr(cbbSearchType.ItemIndex);
  flagTable := true;
  UpdatUserRoleList;
end;

procedure TfrmAvailableUserRole.cbbxFilterSearchClick(Sender: TObject);
begin
  cbbSearchType.ItemIndex := -1;
end;

procedure TfrmAvailableUserRole.cbbxFilterSearchSelect(Sender: TObject);
begin
  if cbbxFilterSearch.ItemIndex = 0 then
  begin
    edtSearch.Clear;
    flagTable := false;
    UpdatUserRoleList;
    edtSearch.BringToFront;
  end
  else if cbbxFilterSearch.ItemIndex = 1 then
  begin
    edtSearch.BringToFront;
  end
  else if cbbxFilterSearch.ItemIndex = 2 then
  begin
    AddSearchTypeItems;
    cbbSearchType.BringToFront;
  end
  else if cbbxFilterSearch.ItemIndex = 3 then
  begin
    AddSearchTypeItems;
    cbbSearchType.BringToFront;
  end;
end;

procedure TfrmAvailableUserRole.edtSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if (edtSearch.Text <> '') and (cbbxFilterSearch.ItemIndex > 0) then
    begin
      ItemSearchIndex := cbbxFilterSearch.ItemIndex;
      SearchName := edtSearch.Text;
      flagTable := true;
      UpdatUserRoleList;
    end
    else if edtSearch.Text = '' then
//    else
    begin
      flagTable := false;
      UpdatUserRoleList;
    end;
  end;
end;

procedure TfrmAvailableUserRole.FormCreate(Sender: TObject);
begin
  FUserRoleList := TList.Create;
end;

procedure TfrmAvailableUserRole.FormDestroy(Sender: TObject);
begin
  FreeItemsAndFreeList(FUserRoleList);
end;

procedure TfrmAvailableUserRole.FormShow(Sender: TObject);
begin
  edtSearch.Clear;
  cbbxFilterSearch.ItemIndex := 0;
  edtSearch.BringToFront;
  flagTable := false;
  UpdatUserRoleList;
end;

procedure TfrmAvailableUserRole.lblCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvailableUserRole.lvUserRoleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected  then
  begin
    if (Item = nil) or (item.Data = nil) then
      Exit;

    FSelectedUserRole := TUserRole(lvUserRole.Selected.Data);
  end;
end;

procedure TfrmAvailableUserRole.UpdatUserRoleList;
var
  i : Integer;
  userRoleTemp : TUserRole;
  li : TListItem;

begin
  lvUserRole.Items.Clear;

  if flagTable = true then
    dmINWO.GetSearchUserRole(ItemSearchIndex, SearchName, FUserRoleList)
  else
    dmINWO.GetAllUserRole(FUserRoleList);

  for i := 0 to FUserRoleList.Count - 1 do
  begin
    userRoleTemp := FUserRoleList.Items[i];
    li := lvUserRole.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add(userRoleTemp.FData.UserRoleAcronim);
    li.SubItems.Add(userRoleTemp.FData.UserRoleIdentifier);
    li.SubItems.Add(SetOrganisasiTugasAkronimToString(TOrganisasiTugas(userRoleTemp.FData.RoleIndex)));
    li.SubItems.Add(SetSubOrganisasiTugasToString(TSubOrganisasiTugas(userRoleTemp.FData.SubRoleIndex)));

//    if userRoleTemp.FData.Perencanaan = 1 then
//      li.SubItems.Add('✔')
//    else
//      li.SubItems.Add('❌');
//
//    if userRoleTemp.FData.Persiapan = 1 then
//      li.SubItems.Add('✔')
//    else
//      li.SubItems.Add('❌');
//
//    if userRoleTemp.FData.Pelaksanaan = 1 then
//      li.SubItems.Add('✔')
//    else
//      li.SubItems.Add('❌');
//
//    if userRoleTemp.FData.Pengakhiran = 1 then
//      li.SubItems.Add('✔')
//    else
//      li.SubItems.Add('❌');

    li.Data := userRoleTemp;
  end;
end;

end.

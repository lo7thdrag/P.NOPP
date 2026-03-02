unit ufrmRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, uDataModule;

type
  TfrmSummaryRole = class(TForm)
    btnCancel: TImage;
    btnOk: TImage;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    pnlRole: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtIdentifier: TEdit;
    lstRole: TListBox;
    btnDelete: TImage;
    btnEdit: TImage;
    btnNew: TImage;
    Label1: TLabel;
    btnClose: TLabel;
    cbbRole: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);

    procedure UpdateListRole;
    procedure lstRoleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbbRoleChange(Sender: TObject);

  private
    FSelectedRole : TRole;
    FRoleList : TList;

    function CekInput: Boolean;
    procedure SetAvailableSize;
    procedure SetSummarySize;
    procedure UpdateRoleData;

  public
    LastName : string;

  end;

var
  frmSummaryRole: TfrmSummaryRole;

implementation

{$R *.dfm}

procedure TfrmSummaryRole.btnCancelClick(Sender: TObject);
begin
  SetAvailableSize;
end;

procedure TfrmSummaryRole.btnEditClick(Sender: TObject);
begin
  if lstRole.ItemIndex <> -1 then
  begin
    SetSummarySize;

    UpdateRoleData;
  end;
end;

procedure TfrmSummaryRole.btnNewClick(Sender: TObject);
begin
  SetSummarySize;

  FSelectedRole := TRole.Create;
  UpdateRoleData;
end;

procedure TfrmSummaryRole.btnOkClick(Sender: TObject);
begin
  with FSelectedRole do
  begin
    if not CekInput then
    begin
      Exit;
    end;

    {$REGION ' General '}
    LastName := cbbRole.Text;
    FData.RoleAcronim := cbbRole.Text;
    FData.RoleIdentifier := edtIdentifier.Text;
    {$ENDREGION}

    if FData.RoleIndex = 0 then
    begin
      if dmINWO.InsertRole(FData) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateRole(FData) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  UpdateListRole;
  SetAvailableSize;
end;

procedure TfrmSummaryRole.cbbRoleChange(Sender: TObject);
begin
  if cbbRole.ItemIndex = -1 then
    cbbRole.ItemIndex := 0;
end;

function TfrmSummaryRole.CekInput: Boolean;
var
  i, chkSpace, numSpace: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (cbbRole.Text = '') or (edtIdentifier.Text = '')then
  begin
    ShowMessage('Input cannot be empty');
    Exit;
  end;

  {Jika berisi spasi semua}
  if Copy(cbbRole.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(cbbRole.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if cbbRole.Text[i] = #32 then
      numSpace := numSpace + 1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('Please use another role name');
      Exit;
    end;
  end;

  {Jika Class Name sudah ada}
  if (dmINWO.GetRoleByName(cbbRole.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedRole.FData.RoleIndex = 0 then
    begin
      ShowMessage('Please use another role name');
      Exit;
    end
    else if LastName <> cbbRole.Text then
    begin
      ShowMessage('Please use another role name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmSummaryRole.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSummaryRole.btnDeleteClick(Sender: TObject);
var
  selectedListRole: Integer;
begin
  if lstRole.ItemIndex = -1 then
    Exit;

  if Assigned(FSelectedRole) then
  begin
    if dmINWO.GetRoleInSubRole(FSelectedRole.FData.RoleIndex) > 0 then
    begin
      ShowMessage('Cannot delete, because is already in used by another Sub Role');
      Exit;
    end;

    if dmINWO.DeleteRole(FSelectedRole.FData.RoleIndex) then
    begin
      ShowMessage('Data has been deleted');
    end;

    UpdateListRole;
  end;
end;

procedure TfrmSummaryRole.FormCreate(Sender: TObject);
begin
  FRoleList := TList.Create;
end;

procedure TfrmSummaryRole.FormDestroy(Sender: TObject);
begin
  FRoleList := TList.Create;

  if Assigned(FSelectedRole) then
    FSelectedRole.Free;
end;

procedure TfrmSummaryRole.FormShow(Sender: TObject);
begin
  UpdateListRole;
  SetAvailableSize;
end;

procedure TfrmSummaryRole.lstRoleClick(Sender: TObject);
begin
  if lstRole.ItemIndex = -1 then
    Exit;

  FSelectedRole := TRole(lstRole.Items.Objects[lstRole.ItemIndex]);
end;

procedure TfrmSummaryRole.UpdateListRole;
var
  i : Integer;
  roleTemp : TRole;
begin
  lstRole.Items.Clear;

  dmINWO.GetAllRole(FRoleList);

  for i := 0 to FRoleList.Count - 1 do
  begin
    roleTemp := FRoleList.Items[i];
    lstRole.Items.AddObject(roleTemp.FData.RoleAcronim, roleTemp);
  end;
end;

procedure TfrmSummaryRole.UpdateRoleData;
begin
  with FSelectedRole do
  begin
    if FData.RoleIndex = 0 then
    begin
      cbbRole.ItemIndex := 0;
      edtIdentifier.Text := '';
    end
    else
    begin
      cbbRole.Text := FData.RoleAcronim;
      edtIdentifier.Text := FData.RoleIdentifier;
    end;

    LastName := cbbRole.Text;
  end;
end;

procedure TfrmSummaryRole.SetAvailableSize;
begin
  Width := 300;
  Height := 356;

//  btnNew.Visible := True;
  btnEdit.Visible := True;
//  btnDelete.Visible := True;
  lstRole.Visible := True;

  pnlRole.Visible := False;
  btnCancel.Visible := False;
  btnOk.Visible := False;
end;

procedure TfrmSummaryRole.SetSummarySize;
begin
  Width := 432;
  Height := 187;

  btnNew.Visible := False;
  btnEdit.Visible := False;
  btnDelete.Visible := False;
  lstRole.Visible := False;

  pnlRole.Visible := True;
  btnCancel.Visible := True;
  btnOk.Visible := True;
end;

end.

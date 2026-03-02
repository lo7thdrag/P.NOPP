unit ufrmSubRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, uDataModule, uConstantaData, RzBmpBtn;

type
  TfrmSubRole = class(TForm)
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    pnlSubRole: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    chkPelaksanaan: TCheckBox;
    chkPengakhiran: TCheckBox;
    chkPerencanaan: TCheckBox;
    chkPersiapan: TCheckBox;
    lstSubRole: TListBox;
    btnNew: TImage;
    btnEdit: TImage;
    btnDelete: TImage;
    Label1: TLabel;
    edtIdentifier: TEdit;
    btnClose: TLabel;
    cbbRole: TComboBox;
    cbbSubRole: TComboBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    btnOk: TRzBmpButton;
    btnCancel: TRzBmpButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

    procedure UpdateListSubRole;
    procedure lstSubRoleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbbRoleChange(Sender: TObject);
    procedure cbbSubRoleChange(Sender: TObject);

  private
    FSelectedSubRole : TSubRole;
    FSelectedRole : TRole;
    FRoleList : TList;
    FSubRoleList : TList;

    function CekInput: Boolean;
    function GetRoleAcronim(id : Integer):string;
    function GetRoleIndex(id : string):Integer;
    procedure SetAvailableSize;
    procedure SetSummarySize;
    procedure UpdateSubRoleData;
    procedure AddCbbRole;
    procedure AddCbbSubRole;

  public
     LastName : string;
  end;

var
  frmSubRole: TfrmSubRole;

implementation

{$R *.dfm}

procedure TfrmSubRole.AddCbbRole;
var
  i : Integer;
  roleTemp : TRole;
begin
  cbbRole.Items.Clear;

  dmINWO.GetAllRole(FRoleList);

  for i := 0 to FRoleList.Count - 1 do
  begin
    roleTemp := FRoleList.Items[i];
    cbbRole.Items.AddObject(roleTemp.FData.RoleAcronim, roleTemp);
  end;
end;

procedure TfrmSubRole.AddCbbSubRole;
begin
  cbbSubRole.Items.Clear;

  if cbbRole.Text = 'INWO' then
  begin
    cbbSubRole.Items.Add('KPL');
    cbbSubRole.Items.Add('STAF LAT');
    cbbSubRole.Items.Add('WASDAL');
    cbbSubRole.Items.Add('KOGAB');
  end
  else if cbbRole.Text = 'NTWO' then
  begin
    cbbSubRole.Items.Add('KOGASGABLA');
  end
  else if cbbRole.Text = 'ATWO' then
  begin
    cbbSubRole.Items.Add('KOGASGABFIB');
  end
  else if cbbRole.Text = 'LFWO' then
  begin
    cbbSubRole.Items.Add('PASRAT');
  end
  else if cbbRole.Text = 'ALWO' then
  begin
    cbbSubRole.Items.Add('KOGASRATMIN');
  end
  else if cbbRole.Text = 'CDWO' then
  begin
    cbbSubRole.Items.Add('KOGASHANTAI');
  end
  else if cbbRole.Text = 'SUWO' then
  begin
    cbbSubRole.Items.Add('SATGASDUK');
  end;
end;

procedure TfrmSubRole.btnCancelClick(Sender: TObject);
begin
  SetAvailableSize;
end;

procedure TfrmSubRole.btnEditClick(Sender: TObject);
begin
  if lstSubRole.ItemIndex <> -1 then
  begin
    SetSummarySize;

    UpdateSubRoleData;
  end;
end;

procedure TfrmSubRole.btnNewClick(Sender: TObject);
begin
  AddCbbRole;
  SetSummarySize;

  FSelectedSubRole := TSubRole.Create;
  UpdateSubRoleData;
end;

procedure TfrmSubRole.buttonOkClick(Sender: TObject);
begin
  FSelectedSubRole := TSubRole.Create;

  with FSelectedSubRole do
  begin
    if not CekInput then
    begin
      Exit;
    end;

    {$REGION ' General '}
    LastName := cbbRole.Text;
    FData.RoleIndex := GetRoleIndex(cbbRole.Text);
    FData.SubRoleAcronim := cbbSubRole.Text;
    FData.SubRoleIdentifier := edtIdentifier.Text;
    FData.Perencanaan := Ord(chkPerencanaan.Checked);
    FData.Persiapan := ord(chkPersiapan.Checked);
    FData.Pelaksanaan := ord(chkPelaksanaan.Checked);
    FData.Pengakhiran := ord(chkPengakhiran.Checked);
    {$ENDREGION}

    if FData.SubRoleIndex = 0 then
    begin
      if dmINWO.InsertSubRole(FData) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateSubRole(FData) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  UpdateListSubRole;
  SetAvailableSize;
end;

procedure TfrmSubRole.cbbRoleChange(Sender: TObject);
begin
  if cbbRole.ItemIndex = -1 then
    cbbRole.ItemIndex := 0;

  AddCbbSubRole;
  cbbSubRole.ItemIndex := 0;
end;

procedure TfrmSubRole.cbbSubRoleChange(Sender: TObject);
begin
  if cbbSubRole.ItemIndex = -1 then
    cbbSubRole.ItemIndex := 0;

end;

function TfrmSubRole.CekInput;
var
  i, chkSpace, numSpace: Integer;
  checkedCount: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (cbbSubRole.Text = '') or (edtIdentifier.Text = '') or (cbbRole.ItemIndex = -1) then
  begin
    ShowMessage('Input cannot be empty');
    Exit;
  end;

  {Jika berisi spasi semua}
  if Copy(cbbSubRole.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(cbbSubRole.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if cbbSubRole.Text[i] = #32 then
      numSpace := numSpace + 1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('Please use another subrole name');
      Exit;
    end;
  end;

  {Jika Class Name sudah ada}
  if (dmINWO.GetSubRoleByName(cbbSubRole.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedSubRole.FData.RoleIndex = 0 then
    begin
      ShowMessage('Please use another subrole name');
      Exit;
    end
    else if LastName <> cbbSubRole.Text then
    begin
      ShowMessage('Please use another subrole name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmSubRole.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSubRole.btnDeleteClick(Sender: TObject);
var
  selectedListSubRole: Integer;
begin
  if lstSubRole.ItemIndex = -1 then
    Exit;

  if Assigned(FSelectedSubRole) then
  begin
    if dmINWO.GetSubRoleInUserRole(FSelectedSubRole.FData.RoleIndex) > 0 then
    begin
      ShowMessage('Cannot delete, because is already in used by another User Role');
      Exit;
    end;

    if dmINWO.DeleteSubRole(FSelectedSubRole.FData.SubRoleIndex) then
    begin
      ShowMessage('Data has been deleted');
    end;

    UpdateListSubRole;
  end;
end;

procedure TfrmSubRole.FormCreate(Sender: TObject);
begin
  FRoleList := TList.Create;
  FSubRoleList := TList.Create;
end;

procedure TfrmSubRole.FormDestroy(Sender: TObject);
begin
  FRoleList.Free;
  FSubRoleList.Free;

  if Assigned(FSelectedRole) then
    FSelectedRole.Free;

  if Assigned(FSelectedSubRole) then
    FSelectedSubRole.Free;
end;

procedure TfrmSubRole.FormShow(Sender: TObject);
begin
  UpdateListSubRole;
  SetAvailableSize;
end;

function TfrmSubRole.GetRoleAcronim(id: Integer): string;
var
  i : Integer;
  roleTemp : TRole;
begin
  Result := '';

  for i := 0 to FRoleList.Count - 1 do
  begin
    roleTemp := FRoleList.Items[i];

    if roleTemp.FData.RoleIndex = id then
    begin
      Result := roleTemp.FData.RoleAcronim;
      Break;
    end;
  end;
end;

function TfrmSubRole.GetRoleIndex(id: string): Integer;
var
  i : Integer;
  roleTemp : TRole;
begin
  Result := 0;

  for i := 0 to FRoleList.Count - 1 do
  begin
    roleTemp := FRoleList.Items[i];

    if roleTemp.FData.RoleAcronim = id then
    begin
      Result := roleTemp.FData.RoleIndex;
      Break;
    end;
  end;
end;

procedure TfrmSubRole.lstSubRoleClick(Sender: TObject);
begin
  if lstSubRole.ItemIndex = -1 then
    Exit;

  FSelectedSubRole := TSubRole(lstSubRole.Items.Objects[lstSubRole.ItemIndex]);
end;

procedure TfrmSubRole.UpdateListSubRole;
var
  i : Integer;
  subroleTemp : TSubRole;
begin
  lstSubRole.Items.Clear;

  dmINWO.GetAllSubRole(FSubRoleList);

  for i := 0 to FSubRoleList.Count - 1 do
  begin
    subroleTemp := FSubRoleList.Items[i];
    lstSubRole.Items.AddObject(subroleTemp.FData.SubRoleAcronim, subroleTemp);
  end;
end;

procedure TfrmSubRole.UpdateSubRoleData;
begin
  AddCbbRole;

  with FSelectedSubRole do
  begin
    if FData.RoleIndex = 0 then
    begin
      if cbbRole.Items.Count > 0 then
        cbbRole.ItemIndex := 0;

      AddCbbSubRole;
      cbbSubRole.ItemIndex := 0;
      edtIdentifier.Text := '';
    end
    else
    begin
      cbbRole.Text := GetRoleAcronim(FData.RoleIndex);
      AddCbbSubRole;
      cbbSubRole.Text := FData.SubRoleAcronim;
      edtIdentifier.Text := FData.SubRoleIdentifier;

    end;

    LastName := cbbSubRole.Text;
    chkPerencanaan.Checked := Boolean(FData.Perencanaan);
    chkPersiapan.Checked := Boolean(FData.Persiapan);
    chkPelaksanaan.Checked := Boolean(FData.Pelaksanaan);
    chkPengakhiran.Checked := Boolean(FData.Perencanaan);
  end;
end;

procedure TfrmSubRole.SetAvailableSize;
begin
  Width := 300;
  Height := 356;

//  btnNew.Visible := True;
  btnEdit.Visible := True;
//  btnDelete.Visible := True;
  btnClose.Visible := True;
  lstSubRole.Visible := True;

  pnlSubRole.Visible := False;
  btnCancel.Visible := False;
  btnOk.Visible := False;
end;

procedure TfrmSubRole.SetSummarySize;
begin
  Width := 485;
  Height := 314;

  btnNew.Visible := False;
  btnEdit.Visible := False;
  btnDelete.Visible := False;
  btnClose.Visible := False;
  lstSubRole.Visible := False;

  pnlSubRole.Visible := True;
  btnCancel.Visible := True;
  btnOk.Visible := True;

end;

end.

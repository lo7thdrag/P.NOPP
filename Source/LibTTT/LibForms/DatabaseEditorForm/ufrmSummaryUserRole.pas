unit ufrmSummaryUserRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, uConstantaData, uDataModule, uRecordData, ufrmRole, ufrmSubRole,
  RzBmpBtn;

type
  TfrmSummaryUserRole = class(TForm)
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    cbbRole: TComboBox;
    cbbSubRole: TComboBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtConfirmPassword: TEdit;
    ImgBackgroundForm: TImage;
    pnlUserRole: TPanel;
    Label13: TLabel;
    lblPlatform: TLabel;
    btnShowPassword: TImage;
    btnShowPassword2: TImage;
    Label14: TLabel;
    imgEdit: TImage;
    btnEditRole: TImage;
    btnEditSubRole: TImage;
    Label3: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    edtIdentifier: TEdit;
    cbbUserRole: TComboBox;
    Label16: TLabel;
    Label17: TLabel;
    btnOk: TRzBmpButton;
    btnCancel: TRzBmpButton;
    procedure cbbRoleChange(Sender: TObject);
    procedure cbbSubRoleChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnShowPasswordClick(Sender: TObject);
    procedure btnShowPassword2Click(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkChangeClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure btnEditRoleClick(Sender: TObject);
    procedure btnEditSubRoleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbbUserRoleChange(Sender: TObject);

  private
    FSelectedUserRole : TUserRole;
    FRoleList : TList;
    FSubRoleList : TList;

    function CekInput: Boolean;
    procedure UpdateUserRoleData;

    procedure AddCbbRole;
    procedure AddCbbSubRole;
    procedure AddCbbUserRole;

    function GetRoleAcronim(id : Integer):string;
    function GetRoleIndex(id : string):Integer;
    function GetSubRoleAcronim(id : Integer):string;
    function GetSubRoleIndex(id : string):Integer;

  public
    LastName : string;
//    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
//    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }

    property SelectedUserRole : TUserRole read FSelectedUserRole write FSelectedUserRole;
  end;

var
  frmSummaryUserRole: TfrmSummaryUserRole;

implementation

{$R *.dfm}
uses
  ufrmDisplayArea;

{$REGION ' Form Event '}

procedure TfrmSummaryUserRole.FormCreate(Sender: TObject);
begin
  FRoleList := TList.Create;
  FSubRoleList := TList.Create;
end;

procedure TfrmSummaryUserRole.FormDestroy(Sender: TObject);
begin
  FRoleList.Free;
  FSubRoleList.Free;
end;

procedure TfrmSummaryUserRole.FormShow(Sender: TObject);
begin
  UpdateUserRoleData;

  with FSelectedUserRole.FData do
    btnOk.Enabled := UserRoleIndex = 0;

//  isOK := True;
//  AfterClose := True;
  btnCancel.Enabled := True;
end;

function TfrmSummaryUserRole.GetRoleAcronim(id: Integer): string;
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

function TfrmSummaryUserRole.GetRoleIndex(id: string): Integer;
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

function TfrmSummaryUserRole.GetSubRoleAcronim(id: Integer): string;
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  Result := '';

  for i := 0 to FSubRoleList.Count - 1 do
  begin
    subRoleTemp := FSubRoleList.Items[i];

    if subRoleTemp.FData.SubRoleIndex = id then
    begin
      Result := subRoleTemp.FData.SubRoleAcronim;
      Break;
    end;
  end;
end;

function TfrmSummaryUserRole.GetSubRoleIndex(id: string): Integer;
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  Result := 0;

  for i := 0 to FSubRoleList.Count - 1 do
  begin
    subRoleTemp := FSubRoleList.Items[i];

    if subRoleTemp.FData.SubRoleAcronim = id then
    begin
      Result := subRoleTemp.FData.SubRoleIndex;
      Break;
    end;
  end;
end;

procedure TfrmSummaryUserRole.btnEditSubRoleClick(Sender: TObject);
begin
  if not Assigned(frmSubRole) then
    frmSubRole := TfrmSubRole.Create(Self);

  try
    with frmSubRole do
    begin
      Show;
    end;
  finally
  end;
end;

{$ENDREGION}

{$REGION ' Button Event '}

procedure TfrmSummaryUserRole.btnApplyClick(Sender: TObject);
begin
  with FSelectedUserRole do
  begin
    if not CekInput then
    begin
      Exit;
    end;

    LastName := cbbUserRole.Text;

    FData.RoleIndex := GetRoleIndex(cbbRole.Text);
    FData.SubRoleIndex := GetSubRoleIndex(cbbSubRole.Text);
    FData.UserRoleAcronim := cbbUserRole.Text;
    FData.UserRoleIdentifier := edtIdentifier.Text;
    FData.Username := edtUsername.Text;
    FData.Password := edtPassword.Text;

    if FData.UserRoleIndex = 0 then
    begin
      if dmINWO.InsertUserRole(FData) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateUserRole(FData) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  frmDisplayArea.UpdateDataPengguna;
  Close;
end;

procedure TfrmSummaryUserRole.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSummaryUserRole.btnEditRoleClick(Sender: TObject);
begin
  if not Assigned(frmSummaryRole) then
    frmSummaryRole := TfrmSummaryRole.Create(Self);

  try
    with frmSummaryRole do
    begin
      Show;
    end;
  finally
  end;
end;

procedure TfrmSummaryUserRole.btnOkClick(Sender: TObject);
begin
  if btnOk.Enabled then
    btnOk.OnClick(nil);

//  if isOk then
    Close;
end;

procedure TfrmSummaryUserRole.btnShowPassword2Click(Sender: TObject);
begin
  if (edtConfirmPassword.PasswordChar = '*') then
  begin
    btnShowPassword2.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnShowPassword.png');
    edtConfirmPassword.PasswordChar := #0;
  end
  else
  begin
    btnShowPassword2.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnHidePassword.png');
    edtConfirmPassword.PasswordChar := '*';
  end
end;

procedure TfrmSummaryUserRole.btnShowPasswordClick(Sender: TObject);
begin
  if (EdtPassword.PasswordChar = '*') then
  begin
    btnShowPassword.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnShowPassword.png');
    EdtPassword.PasswordChar := #0;
  end
  else
  begin
    btnShowPassword.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnHidePassword.png');
    EdtPassword.PasswordChar := '*';
  end
end;

{$ENDREGION}

{$REGION ' Additional Event '}

procedure TfrmSummaryUserRole.AddCbbRole;
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

procedure TfrmSummaryUserRole.AddCbbSubRole;
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  cbbSubRole.Items.Clear;

  dmINWO.GetAllSubRole(FSubRoleList);

  for i := 0 to FSubRoleList.Count - 1 do
  begin
    subRoleTemp := FSubRoleList.Items[i];

    if subRoleTemp.FData.RoleIndex = GetRoleIndex(cbbRole.Text) then
      cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
  end;
end;

procedure TfrmSummaryUserRole.AddCbbUserRole;
begin
  cbbUserRole.Clear;
  if cbbSubRole.Text = 'KPL' then
  begin
    {$REGION ' KPL '}
    cbbUserRole.Items.Add('PIMPINAN');
    cbbUserRole.Items.Add('WAKIL');
    cbbUserRole.Items.Add('DIRLAT');
    cbbUserRole.Items.Add('WADIRLAT');
    cbbUserRole.Items.Add('HATLAT');
    cbbUserRole.Items.Add('TIM EVA');
    cbbUserRole.Items.Add('DESTRA');
    cbbUserRole.Items.Add('DEOYU');
    cbbUserRole.Items.Add('DEKOMLEK');
    cbbUserRole.Items.Add('DEMINLOG');
    cbbUserRole.Items.Add('DELITBANG');
    cbbUserRole.Items.Add('SETLAT');
    cbbUserRole.Items.Add('INSTRUKTUR');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'STAF LAT' then
  begin
    {$REGION ' STAF LAT '}
    cbbUserRole.Items.Add('PIMPINAN');
    cbbUserRole.Items.Add('WAKIL');
    cbbUserRole.Items.Add('DIRLAT');
    cbbUserRole.Items.Add('WADIRLAT');
    cbbUserRole.Items.Add('HATLAT');
    cbbUserRole.Items.Add('TIM EVA');
    cbbUserRole.Items.Add('DESTRA');
    cbbUserRole.Items.Add('DEOYU');
    cbbUserRole.Items.Add('DEKOMLEK');
    cbbUserRole.Items.Add('DEMINLOG');
    cbbUserRole.Items.Add('DELITBANG');
    cbbUserRole.Items.Add('SETLAT');
    cbbUserRole.Items.Add('DENMALAT');
    cbbUserRole.Items.Add('DENHUBLAT');
    cbbUserRole.Items.Add('INSTRUKTUR');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'WASDAL' then
  begin
    {$REGION ' WASDAL '}
    cbbUserRole.Items.Add('PIMPINAN');
    cbbUserRole.Items.Add('WAKIL');
    cbbUserRole.Items.Add('KAWASDAL');
    cbbUserRole.Items.Add('WK WASDAL');
    cbbUserRole.Items.Add('KATIM PENILAI');
    cbbUserRole.Items.Add('KATIM EVA');
    cbbUserRole.Items.Add('KTIM LITBANG');
    cbbUserRole.Items.Add('WASDAL INTEL');
    cbbUserRole.Items.Add('WASDAL OPS');
    cbbUserRole.Items.Add('WASDAL REN');
    cbbUserRole.Items.Add('WASDAL PERS');
    cbbUserRole.Items.Add('WASDAL LOG');
    cbbUserRole.Items.Add('WDL KOMLEK');
    cbbUserRole.Items.Add('WDL GASDUK');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGAB' then
  begin
    {$REGION ' KOGAB '}
    cbbUserRole.Items.Add('PIMPINAN');
    cbbUserRole.Items.Add('WAKIL');
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KASUM');
    cbbUserRole.Items.Add('AS INTEL');
    cbbUserRole.Items.Add('AS OPS');
    cbbUserRole.Items.Add('AS PERS');
    cbbUserRole.Items.Add('AS RENA');
    cbbUserRole.Items.Add('AS KOMLEK');
    cbbUserRole.Items.Add('AS TER/POT');
    cbbUserRole.Items.Add('STF EVABANG');
    cbbUserRole.Items.Add('STF LATIHAN');
    cbbUserRole.Items.Add('LO KEMHAN');
    cbbUserRole.Items.Add('LO AANGKATD');
    cbbUserRole.Items.Add('LO AL');
    cbbUserRole.Items.Add('LO AU');
    cbbUserRole.Items.Add('KASETUM');
    cbbUserRole.Items.Add('INSTRUKTUR');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASGABLA' then
  begin
    {$REGION ' KOGASGABLA '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAF');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DANSATGASLA');
    cbbUserRole.Items.Add('SATGASUD');
    cbbUserRole.Items.Add('DAN UT PUKUL');
    cbbUserRole.Items.Add('DAN UT INTAI');
    cbbUserRole.Items.Add('DAN UT KAWAL');
    cbbUserRole.Items.Add('DAN UT BANTU');
    cbbUserRole.Items.Add('PASET');
    cbbUserRole.Items.Add('INSTRUKTUR ATWO');
    cbbUserRole.Items.Add('INSTRUKTUR NTWO');
    cbbUserRole.Items.Add('WASDAL ATWO');
    cbbUserRole.Items.Add('WASDAL NTWO');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASGABFIB' then
  begin
    {$REGION ' KOGASGABFIB '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAS');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DANSATGASLA');
    cbbUserRole.Items.Add('DAN PASRAT');
    cbbUserRole.Items.Add('DAN SATGASUD');
    cbbUserRole.Items.Add('DAN UT UDARA');
    cbbUserRole.Items.Add('DAN UT TABIR');
    cbbUserRole.Items.Add('DAN UT AJU');
    cbbUserRole.Items.Add('DAN UT BANTU');
    cbbUserRole.Items.Add('DAN UT ANGKT');
    cbbUserRole.Items.Add('DAN UT INTAI');
    cbbUserRole.Items.Add('PASET');
    cbbUserRole.Items.Add('INSTRUKTUR ATWO');
    cbbUserRole.Items.Add('INSTRUKTUR NTWO');
    cbbUserRole.Items.Add('WASDAL ATWO');
    cbbUserRole.Items.Add('WASDAL NTWO');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'PASRAT' then
  begin
    {$REGION ' PASRAT '}
    cbbUserRole.Items.Add('DAN PASRAT');
    cbbUserRole.Items.Add('WAD PASRAT');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DAN BRIF MAR');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASRATMIN' then
  begin
    {$REGION ' KOGASRATMIN '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAF');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DAN SATGASLA');
    cbbUserRole.Items.Add('DAN STGASRAT');
    cbbUserRole.Items.Add('DANSATGASUD');
    cbbUserRole.Items.Add('KATERMINAL');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASHANTAI' then
  begin
    {$REGION ' KOGASHANTAI '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAF');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DAN SATGASLA');
    cbbUserRole.Items.Add('DAN STGASRAT');
    cbbUserRole.Items.Add('DAN SATGASUD');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'SATGASDUK' then
  begin
    {$REGION ' SATGASDUK '}
    cbbUserRole.Items.Add('INTELEJEN');
    cbbUserRole.Items.Add('MINLOG');
    cbbUserRole.Items.Add('KOMLEK');
    cbbUserRole.Items.Add('PERNIKA');
    cbbUserRole.Items.Add('HUKUM');
    cbbUserRole.Items.Add('POM');
    cbbUserRole.Items.Add('PENERANGAN');
    cbbUserRole.Items.Add('PSIKOLOGI');
    cbbUserRole.Items.Add('KESEHATAN');
    cbbUserRole.Items.Add('PERS');
    cbbUserRole.Items.Add('INFO');
    cbbUserRole.Items.Add('BAK');
    cbbUserRole.Items.Add('SAR');
    cbbUserRole.Items.Add('ANGKT UDARA');
    cbbUserRole.Items.Add('ANGKT LAUT');
    cbbUserRole.Items.Add('PASSUS GAB');
    cbbUserRole.Items.Add('TERITORIAL');
    {$ENDREGION}
  end
  else
  begin
    cbbUserRole.Items.Add('ADMINISTRATOR');
  end;
end;

procedure TfrmSummaryUserRole.cbbRoleChange(Sender: TObject);
begin
  if cbbRole.ItemIndex = -1 then
    cbbRole.ItemIndex := 0;

  AddcbbSubRole;
  cbbSubRole.ItemIndex := 0;

  AddCbbUserRole;
  cbbUserRole.ItemIndex := 0;

  btnOk.Enabled := True;
end;

procedure TfrmSummaryUserRole.cbbSubRoleChange(Sender: TObject);
begin
  if cbbSubRole.ItemIndex = -1 then
    cbbSubRole.ItemIndex := 0;

  AddCbbUserRole;
  cbbUserRole.ItemIndex := 0;

  btnOk.Enabled := True;
end;

procedure TfrmSummaryUserRole.cbbUserRoleChange(Sender: TObject);
begin
  if cbbUserRole.ItemIndex = -1 then
    cbbUserRole.ItemIndex := 0

end;

procedure TfrmSummaryUserRole.UpdateUserRoleData;
begin
  AddCbbRole;

  with FSelectedUserRole do
  begin
    if FData.UserRoleIndex = 0 then
    begin
      if cbbRole.Items.Count > 0 then
        cbbRole.ItemIndex := 0;

      AddCbbSubRole;

      if cbbSubRole.Items.Count > 0 then
        cbbSubRole.ItemIndex := 0;

      AddCbbUserRole;
      cbbUserRole.ItemIndex := 0;

      edtUsername.Text := '';
      edtPassword.Text := '';
      edtConfirmPassword.Text := '';
    end
    else
    begin
      cbbRole.Text := GetRoleAcronim(FData.RoleIndex);

      AddCbbSubRole;
      cbbSubRole.Text := GetSubRoleAcronim(FData.SubRoleIndex);

      AddCbbUserRole;
      cbbUserRole.Text := FData.UserRoleAcronim;
      edtIdentifier.Text := FData.UserRoleIdentifier;

      edtUsername.Text := FData.Username;
      edtPassword.Text := FData.Password;
      edtConfirmPassword.Text := FData.Password;
    end;

    LastName := cbbUserRole.Text;
  end;
end;

{$ENDREGION}

{$REGION ' Filter Event '}

function TfrmSummaryUserRole.CekInput: Boolean;
begin
  Result := False;

  {Password tidak sesuai}
  if edtPassword.Text <> edtConfirmPassword.Text then
  begin
    ShowMessage('Cek ulang password anda');
    Exit;
  end;

  {Data ada yg kosong}
  if (edtUsername.Text = '') or (edtPassword.Text = '') then
  begin
    ShowMessage('Inputan data tidak lengkap');
    Exit;
  end;

  {Jika Class Name sudah ada}
  FSelectedUserRole.FData.UserRoleAcronim := cbbUserRole.Text;
  if (dmINWO.GetUserRoleByName(FSelectedUserRole.FData)>0) then
  begin
    {Jika inputan baru}
    if FSelectedUserRole.FData.UserRoleIndex = 0 then
    begin
      ShowMessage('Please use another user role name');
      Exit;
    end
    else if LastName <> cbbUserRole.Text then
    begin
      ShowMessage('Please use another user role name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmSummaryUserRole.chkChangeClick(Sender: TObject);
begin
  btnOk.Enabled := True;
end;

procedure TfrmSummaryUserRole.edtChange(Sender: TObject);
begin
  btnOk.Enabled := True;
end;

{$ENDREGION}

end.

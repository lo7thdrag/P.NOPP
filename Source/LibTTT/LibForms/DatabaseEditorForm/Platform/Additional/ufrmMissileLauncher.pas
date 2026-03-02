unit ufrmMissileLauncher;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vcl.Imaging.pngimage{,
  newClassASTT, uDBAsset_Weapon};

type
  TfrmMissileLauncher = class(TForm)
    pnl1Title: TPanel;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    edtMaxQuantity: TEdit;
    cbbName: TComboBox;
    grbAngleRequired: TGroupBox;
    edtAngle: TEdit;
    cbAngleRequired: TCheckBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lblAngle: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure chkAngleRequiredClick(Sender: TObject);
    procedure edtAngleKeyPress(Sender: TObject; var Key: Char);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
//    FSelectedMissile : TMissile_On_Board;
//    FSelectedLauncher : TFitted_Weap_Launcher_On_Board;

    function CekInput: Boolean;
    procedure UpdateLauncherData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastLauncher : byte;

//    property SelectedMissile : TMissile_On_Board read FSelectedMissile write FSelectedMissile;
//    property SelectedLauncher : TFitted_Weap_Launcher_On_Board read FSelectedLauncher write FSelectedLauncher;
  end;

var
  frmMissileLauncher: TfrmMissileLauncher;


implementation

uses
  uDataModule;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmMissileLauncher.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := cafree;
end;

procedure TfrmMissileLauncher.FormShow(Sender: TObject);
begin
//  UpdateLauncherData;
//
//  with FSelectedLauncher.FData do
//    btnApply.Enabled := Fitted_Weap_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmMissileLauncher.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  if isOk then
    Close;
end;

procedure TfrmMissileLauncher.btnApplyClick(Sender: TObject);
begin
//  if not CekInput then
//  begin
//    isOK := False;
//    Exit;
//  end;
//
//  ValidationFormatInput;
//
//  with FSelectedLauncher do
//  begin
//    FData.LastLauncher_Type := LastLauncher + 1 ;
//    FData.Launcher_Type := cbbName.ItemIndex + 1;
//    FData.Launcher_Max_Qty := StrToInt(edtMaxQuantity.Text);
//    FData.Launcher_Angle_Required := Ord(cbAngleRequired.Checked);
//    FData.Launcher_Angle := StrToInt(edtAngle.Text);
//
//    if FData.Fitted_Weap_Index = 0 then
//    begin
//      FData.Fitted_Weap_Index := FSelectedMissile.FData.Fitted_Weap_Index;
//      dmTTT.InsertFittedWeaponLauncherOnBoard(FData);
//    end
//    else
//      dmTTT.UpdateFittedWeaponLauncherOnBoard(FData);
//  end;
//
//  isOK := True;
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;
end;

procedure TfrmMissileLauncher.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

function TfrmMissileLauncher.CekInput: Boolean;
begin
//  Result := False;
//
//  if cbbName.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Launcher Name');
//    Exit;
//  end;
//
//  {Jika Launcher Name sudah ada}
//  if dmTTT.GetFittedWeaponLauncherOnBoardCount(FSelectedMissile.FData.Fitted_Weap_Index, cbbName.ItemIndex + 1) then
//  begin
//    if FSelectedLauncher.FData.Fitted_Weap_Index = 0 then
//    begin
//      ShowMessage('Duplicate launcher !' + Char(13) + 'Choose different launcher to continue.');
//      Exit;
//    end;
//  end;
//
//  Result := True;
end;

procedure TfrmMissileLauncher.UpdateLauncherData;
begin
//  with FSelectedLauncher.FData do
//  begin
//    LastLauncher := Launcher_Type - 1;
//    cbbName.ItemIndex := Launcher_Type - 1;
//    edtMaxQuantity.Text := FormatFloat('0', Launcher_Max_Qty);
//    cbAngleRequired.Checked := Boolean(Launcher_Angle_Required);
//    edtAngle.Text := IntToStr(Launcher_Angle);
//  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmMissileLauncher.GetNumberOfKoma(s: string): Boolean;
var
  a, i : Integer;
begin
  Result := False;
  a := 0;

  for i := 1 to length(s) do
  begin
    if s[i] = '.' then
      a := a + 1;
  end;

  if a > 0 then
    Result := True;
end;

procedure TfrmMissileLauncher.edtNumeralKeyPress(Sender: TObject; var Key: Char);
var
  value : Double;
begin
  if not (Key in[#48 .. #57, #8, #13, #46]) then
  begin
    Key := #0;
    Exit;
  end;

  if GetNumberOfKoma(TEdit(sender).Text) then
  begin
    if Key = #46 then
      Key := #0;
  end;

  if Key = #13 then
  begin
    if TEdit(Sender).Text = '' then
      TEdit(Sender).Text := '0';

    value := StrToFloat(TEdit(Sender).Text);

    case TEdit(Sender).Tag of
      0: TEdit(Sender).Text := FormatFloat('0', value);
      1: TEdit(Sender).Text := FormatFloat('0.0', value);
      2: TEdit(Sender).Text := FormatFloat('0.00', value);
      3: TEdit(Sender).Text := FormatFloat('0.000', value);
    end;

    btnApply.Enabled := True;
  end;
end;

procedure TfrmMissileLauncher.chkAngleRequiredClick(Sender: TObject);
begin
  grbAngleRequired.Enabled := cbAngleRequired.Checked;

  if not cbAngleRequired.Checked then
  begin
    edtAngle.Text := '0';
  end;

  btnApply.Enabled := True;
end;

procedure TfrmMissileLauncher.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmMissileLauncher.edtAngleKeyPress(Sender: TObject; var Key: Char);
var
  value : Integer;
begin
  if not (Key in [#48 .. #57, #8, #13]) then
    Key := #0;

  if Key = #13 then
  begin
    value := StrToInt(edtAngle.Text);

    if value >= 360 then
      value := 0;

    edtAngle.Text := IntToStr(value);
    btnApply.Enabled := True;
  end;
end;

procedure TfrmMissileLauncher.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmMissileLauncher.ValidationFormatInput;
var
  i: Integer;
  value : Double;

begin
  for i:=0 to ComponentCount-1 do
  begin
    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Tag = 4 then
        continue;

      if TEdit(Components[i]).Text = '' then
        TEdit(Components[i]).Text := '0';

      value := StrToFloat(TEdit(Components[i]).Text);

      case TEdit(Components[i]).Tag of
        0: TEdit(Components[i]).Text := FormatFloat('0', value);
        1: TEdit(Components[i]).Text := FormatFloat('0.0', value);
        2: TEdit(Components[i]).Text := FormatFloat('0.00', value);
        3: TEdit(Components[i]).Text := FormatFloat('0.000', value);
      end;
    end;
  end;
end;

{$ENDREGION}

end.

unit ufrmMissileMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage, uBaseCoordSystem, Vcl.Mask,

  uDBAsset_Weapon, uClassData, uSimContainers ;

type
  TfrmMissileMount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    cbMountExtension: TComboBox;
    edtQuantity: TEdit;
    btnEditLaunchers: TButton;
    pnlBlindZone: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    edtClassName: TLabel;
    edtReload: TMaskEdit;
    lblPlatform: TLabel;
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure cbMountExtensionChange(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnEditLaunchersClick(Sender: TObject);


  private
    FSelectedVehicle : TAsset;
    FSelectedMissile : TMissile_On_Board;

    function CekInput: Boolean;
    procedure UpdateMissileData;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedMissile : TMissile_On_Board read FSelectedMissile write FSelectedMissile;
  end;

var
  frmMissileMount: TfrmMissileMount;

implementation

uses
  uDataModule, ufrmMissileOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmMissileMount.FormShow(Sender: TObject);
begin
  UpdateMissileData;

  with FSelectedMissile.FData do
    btnApply.Enabled := Fitted_Weap_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmMissileMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

    frmMissileOnBoardPickList.UpdateMissileList;
    Close;
end;

procedure TfrmMissileMount.btnApplyClick(Sender: TObject);
var
  reloadTime : Integer;

begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedMissile do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Mount_Type := cbMountExtension.ItemIndex;
    FData.Quantity := StrToInt(edtQuantity.Text);

    TimeToSecond(edtReload.Text, reloadTime);
    FData.Firing_Delay := reloadTime;

    FData.Missile_Index := FDef.Missile_Index;

    if FData.Fitted_Weap_Index = 0 then
      dmINWO.InsertFittedWeaponOnBoard(1, FData)
    else
      dmINWO.UpdateFittedWeaponOnBoard(1, FData);
  end;

  UpdateMissileData;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmMissileMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMissileMount.btnEditLaunchersClick(Sender: TObject);
begin
//  frmLauncherList := TfrmLauncherList.Create(Self);
//  try
//    with frmLauncherList do
//    begin
//      LauncherOwner := loMissile;
//      SelectedWeapon := FSelectedMissile;
//      ShowModal ;
//    end;
//    AfterClose := frmLauncherList.AfterClose;
//  finally
//    frmLauncherList.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmMissileMount.cbMountExtensionChange(Sender: TObject);
begin
  edtName.Text := FSelectedMissile.FDef.Class_Identifier + ' ' +
    cbMountExtension.Text;

  btnApply.Enabled := True;
end;

function TfrmMissileMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetFittedWeaponOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedMissile.FData.Fitted_Weap_Index = 0 then
    begin
      ShowMessage('Duplicate missile mount!' + Char(13) + 'Choose different name to continue.');
      Exit;
    end
    else if LastName <> edtName.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmMissileMount.UpdateMissileData;
var
  timeStr : string;
begin
  with FSelectedMissile do
  begin
    cbMountExtension.ItemIndex := FData.Instance_Type;

    if FData.Fitted_Weap_Index = 0 then
      edtName.Text := FDef.Class_Identifier + ' ' + cbMountExtension.Text
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;
    edtClassName.Caption := FDef.Class_Identifier;

    edtQuantity.Text := FormatFloat('0', FData.Quantity);
    SecondToTime(Round(FData.Firing_Delay), timeStr);
    edtReload.Text := timeStr;

    btnEditLaunchers.Enabled := FData.Fitted_Weap_Index <> 0;
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmMissileMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmMissileMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmMissileMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmMissileMount.ValidationFormatInput;
var
  i, j: Integer;
  value : Double;
  hStr, mStr, sStr, hmSeparator, msSeparator : string;
  h, m, s : Integer;
  aTimeStr : string;
  flag : Boolean;

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

    if Components[i] is TMaskEdit then
    begin
      aTimeStr := TMaskEdit(Components[i]).Text;
      flag := False;

      hStr := Copy(aTimeStr, 1, 2);
      TryStrToInt(hStr, h);

      mStr := Copy(aTimeStr, 4, 2);
      TryStrToInt(mStr, m);

      sStr := Copy(aTimeStr, 7, 2);
      TryStrToInt(sStr, s);

      if h > 23 then
      begin
        hStr := '23';
        flag := True;
      end;

      if m > 59 then
      begin
        mStr := '59';
        flag := True;
      end;

      if s > 59 then
      begin
        sStr := '59';
        flag := True;
      end;

      if flag then
        TMaskEdit(Components[i]).Text := hStr + ':' + mStr + ':' + sStr;
    end;
  end;
end;

{$ENDREGION}

end.

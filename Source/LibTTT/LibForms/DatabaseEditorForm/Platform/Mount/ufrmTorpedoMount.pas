unit ufrmTorpedoMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage, uBaseCoordSystem, Vcl.Mask,

  uDBAsset_Weapon, uClassData, uSimContainers ;

type
  TfrmTorpedoMount = class(TForm)
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
    FSelectedTorpedo : TTorpedo_On_Board;

    function CekInput: Boolean;
    procedure UpdateTorpedoData;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedTorpedo : TTorpedo_On_Board read FSelectedTorpedo write FSelectedTorpedo;
  end;

var
  frmTorpedoMount: TfrmTorpedoMount;

implementation

uses
  uDataModule, ufrmTorpedoOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmTorpedoMount.FormShow(Sender: TObject);
begin
  UpdateTorpedoData;

  with FSelectedTorpedo.FData do
    btnApply.Enabled := Fitted_Weap_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmTorpedoMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmTorpedoOnBoardPickList.UpdateTorpedoList;
  Close;
end;

procedure TfrmTorpedoMount.btnApplyClick(Sender: TObject);
var
  reloadTime : Integer;
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedTorpedo do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Mount_Type := cbMountExtension.ItemIndex;
    FData.Quantity := StrToInt(edtQuantity.Text);

    TimeToSecond(edtReload.Text, reloadTime);
    FData.Firing_Delay := reloadTime;

    FData.Torpedo_Index := FDef.Torpedo_Index;

    if FData.Fitted_Weap_Index = 0 then
      dmINWO.InsertFittedWeaponOnBoard(2, FData)
    else
      dmINWO.UpdateFittedWeaponOnBoard(2, FData);
  end;

  UpdateTorpedoData;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmTorpedoMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTorpedoMount.btnEditLaunchersClick(Sender: TObject);
begin
//  frmLauncherList := TfrmLauncherList.Create(Self);
//  try
//    with frmLauncherList do
//    begin
//      LauncherOwner := loTorpedo;
//      SelectedWeapon := FSelectedTorpedo;
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

procedure TfrmTorpedoMount.cbMountExtensionChange(Sender: TObject);
begin
  edtName.Text := FSelectedTorpedo.FDef.Class_Identifier + ' ' + cbMountExtension.Text;

  btnApply.Enabled := True;
end;

function TfrmTorpedoMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetFittedWeaponOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedTorpedo.FData.Fitted_Weap_Index = 0 then
    begin
      ShowMessage('Duplicate torpedo mount!' + Char(13) + 'Choose different name to continue.');
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

procedure TfrmTorpedoMount.UpdateTorpedoData;
var
  timeStr : string;
begin
  with FSelectedTorpedo do
  begin
    cbMountExtension.ItemIndex := FData.Instance_Type;

    if FData.Fitted_Weap_Index = 0 then
      edtName.Text := FDef.Class_Identifier + ' ' + cbMountExtension.Text
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;
    edtClassName.Caption := FDef.Class_Identifier;

    edtQuantity.Text := FormatFloat('0',FData.Quantity);
    SecondToTime(Round(FData.Firing_Delay), timeStr);
    edtReload.Text := timeStr;

    btnEditLaunchers.Enabled := FData.Fitted_Weap_Index <> 0;
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmTorpedoMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmTorpedoMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmTorpedoMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmTorpedoMount.ValidationFormatInput;
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

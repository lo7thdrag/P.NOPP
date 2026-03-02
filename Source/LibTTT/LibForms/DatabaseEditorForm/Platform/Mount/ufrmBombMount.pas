unit ufrmBombMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage, uBaseCoordSystem,

  uDBAsset_Weapon, uClassData, uSimContainers;

type
  TfrmBombMount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    cbMountExtension: TComboBox;
    edtQuantity: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    edtClassName: TLabel;
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

  private
    FSelectedVehicle : TAsset;
    FSelectedBomb : TBomb_On_Board;

//    FBlindZoneView : TBlindZoneView;

    function CekInput: Boolean;
    procedure UpdateBombData;


  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedBomb : TBomb_On_Board read FSelectedBomb write FSelectedBomb;

  end;

var
  frmBombMount: TfrmBombMount;

implementation

uses
  uDataModule, ufrmBombOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmBombMount.FormShow(Sender: TObject);
begin
  UpdateBombData;

  with FSelectedBomb.FData do
    btnApply.Enabled := Point_Effect_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmBombMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmBombOnBoardPickList.UpdateBombList;
  Close;
end;

procedure TfrmBombMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedBomb do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Mount_Type := cbMountExtension.ItemIndex;
    FData.Quantity := StrToInt(edtQuantity.Text);
    FData.Bomb_Index := FDef.Bomb_Index;

    if FData.Point_Effect_Index = 0 then
      dmINWO.InsertPointEffectOnBoard(2, FData)
    else
      dmINWO.UpdatePointEffectOnBoard(2, FData)
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmBombMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBombMount.cbMountExtensionChange(Sender: TObject);
begin
  edtName.Text := FSelectedBomb.FDef.Bomb_Identifier + ' ' + cbMountExtension.Text;

  btnApply.Enabled := True;
end;

function TfrmBombMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetPointEffectOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedBomb.FData.Point_Effect_Index = 0 then
    begin
      ShowMessage('Duplicate bomb mount!' + Char(13) + 'Choose different name to continue.');
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

procedure TfrmBombMount.UpdateBombData;
begin
  with FSelectedBomb do
  begin
    cbMountExtension.ItemIndex := FData.Mount_Type;

    if FData.Point_Effect_Index = 0 then
      edtName.Text := FDef.Bomb_Identifier + ' ' + cbMountExtension.Text
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;
    edtClassName.Caption := FDef.Bomb_Identifier;

    edtQuantity.Text := FormatFloat('0', FData.Quantity);

  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmBombMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmBombMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmBombMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmBombMount.ValidationFormatInput;
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

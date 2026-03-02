unit ufrmSonobuoyMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers;

type
  TfrmSonobuoyMount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    cbMountExtension: TComboBox;
    edtQuantity: TEdit;
    edtSonarMount: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    edtClassName: TLabel;
    lblPlatform: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    FSelectedSonobuoy : TSonobuoy_On_Board;

    function CekInput: Boolean;
    procedure UpdateSonobuoyData;
//    procedure DrawBlindZone;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedSonobuoy : TSonobuoy_On_Board read FSelectedSonobuoy write FSelectedSonobuoy;
  end;

var
  frmSonobuoyMount : TfrmSonobuoyMount;

implementation

uses
  uDataModule, ufrmSonobuoyOnBoardPickList ;

{$R *.dfm}


{$REGION ' Form Handle '}

procedure TfrmSonobuoyMount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmSonobuoyMount.FormShow(Sender: TObject);
begin
  UpdateSonobuoyData;

  with FSelectedSonobuoy.FData do
    btnApply.Enabled := Sonobuoy_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSonobuoyMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

    frmSonobuoyOnBoardPickList.UpdateSonobuoyList;
    Close;
end;

procedure TfrmSonobuoyMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedSonobuoy do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Instance_Type := cbMountExtension.ItemIndex;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Sonobuoy_Index := FDef.Sonobuoy_Index;
    FData.Quantity := StrToInt(edtQuantity.Text);
    FData.Sonar_Instance_Index := FDef.Sonar_Index;

    if FData.Sonobuoy_Instance_Index = 0 then
      dmINWO.InsertSonobuoyOnBoard(FData)
    else
      dmINWO.UpdateSonobuoyOnBoard(FData);
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSonobuoyMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSonobuoyMount.cbMountExtensionChange(Sender: TObject);
begin
  edtName.Text := FSelectedSonobuoy.FDef.Class_Identifier + ' ' + cbMountExtension.Text;

  btnApply.Enabled := True;
end;

function TfrmSonobuoyMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetSonobuoyOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text)then
  begin
    {Jika inputan baru}
    if FSelectedSonobuoy.FData.Sonobuoy_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate Sonobuoy mount!' + Char(13) + 'Choose different mount to continue.');
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

procedure TfrmSonobuoyMount.UpdateSonobuoyData;
begin
  with FSelectedSonobuoy do
  begin
    cbMountExtension.ItemIndex := FData.Instance_Type;

    if FData.Sonobuoy_Instance_Index = 0 then
      edtName.Text := FDef.Class_Identifier + ' ' + cbMountExtension.Text
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;
    edtClassName.Caption := FDef.Class_Identifier;

    FData.Quantity := StrToInt(edtQuantity.Text);
    FData.Sonar_Instance_Index := FDef.Sonar_Index;

    edtQuantity.Text := FormatFloat('0', FData.Quantity);
//    edtSonarMount.Text := FSonar.FDef.Sonar_Identifier;
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSonobuoyMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSonobuoyMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSonobuoyMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSonobuoyMount.ValidationFormatInput;
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

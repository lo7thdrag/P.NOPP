unit ufrmTowedJammerMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Countermeasure, uClassData, uSimContainers;

type
  TfrmTowedJammerMount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    edtQuantity: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
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
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedVehicle : TAsset;
    FSelectedTowedJammerDecoy : TTowed_Decoy_On_Board;
    procedure UpdateTowedJammerDecoyData;
    function CekInput: Boolean;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedTowedJammerDecoy : TTowed_Decoy_On_Board read FSelectedTowedJammerDecoy write FSelectedTowedJammerDecoy;

  end;

var
  frmTowedJammerMount: TfrmTowedJammerMount;


implementation

uses
  uDataModule, ufrmTowedJammerDecoyOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmTowedJammerMount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := cafree;
end;

procedure TfrmTowedJammerMount.FormShow(Sender: TObject);
begin
  UpdateTowedJammerDecoyData;

  with FSelectedTowedJammerDecoy.FData do
    btnApply.Enabled := Towed_Decoy_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmTowedJammerMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

    frmTowedJammerDecoyOnBoardPickList.UpdateTowedJammerDecoyList;
    Close;
end;

procedure TfrmTowedJammerMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedTowedJammerDecoy do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Instance_Type := 0;
    FData.Quantity := StrToInt(edtQuantity.Text);
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Towed_Decoy_Index := FDef.Towed_Decoy_Index;

    if FData.Towed_Decoy_Instance_Index = 0 then
      dmINWO.InsertTowedJammerDecoyOnBoard(FData)
    else
      dmINWO.UpdateTowedJammerDecoyOnBoard(FData);
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmTowedJammerMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmTowedJammerMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetTowedJammerOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedTowedJammerDecoy.FData.Towed_Decoy_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate Towed Jammer Decoy!' + Char(13) + 'Choose Towed Jammer Decoy to continue.');
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

procedure TfrmTowedJammerMount.UpdateTowedJammerDecoyData;
begin
  with FSelectedTowedJammerDecoy do
  begin
    if FData.Towed_Decoy_Instance_Index = 0 then
      edtName.Text := FDef.Towed_Decoy_Identifier
    else
      edtName.Text := FData.Instance_Identifier;

      LastName := edtName.Text;

    edtQuantity.Text := IntToStr(FData.Quantity);
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmTowedJammerMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmTowedJammerMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmTowedJammerMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmTowedJammerMount.ValidationFormatInput;
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

unit ufrmIFFMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, {uDBAsset_Vehicle, uDBAsset_Sensor,}
  Vcl.Imaging.pngimage;

type
  TfrmIFFMount = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    pnl1Title: TPanel;
    lbl1: TLabel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    cbbCapability: TComboBox;
    edtAntenna: TEdit;
    edtSubmerged: TEdit;
    edtMaxOperational: TEdit;
    lblPlatform: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
//    FSelectedVehicle : TVehicle_Definition;
//    FSelectedIFF : TIFF_Sensor_On_Board;

    function CekInput: Boolean;
    procedure UpdateIFFData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}
    LastName : string;
//    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;
//    property SelectedIFF : TIFF_Sensor_On_Board read FSelectedIFF write FSelectedIFF;

  end;

var
  frmIFFMount: TfrmIFFMount;

implementation

uses
  uDataModule;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmIFFMount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmIFFMount.FormShow(Sender: TObject);
begin
//  UpdateIFFData;
//
//  with FSelectedIFF.FData do
//    btnApply.Enabled := IFF_Instance_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmIFFMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  Close;
end;

procedure TfrmIFFMount.btnApplyClick(Sender: TObject);
begin
//  if not CekInput then
//  begin
//    isOK := False;
//    Exit;
//  end;
//
//  ValidationFormatInput;
//
//  with FSelectedIFF do
//  begin
//    LastName := edtName.Text;
//    FData.Instance_Identifier := edtName.Text;
//    FData.Instance_Type := 0;
//    FData.Vehicle_Index := FSelectedVehicle.FData.Vehicle_Index;
//    FData.IFF_Capability := cbbCapability.ItemIndex;;
//    FData.Rel_Antenna_Height := StrToFloat(edtAntenna.Text);
//    FData.Submerged_Antenna_Height := StrToFloat(edtSubmerged.Text);
//    FData.Max_Operational_Depth := StrToFloat(edtMaxOperational.Text);
//
//    if FData.IFF_Instance_Index = 0 then
//      dmTTT.InsertIFFOnBoard(FData)
//    else
//      dmTTT.UpdateIFFOnBoard(FData);
//  end;
//
//  isOK := True;
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;
end;

procedure TfrmIFFMount.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

function TfrmIFFMount.CekInput: Boolean;
begin
//  Result := False;
//
//  {Jika Mount Name sudah ada}
//  if dmTTT.GetIFFOnBoardCount(FSelectedVehicle.FData.Vehicle_Index, edtName.Text) then
//  begin
//    {Jika inputan baru}
//    if FSelectedIFF.FData.IFF_Instance_Index = 0 then
//    begin
//      ShowMessage('Duplicate IFF!' + Char(13) + 'Choose only one IFF.');
//      Exit;
//    end
//    else if LastName <> edtName.Text then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end;
//  end;
//
//  Result := True;
end;

procedure TfrmIFFMount.UpdateIFFData;
begin
//  with FSelectedIFF.FData do
//  begin
//    edtName.Text := Instance_Identifier;
//    cbbCapability.ItemIndex := IFF_Capability;
//    LastName := edtName.Text;
//    edtAntenna.Text := FormatFloat('0', Rel_Antenna_Height);
//    edtSubmerged.Text := FormatFloat('0', Submerged_Antenna_Height);
//    edtMaxOperational.Text := FormatFloat('0', Max_Operational_Depth);
//  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmIFFMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmIFFMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmIFFMount.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmIFFMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmIFFMount.ValidationFormatInput;
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

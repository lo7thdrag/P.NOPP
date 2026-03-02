unit ufrmSummaryRadarNoiseJammer;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ComCtrls,
  Dialogs, StdCtrls, ExtCtrls, Buttons, math, Vcl.Imaging.pngimage, Vcl.Mask,

  {Project Uses}
  uConstantaData, uDBAsset_Countermeasure, uDataModule, uBaseCoordSystem;

type
  TfrmSummaryRadarNoiseJammer = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    lblPowerDensity: TLabel;
    lbl1: TLabel;
    lblMaxEffectiveRange: TLabel;
    lbl2: TLabel;
    lblJammerType: TLabel;
    lblMaxSectorWidth: TLabel;
    lbl3: TLabel;
    edtPowerDensity: TEdit;
    grbFreqOperatingLimits: TGroupBox;
    lblLowerFreqLimit: TLabel;
    lbl4: TLabel;
    lblUpperFreqLimit: TLabel;
    lbl5: TLabel;
    edtLowerFreqLimit: TEdit;
    edtUpperFreqLimit: TEdit;
    edtMaxEffectiveRange: TEdit;
    cbbJammerType: TComboBox;
    edtMaxSectorWidth: TEdit;
    grbVerticalCoverageLimits: TGroupBox;
    lblLowerVerticalLimit: TLabel;
    lbl6: TLabel;
    lblUpperVerticalLimit: TLabel;
    lbl7: TLabel;
    edtLowerVerticalLimit: TEdit;
    edtUpperVerticalLimit: TEdit;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    lblPlatform: TLabel;
    imgBackgroundForm: TImage;
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
    FSelectedRadarJammer : TRadar_Noise_Jammer_On_Board;

    function CekInput: Boolean;
    procedure UpdateRadarJammerData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedRadarJammer : TRadar_Noise_Jammer_On_Board read FSelectedRadarJammer write FSelectedRadarJammer;
  end;

var
  frmSummaryRadarNoiseJammer: TfrmSummaryRadarNoiseJammer;

implementation

{$R *.dfm}
uses
  ufrmRadarNoiseJammerOnBoardPickList;

{$REGION ' Form Handle '}

procedure TfrmSummaryRadarNoiseJammer.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateRadarJammerData;

  with FSelectedRadarJammer.FDef do
    btnApply.Enabled := Jammer_Index = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryRadarNoiseJammer.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmradarnoisejammerOnBoardPickList.UpdateRadarJammerList;
  Close;
end;

procedure TfrmSummaryRadarNoiseJammer.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
    Exit;
  with FSelectedRadarJammer do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Jammer_Identifier := edtClass.Text;

    FDef.Jammer_Power_Density := StrToFloat(edtPowerDensity.Text);
    FDef.Max_Effective_Range := StrToFloat(edtMaxEffectiveRange.Text);
    FDef.Max_Sector_Width := StrToFloat(edtMaxSectorWidth.Text);
    FDef.Jammer_Type := cbbJammerType.ItemIndex;

    FDef.Lower_Freq_Limit := StrToFloat(edtLowerFreqLimit.Text);
    FDef.Upper_Freq_Limit := StrToFloat(edtUpperFreqLimit.Text);

    FDef.Lower_Vert_Coverage_Angle := StrToFloat(edtLowerVerticalLimit.Text);
    FDef.Upper_Vert_Coverage_Angle := StrToFloat(edtUpperVerticalLimit.Text);
    {$ENDREGION}
    if FDef.Jammer_Index = 0 then
    begin
      if dminwo.InsertRadarNoiseJammerDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateRadarNoiseJammerDef(FDef) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  isOK := True;
  AfterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryRadarNoiseJammer.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryRadarNoiseJammer.UpdateRadarJammerData;
begin
  with FSelectedRadarJammer do
  begin
    if FDef.Jammer_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Jammer_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    edtPowerDensity.Text := FormatFloat('0.00', FDef.Jammer_Power_Density);
    edtMaxEffectiveRange.Text := FormatFloat('0.00', FDef.Max_Effective_Range);
    edtMaxSectorWidth.Text := FormatFloat('0', FDef.Max_Sector_Width);
    cbbJammerType.ItemIndex := FDef.Jammer_Type;

    edtLowerFreqLimit.Text := FormatFloat('0.0', FDef.Lower_Freq_Limit);
    edtUpperFreqLimit.Text := FormatFloat('0.0', FDef.Upper_Freq_Limit);

    edtLowerVerticalLimit.Text := FormatFloat('0', FDef.Lower_Vert_Coverage_Angle);
    edtUpperVerticalLimit.Text := FormatFloat('0', FDef.Upper_Vert_Coverage_Angle);
    {$ENDREGION}
  end;
end;

function TfrmSummaryRadarNoiseJammer.CekInput: Boolean;
var
  i, chkSpace, numSpace: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (edtClass.Text = '')then
  begin
    ShowMessage('Please insert class name');
    Exit;
  end;

  {Jika berisi spasi semua}
  if Copy(edtClass.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtClass.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtClass.Text[i] = #32 then
      numSpace := numSpace + 1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  {Jika Class Name sudah ada}
  if (dmINWO.GetRadarNoiseJammerDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedRadarJammer.FDef.Jammer_Index = 0 then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end
    else if LastName <> edtClass.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;
{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummaryRadarNoiseJammer.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryRadarNoiseJammer.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryRadarNoiseJammer.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadarNoiseJammer.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryRadarNoiseJammer.ValidationFormatInput;
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

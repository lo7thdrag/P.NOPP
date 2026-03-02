unit ufrmSummaryESM;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ComCtrls,
  Dialogs, StdCtrls, ExtCtrls, Buttons, math, Vcl.Imaging.pngimage, Vcl.Mask,

  {Project Uses}
  uConstantaData, uDBAsset_Sensor, uDataModule, uBaseCoordSystem;

type
  TfrmSummaryESM = class(TForm)
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    gbClassificationCharacteristics: TGroupBox;
    lblClassificationPeriod: TLabel;
    lblIdentficationPeriod: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblMaximumConfidenceLevel: TLabel;
    cbbMaximumConfidenceLevel: TComboBox;
    medtClassificationPeriod: TMaskEdit;
    medtIdentificationPeriod: TMaskEdit;
    chkCommunicationInterceptCapable: TCheckBox;
    grpFirstFrequencyDetectionBand: TGroupBox;
    lblLowerLimitFirst: TLabel;
    lblUpperLimitFirst: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtLowerLimitFirst: TEdit;
    edtUpperLimitFirst: TEdit;
    grbSecondFrequency: TGroupBox;
    lblLowerLimitSecond: TLabel;
    lblUpperLimitSecond: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtLowerLimitSecond: TEdit;
    edtUpperLimitSecond: TEdit;
    chkSecondFrequencyDetectionBand: TCheckBox;
    grpDetectionCharacteristics: TGroupBox;
    lblEmitterDetectionRangeFactor: TLabel;
    lblSectorBlankDetectionFactor: TLabel;
    edtEmitterDetectionRangeFactor: TEdit;
    edtSectorBlankDetectionFactor: TEdit;
    grpBearingErrorVariance: TGroupBox;
    lblMinimun: TLabel;
    lblInitial: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    edtMinimum: TEdit;
    edtInitial: TEdit;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
    Procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure CheckBoxDataClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure chkSecondFrequencyDetectionBandClick(Sender: TObject);

  private
    FSelectedESM : TESM_On_Board;

    function CekInput: Boolean;
    procedure UpdateESMData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedESM : TESM_On_Board read FSelectedESM write FSelectedESM;
  end;

var
  frmSummaryESM: TfrmSummaryESM;

implementation

{$R *.dfm}

uses
  ufrmESMOnBoardPickList;

{$REGION ' Form Handle '}

procedure TfrmSummaryESM.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateESMData;

  with FSelectedESM.FDef do
    btnApply.Enabled := ESM_Index = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryESM.btnApplyClick(Sender: TObject);
var
  second : Integer;
begin

  with FSelectedESM do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Class_Identifier := edtClass.Text;
    FDef.ESM_Classification := cbbMaximumConfidenceLevel.ItemIndex;

    TimeToSecond(medtClassificationPeriod.Text, second);
    FDef.Classification_Period := second;

    TimeToSecond(medtIdentificationPeriod.Text, second);
    FDef.Identification_Period := second;

    FDef.Comm_Intercept_Capable := Ord(chkCommunicationInterceptCapable.Checked);

    FDef.Low_Detect_Frequency1 := StrToFloat(edtLowerLimitFirst.Text);
    FDef.High_Detect_Frequency1 := StrToFloat(edtUpperLimitFirst.Text);

    FDef.Second_Frequency_Detection_Capable := Ord(chkSecondFrequencyDetectionBand.Checked);

    FDef.Low_Detect_Frequency2 := StrToFloat(edtLowerLimitSecond.Text);
    FDef.High_Detect_Frequency2 := StrToFloat(edtUpperLimitSecond.Text);

    FDef.Emitter_Detect_Range_Factor := StrToFloat(edtEmitterDetectionRangeFactor.Text);
    FDef.Sector_Blank_Detection_Factor := StrToFloat(edtUpperLimitSecond.Text);

    FDef.Minimum_Bearing_Error_Variance := StrToFloat(edtMinimum.Text);
    FDef.Initial_Bearing_Error_Variance := StrToFloat(edtInitial.Text);

    {Catatan : di form tidak ada variabel2 dibawah ini}
    FDef.Frequency_Identify_Range := 2;
    FDef.PRF_Identify_Range := 1;
    FDef.Pulsewidth_Identify_Range := 1;
    FDef.Scan_Period_Identify_Range := 1;
    {---------------------------------------}

    {$ENDREGION}

    if FDef.ESM_Index = 0 then
    begin
      if dmINWO.InsertESMDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateESMDef(FDef) then
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

procedure TfrmSummaryESM.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryESM.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmESMOnBoardPickList.UpdateESMList;
  Close;
end;

procedure TfrmSummaryESM.chkSecondFrequencyDetectionBandClick(Sender: TObject);
begin
  grbSecondFrequency.Enabled := chkSecondFrequencyDetectionBand.Checked;

  if not chkSecondFrequencyDetectionBand.Checked then
  begin
    edtLowerLimitSecond.Text := '0.0';
    edtUpperLimitSecond.Text := '0.0';
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryESM.UpdateESMData;
var
  timeStr : string;
begin
  with FSelectedESM do
  begin
    if FDef.ESM_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Class_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    cbbMaximumConfidenceLevel.ItemIndex := FDef.ESM_Classification;

    SecondToTime(Round(FDef.Classification_Period), timeStr);
    medtClassificationPeriod.Text := timeStr;

    SecondToTime(Round(FDef.Identification_Period), timeStr);
    medtIdentificationPeriod.Text := timeStr;

    chkCommunicationInterceptCapable.Checked :=Boolean(FDef.Comm_Intercept_Capable);
    edtLowerLimitFirst.Text := FormatFloat('0.0', FDef.Low_Detect_Frequency1);
    edtUpperLimitFirst.Text := FormatFloat('0.0', FDef.High_Detect_Frequency1);

    edtLowerLimitSecond.Text := FormatFloat('0.0', FDef.Low_Detect_Frequency2);
    edtUpperLimitSecond.Text := FormatFloat('0.0', FDef.High_Detect_Frequency2);

    edtEmitterDetectionRangeFactor.Text := FormatFloat('0', FDef.Emitter_Detect_Range_Factor);
    edtSectorBlankDetectionFactor.Text  := FormatFloat('0', FDef.Sector_Blank_Detection_Factor);

    chkSecondFrequencyDetectionBand.Checked := Boolean(FDef.Second_Frequency_Detection_Capable);
    edtMinimum.Text := FormatFloat('0', FDef.Minimum_Bearing_Error_Variance);
    edtInitial.Text := FormatFloat('0', FDef.Initial_Bearing_Error_Variance);
    {$ENDREGION}

  end;
end;

function TfrmSummaryESM.CekInput : Boolean;
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
  if (dmINWO.GetESMDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedESM.FDef.ESM_Index = 0 then
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

function TfrmSummaryESM.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryESM.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryESM.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryESM.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryESM.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryESM.ValidationFormatInput;
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

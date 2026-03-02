unit ufrmSummarySonar;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ComCtrls,
  Dialogs, StdCtrls, ExtCtrls, Buttons, math, Vcl.Imaging.pngimage, Vcl.Mask,

  {Project Uses}
  uConstantaData, uDBAsset_Sensor, uDataModule, uBaseCoordSystem;

type
  TfrmSummarySonar = class(TForm)
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    grpActiveDetectionCapabilities: TGroupBox;
    chkSurfaceDetecting: TCheckBox;
    chkSubSurfaceDetecting: TCheckBox;
    chkTorpedoDetecting: TCheckBox;
    chkMineDetecting: TCheckBox;
    GroupBox1: TGroupBox;
    lblPassiveDetectionRange: TLabel;
    lblActiveDetectionRange: TLabel;
    lblMaxDetectionRange: TLabel;
    Label13: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    edtMaxDetectionRange: TEdit;
    edtActiveDetectionRange: TEdit;
    edtPassiveDetectionRange: TEdit;
    GroupBox3: TGroupBox;
    lblPassiveFrequency: TLabel;
    lblActiveFrequency: TLabel;
    Label37: TLabel;
    Label39: TLabel;
    edtActiveFrequency: TEdit;
    edtPassiveFrequency: TEdit;
    GroupBox4: TGroupBox;
    Label15: TLabel;
    lblOwnshipNoiseDueSonarActiveMode: TLabel;
    lblMaxSonarSpeed: TLabel;
    lblMaxOperatingDepth: TLabel;
    lblActiveSonarPower: TLabel;
    lblSignalSourceLevel: TLabel;
    lblCrossSection: TLabel;
    Label32: TLabel;
    Label36: TLabel;
    Label14: TLabel;
    Label40: TLabel;
    edtOwnshipNoiseDueSonarActiveMode: TEdit;
    edtCrossSection: TEdit;
    cbbCrossSection: TComboBox;
    edtSignalSourceLevel: TEdit;
    edtActiveSonarPower: TEdit;
    edtMaxOperatingDepth: TEdit;
    edtMaxSonarSpeed: TEdit;
    GroupBox2: TGroupBox;
    lblCategory: TLabel;
    lblOperatingMode: TLabel;
    cbbCategory: TComboBox;
    cbbOperatingMode: TComboBox;
    tsCharacteristic: TTabSheet;
    txtSNRvsPODCurve: TLabel;
    lblTimeToIdentifyTarget: TLabel;
    lbl16: TLabel;
    lblCableLength: TLabel;
    lblCablePayoutRate: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    grpTimeIntervalofWatchSetting: TGroupBox;
    lblTimeIntervalWatchShort: TLabel;
    lbl13: TLabel;
    lblTimeIntervalWatchMedium: TLabel;
    lblTimeIntervalWatchLong: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edtTimeIntervalWatchShort: TEdit;
    edtTimeIntervalWatchMedium: TEdit;
    edtTimeIntervalWatchLong: TEdit;
    edtSNRvsPODCurve: TEdit;
    btnSNRvsPODCurve: TButton;
    grpIntegrationPeriod: TGroupBox;
    lblIntegrationPeriodActive: TLabel;
    lblIntegrationPeriodPassive: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    edtCableLength: TEdit;
    edtCablePayoutRate: TEdit;
    chkPassiveTargetInvestigation: TCheckBox;
    chkPassiveTMAInvestigating: TCheckBox;
    chkDepthFinding: TCheckBox;
    chkTracking: TCheckBox;
    tsTowedArray: TTabSheet;
    lblMinTowSpeed: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lblMinDepth: TLabel;
    lblMaxBearingError: TLabel;
    lblAverageBeamWidth: TLabel;
    grpKinking: TGroupBox;
    lblArrayKinkingTurnRate: TLabel;
    lblArrayKinkingSettleTime: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    edtArrayKinkingTurnRate: TEdit;
    chkArrayKinking: TCheckBox;
    edtMinTowSpeed: TEdit;
    edtMinDepth: TEdit;
    edtMaxBearingError: TEdit;
    edtAverageBeamWidth: TEdit;
    chkBearingAmbiguity: TCheckBox;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    pnl1Title: TPanel;
    edtClass: TEdit;
    medtTimeToIdentifyTarget: TMaskEdit;
    medtIntegrationPeriodActive: TMaskEdit;
    medtIntegrationPeriodPassive: TMaskEdit;
    medtArrayKinkingSettleTime: TMaskEdit;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure CheckBoxDataClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    //Characteristic
    procedure btnSNRvsPODCurveClick(Sender: TObject);

    //Towed Array
    procedure chkArrayKinkingClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedSonar : TSonar_On_Board;

    function CekInput: Boolean;
    procedure UpdateSonarData;
    procedure UpdateSNRvsPODData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedSonar : TSonar_On_Board read FSelectedSonar write FSelectedSonar;
  end;

var
  frmSummarySonar: TfrmSummarySonar;

implementation

{$R *.dfm}
uses
  ufrmSonarOnBoardPickList;

{$REGION ' Form Handle '}

procedure TfrmSummarySonar.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateSonarData;

  with FSelectedSonar.FDef do
    btnApply.Enabled := Sonar_Index = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummarySonar.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmSonarOnBoardPickList.UpdateSonarList;
  Close;
end;

procedure TfrmSummarySonar.btnApplyClick(Sender: TObject);
var
  second : Integer;

begin
  with FSelectedSonar do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Sonar_Identifier := edtClass.Text;
    FDef.Sonar_Category_Index := cbbCategory.ItemIndex;
    FDef.Sonar_Classification := cbbOperatingMode.ItemIndex;
    FDef.Surface_Detection_Capable := chkSurfaceDetecting.Checked;
    FDef.SubSurface_Detection_Capable := chkSubSurfaceDetecting.Checked;
    FDef.Torpedo_Detection_Capable := chkTorpedoDetecting.Checked;
    FDef.Mine_Detection_Capable := chkMineDetecting.Checked;
    FDef.Active_Detect_Range := StrToFloat(edtActiveDetectionRange.Text);
    FDef.Known_Cross_Section := StrToFloat(edtCrossSection.Text);
    FDef.Passive_Detect_Range := StrToFloat(edtPassiveDetectionRange.Text);
    FDef.Known_Signal_Source := StrToFloat(edtSignalSourceLevel.Text);
    FDef.Max_Detect_Range := StrToFloat(edtMaxDetectionRange.Text);
    FDef.Active_Operating_Power := StrToFloat(edtActiveSonarPower.Text);
    FDef.Active_Freq_of_Op := StrToFloat(edtActiveFrequency.Text);
    FDef.Passive_Freq_of_Op := StrToFloat(edtPassiveFrequency.Text);
    FDef.Max_Operating_Depth := StrToFloat(edtMaxOperatingDepth.Text);
    FDef.Ownship_Increase_due_to_Active :=
      StrToFloat(edtOwnshipNoiseDueSonarActiveMode.Text);
    FDef.Maximum_Sonar_Speed := StrToFloat(edtMaxSonarSpeed.Text);

    {$ENDREGION}

    {$REGION ' Characteristics '}
    TimeToSecond(medtIntegrationPeriodActive.Text, second);
    FDef.Active_Int_Period := second;

    TimeToSecond(medtIntegrationPeriodPassive.Text, second);
    FDef.Passive_Int_Period := second;

    FDef.TIOW_Short_Range := StrToFloat(edtTimeIntervalWatchShort.Text);
    FDef.TIOW_Medium_Range := StrToFloat(edtTimeIntervalWatchMedium.Text);
    FDef.TIOW_Long_Range := StrToFloat(edtTimeIntervalWatchLong.Text);

    TimeToSecond(medtTimeToIdentifyTarget.Text, second);
    FDef.Time_2_Identify := second;

    FDef.Cable_Length := StrToFloat(edtCableLength.Text);
    FDef.Depth_per_Speed := StrToFloat(edtCablePayoutRate.Text);

    FDef.Target_Identification := chkPassiveTargetInvestigation.Checked;
    FDef.Passive_Processing := chkPassiveTMAInvestigating.Checked;
    FDef.Depth_Finding_Capable := chkDepthFinding.Checked;
    FDef.Tracking_Capable := chkTracking.Checked;

    {$ENDREGION}

    {$REGION ' Tower Array '}
    FDef.Kinking_Processing := chkArrayKinking.Checked;
    FDef.Turn_Rate_2_Kink := StrToFloat(edtArrayKinkingTurnRate.Text);

    TimeToSecond(medtArrayKinkingSettleTime.Text, second);
    FDef.Time_2_Settle_Kinked := second;

    FDef.Tow_Speed := StrToFloat(edtMinTowSpeed.Text);
    FDef.Minimum_Depth := StrToFloat(edtMinDepth.Text);
    FDef.Maximum_Reported_Bearing_Error := StrToFloat(edtMaxBearingError.Text);
    FDef.Average_Beam_Width := StrToFloat(edtAverageBeamWidth.Text);
    FDef.Bearing_Processing := chkBearingAmbiguity.Checked;
    {$ENDREGION}

    if FDef.Sonar_Index = 0 then
    begin
      if dmINWO.InsertSonarDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateSonarDef(FDef) then
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

procedure TfrmSummarySonar.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummarySonar.chkArrayKinkingClick(Sender: TObject);
var
  timeStr : string;
begin
  grpKinking.Enabled := chkArrayKinking.Checked;

  if not chkArrayKinking.Checked then
  begin
    edtArrayKinkingTurnRate.Text := '0.00';
    SecondToTime(0, timeStr);
    medtArrayKinkingSettleTime.Text := timeStr;
  end;

  btnApply.Enabled := True;

end;

procedure TfrmSummarySonar.btnSNRvsPODCurveClick(Sender: TObject);
begin
//  frmSNRvsPODPickList := TfrmSNRvsPODPickList.Create(Self);
//  try
//    with frmSNRvsPODPickList do
//    begin
//      SelectedPODvsSNRId := FSelectedSonar.FDef.Curve_Detection_Index;
//      ShowModal;
//      FSelectedSonar.FDef.Curve_Detection_Index := SelectedPODvsSNRId;
//    end;
//  finally
//    frmSNRvsPODPickList.Free;
//  end;

  UpdateSNRvsPODData;
end;

procedure TfrmSummarySonar.UpdateSNRvsPODData;
begin
//  with FSelectedSonar do
//  begin
//    if dmTTT.GetPODvsSNRCurveDef(FDef.Curve_Detection_Index, FPOD) then
//      edtSNRvsPODCurve.Text := FPOD.Curve_Definition_Identifier
//    else
//      edtSNRvsPODCurve.Text := '(None)';
//  end;
//
//  btnApply.Enabled := True;

end;

procedure TfrmSummarySonar.UpdateSonarData;
var
  timeStr : string;
begin
  with FSelectedSonar do
  begin
    if FDef.Sonar_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Sonar_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    cbbCategory.ItemIndex := FDef.Sonar_Category_Index;
    cbbOperatingMode.ItemIndex := FDef.Sonar_Classification;
    chkSurfaceDetecting.Checked := FDef.Surface_Detection_Capable;
    chkSubSurfaceDetecting.Checked := FDef.SubSurface_Detection_Capable;
    chkTorpedoDetecting.Checked := FDef.Torpedo_Detection_Capable;
    chkMineDetecting.Checked := FDef.Mine_Detection_Capable;
    edtActiveDetectionRange.Text := FormatFloat('0.00', FDef.Active_Detect_Range);
    edtCrossSection.Text := FormatFloat('0.00', FDef.Known_Cross_Section);
    edtPassiveDetectionRange.Text := FormatFloat('0.00', FDef.Passive_Detect_Range);
    edtSignalSourceLevel.Text := FormatFloat('0.0', FDef.Known_Signal_Source);
    edtMaxDetectionRange.Text := FormatFloat('0.00', FDef.Max_Detect_Range);

    edtActiveSonarPower.Text := FormatFloat('0.000', FDef.Active_Operating_Power);
    edtActiveFrequency.Text := FormatFloat('0.000', FDef.Active_Freq_of_Op);
    edtPassiveFrequency.Text := FormatFloat('0.000', FDef.Passive_Freq_of_Op);
    edtMaxOperatingDepth.Text := FormatFloat('0', FDef.Max_Operating_Depth);
    edtOwnshipNoiseDueSonarActiveMode.Text := FormatFloat('0.0', FDef.Ownship_Increase_due_to_Active);
    edtMaxSonarSpeed.Text := FormatFloat('0.00', FDef.Maximum_Sonar_Speed);

    {$ENDREGION}

    {$REGION ' Characteristics '}
    SecondToTime(FDef.Active_Int_Period, timeStr);
    medtIntegrationPeriodActive.Text := timeStr;

    SecondToTime(FDef.Passive_Int_Period, timeStr);
    medtIntegrationPeriodPassive.Text := timeStr;

    edtTimeIntervalWatchShort.Text := FormatFloat('0.00', FDef.TIOW_Short_Range);
    edtTimeIntervalWatchMedium.Text := FormatFloat('0.00', FDef.TIOW_Medium_Range);
    edtTimeIntervalWatchLong.Text := FormatFloat('0.00', FDef.TIOW_Long_Range);

    SecondToTime(FDef.Time_2_Identify, timeStr);
    medtTimeToIdentifyTarget.Text := timeStr;

    edtCableLength.Text := FormatFloat('0', FDef.Cable_Length);
    edtCablePayoutRate.Text := FormatFloat('0.00', FDef.Depth_per_Speed);

    chkPassiveTargetInvestigation.Checked := FDef.Target_Identification;
    chkPassiveTMAInvestigating.Checked := FDef.Passive_Processing;
    chkDepthFinding.Checked := FDef.Depth_Finding_Capable;
    chkTracking.Checked := FDef.Tracking_Capable;

    UpdateSNRvsPODData;

    {$ENDREGION}

    {$REGION ' Tower Array '}
    chkArrayKinking.Checked := FDef.Kinking_Processing;
    edtArrayKinkingTurnRate.Text := FormatFloat('0.00', FDef.Turn_Rate_2_Kink);

    SecondToTime(FDef.Time_2_Settle_Kinked, timeStr);
    medtArrayKinkingSettleTime.Text := timeStr;

    edtMinTowSpeed.Text := FormatFloat('0.00', FDef.Tow_Speed);
    edtMinDepth.Text := FormatFloat('0', FDef.Minimum_Depth);
    edtMaxBearingError.Text := FormatFloat('0', FDef.Maximum_Reported_Bearing_Error);
    edtAverageBeamWidth.Text := FormatFloat('0', FDef.Average_Beam_Width);
    chkBearingAmbiguity.Checked := FDef.Bearing_Processing;
    {$ENDREGION}

  end;
end;

function TfrmSummarySonar.CekInput: Boolean;
var
  i, chkSpace, numSpace: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (edtClass.Text = '') or (edtClass.Text = ' ') then
  begin
    ShowMessage('Please use another class name');
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
  if (dmINWO.GetSonarDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedSonar.FDef.Sonar_Index = 0 then
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

//  {Jika inputan SNR vs POD of Detection Curve masih kosong}
//  if FSelectedSonar.FDef.Curve_Detection_Index = 0 then
//  begin
//    ShowMessage('Select SNR vs POD of Detection Curve');
//    Exit;
//  end;

  Result := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummarySonar.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummarySonar.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummarySonar.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummarySonar.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummarySonar.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummarySonar.ValidationFormatInput;
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

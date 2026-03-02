unit ufrmSummaryChaff;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Vcl.Imaging.pngimage, Math, Vcl.Mask,

  {Project Uses}
  uConstantaData, uDBAsset_Countermeasure, uDataModule, uBaseCoordSystem;

type
  TfrmSummaryChaff = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    lblDissipationTimein100kt: TLabel;
    lbl3: TLabel;
    lblDescentRate: TLabel;
    lbl4: TLabel;
    lblMaxBloom: TLabel;
    lbl5: TLabel;
    lblMaxRadarCross: TLabel;
    lblBloomTime: TLabel;
    lbl1: TLabel;
    lblDissipationTimeinStillAir: TLabel;
    lbl2: TLabel;
    lblMaxRadarAttenuation: TLabel;
    lbl6: TLabel;
    edtDescentRate: TEdit;
    edtMaxBloom: TEdit;
    edtMaxRadarCross: TEdit;
    edtMaxRadarAttenuation: TEdit;
    cbMaxRadar: TComboBox;
    grbRadarFreq: TGroupBox;
    lblLowerLimit: TLabel;
    lbl7: TLabel;
    lblUpperLimit: TLabel;
    lbl8: TLabel;
    edtLowerLimit: TEdit;
    edtUpperLimit: TEdit;
    edtBloomTime: TMaskEdit;
    edtDissipationTimeinStillAir: TMaskEdit;
    edtDissipationTimein100kt: TMaskEdit;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
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
    FSelectedChaff : TChaff_On_Board;

    function CekInput: Boolean;
    procedure UpdateChaffData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedChaff : TChaff_On_Board read FSelectedChaff write FSelectedChaff;
  end;

var
  frmSummaryChaff: TfrmSummaryChaff;

implementation

{$R *.dfm}
uses
  ufrmChaffOnBoardPickList;


{$REGION ' Form Handle '}

procedure TfrmSummaryChaff.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateChaffData;

  with FSelectedChaff.FDef do
    btnApply.Enabled := Chaff_Index = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryChaff.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmChaffOnBoardPickList.UpdateChaffList;
  Close;
end;

procedure TfrmSummaryChaff.btnApplyClick(Sender: TObject);
var
  second : Integer;
begin
  with FSelectedChaff do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Chaff_Identifier := edtClass.Text;

    {Catatan : tidak ada inputan untuk menyimpan nilai cbMaxRadar}
    FDef.Max_Radar_Cross := StrToFloat(edtMaxRadarCross.Text);

    TimeToSecond(edtBloomTime.Text, second);
    FDef.Bloom_Time := second;

    TimeToSecond(edtDissipationTimeinStillAir.Text, second);
    FDef.Max_Dissipation_Time := second;

    TimeToSecond(edtDissipationTimein100kt.Text, second);
    FDef.Min_Dissipation_Time := second;

    FDef.Descent_Rate := StrToFloat(edtDescentRate.Text);
    FDef.Max_Radius := StrToFloat(edtMaxBloom.Text);
    FDef.Max_Radar_Attenuation := StrToFloat(edtMaxRadarAttenuation.Text);
    FDef.Radar_Affect_Lower_Freq := StrToFloat(edtLowerLimit.Text);
    FDef.Radar_Affect_Upper_Freq := StrToFloat(edtUpperLimit.Text);

    {Catatan : Field ini tidak ada inputannya}
    FDef.Platform_Domain := 0;
    FDef.Platform_Category := 0;
    FDef.Platform_Type := 0;
    {$ENDREGION}

    if FDef.Chaff_Index = 0 then
    begin
      if dmINWO.InsertChaffDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateChaffDef(FDef) then
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

procedure TfrmSummaryChaff.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryChaff.UpdateChaffData;
var
  timeStr : string;
begin
  with FSelectedChaff do
  begin
    if FDef.Chaff_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Chaff_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;

    {Catatan : Rumus dibawah sepertinya kurang tepat}
    case cbMaxRadar.ItemIndex of
      0: edtMaxRadarCross.Text := FormatFloat('0.00', FDef.Max_Radar_Cross);
      1: edtMaxRadarCross.Text := FormatFloat('0.00', Power(10, FDef.Max_Radar_Cross / 10));
    end;

    SecondToTime(FDef.Bloom_Time, timeStr);
    edtBloomTime.Text := timeStr;

    SecondToTime(FDef.Max_Dissipation_Time, timeStr);
    edtDissipationTimeinStillAir.Text := timeStr;

    SecondToTime(FDef.Min_Dissipation_Time, timeStr);
    edtDissipationTimein100kt.Text := timeStr;

    edtDescentRate.Text := FormatFloat('0.00', FDef.Descent_Rate);
    edtMaxBloom.Text := FormatFloat('0.00', FDef.Max_Radius);
    edtMaxRadarAttenuation.Text := FormatFloat('0.00', FDef.Max_Radar_Attenuation);

    edtLowerLimit.Text := FormatFloat('0.0', FDef.Radar_Affect_Lower_Freq);
    edtUpperLimit.Text := FormatFloat('0.0', FDef.Radar_Affect_Upper_Freq);
    {$ENDREGION}
  end;
end;

function TfrmSummaryChaff.CekInput: Boolean;
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
  if (dmINWO.GetChaffDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedChaff.FDef.Chaff_Index = 0 then
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

function TfrmSummaryChaff.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryChaff.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryChaff.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryChaff.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryChaff.ValidationFormatInput;
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

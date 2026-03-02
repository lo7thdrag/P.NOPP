unit ufrmSummaryFloatingDecoy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Vcl.Imaging.pngimage, Vcl.Mask,
  {uDBAsset_Countermeasure,} uBaseCoordSystem, uDBAsset_Countermeasure;

type
  TfrmSummaryFloatingDecoy = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    lblLifetimeDuration: TLabel;
    mnlbl8: TLabel;
    grbAcousticCross: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    lblSideAcousticCross: TLabel;
    lblFrontAcousticCross: TLabel;
    edtFrontAcousticCross: TEdit;
    edtSideAcousticCross: TEdit;
    grbDimensions: TGroupBox;
    lbl1: TLabel;
    lblWidthDimensions: TLabel;
    lbl2: TLabel;
    lblLengthDimensions: TLabel;
    lblHeigthDimensions: TLabel;
    lbl3: TLabel;
    edtLengthDimensions: TEdit;
    edtWidththDimensions: TEdit;
    edtHeigthDimensions: TEdit;
    grbRadarCross: TGroupBox;
    lblSideRadarCross: TLabel;
    lblFrontRadarCross: TLabel;
    edtFrontRadarCross: TEdit;
    edtSideRadarCross: TEdit;
    cbFrontRadarCross: TComboBox;
    cbSideRadarCross: TComboBox;
    grbVisualCross: TGroupBox;
    lbl6: TLabel;
    lbl7: TLabel;
    lblSideVisualCross: TLabel;
    lblFrontVisualCross: TLabel;
    edtFrontVisualCross: TEdit;
    edtSideVisualCross: TEdit;
    edtLifetimeDuration: TMaskEdit;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    //General
    procedure CbbGeneralDataChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);


  private
    FSelectedFloatingDecoy : TFloating_Decoy_On_Board;

    function CekInput: Boolean;
    procedure UpdateFloatingDecoyData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedFloatingDecoy : TFloating_Decoy_On_Board read FSelectedFloatingDecoy write FSelectedFloatingDecoy;
  end;

var
  frmSummaryFloatingDecoy: TfrmSummaryFloatingDecoy;

implementation

uses
  uDataModule, Math, ufrmFloatingDecoyOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmSummaryFloatingDecoy.FormShow(Sender: TObject);
begin
//  tsGeneral.Show;;
//  UpdateFloatingDecoyData;
//
//  with FSelectedFloatingDecoy.FFloatingDecoy_Def do
//    btnApply.Enabled := Floating_Decoy_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryFloatingDecoy.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmFloatingDecoyOnBoardPickList.UpdateFloatingDecoyList;
  Close;
end;

procedure TfrmSummaryFloatingDecoy.btnApplyClick(Sender: TObject);
var
  second : Integer;
begin
  with FSelectedFloatingDecoy do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Floating_Decoy_Identifier := edtClass.Text;

    FDef.Length := StrToFloat(edtLengthDimensions.Text);
    FDef.Width := StrToFloat(edtWidththDimensions.Text);
    FDef.Height := StrToFloat(edtHeigthDimensions.Text);

    {Catatan : Tidak ada field untuk menyimpan nilai comboboxnya}
    FDef.Front_Radar_Cross := StrToFloat(edtFrontRadarCross.Text);
    FDef.Side_Radar_Cross := StrToFloat(edtSideRadarCross.Text);

    FDef.Front_Acoustic_Cross := StrToFloat(edtFrontAcousticCross.Text);
    FDef.Side_Acoustic_Cross := StrToFloat(edtSideAcousticCross.Text);

    FDef.Front_Visual_Cross := StrToFloat(edtFrontVisualCross.Text);
    FDef.Side_Visual_Cross := StrToFloat(edtSideVisualCross.Text);

    TimeToSecond(edtLifetimeDuration.Text, second);
    FDef.Lifetime_Duration := second;
    {$ENDREGION}
    if FDef.Floating_Decoy_Index = 0 then
    begin
      if dmINWO.InsertFloatingDecoyDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateFloatingDecoyDef(FDef) then
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

procedure TfrmSummaryFloatingDecoy.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryFloatingDecoy.CbbGeneralDataChange(Sender: TObject);
var
  value : Double;

begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  case TComboBox(Sender).Tag of
    0: {Front}
    begin
      if edtFrontRadarCross.Text = '' then
        edtFrontRadarCross.Text := '0';

      value := StrToFloat(edtFrontRadarCross.Text);

      case TComboBox(Sender).ItemIndex of
        0: edtFrontRadarCross.Text := FormatFloat('0.00', value);
        1: edtFrontRadarCross.Text := FormatFloat('0.00', Power(10, (value / 10)));
      end;
    end;
    1: {Side}
    begin
      if edtSideRadarCross.Text = '' then
        edtSideRadarCross.Text := '0';

      value := StrToFloat(edtSideRadarCross.Text);

      case TComboBox(Sender).ItemIndex of
        0: edtSideRadarCross.Text := FormatFloat('0.00', value);
        1: edtSideRadarCross.Text := FormatFloat('0.00', Power(10, (value / 10)));
      end;
    end;
  end;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryFloatingDecoy.UpdateFloatingDecoyData;
var
  timeStr : string;
begin
//  with FSelectedFloatingDecoy do
//  begin
//    if FFloatingDecoy_Def.Floating_Decoy_Index= 0 then
//      edtClass.Text := '(Unnamed)'
//    else
//      edtClass.Text := FFloatingDecoy_Def.Floating_Decoy_Identifier;
//
//    {$REGION ' General '}
//    LastName := edtClass.Text;
//    edtLengthDimensions.Text := FormatFloat('0', FFloatingDecoy_Def.Length);
//    edtWidththDimensions.Text := FormatFloat('0', FFloatingDecoy_Def.Width);
//    edtHeigthDimensions.Text := FormatFloat('0', FFloatingDecoy_Def.Height);
//
//    {Catatan : seharusnya ada pilihan format satuan yg akan ditampilkan}
//    edtFrontRadarCross.Text := FormatFloat('0.00', FFloatingDecoy_Def.Front_Radar_Cross);
//    edtSideRadarCross.Text := FormatFloat('0.00', FFloatingDecoy_Def.Side_Radar_Cross);
//
//    edtFrontAcousticCross.Text := FormatFloat('0.00', FFloatingDecoy_Def.Front_Acoustic_Cross);
//    edtSideAcousticCross.Text := FormatFloat('0.00', FFloatingDecoy_Def.Side_Acoustic_Cross);
//
//    edtFrontVisualCross.Text := FormatFloat('0.0', FFloatingDecoy_Def.Front_Visual_Cross);
//    edtSideVisualCross.Text := FormatFloat('0.0', FFloatingDecoy_Def.Side_Visual_Cross);
//
//    SecondToTime(Round(FFloatingDecoy_Def.Lifetime_Duration), timeStr);
//    edtLifetimeDuration.Text := timeStr;
//    {$ENDREGION}
//  end;
end;

function TfrmSummaryFloatingDecoy.CekInput: Boolean;
var
  i, chkSpace, numSpace: Integer;
begin
//  Result := False;
//
//  {Jika inputan class name kosong}
//  if (edtClass.Text = '')then
//  begin
//    ShowMessage('Please insert class name');
//    Exit;
//  end;
//
//  {Jika berisi spasi semua}
//  if Copy(edtClass.Text, 1, 1) = ' ' then
//  begin
//    chkSpace := Length(edtClass.Text);
//    numSpace := 0;
//
//    for i := 1 to chkSpace do
//    begin
//      if edtClass.Text[i] = #32 then
//      numSpace := numSpace + 1;
//    end;
//
//    if chkSpace = numSpace then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end;
//  end;
//
//  {Jika Class Name sudah ada}
//  if (dmTTT.GetFloatingDecoyDef(edtClass.Text)>0) then
//  begin
//    {Jika inputan baru}
//    if FSelectedFloatingDecoy.FFloatingDecoy_Def.Floating_Decoy_Index = 0 then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end
//    else if LastName <> edtClass.Text then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end;
//  end;
//
//  Result := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummaryFloatingDecoy.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryFloatingDecoy.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryFloatingDecoy.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryFloatingDecoy.ValidationFormatInput;
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

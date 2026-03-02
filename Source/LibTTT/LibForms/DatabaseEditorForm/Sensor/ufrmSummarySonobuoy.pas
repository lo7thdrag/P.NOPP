unit ufrmSummarySonobuoy;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ComCtrls,
  Dialogs, StdCtrls, ExtCtrls, Buttons, math, Vcl.Imaging.pngimage, Vcl.Mask,

  {Project Uses}
  uConstantaData, uDBAsset_Sensor, uDataModule, uBaseCoordSystem;

type
  TfrmSummarySonobuoy = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    lblName: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    txtMaxDepth: TLabel;
    txtEnduranceTime: TLabel;
    txtSonarDef: TLabel;
    txtMaxDepthUnits: TLabel;
    txtEnduranceTimeUnits: TLabel;
    edtMaxDepth: TEdit;
    edtSonarDef: TEdit;
    btnPick: TButton;
    medtEnduranceTime: TMaskEdit;
    tsPhysical: TTabSheet;
    grbDimensions: TGroupBox;
    lblWidth: TLabel;
    lblHeight: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    lblLength: TLabel;
    Label8: TLabel;
    edtWidth: TEdit;
    edtHeight: TEdit;
    edtLength: TEdit;
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

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

    procedure btnPickClick(Sender: TObject);


  private
    FSelectedSonobuoy : TSonobuoy_On_Board;

    function CekInput: Boolean;
    procedure UpdateSonobuoyData;
    procedure UpdateSonarData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedSonobuoy : TSonobuoy_On_Board read FSelectedSonobuoy write FSelectedSonobuoy;
  end;

var
   frmSummarySonobuoy: TfrmSummarySonobuoy;

implementation

{$R *.dfm}

uses
  ufrmSonobuoyOnBoardPickList;

{$REGION ' Form Handle '}

procedure TfrmSummarySonobuoy.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateSonobuoyData;

  with FSelectedSonobuoy.FDef do
    btnApply.Enabled := Sonobuoy_Index = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummarySonobuoy.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmSonobuoyOnBoardPickList.UpdateSonobuoyList;
  Close;
end;

procedure TfrmSummarySonobuoy.btnApplyClick(Sender: TObject);
var
  second : Integer;
begin

  with FSelectedSonobuoy do
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
    FDef.Max_Depth := StrToFloat(edtMaxDepth.Text);

    TimeToSecond(medtEnduranceTime.Text, second);
    FDef.Endurance_Time := second;
    {$ENDREGION}

    {$REGION ' Physical '}
    FDef.Length := StrToFloat(edtLength.Text);
    FDef.Width := StrToFloat(edtWidth.Text);
    FDef.Height := StrToFloat(edtHeight.Text);

    {Catatan : di form tidak ada variabel2 dibawah ini}
    FDef.Platform_Domain := 2;
    FDef.Platform_Type := 28;
    FDef.CPA_Range_Limit := 10;

    {$ENDREGION}

    if FDef.Sonobuoy_Index = 0 then
    begin
      if dmINWO.InsertSonobuoyDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateSonobuoyDef(FDef) then
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

procedure TfrmSummarySonobuoy.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummarySonobuoy.btnPickClick(Sender: TObject);
begin
//  frmSonobuoyOnBoardPickList := TfrmSonobuoyOnBoardPickList.Create(Self);
//  try
//    with frmSonobuoyOnBoardPickList do
//    begin
//      SelectedSonobuoy := FSelectedSonobuoy.FDef.Sonobuoy_Index;
//      ShowModal;
//      FSelectedSonobuoy.FDef.Sonobuoy_Index := SelectedSonobuoy;
//    end;
//
//  finally
//    frmSonobuoyOnBoardPickList.Free;
//  end;
//
//  UpdateSonobuoyData;
//  btnApply.Enabled := True;
end;

procedure TfrmSummarySonobuoy.UpdateSonobuoyData;
var
  timeStr : string;
begin
  with FSelectedSonobuoy do
  begin
    if FDef.Sonobuoy_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Class_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    edtMaxDepth.Text := FormatFloat('0', FDef.Max_Depth);

    SecondToTime(FDef.Endurance_Time, timeStr);
    medtEnduranceTime.Text := timeStr;

    UpdateSonarData;

    {$ENDREGION}

    {$REGION ' Characteristics '}
    edtLength.Text := FormatFloat('0', FDef.Length);
    edtWidth.Text := FormatFloat('0', FDef.Width);
    edtHeight.Text := FormatFloat('0', FDef.Height);

    {$ENDREGION}

  end;
end;

procedure TfrmSummarySonobuoy.UpdateSonarData;
var
  sonar : TSonar_On_Board;
begin
//  with FSelectedSonobuoy do
//  begin
//    dmINWO.GetSonarDef(FDef.Sonar_Index, sonar);
//
//    if Assigned(sonar) then
//      edtSonarDef.Text := sonar.FDef.Sonar_Identifier
//    else
//      edtSonarDef.Text := 'None';
//  end;
//
//  sonar.Free;
//
//  btnApply.Enabled := True;
end;

function TfrmSummarySonobuoy.CekInput: Boolean;
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
  if (dmINWO.GetSonarDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedSonobuoy.FDef.Sonobuoy_Index = 0 then
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

//  if FSelectedSonobuoy.FDef.Sonar_Index = 0 then
//  begin
//    ShowMessage('Sonar Definition not selected');
//    Exit;
//  end;

  Result := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummarySonobuoy.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummarySonobuoy.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummarySonobuoy.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummarySonobuoy.ValidationFormatInput;
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

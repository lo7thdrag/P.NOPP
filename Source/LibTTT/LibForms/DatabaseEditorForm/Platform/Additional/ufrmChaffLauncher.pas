unit ufrmChaffLauncher;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage{,
  uBlindZoneView, uDBAsset_Vehicle, uDBAsset_Countermeasure};

type
  TfrmChaffLauncher = class(TForm)
    pnl1: TPanel;
    lbl1: TLabel;
    cbbLauncherKind: TComboBox;
    pnlForward: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl12: TLabel;
    edtForward: TEdit;
    edtAverageSpeed: TEdit;
    lbl13: TLabel;
    ImgBackgroundForm: TImage;
    btnOK: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    grbCapabilities: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    edtMinRange: TEdit;
    edtMaxRange: TEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl10: TLabel;
    edtMinElevation: TEdit;
    edtMaxElevation: TEdit;
    lbl7: TLabel;
    lbl6: TLabel;
    Label1: TLabel;
    lbl14: TLabel;
    edtDefaultAltitude: TEdit;
    edtDefaultRange: TEdit;
    lbl15: TLabel;
    lbl16: TLabel;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure RotWheelDegreChange(Sender: TObject);

    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtForwardChange(Sender: TObject);

  private
//    FSelectedVehicle : TVehicle_Definition;
//    FSelectedChaffLauncher : TChaff_Launcher_On_Board;
//
//    FLauncherForward : TBlindZoneView;

    procedure UpdateChaffLauncherData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}
//    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;
//    property SelectedChaffLauncher : TChaff_Launcher_On_Board read FSelectedChaffLauncher write FSelectedChaffLauncher;

  end;

var
  frmChaffLauncher: TfrmChaffLauncher;

implementation

{$R *.dfm}

uses
  uDataModule ;

{$REGION ' Form Handle '}

procedure TfrmChaffLauncher.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FLauncherForward.Free;
  Action := cafree;
end;

procedure TfrmChaffLauncher.FormCreate(Sender: TObject);
begin
//  FLauncherForward := TBlindZoneView.Create(Self);
//
//  with FLauncherForward do
//  begin
//    Parent := pnlForward;
//    Left := 0;
//    Top := 0;
//    Height := pnlForward.Height;
//    Width := pnlForward.Width;
//    EnableDrag := True;
//    OnZoneChange := RotWheelDegreChange;
//    AddZone;
//  end;
end;

procedure TfrmChaffLauncher.FormShow(Sender: TObject);
begin
//  UpdateChaffLauncherData;
//
//  with FSelectedChaffLauncher.FData do
//    btnApply.Enabled := Vehicle_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmChaffLauncher.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  if isOk then
    Close;
end;

procedure TfrmChaffLauncher.btnApplyClick(Sender: TObject);
begin
//  ValidationFormatInput;
//
//  with FSelectedChaffLauncher do
//  begin
//    FData.Vehicle_Index := FSelectedVehicle.FData.Vehicle_Index;
//    FData.Launcher_Angle := StrToFloat(edtForward.Text);
//    FData.Launcher_Kind := cbbLauncherKind.ItemIndex;
//    FData.Min_Range := StrToFloat(edtMinRange.Text);
//    FData.Max_Range := StrToFloat(edtMaxRange.Text);
//    FData.Min_Elevation := StrToFloat(edtMinElevation.Text);
//    FData.Max_Elevation := StrToFloat(edtMaxElevation.Text);
//    FData.Average_Launch_Spd := StrToFloat(edtAverageSpeed.Text);
//    FData.Def_Bloom_Range := StrToFloat(edtDefaultRange.Text);
//    FData.Def_Bloom_Altitude := StrToFloat(edtDefaultAltitude.Text);
//
//    if not dmTTT.GetChaffLauncherOnBoardCount(FSelectedVehicle.FData.Vehicle_Index, FData.Launcher_Number) then
//    begin
//      if dmTTT.InsertChaffLauncherOnBoard(FData) then
//        ShowMessage('Data has been saved');
//    end
//    else
//    begin
//      if dmTTT.UpdateChaffLauncherOnBoard(FData) then
//        ShowMessage('Data has been updated');
//    end;
//  end;
//
//  isOK := True;
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;
end;

procedure TfrmChaffLauncher.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmChaffLauncher.RotWheelDegreChange(Sender: TObject);
//var
//  zs : TZoneSector;
begin
//  zs := FLauncherForward.Zones[0];
//  edtForward.Text := FormatFloat('0', zs.Degree);
end;

procedure TfrmChaffLauncher.UpdateChaffLauncherData;
//var
//  zs : TZoneSector;
begin
//  with FSelectedChaffLauncher.FData do
//  begin
//    cbbLauncherKind.ItemIndex := Launcher_Kind;
//
//    zs := FLauncherForward.Zones[0];
//    zs.Degree := Launcher_Angle;
//    FLauncherForward.Repaint;
//
//    edtForward.Text := FormatFloat('0', Launcher_Angle);
//
//    edtMinRange.Text := FormatFloat('0.00', Min_Range);
//    edtMaxRange.Text := FormatFloat('0.00', Max_Range);
//    edtMinElevation.Text := FormatFloat('0', Min_Elevation);
//    edtMaxElevation.Text := FormatFloat('0', Max_Elevation);
//
//    edtAverageSpeed.Text := FormatFloat('0.0', Average_Launch_Spd);
//
//    edtDefaultRange.Text := FormatFloat('0.00', Def_Bloom_Range);
//    edtDefaultAltitude.Text := FormatFloat('0', Def_Bloom_Altitude);
//  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmChaffLauncher.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmChaffLauncher.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

    if TEdit(Sender).Name = 'edtMinRange' then
    begin
      if (StrToFloat(edtMinRange.Text) > 234700)  then
      begin
        ShowMessage('Incorrect value, more than 234.700');
        edtMinRange.Text := '234700';
      end;
    end;

    if TEdit(Sender).Name = 'edtMaxRange' then
    begin
      if (StrToFloat(edtMaxRange.Text) > 854200)  then
      begin
        ShowMessage('Incorrect value, more than 675.000');
        edtMaxRange.Text := '854200';
      end;
    end;

    if TEdit(Sender).Name = 'edtMinElevation' then
    begin
      if (StrToFloat(edtMinElevation.Text) > 568500)  then
      begin
        ShowMessage('Incorrect value, more than 568.500');
        edtMinElevation.Text := '568500';
      end;
    end;

    if TEdit(Sender).Name = 'edtMaxElevation' then
    begin
      if (StrToFloat(edtMaxElevation.Text) > 465200)  then
      begin
        ShowMessage('Incorrect value, more than 465.200');
        edtMaxElevation.Text := '465200';
      end;
    end;

    if TEdit(Sender).Name = 'edtAverageSpeed' then
    begin
      if (StrToFloat(edtAverageSpeed.Text) > 451200)  then
      begin
        ShowMessage('Incorrect value');
        edtAverageSpeed.Text := '451200';
      end;
    end;

    if TEdit(Sender).Name = 'edtForward' then
    begin
      if (StrToFloat(edtForward.Text) > 359)  then
      begin
        edtForward.Text := '0';
      end;
    end;

    if TEdit(Sender).Name = 'edtDefaultRange' then
    begin
      if (StrToFloat(edtDefaultRange.Text) > 675000)  then
      begin
        ShowMessage('Incorrect value, more than 675.000');
        edtDefaultRange.Text := '675000';
      end;
    end;

    if TEdit(Sender).Name = 'edtDefaultAltitude' then
    begin
      if (StrToFloat(edtDefaultAltitude.Text) > 548000)  then
      begin
        ShowMessage('Incorrect value, more than 548.000');
        edtDefaultAltitude.Text := '548000';
      end;
    end;

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

procedure TfrmChaffLauncher.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmChaffLauncher.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmChaffLauncher.edtForwardChange(Sender: TObject);
//var
//  zs : TZoneSector;
begin
//  if TEdit(Sender).Text = '' then
//      TEdit(Sender).Text := '0'
//  else if (StrToFloat(TEdit(Sender).Text) > 359)  then
//    edtForward.Text := '0';
//
//  zs := FLauncherForward.Zones[0];
//  zs.Degree := StrToFloat(edtForward.Text);
//  FLauncherForward.Repaint;
//
//  btnApply.Enabled := True;
end;

procedure TfrmChaffLauncher.ValidationFormatInput;
var
  i : Integer;
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

      if TEdit(Components[i]).Name = 'edtMinRange' then
      begin
        if (StrToFloat(edtMinRange.Text) > 234700)  then
          edtMinRange.Text := '234700';
      end;

      if TEdit(Components[i]).Name = 'edtMaxRange' then
      begin
        if (StrToFloat(edtMaxRange.Text) > 854200)  then
          edtMaxRange.Text := '854200';
      end;

      if TEdit(Components[i]).Name = 'edtMinElevation' then
      begin
        if (StrToFloat(edtMinElevation.Text) > 568500)  then
          edtMinElevation.Text := '568500'
      end;

      if TEdit(Components[i]).Name = 'edtMaxElevation' then
      begin
        if (StrToFloat(edtMaxElevation.Text) > 465200)  then
          edtMaxElevation.Text := '465200'
      end;

      if TEdit(Components[i]).Name = 'edtAverageSpeed' then
      begin
        if (StrToFloat(edtAverageSpeed.Text) > 451200)  then
          edtAverageSpeed.Text := '451200';
      end;

      if TEdit(Components[i]).Name = 'edtForward' then
      begin
        if (StrToFloat(edtForward.Text) > 359)  then
          edtForward.Text := '0';
      end;

      if TEdit(Components[i]).Name = 'edtDefaultRange' then
      begin
        if (StrToFloat(edtDefaultRange.Text) > 675000)  then
          edtDefaultRange.Text := '675000'
      end;

      if TEdit(Components[i]).Name = 'edtDefaultAltitude' then
      begin
        if (StrToFloat(edtDefaultRange.Text) > 548000)  then
          edtDefaultAltitude.Text := '548000'
      end;

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

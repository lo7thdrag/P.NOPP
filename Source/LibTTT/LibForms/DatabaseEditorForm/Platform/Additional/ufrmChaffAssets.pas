unit ufrmChaffAssets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Vcl.Mask, Vcl.Imaging.pngimage,
  uBaseCoordSystem, {uDBAsset_Vehicle, uDBAsset_Countermeasure, ufrmSummaryVehicle,} uSimContainers;

type
  TfrmChaffAssets = class(TForm)
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    ts1: TTabSheet;
    ts2: TTabSheet;
    lbl2: TLabel;
    lbl3: TLabel;
    edtMaxNumberChaff: TEdit;
    lbl4: TLabel;
    chkLauncher1: TCheckBox;
    chkLauncher2: TCheckBox;
    chkLauncher3: TCheckBox;
    chkLauncher4: TCheckBox;
    btnLauncher1: TButton;
    btnLauncher2: TButton;
    btnLauncher3: TButton;
    btnLauncher4: TButton;
    chkCapable: TCheckBox;
    lbl9: TLabel;
    grpDamage: TGroupBox;
    lbl10: TLabel;
    lbl11: TLabel;
    trckbrProbabilitySuccess: TTrackBar;
    edtProbabilitySuccess: TEdit;
    lbl12: TLabel;
    grp1: TGroupBox;
    grp2: TGroupBox;
    grp3: TGroupBox;
    grp4: TGroupBox;
    ImgBackgroundForm: TImage;
    ImgHeader: TImage;
    GroupBox1: TGroupBox;
    btnOnBoard: TButton;
    edtMinDelay: TMaskEdit;
    edtTimeWeaponImpact: TMaskEdit;
    Label1: TLabel;
    btnOK: TButton;
    btnApply: TButton;
    btnCancel: TButton;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure btnOnBoardClick(Sender: TObject);
    procedure btnLauncher1Click(Sender: TObject);
    procedure chkLauncher1Click(Sender: TObject);
    procedure trckbrProbabilitySuccessChange(Sender: TObject);

    procedure chkCapableClick(Sender: TObject);
    procedure edtProbabilitySuccessChange(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
//    FSelectedVehicle : TVehicle_Definition;
    FChaffLauncherList : TList;

    procedure UpdateChaffData;
    procedure UpdateChaffLauncher;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}

//    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmChaffAssets: TfrmChaffAssets;

implementation

//uses
//  uDataModuleTTT, ufrmChaffLauncher, ufrmChaffOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmChaffAssets.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FChaffLauncherList);
//  Action := cafree;
end;

procedure TfrmChaffAssets.FormCreate(Sender: TObject);
begin
  FChaffLauncherList := TList.Create;
end;

procedure TfrmChaffAssets.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateChaffData;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

procedure TfrmChaffAssets.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  if isOk then
    Close;
end;

procedure TfrmChaffAssets.btnApplyClick(Sender: TObject);
var
  second : Integer;
begin
//  with FSelectedVehicle do
//  begin
//    TimeToSecond(edtMinDelay.Text, second);
//    FData.Min_Delay_Between_Chaff_Rounds := second;
//    FData.Max_Chaff_Salvo_Size := StrToInt(edtMaxNumberChaff.Text);
//
//    if not chkLauncher1.Checked then
//      dmTTT.DeleteChaffLauncherOnBoard(FData.Vehicle_Index, 1);
//
//    if not chkLauncher2.Checked then
//      dmTTT.DeleteChaffLauncherOnBoard(FData.Vehicle_Index, 2);
//
//    if not chkLauncher3.Checked then
//      dmTTT.DeleteChaffLauncherOnBoard(FData.Vehicle_Index, 3);
//
//    if not chkLauncher4.Checked then
//      dmTTT.DeleteChaffLauncherOnBoard(FData.Vehicle_Index, 4);
//
//    FData.Chaff_Seduction_Capable := chkCapable.Checked;
//
//    TimeToSecond(edtTimeWeaponImpact.Text, second);
//    FData.Time_of_Weapon_Impact := second;
//
//    FData.Seduction_Mode_Prob := trckbrProbabilitySuccess.Position / 100;
//
//    dmTTT.UpdateVehicleDef(FData);
//  end;
//
//  isOK := True;
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;
end;

procedure TfrmChaffAssets.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmChaffAssets.btnLauncher1Click(Sender: TObject);
var
  i : Integer;
//  chaffLauncher : TChaff_Launcher_On_Board;
begin

//  for i := 0 to FChaffLauncherList.Count - 1 do
//  begin
//    chaffLauncher := FChaffLauncherList.Items[i];
//
//    if chaffLauncher.FData.Launcher_Number = TButton(Sender).Tag then
//      Break
//    else
//      chaffLauncher := nil;
//  end;
//
//  if not Assigned(chaffLauncher) then
//  begin
//    chaffLauncher := TChaff_Launcher_On_Board.Create;
//    chaffLauncher.FData.Launcher_Number := Ord(TButton(Sender).Tag);
//  end;
//
//  frmChaffLauncher := TfrmChaffLauncher.Create(Self);
//  try
//    with frmChaffLauncher do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      SelectedChaffLauncher := chaffLauncher;
//      ShowModal;
//    end;
//
//    btnApply.Enabled := frmChaffLauncher.AfterClose;
//    btnCancel.Enabled := not frmChaffLauncher.AfterClose;
//
//  finally
//    frmChaffLauncher.Free;
//  end;
//
//  UpdateChaffLauncher;
end;

procedure TfrmChaffAssets.btnOnBoardClick(Sender: TObject);
begin
//  frmChaffOnBoardPickList := TfrmChaffOnBoardPickList.Create(Self);
//  try
//    with frmChaffOnBoardPickList do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      ShowModal;
//    end;
//
//    btnApply.Enabled := frmChaffOnBoardPickList.AfterClose;
//    btnCancel.Enabled := not frmChaffOnBoardPickList.AfterClose;
//
//  finally
//    frmChaffOnBoardPickList.Free;
//  end;
end;

procedure TfrmChaffAssets.chkCapableClick(Sender: TObject);
begin
  lbl9.Enabled  := chkCapable.Checked;
  edtTimeWeaponImpact.Enabled := chkCapable.Checked;
  lbl12.Enabled := chkCapable.Checked;
end;

procedure TfrmChaffAssets.chkLauncher1Click(Sender: TObject);
begin
  btnLauncher1.Enabled := chkLauncher1.Checked;
  btnLauncher2.Enabled := chkLauncher2.Checked;
  btnLauncher3.Enabled := chkLauncher3.Checked;
  btnLauncher4.Enabled := chkLauncher4.Checked;
end;

procedure TfrmChaffAssets.edtProbabilitySuccessChange(Sender: TObject);
begin
  if edtProbabilitySuccess.Text = '' then
    edtProbabilitySuccess.Text := '0';

  if (StrToInt(edtProbabilitySuccess.Text) < 0) then
    edtProbabilitySuccess.Text := '0'
  else if (StrToInt(edtProbabilitySuccess.Text) > 100) then
    edtProbabilitySuccess.Text := '100';

  trckbrProbabilitySuccess.Position := StrToInt(edtProbabilitySuccess.Text);
  btnApply.Enabled := True;
end;

procedure TfrmChaffAssets.trckbrProbabilitySuccessChange(Sender: TObject);
begin
  edtProbabilitySuccess.Text := IntToStr((sender as TTrackBar).Position);
end;

procedure TfrmChaffAssets.UpdateChaffData;
var
  timeStr : string;
begin
//  with FSelectedVehicle.FData do
//  begin
//    SecondToTime(Min_Delay_Between_Chaff_Rounds, timeStr);
//    edtMinDelay.Text := timeStr;
//    edtMaxNumberChaff.Text := IntToStr(Max_Chaff_Salvo_Size);
//
//    UpdateChaffLauncher;
//
//    chkCapable.Checked := Chaff_Seduction_Capable;
//    SecondToTime(Time_of_Weapon_Impact, timeStr);
//    edtTimeWeaponImpact.Text := timeStr;
//    trckbrProbabilitySuccess.Position := Round(Seduction_Mode_Prob * 100);
//  end;
end;

procedure TfrmChaffAssets.UpdateChaffLauncher;
var
  i : Integer;
  defRange, defAltitude : Double;
//  chaffLauncher : TChaff_Launcher_On_Board;
begin
//  dmTTT.GetChaffLauncherOnBoard(FSelectedVehicle.FData.Vehicle_Index, FChaffLauncherList);
//
//  chkLauncher1.Checked := False;
//  btnLauncher1.Enabled := False;
//  chkLauncher2.Checked := False;
//  btnLauncher2.Enabled := False;
//  chkLauncher3.Checked := False;
//  btnLauncher3.Enabled := False;
//  chkLauncher4.Checked := False;
//  btnLauncher4.Enabled := False;
//
//  for i := 0 to FChaffLauncherList.Count - 1 do
//  begin
//    chaffLauncher := FChaffLauncherList.Items[i];
//
//    case chaffLauncher.FData.Launcher_Number of
//      1:
//      begin
//        chkLauncher1.Checked := True;
//        btnLauncher1.Enabled := True;
//      end;
//      2:
//      begin
//        chkLauncher2.Checked := True;
//        btnLauncher2.Enabled := True;
//      end;
//      3:
//      begin
//        chkLauncher3.Checked := True;
//        btnLauncher3.Enabled := True;
//      end;
//      4:
//      begin
//        chkLauncher4.Checked := True;
//        btnLauncher4.Enabled := True;
//      end;
//    end;
//  end;
end;

{$REGION ' Filter Input '}

function TfrmChaffAssets.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmChaffAssets.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

    if TEdit(Sender).Name = 'edtMaxNumberChaff' then
    begin
      if (StrToFloat(edtMaxNumberChaff.Text) > 356000)  then
      begin
        ShowMessage('Incorrect value, more than 356.000');
        edtMaxNumberChaff.Text := '356000';
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

procedure TfrmChaffAssets.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmChaffAssets.ValidationFormatInput;
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

      if TEdit(Components[i]).Name = 'edtMaxNumberChaff' then
      begin
        if (StrToFloat(edtMaxNumberChaff.Text) > 356000)  then
          edtMaxNumberChaff.Text := '356000';
      end;

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

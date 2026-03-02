unit ufrmESMMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers ;

type
  TfrmESMMount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    lbl1: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    ImgHeader: TImage;
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
    lbl9: TLabel;
    lbl10: TLabel;
    cbMountExtension: TComboBox;
    edtAntenna: TEdit;
    edtSubmerged: TEdit;
    edtMaxOperational: TEdit;
    pnlBlindZone: TPanel;
    edtClassName: TLabel;
    lblPlatform: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure cbMountExtensionChange(Sender: TObject);
    procedure pnlBlindZoneClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);


  private
    FSelectedVehicle : TAsset;
    FSelectedESM : TESM_On_Board;

    function CekInput: Boolean;
    procedure UpdateESMData;
    procedure DrawBlindZone;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedESM : TESM_On_Board read FSelectedESM write FSelectedESM;

  end;

var
  frmESMMount: TfrmESMMount;

implementation

uses
  uDataModule, ufrmESMOnBoardPickList;

{$R *.dfm}


{$REGION ' Form Handle '}

procedure TfrmESMMount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FBlindZoneView.Free;
  Action := cafree;
end;

procedure TfrmESMMount.FormCreate(Sender: TObject);
begin
//  FBlindZoneView := TBlindZoneView.Create(Self);
//
//  with FBlindZoneView do
//  begin
//    Parent := pnlBlindZone;
//    Left := 0;
//    Top := 0;
//    Height := pnlBlindZone.Height;
//    Width := pnlBlindZone.Width;
//    OnClick := pnlBlindZoneClick;
//  end;
end;

procedure TfrmESMMount.FormShow(Sender: TObject);
begin
  UpdateESMData;

  with FSelectedESM.FData do
    btnApply.Enabled := ESM_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmESMMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmESMOnBoardPickList.UpdateESMList;
  Close;
end;

procedure TfrmESMMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedESM do
  begin
    LastName := edtName.Text;
    FData.Instance_Identifier := edtName.Text;
    FData.Instance_Type := cbMountExtension.ItemIndex;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.ESM_Index := FDef.ESM_Index;
    FData.Rel_Antenna_Height := StrToFloat(edtAntenna.Text);
    FData.Submerged_Antenna_Height := StrToFloat(edtSubmerged.Text);
    FData.Max_Operational_Depth := StrToFloat(edtMaxOperational.Text);

    if FData.ESM_Instance_Index = 0 then
      dmINWO.InsertESMOnBoard(FData)
    else
      dmINWO.UpdateESMOnBoard(FData);
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmESMMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmESMMount.cbMountExtensionChange(Sender: TObject);
begin
  edtName.Text := FSelectedESM.FDef.Class_Identifier + ' ' + cbMountExtension.Text;

  btnApply.Enabled := True;
end;

function TfrmESMMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetESMOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedESM.FData.ESM_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate ESM mount!' + Char(13) + 'Choose different mount to continue.');
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

procedure TfrmESMMount.DrawBlindZone;
var
  i : Integer;
//  blindZone : TBlind_Zone;
//  zoneSector : TZoneSector;

begin
//  FBlindZoneView.ClearZone;
//
//  with FSelectedESM do
//  begin
//    dmTTT.GetBlindZone(Ord(bzcESM), FData.ESM_Instance_Index, FBlind);
//
//    blindZone := TBlind_Zone.Create;
//    FBZone_1 := blindZone.FData;
//    FBZone_2 := blindZone.FData;
//    blindZone.Free;
//
//    for i := 0 to FBlind.Count - 1 do
//    begin
//      blindZone := FBlind.Items[i];
//
//      case blindZone.FData.BlindZone_Number of
//        1: FBZone_1 := blindZone.FData;
//        2: FBZone_2 := blindZone.FData;
//      end;
//    end;
//
//    if (FBZone_1.BlindZone_Number <> 0) and
//      (FBZone_1.Start_Angle <> FBZone_1.End_Angle) then
//    begin
//      zoneSector := FBlindZoneView.AddZone;
//      zoneSector.StartAngle := FBZone_1.Start_Angle;
//      zoneSector.EndAngle := FBZone_1.End_Angle;
//    end;
//
//    if (FBZone_2.BlindZone_Number <> 0) and
//      (FBZone_2.Start_Angle <> FBZone_2.End_Angle) then
//    begin
//      zoneSector := FBlindZoneView.AddZone;
//      zoneSector.StartAngle := FBZone_2.Start_Angle;
//      zoneSector.EndAngle := FBZone_2.End_Angle;
//    end;
//  end;
//
//  FBlindZoneView.Repaint;
end;

procedure TfrmESMMount.pnlBlindZoneClick(Sender: TObject);
begin
//  if FSelectedESM.FData.ESM_Instance_Index = 0 then
//  begin
//    ShowMessage('Save data before edit blind zone ');
//    Exit;
//  end;
//
//  frmBlindZonesAttachment := TfrmBlindZonesAttachment.Create(Self);
//  try
//    with frmBlindZonesAttachment do
//    begin
//      OnBoardType := bzcESM;
//      OnBoardOwner := FSelectedESM;
//      ShowModal;
//    end;
//
//    btnApply.Enabled := frmBlindZonesAttachment.AfterClose;
//    btnCancel.Enabled := not frmBlindZonesAttachment.AfterClose;
//  finally
//    frmBlindZonesAttachment.Free;
//  end;
//
//  DrawBlindZone;
end;

procedure TfrmESMMount.UpdateESMData;
begin
  with FSelectedESM do
  begin
    cbMountExtension.ItemIndex := FData.Instance_Type;

    if FData.ESM_Instance_Index = 0 then
      edtName.Text := FDef.Class_Identifier + ' ' + cbMountExtension.Text
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;
    edtClassName.Caption := FDef.Class_Identifier;

//    DrawBlindZone;

    edtAntenna.Text := FormatFloat('0', FData.Rel_Antenna_Height);
    edtSubmerged.Text := FormatFloat('0', FData.Submerged_Antenna_Height);
    edtMaxOperational.Text := FormatFloat('0', FData.Max_Operational_Depth);
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmESMMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmESMMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmESMMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmESMMount.ValidationFormatInput;
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

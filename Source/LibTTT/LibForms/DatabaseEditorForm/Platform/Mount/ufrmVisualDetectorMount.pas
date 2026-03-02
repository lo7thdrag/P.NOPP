unit ufrmVisualDetectorMount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage{,
  uDBAsset_Vehicle, uDBAsset_Sensor, uDBBlind_Zone, uBlindZoneView, tttData};

type
  TfrmVisualDetectorMount = class(TForm)
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    pnl1Title: TPanel;
    lbl1: TLabel;
    edtName: TEdit;
    lblBlindZones: TStaticText;
    lblObserver: TStaticText;
    edtObserver: TEdit;
    lblFeetObserver: TStaticText;
    pnlBlindZone: TPanel;
    lblPlatform: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure pnlBlindZoneClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
//    FSelectedVehicle : TVehicle_Definition;
//    FSelectedVisual : TVisual_Sensor_On_Board;
//
//    FBlindZoneView : TBlindZoneView;

    function CekInput: Boolean;
    procedure UpdateVisualData;
    procedure DrawBlindZone;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}
    LastName : string;

//    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;
//    property SelectedVisual : TVisual_Sensor_On_Board read FSelectedVisual write FSelectedVisual;

  end;

var
  frmVisualDetectorMount: TfrmVisualDetectorMount;

implementation

uses
  uDataModule, ufrmBlindZoneAttachment;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmVisualDetectorMount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FBlindZoneView.Free;
  Action := cafree;
end;

procedure TfrmVisualDetectorMount.FormCreate(Sender: TObject);
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

procedure TfrmVisualDetectorMount.FormShow(Sender: TObject);
begin
//  UpdateVisualData;
//
//  with FSelectedVisual.FData do
//    btnApply.Enabled := Visual_Instance_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmVisualDetectorMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  if isOk then
    Close;
end;

procedure TfrmVisualDetectorMount.btnApplyClick(Sender: TObject);
begin
//  if not CekInput then
//  begin
//    isOK := False;
//    Exit;
//  end;
//
//  ValidationFormatInput;
//
//  with FSelectedVisual do
//  begin
//    LastName := edtName.Text;
//    FData.Instance_Identifier := edtName.Text;
//    FData.Instance_Type := 0;
//    FData.Vehicle_Index := FSelectedVehicle.FData.Vehicle_Index;
//    FData.Observer_Height := StrToFloat(edtObserver.Text);
//
//    if FData.Visual_Instance_Index = 0 then
//      dmTTT.InsertVisualOnBoard(FData)
//    else
//      dmTTT.UpdateVisualOnBoard(FData);
//  end;
//
//  isOK := True;
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;
end;

procedure TfrmVisualDetectorMount.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

function TfrmVisualDetectorMount.CekInput: Boolean;
begin
//  Result := False;
//
//  {Jika Mount Name sudah ada}
//  if dmTTT.GetVisualDetectorOnBoardCount(FSelectedVehicle.FData.Vehicle_Index, edtName.Text) then
//  begin
//    {Jika inputan baru}
//    if FSelectedVisual.FData.Visual_Instance_Index = 0 then
//    begin
//      ShowMessage('Duplicate Visual Detector !' + Char(13) + 'Choose only one Visual Detector.');
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

procedure TfrmVisualDetectorMount.DrawBlindZone;
var
  i : Integer;
//  blindZone : TBlind_Zone;
//  zoneSector : TZoneSector;

begin
//  FBlindZoneView.ClearZone;
//
//  with FSelectedVisual do
//  begin
//    dmTTT.GetBlindZone(Ord(bzcVisual), FData.Visual_Instance_Index, FBlind);
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

procedure TfrmVisualDetectorMount.UpdateVisualData;
begin
//  with FSelectedVisual.FData do
//  begin
//    edtName.Text := Instance_Identifier;
//
//    LastName := edtName.Text;
//
//    DrawBlindZone;
//
//    edtObserver.Text := FormatFloat('0', Observer_Height);
//  end;
end;

procedure TfrmVisualDetectorMount.pnlBlindZoneClick(Sender: TObject);
begin
//  if FSelectedVisual.FData.Visual_Instance_Index = 0 then
//  begin
//    ShowMessage('Save data before edit blind zone ');
//    Exit;
//  end;
//
//  frmBlindZonesAttachment := TfrmBlindZonesAttachment.Create(Self);
//  try
//    with frmBlindZonesAttachment do
//    begin
//      OnBoardType := bzcVisual;
//      OnBoardOwner := FSelectedVisual;
//      ShowModal;
//    end;
//
//    btnApply.Enabled := frmBlindZonesAttachment.AfterClose;
//    btnCancel.Enabled := not frmBlindZonesAttachment.AfterClose;
//
//  finally
//    frmBlindZonesAttachment.Free;
//  end;
//
//  DrawBlindZone
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmVisualDetectorMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmVisualDetectorMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmVisualDetectorMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmVisualDetectorMount.ValidationFormatInput;
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

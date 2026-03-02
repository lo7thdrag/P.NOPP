unit ufrmBlindZoneAttachment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {uBlindZoneView, uDBBlind_Zone, tttData,} Vcl.Imaging.pngimage;

type
  TfrmBlindZonesAttachment = class(TForm)
    Panel1: TPanel;
    grbSecondBlindZone: TGroupBox;
    TrackCentreSecond: TTrackBar;
    edtCentreSecond: TEdit;
    TrackWidthSecond: TTrackBar;
    edtWidthSecond: TEdit;
    cbFirstBlindZone: TCheckBox;
    cbSecondBlindZone: TCheckBox;
    lbl3: TLabel;
    lbl4: TLabel;
    ImgBackgroundForm: TImage;
    btnOK: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    grbFirstBlindZone: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    TrackCentreFirst: TTrackBar;
    edtCentreFirst: TEdit;
    TrackWidthFirst: TTrackBar;
    edtWidthFirst: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lbl5: TLabel;
    pnlFirstBlind: TPanel;
    lbl6: TLabel;
    pnlSecondBlind: TPanel;
    lblPlatform: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    //General
    procedure edtGeneralChange(Sender: TObject);
    procedure trckbrGeneralChange(Sender: TObject);

    procedure cbFirstBlindZoneClick(Sender: TObject);
    procedure cbSecondBlindZoneClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

    procedure FirstRotWheelDegreeChange(Sender: TObject);
    procedure SecondRotWheelDegreeChange(Sender: TObject);

  private
//    FOnBoardType : E_BlindZoneType;
    FOnBoardOwner : TObject;

//    FFirstBZView : TBlindZoneView;
//    FSecondBZView : TBlindZoneView;

    function GetBlindZoneCentre(const aDegStart, aDegEnd: Double): Integer;
    function GetBlindZoneAngleWidth(const aDegStart, aDegEnd: Double): Integer;
    procedure UpdateBlindZoneForm;

  public
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }

//    property OnBoardType : E_BlindZoneType read FOnBoardType write FOnBoardType;
    property OnBoardOwner : TObject read FOnBoardOwner write FOnBoardOwner;
  end;

var
  frmBlindZonesAttachment: TfrmBlindZonesAttachment;

implementation

{$R *.dfm}

//uses
//  uDBAsset_Sensor, uDBAsset_Radar, uDBAsset_Sonar, uDBAsset_Weapon,
//
//ufrmRadarMount, uDataModuleTTT, ufrmRadarOnBoardPickList, ufrmESMOnBoardPickList,
//  ufrmESMMount, ufrmSonarMount, ufrmSONAROnBoardPickList, ufrmEODOnBoardPickList,
//  ufrmSummaryEOD, ufrmMissileMount, ufrmTorpedoMount, ufrmGunMount,
//  ufrmVisualDetectorMount, ufrmEODMount;

{$REGION ' Form Handle '}

procedure TfrmBlindZonesAttachment.FormCreate(Sender: TObject);
begin
//  FFirstBZView := TBlindZoneView.Create(Self);
//
//  with FFirstBZView do
//  begin
//    Parent := pnlFirstBlind;
//    Left := 0;
//    Top := 0;
//    Height := pnlFirstBlind.Height;
//    Width := pnlFirstBlind.Width;
//    EnableDrag := True;
//    OnZoneChange := FirstRotWheelDegreeChange;
//    AddZone;
//  end;
//
//  FSecondBZView := TBlindZoneView.Create(Self);
//
//  with FSecondBZView do
//  begin
//    Parent := pnlSecondBlind;
//    Left := 0;
//    Top := 0;
//    Height := pnlSecondBlind.Height;
//    Width := pnlSecondBlind.Width;
//    EnableDrag := True;
//    OnZoneChange := SecondRotWheelDegreeChange;
//    AddZone;
//  end;
end;

procedure TfrmBlindZonesAttachment.FormShow(Sender: TObject);
begin
  UpdateBlindZoneForm;

  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmBlindZonesAttachment.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  Close;
end;

procedure TfrmBlindZonesAttachment.btnApplyClick(Sender: TObject);
begin
//  case FOnBoardType of
//    bzcFireControl:
//    begin
//    end;
//    bzcESM:
//    begin
//      with TESM_On_Board(FOnBoardOwner) do
//      begin
//
//        {$REGION ' Blind Zone 1 Section '}
//
//        if cbFirstBlindZone.Checked then
//        begin
//          FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_1.BlindZone_Number := 1;
//          FBZone_1.ESM_Instance_Index := FData.ESM_Instance_Index;
//          FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//          FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//          if FBZone_1.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_1)
//          else
//            dmTTT.UpdateBlindZone(FBZone_1);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_1.Blind_Zone_Type, FData.ESM_Instance_Index, 1);
//
//        {$ENDREGION}
//
//        {$REGION ' Blind Zone 2 Section '}
//
//        if cbSecondBlindZone.Checked then
//        begin
//          FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_2.BlindZone_Number := 2;
//          FBZone_2.ESM_Instance_Index := FData.ESM_Instance_Index;
//          FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//          FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//          if FBZone_2.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_2)
//          else
//            dmTTT.UpdateBlindZone(FBZone_2);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_2.Blind_Zone_Type, FData.ESM_Instance_Index, 2);
//
//        {$ENDREGION}
//
//      end;
//    end;
//    bzcEO:
//    begin
//      with TEOD_On_Board(FOnBoardOwner) do
//      begin
//
//        {$REGION ' Blind Zone 1 Section '}
//
//        if cbFirstBlindZone.Checked then
//        begin
//          FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_1.BlindZone_Number := 1;
//          FBZone_1.EO_Instance_Index := FData.EO_Instance_Index;
//          FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//          FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//          if FBZone_1.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_1)
//          else
//            dmTTT.UpdateBlindZone(FBZone_1);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_1.Blind_Zone_Type, FData.EO_Instance_Index, 1);
//
//        {$ENDREGION}
//
//        {$REGION ' Blind Zone 2 Section '}
//
//        if cbSecondBlindZone.Checked then
//        begin
//          FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_2.BlindZone_Number := 2;
//          FBZone_2.EO_Instance_Index := FData.EO_Instance_Index;
//          FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//          FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//          if FBZone_2.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_2)
//          else
//            dmTTT.UpdateBlindZone(FBZone_2);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_2.Blind_Zone_Type, FData.EO_Instance_Index, 2);
//
//        {$ENDREGION}
//
//      end;
//    end;
//    bzcVisual:
//    begin
//      with TVisual_Sensor_On_Board(FOnBoardOwner) do
//      begin
//
//        {$REGION ' Blind Zone 1 Section '}
//
//        if cbFirstBlindZone.Checked then
//        begin
//          FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_1.BlindZone_Number := 1;
//          FBZone_1.Visual_Instance_Index := FData.Visual_Instance_Index;
//          FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//          FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//          if FBZone_1.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_1)
//          else
//            dmTTT.UpdateBlindZone(FBZone_1);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_1.Blind_Zone_Type, FData.Visual_Instance_Index, 1);
//
//        {$ENDREGION}
//
//        {$REGION ' Blind Zone 2 Section '}
//
//        if cbSecondBlindZone.Checked then
//        begin
//          FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_2.BlindZone_Number := 2;
//          FBZone_2.Visual_Instance_Index := FData.Visual_Instance_Index;
//          FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//          FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//          if FBZone_2.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_2)
//          else
//            dmTTT.UpdateBlindZone(FBZone_2);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_2.Blind_Zone_Type, FData.Visual_Instance_Index, 2);
//
//        {$ENDREGION}
//
//      end;
//    end;
//    bzcPointEffect:
//    begin
//      with TGun_Definition(FOnBoardOwner) do
//      begin
//
//        {$REGION ' Blind Zone 1 Section '}
//
//        if cbFirstBlindZone.Checked then
//        begin
//          FPoint.FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//          FPoint.FBZone_1.BlindZone_Number := 1;
//          FPoint.FBZone_1.Point_Effect_Index := FPoint.FData.Point_Effect_Index;
//          FPoint.FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//          FPoint.FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//          if FPoint.FBZone_1.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FPoint.FBZone_1)
//          else
//            dmTTT.UpdateBlindZone(FPoint.FBZone_1);
//        end
//        else
//          dmTTT.DeleteBlindZone(FPoint.FBZone_1.Blind_Zone_Type, FPoint.FData.Point_Effect_Index, 1);
//
//        {$ENDREGION}
//
//        {$REGION ' Blind Zone 2 Section '}
//
//        if cbSecondBlindZone.Checked then
//        begin
//          FPoint.FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//          FPoint.FBZone_2.BlindZone_Number := 2;
//          FPoint.FBZone_2.Point_Effect_Index := FPoint.FData.Point_Effect_Index;
//          FPoint.FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//          FPoint.FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//          if FPoint.FBZone_2.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FPoint.FBZone_2)
//          else
//            dmTTT.UpdateBlindZone(FPoint.FBZone_2);
//        end
//        else
//          dmTTT.DeleteBlindZone(FPoint.FBZone_2.Blind_Zone_Type, FPoint.FData.Point_Effect_Index, 2);
//
//        {$ENDREGION}
//
//      end;
//    end;
//    bzcWeapon:
//    begin
//      if FOnBoardOwner is TMissile_On_Board then
//      begin
//        with TMissile_On_Board(FOnBoardOwner) do
//        begin
//
//          {$REGION ' Blind Zone 1 Section '}
//
//          if cbFirstBlindZone.Checked then
//          begin
//            FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//            FBZone_1.BlindZone_Number := 1;
//            FBZone_1.Fitted_Weap_Index := FData.Fitted_Weap_Index;
//            FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//            FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//            if FBZone_1.Blind_Zone_Index = 0 then
//              dmTTT.InsertBlindZone(FBZone_1)
//            else
//              dmTTT.UpdateBlindZone(FBZone_1);
//          end
//          else
//            dmTTT.DeleteBlindZone(FBZone_1.Blind_Zone_Type, FData.Fitted_Weap_Index, 1);
//
//          {$ENDREGION}
//
//          {$REGION ' Blind Zone 2 Section '}
//
//          if cbSecondBlindZone.Checked then
//          begin
//            FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//            FBZone_2.BlindZone_Number := 2;
//            FBZone_2.Fitted_Weap_Index := FData.Fitted_Weap_Index;
//            FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//            FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//            if FBZone_2.Blind_Zone_Index = 0 then
//              dmTTT.InsertBlindZone(FBZone_2)
//            else
//              dmTTT.UpdateBlindZone(FBZone_2);
//          end
//          else
//            dmTTT.DeleteBlindZone(FBZone_2.Blind_Zone_Type, FData.Fitted_Weap_Index, 2);
//
//          {$ENDREGION}
//
//        end;
//      end
//      else if FOnBoardOwner is TTorpedo_On_Board then
//      begin
//        with TTorpedo_On_Board(FOnBoardOwner) do
//        begin
//
//          {$REGION ' Blind Zone 1 Section '}
//
//          if cbFirstBlindZone.Checked then
//          begin
//            FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//            FBZone_1.BlindZone_Number := 1;
//            FBZone_1.Fitted_Weap_Index := FData.Fitted_Weap_Index;
//            FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//            FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//            if FBZone_1.Blind_Zone_Index = 0 then
//              dmTTT.InsertBlindZone(FBZone_1)
//            else
//              dmTTT.UpdateBlindZone(FBZone_1);
//          end
//          else
//            dmTTT.DeleteBlindZone(FBZone_1.Blind_Zone_Type, FData.Fitted_Weap_Index, 1);
//
//          {$ENDREGION}
//
//          {$REGION ' Blind Zone 2 Section '}
//
//          if cbSecondBlindZone.Checked then
//          begin
//            FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//            FBZone_2.BlindZone_Number := 2;
//            FBZone_2.Fitted_Weap_Index := FData.Fitted_Weap_Index;
//            FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//            FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//            if FBZone_2.Blind_Zone_Index = 0 then
//              dmTTT.InsertBlindZone(FBZone_2)
//            else
//              dmTTT.UpdateBlindZone(FBZone_2);
//          end
//          else
//            dmTTT.DeleteBlindZone(FBZone_2.Blind_Zone_Type, FData.Fitted_Weap_Index, 2);
//
//          {$ENDREGION}
//
//        end;
//      end;
//    end;
//    bzcSonar:
//    begin
//      with TSonar_On_Board(FOnBoardOwner) do
//      begin
//
//        {$REGION ' Blind Zone 1 Section '}
//
//        if cbFirstBlindZone.Checked then
//        begin
//          FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_1.BlindZone_Number := 1;
//          FBZone_1.Sonar_Instance_Index := FData.Sonar_Instance_Index;
//          FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//          FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//          if FBZone_1.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_1)
//          else
//            dmTTT.UpdateBlindZone(FBZone_1);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_1.Blind_Zone_Type, FData.Sonar_Instance_Index, 1);
//
//        {$ENDREGION}
//
//        {$REGION ' Blind Zone 2 Section '}
//
//        if cbSecondBlindZone.Checked then
//        begin
//          FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_2.BlindZone_Number := 2;
//          FBZone_2.Sonar_Instance_Index := FData.Sonar_Instance_Index;
//          FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//          FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//          if FBZone_2.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_2)
//          else
//            dmTTT.UpdateBlindZone(FBZone_2);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_2.Blind_Zone_Type, FData.Sonar_Instance_Index, 2);
//
//        {$ENDREGION}
//
//      end;
//    end;
//    bzcRadar:
//    begin
//      with TRadar_On_Board(FOnBoardOwner) do
//      begin
//
//        {$REGION ' Blind Zone 1 Section '}
//
//        if cbFirstBlindZone.Checked then
//        begin
//          FBZone_1.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_1.BlindZone_Number := 1;
//          FBZone_1.Radar_Instance_Index := FData.Radar_Instance_Index;
//          FBZone_1.Start_Angle := FFirstBZView.Zones[0].StartAngle;
//          FBZone_1.End_Angle := FFirstBZView.Zones[0].EndAngle;
//
//          if FBZone_1.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_1)
//          else
//            dmTTT.UpdateBlindZone(FBZone_1);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_1.Blind_Zone_Type, FData.Radar_Instance_Index, 1);
//
//        {$ENDREGION}
//
//        {$REGION ' Blind Zone 2 Section '}
//
//        if cbSecondBlindZone.Checked then
//        begin
//          FBZone_2.Blind_Zone_Type := Ord(FOnBoardType);
//          FBZone_2.BlindZone_Number := 2;
//          FBZone_2.Radar_Instance_Index := FData.Radar_Instance_Index;
//          FBZone_2.Start_Angle := FSecondBZView.Zones[0].StartAngle;
//          FBZone_2.End_Angle := FSecondBZView.Zones[0].EndAngle;
//
//          if FBZone_2.Blind_Zone_Index = 0 then
//            dmTTT.InsertBlindZone(FBZone_2)
//          else
//            dmTTT.UpdateBlindZone(FBZone_2);
//        end
//        else
//          dmTTT.DeleteBlindZone(FBZone_2.Blind_Zone_Type, FData.Radar_Instance_Index, 2);
//
//        {$ENDREGION}
//      end;
//    end;
//  end;
//
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;
end;

procedure TfrmBlindZonesAttachment.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmBlindZonesAttachment.cbFirstBlindZoneClick(Sender: TObject);
begin
  grbFirstBlindZone.Enabled := cbFirstBlindZone.Checked;
  cbSecondBlindZone.Enabled := cbFirstBlindZone.Checked;

  if not cbFirstBlindZone.Checked then
  begin
    cbSecondBlindZone.Checked := False;
    TrackCentreFirst.Position := 0;
    TrackWidthFirst.Position  := 0;
    edtCentreFirst.Text   := '0';
    edtWidthFirst.Text    := '0';
  end;

  btnApply.Enabled := True;
end;

procedure TfrmBlindZonesAttachment.cbSecondBlindZoneClick(Sender: TObject);
begin
  grbSecondBlindZone.Enabled := cbSecondBlindZone.Checked;

  if not cbSecondBlindZone.Checked then
  begin
    TrackCentreSecond.Position := 0;
    TrackWidthSecond.Position  := 0;
    edtCentreSecond.Text   := '0';
    edtWidthSecond.Text    := '0';
  end;

  btnApply.Enabled := True;
end;

procedure TfrmBlindZonesAttachment.edtGeneralChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 359) then
    TEdit(Sender).Text := '0';

  if TEdit(Sender).Name = 'edtCentreFirst' then
    TrackCentreFirst.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtWidthFirst' then
    TrackWidthFirst.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtCentreSecond' then
    TrackCentreSecond.Position := StrToInt(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'edtWidthSecond' then
    TrackWidthSecond.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

procedure TfrmBlindZonesAttachment.trckbrGeneralChange(Sender: TObject);
var
  d, e: double;
//  zs: TZoneSector;

begin
//  case TTrackBar(Sender).Tag of
//    0: {Centre First}
//    begin
//      zs := FFirstBZView.Zones[0];
//      zs.Degree := TTrackBar(Sender).Position;
//
//      edtCentreFirst.Text := FormatFloat('0', zs.Degree);
//      FFirstBZView.Repaint;
//    end;
//    1: {Width First}
//    begin
//      zs := FFirstBZView.Zones[0];
//      zs.AngleWidth := TTrackBar(Sender).Position;
//
//      edtWidthFirst.Text := FormatFloat('0', zs.AngleWidth);
//      FFirstBZView.Repaint;
//    end;
//    2: {Centre Second}
//    begin
//      zs := FSecondBZView.Zones[0];
//      zs.Degree := TTrackBar(Sender).Position;
//
//      edtCentreSecond.Text := FormatFloat('0', zs.Degree);
//      FSecondBZView.Repaint;
//    end;
//    3: {Width Second}
//    begin
//      zs := FSecondBZView.Zones[0];
//      zs.AngleWidth := TTrackBar(Sender).Position;
//
//      edtWidthSecond.Text := FormatFloat('0', zs.AngleWidth);
//      FSecondBZView.Repaint;
//    end;
//  end;
end;

procedure TfrmBlindZonesAttachment.FirstRotWheelDegreeChange(Sender: TObject);
//var
//  zs : TZoneSector;
begin
//  zs := FFirstBZView.Zones[0];
//  TrackCentreFirst.Position := Round(zs.Degree);
end;

procedure TfrmBlindZonesAttachment.SecondRotWheelDegreeChange(Sender: TObject);
//var
//  zs : TZoneSector;
begin
//  zs := FSecondBZView.Zones[0];
//  TrackCentreSecond.Position := Round(zs.Degree);
end;

function TfrmBlindZonesAttachment.GetBlindZoneAngleWidth(const aDegStart, aDegEnd: Double): Integer;
begin
  Result := Round(aDegEnd - aDegStart);

  if Result < 0 then
    Result := Result + 360;
end;

function TfrmBlindZonesAttachment.GetBlindZoneCentre(const aDegStart, aDegEnd: Double): Integer;
var
  width : Integer;
begin
  width := GetBlindZoneAngleWidth(aDegStart, aDegEnd);
  Result := Round((width / 2) + aDegStart);

  if Result > 360 then
    Result := Result - 360;
end;

procedure TfrmBlindZonesAttachment.UpdateBlindZoneForm;
//var
//  zs : TZoneSector;
begin
//  case FOnBoardType of
//    bzcFireControl: ;
//    bzcESM:
//    begin
//      with TESM_On_Board(FOnBoardOwner) do
//      begin
//        cbFirstBlindZone.Checked := FBZone_1.Blind_Zone_Index <> 0;
//        cbSecondBlindZone.Checked := FBZone_2.Blind_Zone_Index <> 0;
//
//        TrackCentreFirst.Position := GetBlindZoneCentre(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackWidthFirst.Position := GetBlindZoneAngleWidth(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackCentreSecond.Position := GetBlindZoneCentre(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//        TrackWidthSecond.Position := GetBlindZoneAngleWidth(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//      end;
//    end;
//    bzcEO:
//    begin
//      with TEOD_On_Board(FOnBoardOwner) do
//      begin
//        cbFirstBlindZone.Checked := FBZone_1.Blind_Zone_Index <> 0;
//        cbSecondBlindZone.Checked := FBZone_2.Blind_Zone_Index <> 0;
//
//        TrackCentreFirst.Position := GetBlindZoneCentre(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackWidthFirst.Position := GetBlindZoneAngleWidth(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackCentreSecond.Position := GetBlindZoneCentre(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//        TrackWidthSecond.Position := GetBlindZoneAngleWidth(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//      end;
//    end;
//    bzcVisual:
//    begin
//      with TVisual_Sensor_On_Board(FOnBoardOwner) do
//      begin
//        cbFirstBlindZone.Checked := FBZone_1.Blind_Zone_Index <> 0;
//        cbSecondBlindZone.Checked := FBZone_2.Blind_Zone_Index <> 0;
//
//        TrackCentreFirst.Position := GetBlindZoneCentre(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackWidthFirst.Position := GetBlindZoneAngleWidth(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackCentreSecond.Position := GetBlindZoneCentre(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//        TrackWidthSecond.Position := GetBlindZoneAngleWidth(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//      end;
//    end;
//    bzcSonar:
//    begin
//      with TSonar_On_Board(FOnBoardOwner) do
//      begin
//        cbFirstBlindZone.Checked := FBZone_1.Blind_Zone_Index <> 0;
//        cbSecondBlindZone.Checked := FBZone_2.Blind_Zone_Index <> 0;
//
//        TrackCentreFirst.Position := GetBlindZoneCentre(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackWidthFirst.Position := GetBlindZoneAngleWidth(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackCentreSecond.Position := GetBlindZoneCentre(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//        TrackWidthSecond.Position := GetBlindZoneAngleWidth(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//      end;
//    end;
//    bzcRadar:
//    begin
//      with TRadar_On_Board(FOnBoardOwner) do
//      begin
//        cbFirstBlindZone.Checked := FBZone_1.Blind_Zone_Index <> 0;
//        cbSecondBlindZone.Checked := FBZone_2.Blind_Zone_Index <> 0;
//
//        TrackCentreFirst.Position := GetBlindZoneCentre(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackWidthFirst.Position := GetBlindZoneAngleWidth(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//        TrackCentreSecond.Position := GetBlindZoneCentre(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//        TrackWidthSecond.Position := GetBlindZoneAngleWidth(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//      end;
//    end;
//    bzcPointEffect:
//    begin
//      with TGun_Definition(FOnBoardOwner) do
//      begin
//        cbFirstBlindZone.Checked := FPoint.FBZone_1.Blind_Zone_Index <> 0;
//        cbSecondBlindZone.Checked := FPoint.FBZone_2.Blind_Zone_Index <> 0;
//
//        TrackCentreFirst.Position := GetBlindZoneCentre(FPoint.FBZone_1.Start_Angle, FPoint.FBZone_1.End_Angle);
//        TrackWidthFirst.Position := GetBlindZoneAngleWidth(FPoint.FBZone_1.Start_Angle, FPoint.FBZone_1.End_Angle);
//        TrackCentreSecond.Position := GetBlindZoneCentre(FPoint.FBZone_2.Start_Angle, FPoint.FBZone_2.End_Angle);
//        TrackWidthSecond.Position := GetBlindZoneAngleWidth(FPoint.FBZone_2.Start_Angle, FPoint.FBZone_2.End_Angle);
//      end;
//    end;
//    bzcWeapon:
//    begin
//      if FOnBoardOwner is TMissile_On_Board then
//      begin
//        with TMissile_On_Board(FOnBoardOwner) do
//        begin
//          cbFirstBlindZone.Checked := FBZone_1.Blind_Zone_Index <> 0;
//          cbSecondBlindZone.Checked := FBZone_2.Blind_Zone_Index <> 0;
//
//          TrackCentreFirst.Position := GetBlindZoneCentre(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//          TrackWidthFirst.Position := GetBlindZoneAngleWidth(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//          TrackCentreSecond.Position := GetBlindZoneCentre(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//          TrackWidthSecond.Position := GetBlindZoneAngleWidth(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//        end;
//      end
//      else if FOnBoardOwner is TTorpedo_On_Board then
//      begin
//        with TTorpedo_On_Board(FOnBoardOwner) do
//        begin
//          cbFirstBlindZone.Checked := FBZone_1.Blind_Zone_Index <> 0;
//          cbSecondBlindZone.Checked := FBZone_2.Blind_Zone_Index <> 0;
//
//          TrackCentreFirst.Position := GetBlindZoneCentre(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//          TrackWidthFirst.Position := GetBlindZoneAngleWidth(FBZone_1.Start_Angle, FBZone_1.End_Angle);
//          TrackCentreSecond.Position := GetBlindZoneCentre(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//          TrackWidthSecond.Position := GetBlindZoneAngleWidth(FBZone_2.Start_Angle, FBZone_2.End_Angle);
//        end;
//      end;
//    end;
//
//  end;
end;

{$ENDREGION}

end.

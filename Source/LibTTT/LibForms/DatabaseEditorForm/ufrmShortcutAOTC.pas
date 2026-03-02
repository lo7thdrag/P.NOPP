unit ufrmShortcutAOTC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmShortcutAOTC = class(TForm)
    ImgBackgroundForm: TImage;
    ImgLogoCountermeasures: TImage;
    ImgCountermeasures: TImage;
    ImgLogoOther: TImage;
    ImgLogoPlatform: TImage;
    ImgLogoSensor: TImage;
    ImgLogoWeapon: TImage;
    ImgOther: TImage;
    ImgPlatform: TImage;
    ImgSensor: TImage;
    ImgWeapon: TImage;
    ImgLogoLogout: TImage;
    ImgLogout: TImage;
    pnlMain: TPanel;
    ImgMissile: TImage;
    ImgTorpedo: TImage;
    ImgMine: TImage;
    ImgGun: TImage;
    ImgBomb: TImage;
    ImgAcousticDecoy: TImage;
    ImgAirBubble: TImage;
    ImgChaff: TImage;
    ImgFloatingDecoy: TImage;
    ImgInfraredDecoy: TImage;
    ImgRadarNoiseJammer: TImage;
    ImgSelfDefensiveJammer: TImage;
    ImgTowedJammer: TImage;
    ImgSNRvsPOD: TImage;
    ImgGameDefault: TImage;
    ImgLogistic: TImage;
    ImgMotion: TImage;
    ImgTransport: TImage;
    ImgVehicle: TImage;
    ImgEOD: TImage;
    ImgMAD: TImage;
    ImgESM: TImage;
    ImgSonobuoy: TImage;
    ImgSonar: TImage;
    ImgRadar: TImage;
    Timer1: TTimer;
    procedure ImgCountermeasuresClick(Sender: TObject);
    procedure ImgPlatformClick(Sender: TObject);
    procedure ImgSensorClick(Sender: TObject);
    procedure ImgOtherClick(Sender: TObject);
    procedure ImgLogoutClick(Sender: TObject);
    procedure ImgWeaponClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    isStateCollaps : Boolean;
    pnlActive : Integer;


    procedure InitiateButton();
    procedure SetVisibleButton();
    procedure CollapseButton();
    procedure UnCollapseButton();
  public
    { Public declarations }
  end;

var
  frmShortcutAOTC: TfrmShortcutAOTC;

implementation

{$R *.dfm}

procedure TfrmShortcutAOTC.FormShow(Sender: TObject);
begin
//  self.BorderStyle := bsNone;
//  self.Width := 1300;//1485;
//  self.Height := 700;//800;

  InitiateButton();
  isStateCollaps := True;
end;

procedure TfrmShortcutAOTC.ImgCountermeasuresClick(Sender: TObject);
begin
  Timer1.Enabled := True;
  pnlActive := 4;
end;

procedure TfrmShortcutAOTC.ImgLogoutClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmShortcutAOTC.ImgOtherClick(Sender: TObject);
begin
  Timer1.Enabled := True;
  pnlActive := 3;
end;

procedure TfrmShortcutAOTC.ImgPlatformClick(Sender: TObject);
begin
  Timer1.Enabled := True;
  pnlActive := 0;
end;

procedure TfrmShortcutAOTC.ImgSensorClick(Sender: TObject);
begin
  Timer1.Enabled := True;
  pnlActive := 1;
end;

procedure TfrmShortcutAOTC.ImgWeaponClick(Sender: TObject);
begin
  Timer1.Enabled := True;
  pnlActive := 2;
end;

procedure TfrmShortcutAOTC.InitiateButton;
begin

  {$REGION ' Platform Section '}
  ImgVehicle.Height := 0;
  ImgVehicle.Width := 0;
  {$ENDREGION}

  {$REGION ' Sensor Section '}
  ImgRadar.Height := 0;
  ImgRadar.Width := 0;

  ImgSonar.Height := 0;
  ImgSonar.Width := 0;

  ImgSonobuoy.Height := 0;
  ImgSonobuoy.Width := 0;

  ImgESM.Height := 0;
  ImgESM.Width := 0;

  ImgEOD.Height := 0;
  ImgEOD.Width := 0;

  ImgMAD.Height := 0;
  ImgMAD.Width := 0;
  {$ENDREGION}

  {$REGION ' Weapon Section '}
  ImgGun.Height := 0;
  ImgGun.Width := 0;

  ImgTorpedo.Height := 0;
  ImgTorpedo.Width := 0;

  ImgMissile.Height := 0;
  ImgMissile.Width := 0;

  ImgBomb.Height := 0;
  ImgBomb.Width := 0;

  ImgMine.Height := 0;
  ImgMine.Width := 0;
  {$ENDREGION}

  {$REGION ' Countermeasure Section '}
  ImgAcousticDecoy.Height := 0;
  ImgAcousticDecoy.Width := 0;

  ImgAirBubble.Height := 0;
  ImgAirBubble.Width := 0;

  ImgChaff.Height := 0;
  ImgChaff.Width := 0;

  ImgFloatingDecoy.Height := 0;
  ImgFloatingDecoy.Width := 0;

  ImgInfraredDecoy.Height := 0;
  ImgInfraredDecoy.Width := 0;

  ImgRadarNoiseJammer.Height := 0;
  ImgRadarNoiseJammer.Width := 0;

  ImgSelfDefensiveJammer.Height := 0;
  ImgSelfDefensiveJammer.Width := 0;

  ImgTowedJammer.Height := 0;
  ImgTowedJammer.Width := 0;
  {$ENDREGION}

  {$REGION ' Other Section '}
//  ImgRPL.Height := 0;
//  ImgRPL.Width := 0;
//
//  ImgOverlay.Height := 0;
//  ImgOverlay.Width := 0;

  ImgLogistic.Height := 0;
  ImgLogistic.Width := 0;

  ImgTransport.Height := 0;
  ImgTransport.Width := 0;

//  ImgBase.Height := 0;
//  ImgBase.Width := 0;
//
//  ImgWaypoint.Height := 0;
//  ImgWaypoint.Width := 0;

  ImgMotion.Height := 0;
  ImgMotion.Width := 0;

  ImgSNRvsPOD.Height := 0;
  ImgSNRvsPOD.Width := 0;

//  ImgStudentRole.Height := 0;
//  ImgStudentRole.Width := 0;

  ImgGameDefault.Height := 0;
  ImgGameDefault.Width := 0;

//  ImgGameArea.Height := 0;
//  ImgGameArea.Width := 0;
  {$ENDREGION}

end;

procedure TfrmShortcutAOTC.CollapseButton;
begin

  if ImgRadar.Height < 120 then
  begin

    {$REGION ' Platform Section '}
    ImgVehicle.Height := ImgVehicle.Height + 2;
    ImgVehicle.Width := ImgVehicle.Width + 2;
    {$ENDREGION}

    {$REGION ' Sensor Section '}
    ImgRadar.Height := ImgRadar.Height + 2;
    ImgRadar.Width := ImgRadar.Width + 2;

    ImgSonar.Height := ImgSonar.Height + 2;
    ImgSonar.Width := ImgSonar.Width + 2;

    ImgSonobuoy.Height := ImgSonobuoy.Height + 2;
    ImgSonobuoy.Width := ImgSonobuoy.Width + 2;

    ImgESM.Height := ImgESM.Width + 2;
    ImgESM.Width := ImgESM.Width + 2;

    ImgEOD.Height := ImgEOD.Width + 2;
    ImgEOD.Width := ImgEOD.Width + 2;

    ImgMAD.Height := ImgEOD.Width + 2;
    ImgMAD.Width := ImgEOD.Width + 2;
    {$ENDREGION}

    {$REGION ' Weapon Section '}
    ImgMissile.Height := ImgMissile.Height + 2;
    ImgMissile.Width := ImgMissile.Width + 2;

    ImgTorpedo.Height := ImgTorpedo.Height + 2;
    ImgTorpedo.Width := ImgTorpedo.Width + 2;

    ImgMine.Height := ImgMine.Height + 2;
    ImgMine.Width := ImgMine.Width + 2;

    ImgBomb.Height := ImgBomb.Height + 2;
    ImgBomb.Width := ImgBomb.Width + 2;

    ImgGun.Height := ImgGun.Height + 2;
    ImgGun.Width := ImgGun.Width + 2;
    {$ENDREGION}

    {$REGION ' Countermeasure Section '}
    ImgAcousticDecoy.Height := ImgAcousticDecoy.Height + 2;
    ImgAcousticDecoy.Width := ImgAcousticDecoy.Width + 2;

    ImgAirBubble.Height := ImgAirBubble.Height + 2;
    ImgAirBubble.Width := ImgAirBubble.Width + 2;

    ImgChaff.Height := ImgChaff.Height + 2;
    ImgChaff.Width := ImgChaff.Width + 2;

    ImgFloatingDecoy.Height := ImgFloatingDecoy.Height + 2;
    ImgFloatingDecoy.Width := ImgFloatingDecoy.Width + 2;

    ImgInfraredDecoy.Height := ImgInfraredDecoy.Height + 2;
    ImgInfraredDecoy.Width := ImgInfraredDecoy.Width + 2;

    ImgRadarNoiseJammer.Height := ImgRadarNoiseJammer.Height + 2;
    ImgRadarNoiseJammer.Width := ImgRadarNoiseJammer.Width + 2;

    ImgSelfDefensiveJammer.Height := ImgSelfDefensiveJammer.Height + 2;
    ImgSelfDefensiveJammer.Width := ImgSelfDefensiveJammer.Width + 2;

    ImgTowedJammer.Height := ImgTowedJammer.Height + 2;
    ImgTowedJammer.Width := ImgTowedJammer.Width + 2;
    {$ENDREGION}

    {$REGION ' Other Section '}
//    ImgRPL.Height := ImgRPL.Height + 2;
//    ImgRPL.Width := ImgRPL.Width + 2;
//
//    ImgOverlay.Height := ImgOverlay.Height + 2;
//    ImgOverlay.Width := ImgOverlay.Width + 2;

    ImgLogistic.Height := ImgLogistic.Height + 2;
    ImgLogistic.Width := ImgLogistic.Width + 2;

    ImgTransport.Height := ImgTransport.Height + 2;
    ImgTransport.Width := ImgTransport.Width + 2;

//    ImgBase.Height := ImgBase.Height + 2;
//    ImgBase.Width := ImgBase.Width + 2;
//
//    ImgWaypoint.Height := ImgWaypoint.Height + 2;
//    ImgWaypoint.Width := ImgWaypoint.Width + 2;

    ImgMotion.Height := ImgMotion.Height + 2;
    ImgMotion.Width := ImgMotion.Width + 2;

    ImgSNRvsPOD.Height := ImgSNRvsPOD.Height + 2;
    ImgSNRvsPOD.Width := ImgSNRvsPOD.Width + 2;

//    ImgStudentRole.Height := ImgStudentRole.Height + 2;
//    ImgStudentRole.Width := ImgStudentRole.Width + 2;

    ImgGameDefault.Height := ImgGameDefault.Height + 2;
    ImgGameDefault.Width := ImgGameDefault.Width + 2;

//    ImgGameArea.Height := ImgGameArea.Height + 2;
//    ImgGameArea.Width := ImgGameArea.Width + 2;
    {$ENDREGION}

  end
  else
  begin
    isStateCollaps := True;
    Timer1.Enabled := false;
  end;
end;

procedure TfrmShortcutAOTC.SetVisibleButton;
begin

  {$REGION ' Platform Section '}
  ImgVehicle.Visible := False;
  {$ENDREGION}

  {$REGION ' Sensor Section '}
  ImgRadar.Visible := False;
  ImgSonar.Visible := False;
  ImgSonobuoy.Visible := False;
  ImgESM.Visible := False;
  ImgEOD.Visible := False;
  ImgMAD.Visible := False;
  {$ENDREGION}

  {$REGION ' Weapon Section '}
  ImgGun.Visible := False;
  ImgTorpedo.Visible := False;
  ImgMissile.Visible := False;
  ImgBomb.Visible := False;
  ImgMine.Visible := False;
  {$ENDREGION}

  {$REGION ' Countermeasure Section '}
  ImgAcousticDecoy.Visible := False;
  ImgAirBubble.Visible := False;
  ImgChaff.Visible := False;
  ImgFloatingDecoy.Visible := False;
  ImgInfraredDecoy.Visible := False;
  ImgRadarNoiseJammer.Visible := False;
  ImgSelfDefensiveJammer.Visible := False;
  ImgTowedJammer.Visible := False;
  {$ENDREGION}

  {$REGION ' Other Section '}
//  ImgRPL.Visible := False;
//  ImgOverlay.Visible := False;
  ImgLogistic.Visible := False;
  ImgTransport.Visible := False;
//  ImgBase.Visible := False;
//  ImgWaypoint.Visible := False;
  ImgMotion.Visible := False;
  ImgSNRvsPOD.Visible := False;
//  ImgStudentRole.Visible := False;
  ImgGameDefault.Visible := False;
//  ImgGameArea.Visible := False;
  {$ENDREGION}

  case pnlActive of
    0:
    begin
      ImgVehicle.Visible := True;
    end;
    1:
    begin
      ImgRadar.Visible := True;
      ImgSonar.Visible := True;
      ImgSonobuoy.Visible := True;
      ImgESM.Visible := True;
      ImgEOD.Visible := True;
      ImgMAD.Visible := True;
    end;
    2:
    begin
      ImgMissile.Visible := True;
      ImgTorpedo.Visible := True;
      ImgMine.Visible := True;
      ImgBomb.Visible := True;
      ImgGun.Visible := True;
    end;
    3:
    begin
//      ImgRPL.Visible := True;
//      ImgOverlay.Visible := True;
      ImgLogistic.Visible := True;
      ImgTransport.Visible := True;
//      ImgBase.Visible := True;
//      ImgWaypoint.Visible := True;
      ImgMotion.Visible := True;
      ImgSNRvsPOD.Visible := True;
//      ImgStudentRole.Visible := True;
      ImgGameDefault.Visible := True;
//      ImgGameArea.Visible := True;
    end;
    4:
    begin
      ImgAcousticDecoy.Visible := True;
      ImgAirBubble.Visible := True;
      ImgChaff.Visible := True;
      ImgFloatingDecoy.Visible := True;
      ImgInfraredDecoy.Visible := True;
      ImgRadarNoiseJammer.Visible := True;
      ImgSelfDefensiveJammer.Visible := True;
      ImgTowedJammer.Visible := True;
    end;
  end;
end;

procedure TfrmShortcutAOTC.Timer1Timer(Sender: TObject);
begin
  if not Timer1.Enabled then
    Exit;

  if isStateCollaps then
    UnCollapseButton
  else
    CollapseButton;
end;

procedure TfrmShortcutAOTC.UnCollapseButton;
begin

  if ImgRadar.Height > 0 then
  begin

    {$REGION ' Platform Section '}
    ImgVehicle.Height := ImgVehicle.Height - 2;
    ImgVehicle.Width := ImgVehicle.Width - 2;

    {$ENDREGION}

    {$REGION ' Sensor Section '}
    ImgRadar.Height := ImgRadar.Height - 2;
    ImgRadar.Width := ImgRadar.Width - 2;

    ImgSonar.Height := ImgSonar.Height - 2;
    ImgSonar.Width := ImgSonar.Width - 2;

    ImgSonobuoy.Height := ImgSonobuoy.Height - 2;
    ImgSonobuoy.Width := ImgSonobuoy.Width - 2;

    ImgESM.Height := ImgESM.Width - 2;
    ImgESM.Width := ImgESM.Width - 2;

    ImgEOD.Height := ImgEOD.Width - 2;
    ImgEOD.Width := ImgEOD.Width - 2;

    ImgMAD.Height := ImgEOD.Width - 2;
    ImgMAD.Width := ImgEOD.Width - 2;
    {$ENDREGION}

    {$REGION ' Weapon Section '}
    ImgMissile.Height := ImgMissile.Height - 2;
    ImgMissile.Width := ImgMissile.Width - 2;

    ImgTorpedo.Height := ImgTorpedo.Height - 2;
    ImgTorpedo.Width := ImgTorpedo.Width - 2;

    ImgMine.Height := ImgMine.Height - 2;
    ImgMine.Width := ImgMine.Width - 2;

    ImgBomb.Height := ImgBomb.Height - 2;
    ImgBomb.Width := ImgBomb.Width - 2;

    ImgGun.Height := ImgGun.Height - 2;
    ImgGun.Width := ImgGun.Width - 2;
    {$ENDREGION}

    {$REGION ' Countermeasure Section '}
    ImgAcousticDecoy.Height := ImgAcousticDecoy.Height - 2;
    ImgAcousticDecoy.Width := ImgAcousticDecoy.Width - 2;

    ImgAirBubble.Height := ImgAirBubble.Height - 2;
    ImgAirBubble.Width := ImgAirBubble.Width - 2;

    ImgChaff.Height := ImgChaff.Height - 2;
    ImgChaff.Width := ImgChaff.Width - 2;

    ImgFloatingDecoy.Height := ImgFloatingDecoy.Height - 2;
    ImgFloatingDecoy.Width := ImgFloatingDecoy.Width - 2;

    ImgInfraredDecoy.Height := ImgInfraredDecoy.Height - 2;
    ImgInfraredDecoy.Width := ImgInfraredDecoy.Width - 2;

    ImgRadarNoiseJammer.Height := ImgRadarNoiseJammer.Height - 2;
    ImgRadarNoiseJammer.Width := ImgRadarNoiseJammer.Width - 2;

    ImgSelfDefensiveJammer.Height := ImgSelfDefensiveJammer.Height - 2;
    ImgSelfDefensiveJammer.Width := ImgSelfDefensiveJammer.Width - 2;

    ImgTowedJammer.Height := ImgTowedJammer.Height - 2;
    ImgTowedJammer.Width := ImgTowedJammer.Width - 2;
    {$ENDREGION}

    {$REGION ' Other Section '}
//    ImgRPL.Height := ImgRPL.Height - 2;
//    ImgRPL.Width := ImgRPL.Width - 2;
//
//    ImgOverlay.Height := ImgOverlay.Height - 2;
//    ImgOverlay.Width := ImgOverlay.Width - 2;

    ImgLogistic.Height := ImgLogistic.Height - 2;
    ImgLogistic.Width := ImgLogistic.Width - 2;

    ImgTransport.Height := ImgTransport.Height - 2;
    ImgTransport.Width := ImgTransport.Width - 2;

//    ImgBase.Height := ImgBase.Height - 2;
//    ImgBase.Width := ImgBase.Width - 2;
//
//    ImgWaypoint.Height := ImgWaypoint.Height - 2;
//    ImgWaypoint.Width := ImgWaypoint.Width - 2;

    ImgMotion.Height := ImgMotion.Height - 2;
    ImgMotion.Width := ImgMotion.Width - 2;

    ImgSNRvsPOD.Height := ImgSNRvsPOD.Height - 2;
    ImgSNRvsPOD.Width := ImgSNRvsPOD.Width - 2;

//    ImgStudentRole.Height := ImgStudentRole.Height - 2;
//    ImgStudentRole.Width := ImgStudentRole.Width - 2;

    ImgGameDefault.Height := ImgGameDefault.Height - 2;
    ImgGameDefault.Width := ImgGameDefault.Width - 2;

//    ImgGameArea.Height := ImgGameDefault.Height - 2;
//    ImgGameArea.Width := ImgGameDefault.Width - 2;
    {$ENDREGION}

  end
  else
  begin
    SetVisibleButton;
    isStateCollaps := false;
  end;
end;

end.

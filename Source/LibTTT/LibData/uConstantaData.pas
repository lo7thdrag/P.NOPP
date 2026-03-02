unit uConstantaData;

interface

uses
  {Delphi Uses}
  Classes, graphics ;

const
  /// client role play
  crpServer         = 0;
  crpInstructor     = 1;
  crpWasdal         = 2;
  crpSituationBoard = 3;
  crpOfficial       = 4;

  /// color group
  cgFriend       = clBlue; // TColor($33CCFF);  // light blue
  cgHostile      = clRed;  // TColor($FF0000);  // red
  cgSuspect      = clGreen;// TColor($00FF33);  // green
  cgOther        = clWhite;
  clrSelected    = clYellow; //TColor($FFFF33);  // Yellow

  /// User Map Tool Constanta
  mtSelectObject = 100;
  mtEditOverlay  = 101;
  mtAddOverlay   = 102;

  /// Overlay Type
  ovText      = 1;
  ovLine      = 2;
  ovRectangle = 3;
  ovCircle    = 4;
  ovEllipse   = 5;
  ovArc       = 6;
  ovSector    = 7;
  ovGrid      = 8;
  ovPolygon   = 9;
  ovIntelijen = 10;
  ovLogistic  = 11;
  ovRadar     = 12;
  ovPangkalan = 13;
  ovPanah     = 14;
  ovPlatform  = 15;

  /// Action Type
  caAdd     = 0;
  caEdit    = 1;
  caDelete  = 2;

  /// platform Identity (*sesuai id database)
  piPending             = 0;
  piUnknown             = 1;
  piAssumedFriend       = 2;
  piFriend              = 3;
  piNeutral             = 4;
  piSuspect             = 5;
  piHostile             = 6;

  /// symbol pictures name
  pfAssumedFriend           : string = 'AssumedFriend';
  pfFriend                  : string = 'Friend';
  pfHostile                 : string = 'Hostile';
  pfNeutral                 : string = 'Neutral';
  pfPending                 : string = 'Pending';
  pfUnknown                 : string = 'Unknown';
  pfSuspect                 : string = 'Suspect';

  pctAir                     : string = 'Air';
  pctAirborneEarlyWarning    : string = 'AirborneEarlyWarning';
  pctAirfield                : string = 'Airfield';
  pctAirGeneral              : string = 'AirGeneral';
  pctAirport_Civilian        : string = 'Airport_Civilian';
  pctAirport_Military        : string = 'Airport_Military';
  pctArmour                  : string = 'Armour';
  pctAssign                  : string = 'Assign';
  pctAswGeneral              : string = 'AswGeneral';
  pctBatteryAaa              : string = 'BatteryAaa';
  pctBatterySam              : string = 'BatterySam';
  pctBriefContact            : string = 'BriefContact';
  pctBullseye                : string = 'Bullseye';
  pctBuoy                    : string = 'Buoy';
  pctChaff                   : string = 'Chaff';
  pctCoastArtillery          : string = 'CoastArtillery';
  pctCoastMissile            : string = 'CoastMissile';
  pctCombatAirPatrol         : string = 'CombatAirPatrol';
  pctDataLinkReferencePoint  : string = 'DataLinkReferencePoint';
  pctDatum                   : string = 'Datum';
  pctDecoy                   : string = 'Decoy';
  pctDistressedVessel        : string = 'DistressedVessel';
  pctDitchedAirCraft         : string = 'DitchedAirCraft';
  pctEmpty                   : string = 'Empty';
  pctEngage                  : string = 'Engage';
  pctEsmEcmFix               : string = 'EsmEcmFix';
  pctFixedWing               : string = 'FixedWing';
  pctForceCenter             : string = 'ForceCenter';
  pctFormationMember         : string = 'FormationMember';
  pctGate                    : string = 'Gate';
  pctGeneral                 : string = 'General';
  pctGroundZero              : string = 'GroundZero';
  pctIff                     : string = 'Iff';
  pctInfantry                : string = 'Infantry';
  pctInfraredDecoy           : string = 'InfraredDecoy';
  pctKingpin                 : string = 'Kingpin';
  pctLand                    : string = 'Land';
  pctManInWater              : string = 'ManInWater';
  pctMaritimeHeadquarters    : string = 'MaritimeHeadquarters';
  pctMidCrsMissile           : string = 'MidCrsMissile';
  pctMine                    : string = 'Mine';
  pctMineHazard              : string = 'MineHazard';
  pctMissile                 : string = 'Missile';
  pctNavigationHazard        : string = 'NavigationHazard';
  pctNavigationalHazard      : string = 'NavigationalHazard';
  pctOilRig                  : string = 'OilRig';
  pctOwnShip                 : string = 'OwnShip';
  pct_Platform               : string = 'Platform';
  pctPopulated_Place         : string = 'Populated_Place';
  pctPort                    : string = 'Port';
  pctRiser                   : string = 'Riser';
  pctRotaryWing              : string = 'RotaryWing';
  pctSearchCenter            : string = 'SearchCenter';
  pctSearchCentre            : string = 'SearchCentre';
  pctSinker                  : string = 'Sinker';
  pctSonobuoy                : string = 'Sonobuoy';
  pctSonoMonitorCtrl         : string = 'SonoMonitorCtrl';
  pctSonoMonitorOther        : string = 'SonoMonitorOther';
  pctStation                 : string = 'Station';
  pctSubSurfaceAssumedFriend : string = 'SubSurfaceAssumedFriend';
  pctSubSurface              : string = 'SubSurface';
  pctSurface                 : string = 'Surface';
  pctTacticalGridorigin      : string = 'TacticalGridorigin';
  pctTaskGroup               : string = 'TaskGroup';
  pctTorpedo                 : string = 'Torpedo';
  pctWayPoint                : string = 'WayPoint';
  pctWeaponEntryPoint        : string = 'WeaponEntryPoint';
  pctWpnDropPoint            : string = 'WpnDropPoint';
  pctWreck                   : string = 'Wreck';
  pctAmphibious              : string = 'Amphibious';  //mk 03052012

  {Prince}
  pctFlagPoint               : string = 'FlagPoint';
  pctLogisticPoint           : string = 'Plot Base Logistic';
  pctPanah                   : string = 'Plot Panah';
  pctBaseAL                  : string = 'Plot Base AL';
  pctBaseAU                  : string = 'Base AU';
  pctBasePOLRI               : string = 'Base POLRI';
  pctBaseRadar               : string = 'Plot Base Radar';

/// symbol pictures name
  pfiAssumedFriend           : Char = '4';
  pfiFriend                  : Char = '4';
  pfiHostile                 : Char = '5';
  pfiNeutral                 : Char = '7';
  pfiPending                 : Char = '6';
  pfiUnknown                 : Char = '6';
  pfiSuspect                 : Char = '5';

  pciAir                     : Char = '`';
  pciAirborneEarlyWarning    : Char = '(';
  pciAirfield                : Char = 'r';
  pciAirGeneral              : Char = 'Q';
  pciAirport_Civilian        : Char = '@';
  pciAirport_Military        : Char = '!';
  pciArmour                  : Char = 't';
  pciAssign                  : Char = '^';
  pciAswGeneral              : Char = 'E';
  pciBatteryAaa              : Char = 'y';
  pciBatterySam              : Char = 'u';
  pciBriefContact            : Char = 'D';
  pciBullseye                : Char = 'F';
  pciBuoy                    : Char = 'A';
  pciChaff                   : Char = 'i';
  pciCoastArtillery          : Char = 'o';
  pciCoastMissile            : Char = 'p';
  pciCombatAirPatrol         : Char = ')';
  pciDataLinkReferencePoint  : Char = '$';
  pciDatum                   : Char = 'R';
  pciDecoy                   : Char = '[';
  pciDistressedVessel        : Char = '{';
  pciDitchedAirCraft         : Char = '}';
  pciEmpty                   : Char = '?';
  pciEngage                  : Char = '#';
  pciEsmEcmFix               : Char = '%';
  pciFixedWing               : Char = ']';
  pciForceCenter             : Char = '_';
  pciFormationMember         : Char = '+';
  pciGate                    : Char = '|';
  pciGeneral                 : Char = 'q';
  pciGroundZero              : Char = 'G';
  pciIff                     : Char = '"';
  pciInfantry                : Char = 'e';
  pciInfraredDecoy           : Char = 'i';
  pciKingpin                 : Char = 'l';
  pciLand                    : Char = '=';
  pciManInWater              : Char = 'O';
  pciMaritimeHeadquarters    : Char = '~';
  pciMidCrsMissile           : Char = 'a';
  pciMine                    : Char = '\';
  pciMineHazard              : Char = '\';
  pciMissile                 : Char = 's';
  pciNavigationHazard        : Char = 'H';
  pciNavigationalHazard      : Char = 'H';
  pciOilRig                  : Char = 'K';
  pciOwnShip                 : Char = 'W';
  pci_Platform               : Char = 'J';
  pciPopulated_Place         : Char = 'U';
  pciPort                    : Char = 'm';
  pciRiser                   : Char = 'P';
  pciRotaryWing              : Char = 'k';
  pciSearchCenter            : Char = 'Y';
  pciSearchCentre            : Char = 'Y';
  pciSinker                  : Char = 'S';
  pciSonobuoy                : Char = 'l';
  pciSonoMonitorCtrl         : Char = ';';
  pciSonoMonitorOther        : Char = '''';
  pciStation                 : Char = 'I';
  pciSubSurfaceAssumedFriend : Char = '0';
  pciSubSurface              : Char = '8';
  pciSurface                 : Char = '4';
  pciTacticalGridorigin      : Char = '#';
  pciTaskGroup               : Char = 'T';
  pciTorpedo                 : Char = 'd';
  pciWayPoint                : Char = '&';
  pciWeaponEntryPoint        : Char = 'h';
  pciWpnDropPoint            : Char = 'j';
  pciWreck                   : Char = 'w';
  pciAmphibious              : Char = '4';  //mk 03052012

  {Prince}
  pciFlagPoint               : Char = 'Q';
  pciLogisticPoint           : Char = '/';
  pciPanah                   : Char = '.';
  pciBaseAL                  : Char = 'm';
  pciBaseAU                  : Char = 'n';
  pciBasePOLRI               : Char = 'o';
  pciBaseRadar               : Char = ',';

  /// vehicle misc data
  /// vehicle domain
  vhdAir        = 0;        vhdsAir         = 'Air';
  vhdSurface    = 1;        vhdsSurface     = 'Surface';
  vhdSubsurface = 2;        vhdsSubsurface  = 'Subsurface';
  vhdLand       = 3;        vhdsLand        = 'Land';
  vhdAmphibious = 4;        vhdsAmphibious  = 'Amphibious'; //mk oper vhdGeneral - vhdAmphibious
  vhdWreck      = 5;        vhdsWreck       = 'Wreck';
  vhdGeneral    = 6;        vhdsGeneral     = 'General';    //mk oper vhdAmphibious - vhdGeneral
  vhdGrpPersonel= 7;        vhdsGrpPersonel = 'GRPPersonel';
  vhdTarget     = 8;        vhdsTarget      = 'Target';

  { for goto time }
  C_GotoTimeInfo : array [0..4] of String = ( '5 Minutes', '30 Minutes', '1 Hour', '2 Hour', '1 Day');
  C_GotoTimeSecond : array [0..4] of Extended = ( 60 * 5, 60 * 30, 60 * 60, 60 * 60 * 2, 60 * 60 * 24);

type
  TDSiWindowsVersion  = (wvUnknown, wvWin31, wvWin95, wvWin95OSR2, wvWin98, wvWin98SE, wvWinME, wvWin9x, wvWinNT3, wvWinNT4,
                          wvWin2000, wvWinXP, wvWinNT, wvWinServer2003, wvWinVista);
  TConsoleGroup       = (cgInstructor, cgSituationBoard, cgOfficial, cgWasdal);
  TOrganisasiTugas    = (otINWO, otNTWO, otATWO, otLFWO, otALWO, otCDWO, otSUWO, otLAIN);
  TSubOrganisasiTugas = (sotKPL, sotSTAFLAT, sotWASDAL, sotKOGAB, sotKOGASGABLA, sotKOGASGABFIB, sotPASRAT, sotKOGASRATMIN, sotKOGASHANTAI, sotSATGASDUK, sotLAIN);

  TFileExtention      = (feWord, feExcel, fePPT, fePaint, feEdge, feChrome, fePdf, feImage);

  TStorageType        = (stVehicle, stMissile, stTorpedo, stGun, stBomb, stMine, stRadar, stSonar, stEsm, stMad, stEod, stSonobuoy,
                         stChaff, stAirBubble, stAcousticDecoy, stInfraredDecoy, stFloatingDecoy, stTowedDecoy, stDefensiveJammer,
                         stRadarNoiseJammer);

  TTipeTahapan        = (ttPerencanaan, ttPersiapan, ttPelaksanaan, ttPengakhiran);

  TMapCursor          = (mcSelect, mcAdd, mcEdit, mcRulerStart, mcRulerEnd);

  TSingleArray  = array of Single;
  TIntegerArray = array of Integer;
  TString       = array of String;

  function SetOrganisasiTugasToString(aValue : TOrganisasiTugas) : String;
  function SetOrganisasiTugasAkronimToString(aValue : TOrganisasiTugas) : String;
  function SetOrganisasiTugasToEnum(aValue : String) : TOrganisasiTugas;

  function SetSubOrganisasiTugasToString(aValue : TSubOrganisasiTugas) : String;
  function SetSubOrganisasiTugasToEnum(aValue : String) : TSubOrganisasiTugas;

  function SetFileExtentionToString(aValue : TFileExtention) : String;
  function SetFileExtentionToEnum(aValue : String) : TFileExtention;

  function SetTipeTahapanToString(aValue : TTipeTahapan) : String;
  function SetTipeTahapanToEnum(aValue : String) : TTipeTahapan;

  function SetLineType(linetype :TPenStyle): Integer;

implementation

function SetOrganisasiTugasToString(aValue : TOrganisasiTugas) : String;
begin
  case aValue of
    otINWO : result := 'Integrated Naval Warfare Operations';
    otNTWO : result := 'Naval Tactical Warfare Operations';
    otATWO : result := 'Amphibious Tactical Warfare Operations';
    otLFWO : result := 'Landing Forces Warfare Operations';
    otALWO : result := 'Administrative Landing Warfare Operations';
    otCDWO : result := 'Coastal Defence Warfare Operations';
    otSUWO : result := 'Supporting Unit Warfare Operations';
  end;
end;

function SetOrganisasiTugasAkronimToString(aValue : TOrganisasiTugas) : String;
begin
  case aValue of
    otINWO : result := 'INWO';
    otNTWO : result := 'NTWO';
    otATWO : result := 'ATWO';
    otLFWO : result := 'LFWO';
    otALWO : result := 'ALWO';
    otCDWO : result := 'CDWO';
    otSUWO : result := 'SUWO';
  end;
end;

function SetOrganisasiTugasToEnum(aValue : String) : TOrganisasiTugas;
begin
  if aValue = 'Integrated Naval Warfare Operations' then
  begin
    result := otINWO;
  end
  else if aValue = 'Naval Tactical Warfare Operations' then
  begin
    result := otNTWO;
  end
  else if aValue = 'Amphibious Tactical Warfare Operations' then
  begin
    result := otATWO;
  end
  else if aValue = 'Landing Forces Warfare Operations' then
  begin
    result := otLFWO;
  end
  else if aValue = 'Administrative Landing Warfare Operations' then
  begin
    result := otALWO;
  end
  else if aValue = 'Coastal Defence Warfare Operations' then
  begin
    result := otCDWO;
  end
  else if aValue = 'Supporting Unit Warfare Operations' then
  begin
    result := otSUWO;
  end;
end;

function SetSubOrganisasiTugasToString(aValue : TSubOrganisasiTugas) : String;
begin
  case aValue of
    sotKPL : result := 'KPL';
    sotSTAFLAT : result := 'STAF LAT';
    sotWASDAL : result := 'WASDAL';
    sotKOGAB : result := 'KOGAB';
    sotKOGASGABLA : result := 'KOGASGABLA';
    sotKOGASGABFIB : result := 'KOGASGABFIB';
    sotPASRAT : result := 'PASRAT';
    sotKOGASRATMIN : result := 'KOGASRATMIN';
    sotKOGASHANTAI : result := 'KOGASHANTAI';
    sotSATGASDUK : result := 'SATGASDUK';
    sotLAIN : Result := 'LAIN-LAIN'
  end;
end;

function SetSubOrganisasiTugasToEnum(aValue : String) : TSubOrganisasiTugas;
begin
  if aValue = 'KPL' then
  begin
    result := sotKPL;
  end
  else if aValue = 'STAF LAT' then
  begin
    result := sotSTAFLAT;
  end
  else if aValue = 'WASDAL' then
  begin
    result := sotWASDAL;
  end
  else if aValue = 'KOGAB' then
  begin
    result := sotKOGAB;
  end
  else if aValue = 'KOGASGABLA' then
  begin
    result := sotKOGASGABLA;
  end
  else if aValue = 'KOGASGABFIB' then
  begin
    result := sotKOGASGABFIB;
  end
  else if aValue = 'PASRAT' then
  begin
    result := sotPASRAT;
  end
  else if aValue = 'KOGASRATMIN' then
  begin
    result := sotKOGASRATMIN;
  end
  else if aValue = 'KOGASHANTAI' then
  begin
    result := sotKOGASHANTAI;
  end
  else if aValue = 'SATGASDUK' then
  begin
    result := sotSATGASDUK;
  end;
end;

function SetFileExtentionToString(aValue : TFileExtention) : String;
begin
  case aValue of
    feWord   : result := '.docx';
    feExcel  : result := '.xlsx';
    fePPT    : result := '.pptx';
    fePaint  : result := '.png';
    feEdge   : result := '.html';
    feChrome : result := '.html';
    fePdf    : result := '.pdf';
    feImage  : result := '.jpeg, .jpg, .png';
  end;
end;

function SetFileExtentionToEnum(aValue : String) : TFileExtention;
begin
  if (aValue = '.docx') or (aValue = '.doc') then
  begin
    result := feWord;
  end
  else if (aValue = '.xlsx') or (aValue = '.xls') then
  begin
    result := feExcel;
  end
  else if (aValue = '.pptx') or (aValue = '.ppt') then
  begin
    result := fePPT;
  end
  else if aValue = '.png' then
  begin
    result := fePaint;
  end
  else if aValue = '.html' then
  begin
    result := feEdge;
  end
  else if aValue = '.html' then
  begin
    result := feChrome;
  end
  else if aValue = '.pdf' then
  begin
    result := fePdf;
  end
  else if aValue = '.jpeg' then
  begin
    result := feImage;
  end
  else if aValue = '.jpg' then
  begin
    result := feImage;
  end
  else if aValue = '.png' then
  begin
    result := feImage;
  end;
end;

function SetTipeTahapanToString(aValue : TTipeTahapan) : String;
begin
  case aValue of
    ttPerencanaan : result := 'Perencanaan';
    ttPersiapan   : result := 'Persiapan';
    ttPelaksanaan : result := 'Pelaksanaan';
    ttPengakhiran : result := 'Pengakhiran';
  end;
end;

function SetTipeTahapanToEnum(aValue : String) : TTipeTahapan;
begin
  if (aValue = 'Perencanaan') then
  begin
    result := ttPerencanaan;
  end
  else if (aValue = 'Persiapan') then
  begin
    result := ttPersiapan;
  end
  else if (aValue = 'Pelaksanaan') then
  begin
    result := ttPelaksanaan;
  end
  else if aValue = 'Pengakhiran' then
  begin
    result := ttPengakhiran;
  end;
end;

function SetLineType(linetype: TPenStyle): Integer;
begin
  case linetype of
    TPenStyle(psSolid): Result := 0;
    TPenStyle(psDash) : Result := 1;
    TPenStyle(psDot)  : Result := 2;
    TPenStyle(psDashDot): Result := 3;
    TPenStyle(psDashDotDot): Result := 4;
  end;
end;

end.

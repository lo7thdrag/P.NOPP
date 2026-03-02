unit uSimScenario;

interface

uses
  Classes,
  uSimSettings;

type

  TSimScenario = class
  protected
    FScenarioFileName: string;
    FLoaded: boolean;

    function FindByShipName(const sName: string; var sDat: TShipData): boolean;
  public
    SceneData: TScenarioData;

    ObjectData: TStrings;

    constructor Create;
    destructor Destroy; override;

    procedure ReadFromFile(const fname: string);
    procedure SaveToFile(const fname: string);
    procedure UnLoad;

// ==== from editor function?
    function AddShip(sDat: TShipData): boolean;

    property Loaded: boolean read FLoaded;

  end;

implementation

uses
  SysUtils, IniFiles, uSimContainers;

{ TSimScenario }

constructor TSimScenario.Create;
begin
  ObjectData := TStringList.Create;

end;

destructor TSimScenario.Destroy;
begin
  if FLoaded then UnLoad;
  ClearAndFreeItems(ObjectData);

  inherited;
end;

//==============================================================================
procedure Save_ScenarioData(const scDat: TScenarioData; var inif: TIniFile);
begin
  with scDat do begin
    Inif.WriteString(c_scene, 'name', ScenarioName);
    Inif.WriteDateTime(c_scene, 'startgametime', StartTime);
    IniF.WriteString(c_map, 'path', MapGeoset);
  end;
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
{  procedure Save_MapData(const mSet: TMapSetting; var inif: TIniFile);
  begin
    with mSet do begin

      IniF.WriteString(c_map,  'path'  , mGeoset );

      IniF.WriteFloat(c_map,   'mx', mX);
      IniF.WriteFloat(c_map,   'my', mY);
      IniF.WriteFloat(c_map,   'mz', mZ);
    end;
  end;
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure Save_ShipData(const mShip: TRecShipStateData; var inif: TIniFile);
var
  sect: string;
begin
  sect := 'ship_' + IntToStr(mShip.ixShip);

  with mShip do begin
    IniF.WriteInteger(sect, 'ship_ix', ixShip);
    IniF.WriteFloat(sect, 'posx', X);
    IniF.WriteFloat(sect, 'posy', Y);
//      IniF.WriteFloat  (sect, 'posz',     Z         );
    IniF.WriteFloat(sect, 'course', Course);

    IniF.WriteFloat(sect, 'lspeed', LSpeed);
    IniF.WriteFloat(sect, 'lspeedto', LSpeedTo);
    IniF.WriteFloat(sect, 'rspeed', RSpeed);
    IniF.WriteFloat(sect, 'rspeedto', RSpeedTo);
    IniF.WriteFloat(sect, 'rudder', Rudder);
    IniF.WriteFloat(sect, 'rudderto', rudderto);
  end;

end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TSimScenario.SaveToFile(const fname: string);
var
  i: integer;
  sDat: TShipData;
  iniF: TIniFile;
begin
     //save
  DeleteFile(fName);
  IniF := TIniFile.Create(fName);
  Save_ScenarioData(SceneData, iniF);
  for i := 0 to ObjectData.Count - 1 do begin
    sDat := TShipData(ObjectData.Objects[i]);
    Save_ShipData(sDat.StateData, iniF);
  end;

  iniF.Free;
end;

//==============================================================================

procedure Load_ScenarioData(const iniF: TIniFile; var scDat: TScenarioData);
begin
  with scDat do begin
    ScenarioName := Inif.ReadString(c_scene, 'name', '');
    StartTime := Inif.ReadDateTime(c_scene, 'startgametime', now);
    MapGeoset := Inif.ReadString(c_map, 'path',
      'data\maps\indonesia.gst');
  end;
end;

procedure Load_ShipData(const iniF: TIniFile; const sect: string;
  var mShip: TRecShipStateData);
begin
  with mShip do begin
    ixShip := IniF.ReadInteger(sect, 'ship_ix', 0);
    X := IniF.ReadFloat(sect, 'posx', 118.71);
    Y := IniF.ReadFloat(sect, 'posy', -9.21);
//      Z         := IniF.ReadFloat(sect, 'posz',0.0 );
    Course := IniF.ReadFloat(sect, 'course', 0.0);

    LSpeed := IniF.ReadFloat(sect, 'lspeed', 10.0);
    LSpeedTo := IniF.ReadFloat(sect, 'lspeedto', 10.0);
    RSpeed := IniF.ReadFloat(sect, 'rspeed', 10.0);
    RSpeedTo := IniF.ReadFloat(sect, 'rspeedto', 10.0);
    Rudder := IniF.ReadFloat(sect, 'rudder', 0.0);
    rudderto := IniF.ReadFloat(sect, 'rudderto', 0.0);
  end;
end;

procedure TSimScenario.ReadFromFile(const fname: string);
var
  i: integer;
  sDat: TShipData;
  iniF: TIniFile;
  strs: TStrings;
begin
  FScenarioFileName := fName;

  IniF := TIniFile.Create(fName);

  Load_ScenarioData(iniF, SceneData);

  strs := TStringList.Create;
  inif.ReadSections(strs);

  for i := 0 to strs.Count - 1 do begin

    if (Pos('ship_', strs[i]) = 1) then begin
      sDat := TShipData.Create;
      Load_ShipData(inif, strs[i], sDat.StateData);

      AddShip(sDat);
    end;

  end;

  strs.Free;
  iniF.Free;

  FLoaded := True;
end;

procedure TSimScenario.UnLoad;
begin
  //UnloadShip;

  FLoaded := false;
end;

function TSimScenario.AddShip(sDat: TShipData): boolean;
var
  i: integer;
begin
  i := ObjectData.IndexOf(sDat.ShipName);
  result := i < 0;
  if result then begin
    ObjectData.AddObject(sDAt.ShipName, sDat);
  end
end;

function TSimScenario.FindByShipName(const sName: string; var sDat: TShipData): boolean;
var
  i: integer;
begin
  i := ObjectData.IndexOf(sName);
  result := i >= 0;

  if result then
    sDat := ObjectData.Objects[i] as TShipData
  else
    sDat := nil;

end;

initialization
  DateSeparator := '/';
  ShortDateFormat := 'd/m/yyyy';
  DecimalSeparator := '.';

end.

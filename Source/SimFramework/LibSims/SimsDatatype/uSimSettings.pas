unit uSimSettings;

interface
uses
  Graphics;

const
  // aplication.ini setting
  c_lib = 'library';
  c_map = 'map';

  c_net = 'network';
  c_gps = 'gps';
  c_wifi = 'wifi';
  c_default = 'default';
  c_scene = 'scenario';

  c_display = 'display';
  c_netmesh = 'mesh';

  c_LEDDisplay = 'leddisplay';
  c_PCDSetting = 'pdcsetting';

type
  //------------------------------------------------------------------------------
    // load from main setting file.
  TMapSetting = record
    MapPath,
    MapGeoset: string;
    MapZoom: integer;
    mX, mY: double;
    colorbg : TColor;
    MapDataGeoset : string;
    EnableDepthCheck: Boolean;
    EnableLandCheck: Boolean;

  end;

  //------------------------------------------------------------------------------
  TLibSetting = record
    LibPath: string;
    ShipLibrary: string;

    ScenarioPath: string;
    ScenName: string;
    shutdownPath: string;
  end;

  //------------------------------------------------------------------------------
  TLibInstSetting = record
    LibPath: string;
    ShipLibrary: string;
    RecordPath: string;
    ScenarioPath: string;
    ShutdownPath: string;
  end;

  //------------------------------------------------------------------------------
  TNetSetting = record
    IPserver: string[15];
    // broadcaster nunut
    IPList1_File: string;
    IPList2_File: string;
    retryconnect: integer; // ms
    autoConnect: Boolean;
    timeSynch: Boolean;
  end;

  TNetMeshSetting = record
    groupIPList : string;
  end;

  //----------------------------------------------------------------------------
  TGPSSetting = record
    COMNum: Integer;
    COMBaud: Integer;
  end;

  TScenarioData = record
    ScenarioName: string;
    StartTime: TDateTime;
    MapGeoset: string;
  end;

  TDisplaySect = record
    vmView: byte; // monitor index
    vsCtrl: byte;
    symbClr: TColor;
    symbSize: byte;
    symbFont: string;
    lblColor: TColor;
    rulertext: TColor;
    rulerline: TColor;
  end;

  TWiFiSetting = record
    active: boolean; //
    devicename: string;
  end;

  TDefaultSetting = record
    bahasa: integer; //
    CTRL_MONITOR : integer; // 0 OFF, 1 Relay, 2 PDC
    ATP_VERSION : string; // 1A or 1D
  end;

  TLEDSetting = record
    useLed: boolean;
    COMNum: Integer;
  end;

  TPDCSetting = record
    usePDC: boolean;
    COMNum: Integer;
  end;

  function getFileSetting: string;

  function LoadFF_LibSetting(const fName: string; var lSet: TLibSetting): boolean;

  function LoadFF_LibInstSetting(const fName: string; var liSet: TLibInstSetting): boolean;

  function LoadFF_MapSetting(const fName: string; var mSet: TMapSetting): boolean;

  function LoadFF_NetSetting(const fName: string; var nSet: TNetSetting): boolean;


//Load Section From File
{  function LoadFF_Display(const fName: string; var displSet : TDisplaySect): boolean;
}

  function LoadFF_GPSSetting(const fName: string; var gpsSet: TGPSSetting): boolean;
  procedure SaveFF_GPSSetting(const fName: string; var gpsSet: TGPSSetting);

  function Load_WiFiSetting(const fName: string; var wSet: TWiFiSetting): string;
  function Load_DefaultSetting(const fName: string; var def: TDefaultSetting): boolean;
  procedure Save_DefaultSetting(const fName: string; var def: TDefaultSetting);

  function LoadFF_LEDSetting(const fName: string; var ledSet: TLEDSetting): boolean;

  function LoadFF_NetMeshSetting(const fName: string; var nMeshSet: TNetMeshSetting): boolean;
  function SaveFF_NetMeshSetting(const fName: string; const nMeshSet: TNetMeshSetting): boolean;

  function Load_PDCSetting(var pdcSet: TPDCSetting): boolean;

var
  //loaded setting  FROM FILE
  LibSettingFile: string;

  LibSetting: TLibSetting;
  LibInstSetting: TLibInstSetting;

  LibMapSetting: TMapSetting;

  LibGpsSetting: TGPSSetting;
  LibNetSetting: TNetSetting;

  LibNetMeshSetting: TNetMeshSetting;

const
  C_MaxZoomIndex = 12;
  C_MinZoomIndex = 0;



implementation

uses
  IniFiles, SysUtils, uIniFilesProcs;

//==============================================================================
function getFileSetting: string;
begin
  result := ChangeFileExt(ParamStr(0), '.ini');

end;
//==============================================================================

function LoadFF_LibSetting(const fName: string; var lSet: TLibSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin

  IniF := TIniFile.Create(fName);

  s := ExtractFilePath(ParamStr(0));
  with lSet do begin
    LibPath := IncludeTrailingBackslash(
      s + IniFReadstring(inif, c_lib, 'shipdbpath', 'data'));
    ShipLibrary := IniFReadstring(inif, c_lib, 'shiplib', 'shipdb.xml');

    ScenarioPath := IncludeTrailingBackslash(
      s + IniFReadstring(inif, c_lib, 'scenariopath', 'scenario'));

    ScenName := IniFReadstring(inif, c_lib, 'defscenario', 'atnp.sce');

    ShutdownPath := IniFReadstring(inif, c_lib, 'shutdown', '');
  end;

  Inif.Free;
  result := true;
end;

//==============================================================================
function LoadFF_LibInstSetting(const fName: string; var liSet: TLibInstSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  IniF := TIniFile.Create(fName);

  s := ExtractFilePath(ParamStr(0));
  with liSet do begin

    LibPath := IncludeTrailingBackslash(
      s + IniFReadstring(inif, c_lib, 'shipdbpath', 'data'));

    ShipLibrary := IniFReadstring(inif, c_lib, 'shiplib', 'shipdb.xml');

    RecordPath := IncludeTrailingBackslash(
      s + IniFReadstring(inif, c_lib, 'recordpath', 'records'));

    ScenarioPath := IncludeTrailingBackslash(
      s + IniFReadstring(inif, c_lib, 'scenariopath', 'scenario'));

    ShutdownPath := IniFReadstring(inif, c_lib, 'shutdown', '');
  end;

  Inif.Free;
  result := true;
end;

//==============================================================================
function LoadFF_MapSetting(const fName: string; var mSet: TMapSetting): boolean;
var IniF: TIniFile;
    s: string;
begin
  IniF := TIniFile.Create(fName);

  s := ExtractFilePath(ParamStr(0));
  with mSet do begin
    MapPath := IncludeTrailingBackslash(
      s + IniFReadstring(inif, c_map, 'mappath', 'mapsea'));
    MapGeoset     := IniFReadstring(inif, c_map, 'defmap', 'Indonesia.gst');
    MapDataGeoset := IniFReadstring(inif, c_map, 'mapdata', 'mapdata.gst');

    MapZoom := INIFReadInteger(inif, c_map, 'zoom', 5);
    if MapZoom > C_MaxZoomIndex then MapZoom := C_MaxZoomIndex;
    if MapZoom < C_MinZoomIndex then MapZoom := C_MinZoomIndex;

    mX := INIFReadFloat(IniF, c_map, 'long', 112.75 );
    mY := INIFReadFloat(IniF, c_map, 'latt', -7.2 );

   EnableDepthCheck := INIFReadInteger(inif, c_map, 'depthcheck', 0) = 1;
   EnableLandCheck  := INIFReadInteger(inif, c_map, 'landcheck', 0) = 1;

  end;
end;


function LoadFF_Display(const fName: string; var displSet: TDisplaySect): boolean;
var
  IniF: TIniFile;
begin
  //if not FileExists(fName) then exit;

  IniF := TIniFile.Create(fName);

  with displSet do begin
    vmView := IniFReadInteger(inif, c_display, 'vmview', 0) and $FF;
    vsCtrl := IniFReadInteger(inif, c_display, 'vsctrl', 0) and $FF;
    symbSize := IniFReadInteger(inif, c_display, 'symbsize', 0) and $FF;
    symbClr := TColor(IniFReadInteger(inif, c_display, 'symbcolor', 0));
    symbFont := IniFReadstring(inif, c_display, 'symbfont', '');

    lblColor := TColor(IniFReadInteger(inif, c_display, 'lblcolor', 0));
    rulertext := TColor(IniFReadInteger(inif, c_display, 'rulertext', 0));
    rulerline := TColor(IniFReadInteger(inif, c_display, 'rulerline', 0));

  end;

  Inif.Free;

  result := true;
end;

//==============================================================================

function LoadFF_NetSetting(const fName: string; var nSet: TNetSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  //if not FileExists(fName) then exit;
  s := ExtractFilePath(ParamStr(0));

  IniF := TIniFile.Create(fName);

  with nSet do begin
    IPserver := IniFReadstring(inif, c_net, 'ipserver', '192.168.0.1');
    IPList1_File :=  s + IniFReadstring(inif, c_net, 'iplist1', 'iplist1.ini');
    IPList2_File :=  s + IniFReadstring(inif, c_net, 'iplist2', 'iplist2.ini');

    retryconnect := INIFReadInteger(inif, c_net, 'retry', 10000); // 20 detik
    autoConnect := INIFReadInteger(inif, c_net, 'autoconnect', 0) = 1;
    timeSynch := INIFReadInteger(inif, c_net, 'timesynch', 0) = 1;
  end;

  Inif.Free;

  result := true;
end;

//==============================================================================

function LoadFF_GPSSetting(const fName: string; var gpsSet: TGPSSetting): boolean;
var
  IniF: TIniFile;
begin
  //if not FileExists(fName) then exit;

  IniF := TIniFile.Create(fName);

  with gpsSet do begin
    COMNum := INIFReadInteger(inif, c_gps, 'comnumber', 1);
    if COMNum < 1  then begin
      COMNum := 1;
      IniF.WriteString(c_gps, 'comnumber', '1');
    end;
    if COMNum > 16  then begin
      COMNum := 16;
      IniF.WriteString(c_gps, 'comnumber', '16');
    end;

    COMBaud := INIFReadInteger(inif, c_gps, 'combaud', 2);
  end;

  Inif.Free;

  result := true;
end;

//------------------------------------------------------------------------------

procedure SaveFF_GPSSetting(const fName: string; var gpsSet: TGPSSetting);
var
  IniF: TIniFile;
begin
  IniF := TIniFile.Create(fName);

  with gpsSet do begin
    IniF.WriteInteger(c_gps, 'comnumber', COMNum);
    IniF.WriteInteger(c_gps, 'combaud', COMBaud);
  end;

  Inif.Free;
end;

//==============================================================================

function Load_WiFiSetting(const fName: string; var wSet: TWiFiSetting): string;
var
  IniF: TIniFile;
begin
  IniF := TIniFile.Create(fName);
  with wSet do begin
    active := INIFReadBool(inif, c_wifi, 'active', true);
    devicename := INIFReadString(inif, c_wifi, 'devicename', 'TL-WN422G');
  end;
  Result := wSet.devicename;
  Inif.Free;
end;

//==============================================================================

function Load_DefaultSetting(const fName: string; var def: TDefaultSetting): boolean;
var
  IniF: TIniFile;
begin
  Result := True;
  IniF := TIniFile.Create(fName);
  with def do begin
    bahasa := INIFReadInteger(inif, c_default, 'bahasa', 1); // BHS_ENG
    CTRL_MONITOR := INIFReadInteger(inif, c_default, 'monitor_ctrl', 0); // default 0 = OFF
    ATP_VERSION := INIFReadString(inif, c_default, 'atp_version', '1D'); // default 1D
  end;
  Inif.Free;
end;

procedure Save_DefaultSetting(const fName: string; var def: TDefaultSetting);
var
  IniF: TIniFile;
begin
  IniF := TIniFile.Create(fName);
  with def do begin
    IniF.WriteInteger(c_default, 'bahasa', bahasa);
    IniF.WriteInteger(c_default, 'monitor_ctrl', CTRL_MONITOR);
    IniF.WriteString(c_default, 'atp_version', ATP_VERSION);
  end;
  Inif.Free;
end;

//==============================================================================

function LoadFF_LEDSetting(const fName: string; var ledSet: TLEDSetting): boolean;
var
  IniF: TIniFile;
begin
  Result := True;
  if fName = '' then
    IniF := TIniFile.Create(getfileSetting)
  else
    IniF := TIniFile.Create(fName);
  with ledSet do begin
    useLed := INIFReadInteger(inif, c_LEDDisplay, 'useled', 1) = 1;
    COMNum := INIFReadInteger(inif, c_LEDDisplay, 'comnum', 1);
  end;
  Inif.Free;
end;

//==========net mesh for image and sea atnp=========================

function LoadFF_NetMeshSetting(const fName: string; var nMeshSet: TNetMeshSetting): boolean;
var
  IniF: TIniFile;
begin
  IniF := TIniFile.Create(fName);

  with nMeshSet do begin
    groupIPList := IniFReadstring(inif, c_netmesh, 'grouplist', 'grouplist.txt');
//    defIpAddress :=  IniFReadstring(inif, c_netmesh, 'defipaddress', '127.0.0.1');
  end;

  Inif.Free;
  result := true;
end;

function SaveFF_NetMeshSetting(const fName: string; const nMeshSet: TNetMeshSetting): boolean;
var
  IniF: TIniFile;
begin
  IniF := TIniFile.Create(fName);

  with nMeshSet do begin
     IniF.WriteString(c_netmesh, 'grouplist', groupIPList);
  end;

  Inif.Free;
  result := true;
end;

//==============================================================================

function Load_PDCSetting(var pdcSet: TPDCSetting): boolean;
var
  IniF: TIniFile;
  FName: string;
begin
  Result := false;
  FName := ChangeFileExt(ParamStr(0), '.ini');
  IniF := TIniFile.Create(fName);
  with pdcSet do begin
    usePDC := INIFReadBool(inif, c_PCDSetting, 'usePDC', true);
    COMNum := INIFReadInteger(inif, c_PCDSetting, 'comnum', 10);
  end;
  if pdcSet.usePDC then
    Result := true
  else
    Result := false;
  Inif.Free;
end;

//==============================================================================

end.


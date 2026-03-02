unit uLibSetting;


interface

uses
  Graphics, uDataTypes, Windows;

const
  // aplication.ini setting
  c_net = 'network';
    c_NET_SESSIONPORT     = 32001;      // session server tcp listen. GC connect to.
    c_NET_DBEDITPORT      = 32002;
    c_NET_GAMEPORT        = 32003;      // udp broadcasst port.
    c_NET_COMMANDPORT     = 32004;      // game server tcp listen. game client connect.

  c_NET_BC_ADDRESS = '192.168.1.255';

  c_NET_SVRIP = '192.168.1.11';

  c_map = 'map';
    C_MaxZoomIndex = 12;
    C_MinZoomIndex = 0;

 c_dBase = 'database';
  c_defaultDBUser      = 'sa';
  c_defaultDBpassword  = 'sa';
  c_defaultDBProto     = 'mssql';

 c_symbol = 'symbol';

type
  //------------------------------------------------------------------------------
  // load from main setting file.
  //------------------------------------------------------------------------------
  TNetSetting = record
    SessionPort     : Word;     // TCP sessionPort Session Server Listen. GC Connect
    DBEditPort      : Word;
    CommandPort     : Word;     // TCP GameServer Listen.
    GamePort        : Word;     // UDP GameServer BC
    GameAddress     : string;   // UDP Broadcast Address.
    AutoStart       : Boolean;
  end;

  TNetServerSetting = record
    SendInterval: Integer;
  end;

  TNetClientSetting = record
    ServerIP: string;
  end;

  TNetBridgeSetSetting = record
    ServerIP: string;
    Port: Integer;
  end;

  TMapSetting = record
    MapPath,
    MapGSTGame,
    ImageGame,
    MapGeoset: string;
    MapDataGeoset: string;

    MapZoom: integer;
    mX, mY: double;
    Colorbg : TColor;
  end;

  TRecPlayMode   = record
    GameType      : byte ;
    RecFileName   : string;
  end;

  TGameDataSetting = record
    DataPath: string;
    GroupSetting: string;
    SessionID : Integer;
    FormOfficer: Boolean;
    FormSituationBoard: Boolean;
    FileDirectory : string;
    FileReferensi : string;
    FileSimbolTaktis : string;
    LocalDirectory : string;
    ImageModel : string;
    ImageBackgroundLogin : string;
    ImgPath : string;
    FileTransfer : string;
    RemotePort : integer ;
    TacticalScreen : Integer;
    ToteScreen : Integer;
    DemoMode : Boolean;
    LogData : Boolean;
    DelaySendData : Cardinal;

//    ScenarioID : Integer;
//    RootRecordPath : string;
//    GamePlayMode : TRecPlayMode ;
//    OwnShipPlatfomID: Integer;
//    ToteScreen : Integer;
//    VisibleCircleWP : Boolean;
//    GotoInterval : integer;
  end;

  TDBaseSetting  = record
    dbServer,
    dbProto,
    dbName,
    dbUser,
    dbPass: string
  end;

  TSymbolSetting = record
    ImgPath: string;
    DefaultSymbol: string;
    FontSize : Integer;
  end;

  TApplicationSetting = record
    GameServerName  : string;
    GameClientName  : string;
    DBEditorName    : string;
  end;

  TCubicleAssignSetting = record
    GroupIDs : array of Integer;
  end;

  TDBEditorSetting = record
    MapSourcePathENC      : string;   //D:\TTT\mapsource\coverageArea
    MapSourceGeosetENC    : string;   //D:\TTT\mapsource\coverage\AreaCoverage.gst
    MapDestPathENC        : string;   //M:\map\mapsea
    MapSourcePathVECT     : string;   //D:\TTT\mapsource\map
    MapSourceGeosetVECT   : string;   //D:\TTT\mapsource\map\world.gst
    MapDestPathVECT       : string;   //M:\map\game_area
    MapENC                : string;   //D:\TTT\map\mapsea
    OverlayPath           : string;   //M:\map\overlay
    PlottingPath          : string;
    Pattern               : String;   //D:\TTT\mapsource\map\background.gst
    predefPattern         : String;   //M:\map\pattern
    MapTypePath           : string;   //D:\MAP
    MapGSTGame            : string;   //D:\MAP\GST_GAME
    ProjectName           : string;
    UserDBEditor          : string;
    PasswordDBEditor      : string;
    MapDefGame            : string;   //D:\MAP\DEF_GAME
  end;

  function getFileSetting: string;

  function LoadFF_NetSetting(const fName: string; var nSet: TNetSetting): boolean;
  function LoadFF_NetServerSetting(const fName: string; var nSet: TNetServerSetting): boolean;
  function LoadFF_NetClientSetting(const fName: string; var nSet: TNetClientSetting): boolean;
  function LoadFF_NetBridgeSetSetting(const fName: string; var nSet: TNetBridgeSetSetting): boolean;

  function LoadFF_MapSetting(const fName: string; var mSet: TMapSetting): boolean;
  function LoadFF_GameSetting(const fName: string; var gdSet: TGameDataSetting): boolean;
  function LoadFF_dBaseSetting(const fName: string; var dbSet: TDBaseSetting): boolean;
  function LoadFF_SymbolSetting(const fName: string; var imgSet: TSymbolSetting): boolean;

  function LoadFF_AppSetting(const fName: string; var appSett: TApplicationSetting): boolean;
  function LoadFF_AppDBSetting(const fName: string; var dbEditSett: TDBEditorSetting): boolean;

  procedure SaveFF_dBaseSetting(const fName: string; var dbSet: TDBaseSetting);
  procedure SaveFF_GameSetting(const fName: string; var gdSet: TGameDataSetting);

var
  {global var}
  //loaded setting  FROM FILE

  vSettingFile: string;

  vNetSetting         : TNetSetting;
    vNetServerSetting : TNetServerSetting;
    vNetClientSetting : TNetClientSetting;

  vMapSetting         : TMapSetting;
  vGameDataSetting    : TGameDataSetting;
  vDatabaseSetting    : TDBaseSetting;
  vSymbolSetting      : TSymbolSetting;

  vAppSetting         : TApplicationSetting;
  vGameAreaSetting       : TDBEditorSetting;

  vCubicalAssignSetting : TCubicleAssignSetting;

implementation

uses
  Classes, IniFiles, SysUtils, uIniFilesProcs, uCodecBase64;

const
   c_gdata = 'gamedata';

function getFileSetting: string;
begin
  result := ExtractFilePath(ParamStr(0)) + 'Setting.ini';
end;

function LoadFF_NetSetting(const fName: string; var nSet: TNetSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  s := ExtractFilePath(ParamStr(0));
  IniF := TIniFile.Create(fName);

  with nSet do
  begin
    SessionPort   := Abs(INIFReadInteger(inif, c_net, 'sessionport',  c_NET_SESSIONPORT));
    DBEditPort    := Abs(INIFReadInteger(inif, c_net, 'dbeditport',   c_NET_DBEDITPORT));
    CommandPort   := Abs(INIFReadInteger(inif, c_net, 'commandport',  c_NET_COMMANDPORT));

    GamePort      := Abs(INIFReadInteger(inif, c_net, 'gameport',     c_NET_GAMEPORT));
    GameAddress   := INIFReadString(inif, c_net,      'gameaddress',  c_NET_BC_ADDRESS);
    AutoStart     := INIFReadBool(inif, c_net,       'autostart', true);
  end;
  Inif.Free;

  result := true;
end;

function LoadFF_NetServerSetting(const fName: string; var nSet: TNetServerSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  s := ExtractFilePath(ParamStr(0));
  IniF := TIniFile.Create(fName);

  with nSet do
  begin
    SendInterval :=  Abs(INIFReadInteger(inif, c_net, 'sendinterval', 4));
  end;

  Inif.Free;

  result := true;
end;

function LoadFF_NetClientSetting(const fName: string; var nSet: TNetClientSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  s := ExtractFilePath(ParamStr(0));
  IniF := TIniFile.Create(fName);

  with nSet do
  begin
    ServerIP  := INIFReadString(inif, c_net, 'serverip',  c_NET_SVRIP);
  end;

  Inif.Free;

  result := true;
end;

function LoadFF_NetBridgeSetSetting(const fName: string; var nSet: TNetBridgeSetSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  s := ExtractFilePath(ParamStr(0));
  IniF := TIniFile.Create(fName);

  with nSet do
  begin
    ServerIP  := INIFReadString(inif, c_net, 'BridgeSetServer',  '192.168.1.4');
    Port      := abs(INIFReadInteger(IniF, c_net, 'BridgeSetPort', 2121));
  end;

  Inif.Free;

  result := true;
end;

function LoadFF_MapSetting(const fName: string; var mSet: TMapSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  IniF := TIniFile.Create(fName);

  s := ExtractFilePath(ParamStr(0));

  with mSet do
  begin
    MapPath := IncludeTrailingBackslash(IniFReadstring(inif, c_map, 'mappath', 'M:\game_area'));
    MapGSTGame := INIFReadString(IniF, c_map, 'MapGSTGame', '');
    MapGeoset := IniFReadstring(inif, c_map, 'defmap', 'Indonesia.gst');
    MapDataGeoset := IniFReadstring(inif, c_map, 'mapdata','M:\map\mapdata\mapdata.gst');
    ImageGame := IniFReadstring(inif, c_map, 'ImageGame','');

    MapZoom := INIFReadInteger(inif, c_map, 'zoom', 5);
    if MapZoom > C_MaxZoomIndex then
      MapZoom := C_MaxZoomIndex;
    if MapZoom < C_MinZoomIndex then
        MapZoom := C_MinZoomIndex;

    mX := INIFReadFloat(IniF, c_map, 'long', 112.75 );
    mY := INIFReadFloat(IniF, c_map, 'latt', -7.2 );

  end;
  inif.Free;

  result := true;

end;

function LoadFF_GameSetting(const fName: string; var gdSet: TGameDataSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  IniF := TIniFile.Create(fName);
  s := ExtractFilePath(ParamStr(0));

  with gdSet do
  begin
    DataPath             := IncludeTrailingBackslash(s + IniFReadstring(inif, c_gdata, 'DataPath', '.\data\'));
    GroupSetting         := DataPath + IniFReadstring(inif, c_gdata, 'GroupSetting' , 'cubicles.xml');
    SessionID            := INIFReadInteger(IniF, c_gdata, 'SessionId', 1111);
    RemotePort           := INIFReadInteger(IniF, c_gdata, 'RemotePort',9000);
    TacticalScreen       := INIFReadInteger(IniF, c_gdata, 'TacticalScreen',0);
    ToteScreen           := INIFReadInteger(IniF, c_gdata, 'ToteScreen',0);
    DemoMode             := INIFReadBool(IniF, c_gdata, 'DemoMode', False);
    DelaySendData        := INIFReadInteger(IniF, c_gdata, 'DelaySendData', 500);
    LogData              := INIFReadBool(IniF, c_gdata, 'LogData', LogData);
    FormOfficer          := INIFReadBool(inif, c_map, 'FormOfficer', True );
    FormSituationBoard   := INIFReadBool(inif, c_map, 'FormSituationBoard', True );
    FileDirectory        := IniFReadstring(inif, c_gdata, 'FileDirectory' , '');
    FileReferensi        := IniFReadstring(inif, c_gdata, 'FileReferensi' , '');
    FileSimbolTaktis     := IniFReadstring(inif, c_gdata, 'FileSimbolTaktis' , '');
    LocalDirectory       := IniFReadstring(inif, c_gdata, 'LocalDirectory' , 'D:\');
    ImgPath              := IniFReadstring(inif, c_gdata, 'ImgPath' , '.\data\bitmap\');
    ImageModel           := IniFReadstring(inif, c_gdata, 'ImageModel' , '\\192.168.1.50\Program Files (x24)\Bin\data\Image DBEditor\Interface\');
    FileTransfer         := IniFReadstring(inif, c_gdata, 'FileTransfer' , '');
    ImageBackgroundLogin := IniFReadstring(inif, c_gdata, 'ImageBackgroundLogin' , '');
  end;
  inif.Free;

  result := true;
end;

procedure SaveFF_GameSetting(const fName: string; var gdSet: TGameDataSetting);
var
  iniF: TIniFile;
begin
  IniF := TIniFile.Create(fName);

  with iniF, gdSet do
  begin
    WriteInteger(c_gdata, 'SessionId', SessionID); //untuk client.
    WriteInteger(c_gdata, 'RemotePort', RemotePort);
    WriteInteger(c_gdata, 'TacticalScreen', TacticalScreen);
    WriteBool(c_gdata, 'DemoMode', DemoMode);
    WriteInteger(c_gdata, 'DelaySendData', DelaySendData);
    WriteBool(c_gdata, 'LogData', LogData);
    WriteBool(c_gdata, 'FormOfficer', FormOfficer);
    WriteBool(c_gdata, 'FormSituationBoard', FormSituationBoard);
    WriteString(c_gdata, 'FileDirectory', FileDirectory);

//    WriteInteger (c_gdata,  'scenarioid',  ScenarioID);
//    WriteInteger(c_gdata, 'gameplaymode',  GamePlayMode.GameType);
//    WriteString(c_gdata, 'recplayname',    GamePlayMode.RecFileName);
  end;
  inif.Free;

end;

function LoadFF_dBaseSetting(const fName: string; var dbSet: TDBaseSetting): boolean;
var
  IniF: TIniFile;
  s: string;
  readIn, readOut : string;
begin
  IniF := TIniFile.Create(fName);
  s := ExtractFilePath(ParamStr(0));

  with dbSet do
  begin
    dbServer :=  IniFReadstring(inif, c_dBase, 'dbserver', '192.168.1.15');
    dbProto  :=  IniFReadstring(inif, c_dBase, 'dbproto', c_defaultDBProto );
    dbName   :=  IniFReadstring(inif, c_dBase, 'dbname',  'runtime_db');

    readIn    := Base64Encode(c_defaultDBUser);
    readOut   := IniFReadstring(inif, c_dBase, 'dbuser', readIn);
    dbUser    := Base64Decode(readOut);

    readIn    := Base64Encode(c_defaultDBPassword);
    readOut   := IniFReadstring(inif, c_dBase, 'dbpass', readIn);
    dbPass    := Base64Decode(readOut);

  end;
  IniF.Free;
  result := true;
end;

procedure SaveFF_dBaseSetting(const fName: string; var dbSet: TDBaseSetting);
var
  iniF: TIniFile;
begin
  IniF := TIniFile.Create(fName);

  with iniF, dbSet do
  begin
    WriteString(c_dBase, 'dbserver', dbServer);
    WriteString(c_dBase, 'dbproto',  dbProto );
    WriteString(c_dBase, 'dbname',   dbName);
    WriteString(c_dBase, 'dbuser',   Base64Encode(dbUser));
    WriteString(c_dBase, 'dbpass',   Base64Encode(dbPass));
  end;
  inif.Free;

end;

function LoadFF_SymbolSetting(const fName: string; var imgSet: TSymbolSetting): boolean;
var
  IniF: TIniFile;
  s: string;
begin
  IniF := TIniFile.Create(fName);
  s := ExtractFilePath(ParamStr(0));

  with imgSet do
  begin
    ImgPath := IncludeTrailingBackslash(s + IniFReadstring(IniF, c_symbol, 'imgpath', '.\data\bitmap\'));
    DefaultSymbol := IniFReadstring(IniF, c_symbol, 'defsymbol', 'SurfacePending.bmp' );
    FontSize := INIFReadInteger(IniF, c_symbol, 'FontSize', 24);
  end;
  inif.Free;

  Result := True;
end;

function LoadFF_AppSetting(const fName: string; var appSett: TApplicationSetting): boolean;
const
  c_appsetting = 'application';

var
  IniF: TIniFile;
  s: string;
begin
  IniF := TIniFile.Create(fName);
  s := ExtractFilePath(ParamStr(0));

  with appSett do
  begin
    GameServerName  := IniFReadstring(inif, c_appsetting, 'gameserver', 'SimServer.exe' );
    GameClientName  := IniFReadstring(inif, c_appsetting, 'gameclient', 'SimClient.exe' );
    DBEditorName    := IniFReadstring(inif, c_appsetting, 'dbeditclient', 'pDBEditor.exe' );
  end;
  inif.Free;

  result := true;
end;

function LoadFF_AppDBSetting(const fName: string; var dbEditSett: TDBEditorSetting): boolean;
const
  c_appsetting = 'dbeditor';
var
  IniF : TIniFile;
  s    : string;
  str  : string;
begin
  Result := True;
  s     := ExtractFilePath(ParamStr(0));
  str := s;
  s := s + fName;

  IniF  := TIniFile.Create(s);
  try
    with dbEditSett do
    begin
      MapSourcePathENC      := IniFReadstring(inif, c_appsetting, 'MapSourcePathENC', 'D:\Map\mapsource\coverageArea' );
      MapSourceGeosetENC    := IniFReadstring(inif, c_appsetting, 'MapSourceGeosetENC', 'D:\Map\mapsource\coverage\AreaCoverage.gst' );

      MapENC                := IniFReadstring(inif, c_appsetting, 'MapENC', 'D:\MAP\_MAP_ENC' );

      OverlayPath           := IniFReadstring(inif, c_appsetting, 'OverlayPath', 'D:\Map\overlay' );
      PlottingPath          := IniFReadString(IniF, c_appsetting, 'PlottingPath', 'D:\Map\Plotting');
      Pattern               := IniFReadstring(inif, c_appsetting, 'Pattern', 'D:\Map\mapsource\map\background.gst' );
      predefPattern         := IniFReadstring(inif, c_appsetting, 'predefPattern', 'D:\Map\pattern' );

      UserDBEditor          := IniFReadstring(inif, c_appsetting, 'UserDBEditor','Administrator');
      PasswordDBEditor      := IniFReadstring(inif, c_appsetting, 'PasswordDBEditor','admin');

      MapTypePath           := INIFReadString(IniF, c_appsetting, 'MapTypePath', '');
      MapGSTGame            := INIFReadString(IniF, c_appsetting, 'MapGSTGame', '');
      MapDefGame            := INIFReadString(IniF, c_appsetting, 'MapDefGame', '');
    end;
  finally
    IniF.DisposeOf
  end;
//  IniF.Free;
end;

end.



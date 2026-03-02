unit uScriptSimServer;


interface

  procedure BeginGame_Server;
  procedure EndGame_Server;

implementation

uses
  SysUtils,
  uScriptCommon, uMapXData, uLibSetting, ufrmMainGameServer, uNetHandle_Server,
  uSimMgr_Server, uT3ServerEventManager, uCoordConvertor, uClassData{, uMapLayerDB};

procedure BeginGame_Server;
begin
  BeginGameCommon;

  {procedure dipindah untuk load peta sama dengan db}
  VMapData := TSimMapData.Create;
  simMgrServer := TSimMgr_Server.Create(VMapData.DMap);

  simMgrServer.SessionID  := vGameDataSetting.SessionID;
  simMgrServer.OnUpdateGameState  := frmMainGameServer.UpdateGameState;

  simMgrServer.LoadConsoleID;
  simMgrServer.LoadDataAsset(vGameDataSetting);

  LoadFF_NetClientSetting(vSettingFile, vNetClientSetting);
  LoadFF_NetServerSetting(vSettingFile, vNetServerSetting);

  //netserver
  VNetServer                  := TNetHandle_Server.Create;
  VNetServer.GamePort         := vNetSetting.GamePort;
  VNetServer.CommandPort      := vNetSetting.CommandPort;

  VNetServer.BroadCastAddress := vNetSetting.GameAddress;
  VNetServer.SessionPort      := vNetSetting.SessionPort;
  VNetServer.SessionServerIP  := vNetClientSetting.ServerIP;

  VNetServer.OnClientConnect    :=  simMgrServer.FNetServerOnClientConnect;
  VNetServer.OnClientDisConnect :=  simMgrServer.FNetServerOnClientDisConnect;

  VNetServer.StartNetworking;  // Create server port
  simMgrServer.InitNetwork;    // register procedure

//  VNetServer.OnlogRecv := frmMainGameServer.LogRecv;

  simMgrServer.BroadcastData := true;
end;

procedure EndGame_Server;
begin
  simMgrServer.GameTerminate;
  simMgrServer.GamePause;

  VNetServer.StopNetworking;
  VNetServer.Free;

  simMgrServer.Free;

  VMapData.Free;
end;



end.



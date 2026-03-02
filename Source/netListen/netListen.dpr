program netListen;

uses
  Forms,
  ufT3NetListen in 'ufT3NetListen.pas' {frmNetListen},
  uGameData_TTT in '..\LibTTT\netTTT\uGameData_TTT.pas',
  uNetBaseSocket in '..\SimFramework\LibNets\NetComponent\uNetBaseSocket.pas',
  uNetUDPnode in '..\SimFramework\LibNets\NetComponent\uNetUDPnode.pas',
  uPacketBuffer in '..\SimFramework\LibNets\NetComponent\uPacketBuffer.pas',
  uPacketRegister in '..\SimFramework\LibNets\NetComponent\uPacketRegister.pas',
  uTCPClient in '..\SimFramework\LibNets\NetComponent\uTCPClient.pas',
  uTCPDatatype in '..\SimFramework\LibNets\NetComponent\uTCPDatatype.pas',
  uBaseNetHandler in '..\SimFramework\LibNets\uBaseNetHandler.pas',
  uNetClient_Mgr in 'uNetClient_Mgr.pas' {$R *.res},
  uT3netPlatform in 'uT3netPlatform.pas',
  uLibSettingTTT in '..\LibTTT\uLibSettingTTT.pas',
  uIniFilesProcs in '..\SimFramework\LibBaseUtils\uIniFilesProcs.pas',
  uCodecBase64 in '..\SimFramework\LibComponent\Base64\uCodecBase64.pas',
  uBaseCoordSystem in '..\SimFramework\LibBaseUtils\CoordSystem\uBaseCoordSystem.pas',
  uDataTypes in '..\SimFramework\LibBaseUtils\CoordSystem\uDataTypes.pas',
  uStringFunc in '..\SimFramework\LibBaseUtils\StringUtils\uStringFunc.pas',
  uTCPServer in '..\SimFramework\LibNets\NetComponent\uTCPServer.pas',
  uThreadTimer in '..\SimFramework\LibBaseUtils\Counter\uThreadTimer.pas',
  tttData in '..\LibTTT\libDBScenario\tttData.pas',
  uT3Listener in '..\LibTTT\libUnit\uT3Listener.pas',
  uDataBuffer in '..\SimFramework\LibNets\NetComponent\uDataBuffer.pas',
  uNetHandle_TTT in '..\LibTTT\netTTT\uNetHandle_TTT.pas',
  uNetHandle_Client in '..\AOPRSimClient.src\uNetHandle_Client.pas',
  uCoordConvertor in '..\SimFramework\LibBaseUtils\CoordSystem\uCoordConvertor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmNetListen, frmNetListen);
  StartClient;

  netMgr.OnConnected        := frmNetListen.event_OnConnected;
  netMgr.OnDisConnected     := frmNetListen.event_OnDisConnected;

  netMgr.OnCtrlConnected        := frmNetListen.event_OnCtrlConnected;
  netMgr.OnCtrlDisConnected     := frmNetListen.event_OnCtrlDisConnected;
  netMgr.OnPlatformSelected     := frmNetListen.event_OnSelectPlatform;

  netMgr.OnGameStateChange    := frmNetListen.event_OnGameState;
  netMgr.OnGetMovementData    := frmNetListen.event_OnGetPlatformData;
  netMgr.OnNetLog             := frmNetListen.event_OnNetLog;

  VNetClient.StartNetworking;

  netMgr.InitNetwork;

  Application.Run;

  VNetClient.StopNetworking;
  EndClient;
end.

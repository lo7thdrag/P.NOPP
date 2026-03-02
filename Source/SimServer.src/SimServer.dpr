program SimServer;

{$DEFINE SERVER}

uses
  Windows,
  Messages,
  Forms,
  SysUtils,
  ShellApi,
  GmXml in '..\SimFramework\LibComponent\XMLReader\GmXml.pas',
  GmXMLInterface in '..\SimFramework\LibComponent\XMLReader\GmXMLInterface.pas',
  uThreadTimer in '..\SimFramework\LibBaseUtils\Counter\uThreadTimer.pas',
  uIniFilesProcs in '..\SimFramework\LibBaseUtils\uIniFilesProcs.pas',
  uStringFunc in '..\SimFramework\LibBaseUtils\StringUtils\uStringFunc.pas',
  uCodecBase64 in '..\SimFramework\LibBaseUtils\StringUtils\uCodecBase64.pas',
  uVirtualTime in '..\SimFramework\LibBaseUtils\Counter\uVirtualTime.pas',
  uSteppers in '..\SimFramework\LibBaseUtils\Counter\uSteppers.pas',
  uBaseSimObjects in '..\SimFramework\LibSims\SimSystem\uBaseSimObjects.pas',
  uSimContainers in '..\SimFramework\LibSims\SimSystem\uSimContainers.pas',
  uSimSettings in '..\SimFramework\LibSims\SimSystem\uSimSettings.pas',
  u2DMover in '..\SimFramework\LibSims\SimsObjects\u2DMover.pas',
  uSimObjects in '..\SimFramework\LibSims\SimSystem\uSimObjects.pas',
  uBaseSimCenter in '..\SimFramework\LibSims\SimSystem\uBaseSimCenter.pas',
  uPacketBuffer in '..\SimFramework\LibNets\NetComponent\uPacketBuffer.pas',
  uPacketRegister in '..\SimFramework\LibNets\NetComponent\uPacketRegister.pas',
  uTCPDatatype in '..\SimFramework\LibNets\NetComponent\uTCPDatatype.pas',
  uTCPClient in '..\SimFramework\LibNets\NetComponent\uTCPClient.pas',
  uTCPServer in '..\SimFramework\LibNets\NetComponent\uTCPServer.pas',
  uNetUDPnode in '..\SimFramework\LibNets\NetComponent\uNetUDPnode.pas',
  uSimVisuals in '..\LibTTT\LibVisual\uSimVisuals.pas',
  uCompassVisual in '..\LibTTT\LibVisual\uCompassVisual.pas',
  ufrmMainGameServer in 'ufrmMainGameServer.pas' {frmMainGameServer},
  uObjectVisuals in '..\LibTTT\LibVisual\uObjectVisuals.pas',
  ufDebugNet in '..\LibDebug\ufDebugNet.pas' {frmDebug},
  uNetBaseSocket in '..\SimFramework\LibNets\NetComponent\uNetBaseSocket.pas',
  uBaseNetHandler in '..\SimFramework\LibNets\uBaseNetHandler.pas',
  uT3UnitContainer in '..\LibTTT\libUnit\uT3UnitContainer.pas',
  uT3Listener in '..\LibTTT\libUnit\uT3Listener.pas',
  uExecuter in '..\SimFramework\LibComponent\Executor\uExecuter.pas',
  uDataBuffer in '..\SimFramework\LibNets\NetComponent\uDataBuffer.pas',
  uVectorVisual in '..\LibTTT\libVisual\uVectorVisual.pas',
  GDIPAPI in '..\LibTTT\libGDIP\GDIPAPI.pas',
  GdiPlus in '..\LibTTT\libGDIP\GdiPlus.pas',
  GdiPlusHelpers in '..\LibTTT\libGDIP\GdiPlusHelpers.pas',
  GDIPOBJ in '..\LibTTT\libGDIP\GDIPOBJ.pas',
  uConstantaData in '..\LibTTT\LibData\uConstantaData.pas',
  uBaseCoordSystem in '..\LibTTT\LibData\uBaseCoordSystem.pas',
  uCoordConvertor in '..\LibTTT\LibData\uCoordConvertor.pas',
  uDataTypes in '..\LibTTT\LibData\uDataTypes.pas',
  uRecordData in '..\LibTTT\LibData\uRecordData.pas',
  uConsoleData in '..\LibTTT\LibData\uConsoleData.pas',
  uNetHandle_Server in 'LibServer\uNetHandle_Server.pas',
  uScriptSimServer in 'LibServer\uScriptSimServer.pas',
  uSimMgr_Server in 'LibServer\uSimMgr_Server.pas',
  uT3ServerEventManager in 'LibServer\uT3ServerEventManager.pas',
  uNetHandle_TTT in '..\LibTTT\LibNet\uNetHandle_TTT.pas',
  uFormula in '..\LibTTT\LibData\uFormula.pas',
  ufrmDatabaseLogin in '..\LibTTT\LibForms\ufrmDatabaseLogin.pas' {frmDatabaseLogin},
  uLibSetting in '..\LibTTT\LibData\uLibSetting.pas',
  uEventSummary in '..\LibTTT\LibManager\uEventSummary.pas',
  uScriptCommon in '..\LibTTT\LibManager\uScriptCommon.pas',
  uSimManager in '..\LibTTT\LibManager\uSimManager.pas',
  uT3EventManager in '..\LibTTT\LibManager\uT3EventManager.pas',
  uT3SimManager in '..\LibTTT\LibManager\uT3SimManager.pas',
  uMapXData in '..\LibTTT\LibComponent\uMapXData.pas',
  uMapXHandler in '..\LibTTT\LibComponent\uMapXHandler.pas',
  uTMapTouch2 in '..\LibTTT\LibComponent\uTMapTouch2.pas',
  WbemScripting_TLB in '..\LibTTT\LibComponent\WbemScripting_TLB.pas',
  uDataModule in '..\LibTTT\LibData\uDataModule.pas' {dmINWO: TDataModule},
  uClassData in '..\LibTTT\LibData\uClassData.pas',
  uDBAsset_Countermeasure in '..\LibTTT\LibData\uDBAsset_Countermeasure.pas',
  uDBAsset_Sensor in '..\LibTTT\LibData\uDBAsset_Sensor.pas',
  uDBAsset_Vehicle in '..\LibTTT\LibData\uDBAsset_Vehicle.pas',
  uDBAsset_Weapon in '..\LibTTT\LibData\uDBAsset_Weapon.pas';

{$R *.res}

var
  Mutex : THandle;
begin
  ReportMemoryLeaksOnShutdown := True;

//  MyMsg := RegisterWindowMessage('GameServer_Message');
  Mutex := CreateMutex(nil, True, 'GameServer_Mutex');
  if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
//    SendMessage(HWND_BROADCAST, MyMsg, 0, 0);

    Application.MessageBox('Another Game Server has already running.',
      'Game Server', MB_OK + MB_ICONINFORMATION);
  end
  else
  begin
    Application.Initialize;

   //Application.MainFormOnTaskbar := True;

    Application.CreateForm(TfrmMainGameServer, frmMainGameServer);
  Application.CreateForm(TfrmDatabaseLogin, frmDatabaseLogin);
  Application.CreateForm(TdmINWO, dmINWO);
  uScriptSimServer.BeginGame_Server;

    Randomize;

    Application.Run;

    uScriptSimServer.EndGame_Server;

    if Mutex <> 0 then
      CloseHandle(Mutex);
  end;
end.

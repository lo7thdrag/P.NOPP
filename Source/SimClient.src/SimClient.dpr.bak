program SimClient;

{$DEFINE CLIENT}

uses
  Forms,
  SysUtils,
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
  uSimVisuals in '..\LibTTT\LibVisual\uSimVisuals.pas',
  uCompassVisual in '..\LibTTT\LibVisual\uCompassVisual.pas',
  uObjectVisuals in '..\LibTTT\LibVisual\uObjectVisuals.pas',
  uPacketBuffer in '..\SimFramework\LibNets\NetComponent\uPacketBuffer.pas',
  uPacketRegister in '..\SimFramework\LibNets\NetComponent\uPacketRegister.pas',
  uTCPClient in '..\SimFramework\LibNets\NetComponent\uTCPClient.pas',
  uTCPDatatype in '..\SimFramework\LibNets\NetComponent\uTCPDatatype.pas',
  uTCPServer in '..\SimFramework\LibNets\NetComponent\uTCPServer.pas',
  uNetUDPnode in '..\SimFramework\LibNets\NetComponent\uNetUDPnode.pas',
  uNetBaseSocket in '..\SimFramework\LibNets\NetComponent\uNetBaseSocket.pas',
  uBaseNetHandler in '..\SimFramework\LibNets\uBaseNetHandler.pas',
  GmXml in '..\SimFramework\LibComponent\XMLReader\GmXml.pas',
  GmXMLInterface in '..\SimFramework\LibComponent\XMLReader\GmXMLInterface.pas',
  uT3UnitContainer in '..\LibTTT\libUnit\uT3UnitContainer.pas',
  DosCommand in '..\SimFramework\LibComponent\DosCommand\DosCommand.pas',
  uAppUtils in '..\SimFramework\LibBaseUtils\uAppUtils.pas',
  uT3Listener in '..\LibTTT\libUnit\uT3Listener.pas',
  uExecuter in '..\SimFramework\LibComponent\Executor\uExecuter.pas',
  uDataBuffer in '..\SimFramework\LibNets\NetComponent\uDataBuffer.pas',
  uVectorVisual in '..\LibTTT\libVisual\uVectorVisual.pas',
  GDIPAPI in '..\LibTTT\libGDIP\GDIPAPI.pas',
  GdiPlus in '..\LibTTT\libGDIP\GdiPlus.pas',
  GdiPlusHelpers in '..\LibTTT\libGDIP\GdiPlusHelpers.pas',
  GDIPOBJ in '..\LibTTT\libGDIP\GDIPOBJ.pas',
  uConstantaData in '..\LibTTT\LibData\uConstantaData.pas',
  uRecordData in '..\LibTTT\LibData\uRecordData.pas',
  uConsoleData in '..\LibTTT\LibData\uConsoleData.pas',
  uT3ClientEventManager in 'LibClient\uT3ClientEventManager.pas',
  uNetHandle_Client in 'LibClient\uNetHandle_Client.pas',
  uScriptSimClients in 'LibClient\uScriptSimClients.pas',
  uSimMgr_Client in 'LibClient\uSimMgr_Client.pas',
  uBaseCoordSystem in '..\LibTTT\LibData\uBaseCoordSystem.pas',
  uCoordConvertor in '..\LibTTT\LibData\uCoordConvertor.pas',
  uDataTypes in '..\LibTTT\LibData\uDataTypes.pas',
  uNetHandle_TTT in '..\LibTTT\LibNet\uNetHandle_TTT.pas',
  uFormula in '..\LibTTT\LibData\uFormula.pas',
  ufrmDatabaseLogin in '..\LibTTT\LibForms\ufrmDatabaseLogin.pas' {frmDatabaseLogin},
  uDataModule in '..\LibTTT\LibData\uDataModule.pas' {dmINWO: TDataModule},
  uLibSetting in '..\LibTTT\LibData\uLibSetting.pas',
  uMapXData in '..\LibTTT\LibComponent\uMapXData.pas',
  uMapXHandler in '..\LibTTT\LibComponent\uMapXHandler.pas',
  uTMapTouch2 in '..\LibTTT\LibComponent\uTMapTouch2.pas',
  WbemScripting_TLB in '..\LibTTT\LibComponent\WbemScripting_TLB.pas',
  uEventSummary in '..\LibTTT\LibManager\uEventSummary.pas',
  uScriptCommon in '..\LibTTT\LibManager\uScriptCommon.pas',
  uSimManager in '..\LibTTT\LibManager\uSimManager.pas',
  uT3EventManager in '..\LibTTT\LibManager\uT3EventManager.pas',
  uT3SimManager in '..\LibTTT\LibManager\uT3SimManager.pas',
  ufrmTacticalDisplay in '..\LibTTT\LibForms\SimulatorForm\ufrmTacticalDisplay.pas' {frmTacticalDisplay},
  uClassData in '..\LibTTT\LibData\uClassData.pas',
  ufrmDisplayArea in '..\LibTTT\LibForms\SimulatorForm\ufrmDisplayArea.pas' {frmDisplayArea},
  ufrmSituationBoard in '..\LibTTT\LibForms\SimulatorForm\ufrmSituationBoard.pas' {frmSituationBoard},
  ufrmTelegram in '..\LibTTT\LibForms\SimulatorForm\ufrmTelegram.pas' {frmTelegram},
  ufrmVideoConference in '..\LibTTT\LibForms\SimulatorForm\ufrmVideoConference.pas' {frmVideoConference},
  uDBAsset_Countermeasure in '..\LibTTT\LibData\uDBAsset_Countermeasure.pas',
  uDBAsset_Sensor in '..\LibTTT\LibData\uDBAsset_Sensor.pas',
  uDBAsset_Vehicle in '..\LibTTT\LibData\uDBAsset_Vehicle.pas',
  uDBAsset_Weapon in '..\LibTTT\LibData\uDBAsset_Weapon.pas',
  ufrmSummaryUserRole in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmSummaryUserRole.pas' {frmSummaryUserRole},
  ufrmCreateTab in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmCreateTab.pas' {frmCreateTab},
  ufrmImageInsert in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmImageInsert.pas' {frmImageInsert},
  ufrmAvailableUserRole in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmAvailableUserRole.pas' {frmAvailableUserRole},
  UfrmMapEditor in '..\LibTTT\LibForms\DatabaseEditorForm\UfrmMapEditor.pas' {frmMapEditor},
  ufrmOverlayTools in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmOverlayTools.pas' {frmOverlayTools},
  ufrmSimbolTaktis in '..\LibTTT\LibForms\SimulatorForm\ufrmSimbolTaktis.pas' {frmSimbolTaktis},
  ufrmMapPreview in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmMapPreview.pas' {frmMapPreview},
  ufrmBrowseMap in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmBrowseMap.pas' {frmBrowseMap},
  ufrmAsset in '..\LibTTT\LibForms\SimulatorForm\ufrmAsset.pas' {frmAsset},
  ufrmRole in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmRole.pas' {frmSummaryRole},
  ufrmSubRole in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmSubRole.pas' {frmSubRole},
  ufrmSelectSimbolTaktis in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmSelectSimbolTaktis.pas' {frmSelectSimbolTaktis},
  ufrmAccousticDecoyOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmAccousticDecoyOnBoardPickList.pas' {frmAccousticDecoyOnBoardPickList},
  ufrmAcousticDecoyOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmAcousticDecoyOnBoardPickList.pas' {frmAcousticDecoyOnBoardPickList},
  ufrmAirBubbleOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmAirBubbleOnBoardPickList.pas' {frmAirBubbleOnBoardPickList},
  ufrmBombOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmBombOnBoardPickList.pas' {frmBombOnBoardPickList},
  ufrmChaffOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmChaffOnBoardPickList.pas' {frmChaffOnBoardPickList},
  ufrmEmbarkedOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmEmbarkedOnBoardPickList.pas' {frmEmbarkedOnBoardPickList},
  ufrmEODOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmEODOnBoardPickList.pas' {frmEODOnBoardPickList},
  ufrmESMOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmESMOnBoardPickList.pas' {frmESMOnBoardPickList},
  ufrmFloatingDecoyOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmFloatingDecoyOnBoardPickList.pas' {frmFloatingDecoyOnBoardPickList},
  ufrmGunOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmGunOnBoardPickList.pas' {frmGunOnBoardPickList},
  ufrmIFFOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmIFFOnBoardPickList.pas' {frmIFFOnBoardPickList},
  ufrmInfraredDecoyOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmInfraredDecoyOnBoardPickList.pas' {frmInfraredDecoyOnBoardPickList},
  ufrmMADOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmMADOnBoardPickList.pas' {frmMADOnBoardPickList},
  ufrmMineOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmMineOnBoardPickList.pas' {frmMineOnBoardPickList},
  ufrmMissileOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmMissileOnBoardPickList.pas' {frmMissileOnBoardPickList},
  ufrmRadarNoiseJammerOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmRadarNoiseJammerOnBoardPickList.pas' {frmRadarNoiseJammerOnBoardPickList},
  ufrmRadarOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmRadarOnBoardPickList.pas' {frmRadarOnBoardPickList},
  ufrmSelfDefensiveJammerOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmSelfDefensiveJammerOnBoardPickList.pas' {frmSelfDefensiveJammerOnBoardPickList},
  ufrmSonarOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmSonarOnBoardPickList.pas' {frmSonarOnBoardPickList},
  ufrmSonobuoyOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmSonobuoyOnBoardPickList.pas' {frmSonobuoyOnBoardPickList},
  ufrmTorpedoOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmTorpedoOnBoardPickList.pas' {frmTorpedoOnBoardPickList},
  ufrmTowedJammerDecoyOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmTowedJammerDecoyOnBoardPickList.pas' {frmTowedJammerDecoyOnBoardPickList},
  ufrmVisualDetectorOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmVisualDetectorOnBoardPickList.pas' {frmVisualDetectorOnBoardPickList},
  ufrmAcousticDecoyMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmAcousticDecoyMount.pas' {frmAcousticDecoyMount},
  ufrmAirBubbleMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmAirBubbleMount.pas' {frmAirBubbleMount},
  ufrmBombMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmBombMount.pas' {frmBombMount},
  ufrmChaffMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmChaffMount.pas' {frmChaffMount},
  ufrmEODMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmEODMount.pas' {frmEODMount},
  ufrmESMMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmESMMount.pas' {frmESMMount},
  ufrmFloatingDecoyMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmFloatingDecoyMount.pas' {frmFloatingDecoyMount},
  ufrmGunMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmGunMount.pas' {frmGunMount},
  ufrmIFFMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmIFFMount.pas' {frmIFFMount},
  ufrmInfraRedmount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmInfraRedmount.pas' {frmInfraredmount},
  ufrmMADMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmMADMount.pas' {frmMADMount},
  ufrmMineMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmMineMount.pas' {frmMineMount},
  ufrmMissileMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmMissileMount.pas' {frmMissileMount},
  ufrmRadarJammerMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmRadarJammerMount.pas' {frmRadarJammerMount},
  ufrmRadarMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmRadarMount.pas' {frmRadarMount},
  ufrmSonarMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmSonarMount.pas' {frmSonarMount},
  ufrmSonobuoyMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmSonobuoyMount.pas' {frmSonobuoyMount},
  ufrmTorpedoMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmTorpedoMount.pas' {frmTorpedoMount},
  ufrmTowedJammerMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmTowedJammerMount.pas' {frmTowedJammerMount},
  ufrmVisualDetectorMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmVisualDetectorMount.pas' {frmVisualDetectorMount},
  ufrmBlindZoneAttachment in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmBlindZoneAttachment.pas' {frmBlindZonesAttachment},
  ufrmChaffAssets in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmChaffAssets.pas' {frmChaffAssets},
  ufrmChaffLauncher in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmChaffLauncher.pas' {frmChaffLauncher},
  ufrmEmbarkedInputName in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmEmbarkedInputName.pas' {frmEmbarkedInputName},
  ufrmLauncherList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmLauncherList.pas' {frmLauncherList},
  ufrmMissileLauncher in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmMissileLauncher.pas' {frmMissileLauncher},
  ufrmPlatformInstanceInput in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmPlatformInstanceInput.pas' {frmPlatformInstanceInput},
  ufrmTorpedoLauncher in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmTorpedoLauncher.pas' {frmTorpedoLauncher},
  ufrmVehicleInputToBase in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmVehicleInputToBase.pas' {frmVehicleInputToBase},
  uSimbolTaktis in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\uSimbolTaktis.pas' {SimbolTaktis},
  ufrmReferensi in '..\LibTTT\LibForms\SimulatorForm\ufrmReferensi.pas' {frmReferensi};

{$R *.res}

var
  SavedDecimalSeparator : char;
//  SavedDateFormat : string;
begin
//  ReportMemoryLeaksOnShutdown := True;

  SavedDecimalSeparator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';

  Application.Initialize;

  //Application.MainFormOnTaskbar := True;

  Application.Title := 'SimClient';
  Application.CreateForm(TdmINWO, dmINWO);
  Application.CreateForm(TfrmTacticalDisplay, frmTacticalDisplay);
//  Application.CreateForm(TfrmDisplayArea, frmDisplayArea);
  frmDisplayArea := nil;
  frmSituationBoard := nil;
//  Application.CreateForm(TfrmSituationBoard, frmSituationBoard);
  Application.CreateForm(TfrmOverlayTools, frmOverlayTools);
//  Application.CreateForm(TfrmBrowseMap, frmBrowseMap);
  uScriptSimClients.BeginGame;

  Application.Run;

  uScriptSimClients.EndGame;
  FormatSettings.DecimalSeparator := SavedDecimalSeparator;

end.

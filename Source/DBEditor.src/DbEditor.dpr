program DbEditor;

uses
  Forms,
  uIniFilesProcs in '..\SimFramework\LibBaseUtils\uIniFilesProcs.pas',
  uCodecBase64 in '..\SimFramework\LibBaseUtils\StringUtils\uCodecBase64.pas',
  uSimObjects in '..\SimFramework\LibSims\SimSystem\uSimObjects.pas',
  u2DMover in '..\SimFramework\LibSims\SimsObjects\u2DMover.pas',
  uSteppers in '..\SimFramework\LibBaseUtils\Counter\uSteppers.pas',
  uBaseSimObjects in '..\SimFramework\LibSims\SimSystem\uBaseSimObjects.pas',
  uSimContainers in '..\SimFramework\LibSims\SimSystem\uSimContainers.pas',
  uStringFunc in '..\SimFramework\LibBaseUtils\StringUtils\uStringFunc.pas',
  uVirtualTime in '..\SimFramework\LibBaseUtils\Counter\uVirtualTime.pas',
  uThreadTimer in '..\SimFramework\LibBaseUtils\Counter\uThreadTimer.pas',
  uPacketBuffer in '..\SimFramework\LibNets\NetComponent\uPacketBuffer.pas',
  uPacketRegister in '..\SimFramework\LibNets\NetComponent\uPacketRegister.pas',
  uTCPClient in '..\SimFramework\LibNets\NetComponent\uTCPClient.pas',
  uTCPDatatype in '..\SimFramework\LibNets\NetComponent\uTCPDatatype.pas',
  uTCPServer in '..\SimFramework\LibNets\NetComponent\uTCPServer.pas',
  uNetBaseSocket in '..\SimFramework\LibNets\NetComponent\uNetBaseSocket.pas',
  uBaseNetHandler in '..\SimFramework\LibNets\uBaseNetHandler.pas',
  GmXml in '..\SimFramework\LibComponent\XMLReader\GmXml.pas',
  GmXMLInterface in '..\SimFramework\LibComponent\XMLReader\GmXMLInterface.pas',
  xmlInterface in '..\SimFramework\LibComponent\XMLReader\xmlInterface.pas' {,
  uSimMgr_Client in '..\tttSimClient.src\uSimMgr_Client.pas',
  uNetHandle_Client in '..\tttSimClient.src\uNetHandle_Client.pas',
  uNetUDPnode in '..\SimFramework\LibNets\NetComponent\uNetUDPnode.pas',
  uNetHandle_TTT in '..\LibTTT\netTTT\uNetHandle_TTT.pas'},
  Vcl.Themes,
  Vcl.Styles,
  uConstantaData in '..\LibTTT\LibData\uConstantaData.pas',
  uT3Listener in '..\LibTTT\libUnit\uT3Listener.pas',
  uLibSetting in '..\LibTTT\LibData\uLibSetting.pas',
  uDataModule in '..\LibTTT\LibData\uDataModule.pas' {dmINWO: TDataModule},
  ufrmDatabaseLogin in '..\LibTTT\LibForms\ufrmDatabaseLogin.pas' {frmDatabaseLogin},
  uRecordData in '..\LibTTT\LibData\uRecordData.pas',
  uDataTypes in '..\LibTTT\LibData\uDataTypes.pas',
  uBaseCoordSystem in '..\LibTTT\LibData\uBaseCoordSystem.pas',
  uCoordConvertor in '..\LibTTT\LibData\uCoordConvertor.pas',
  uObjectVisuals in '..\LibTTT\libVisual\uObjectVisuals.pas',
  GDIPAPI in '..\LibTTT\libGDIP\GDIPAPI.pas',
  GdiPlus in '..\LibTTT\libGDIP\GdiPlus.pas',
  GdiPlusHelpers in '..\LibTTT\libGDIP\GdiPlusHelpers.pas',
  GDIPOBJ in '..\LibTTT\libGDIP\GDIPOBJ.pas',
  uCompassVisual in '..\LibTTT\libVisual\uCompassVisual.pas',
  uSimVisuals in '..\LibTTT\libVisual\uSimVisuals.pas',
  uVectorVisual in '..\LibTTT\libVisual\uVectorVisual.pas',
  uDataBuffer in '..\SimFramework\LibNets\NetComponent\uDataBuffer.pas',
  uSimDBEditor in 'LibDbEditor\uSimDBEditor.pas',
  ufrmAvailableGameArea in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmAvailableGameArea.pas' {frmAvailableGameArea},
  ufrmAvailablePlatform in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmAvailablePlatform.pas' {frmAvailablePlatform},
  ufrmAvailableTacticalSyimbol in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmAvailableTacticalSyimbol.pas' {frmAvailableTacticalSymbol},
  ufrmAvailableUserRole in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmAvailableUserRole.pas' {frmAvailableUserRole},
  ufrmMainForm in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmMainForm.pas' {frmMainForm},
  ufrmSummaryGameArea in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmSummaryGameArea.pas' {frmSummaryGameArea},
  ufrmSummaryPlatform in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmSummaryPlatform.pas' {frmSummaryPlatform},
  ufrmSummaryTacticalSymbol in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmSummaryTacticalSymbol.pas' {frmTacticalSymbol},
  ufrmSummaryUserRole in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmSummaryUserRole.pas' {frmSummaryUserRole},
  uClassData in '..\LibTTT\LibData\uClassData.pas',
  ufrmSummaryRadar in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmSummaryRadar.pas' {frmSummaryRadar},
  ufrmAvailableSonar in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmAvailableSonar.pas' {frmAvailableSonar},
  ufrmAvailableMissile in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmAvailableMissile.pas' {frmAvailableMissile},
  ufrmAvailableBomb in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmAvailableBomb.pas' {frmAvailableBomb},
  ufrmAvailableRadar in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmAvailableRadar.pas' {frmAvailableRadar},
  ufrmAvailableGun in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmAvailableGun.pas' {frmAvailableGun},
  ufrmAvailableMine in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmAvailableMine.pas' {frmAvailableMine},
  ufrmShortcutAOTC in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmShortcutAOTC.pas' {frmShortcutAOTC},
  ufrmAvailableEOD in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmAvailableEOD.pas' {frmAvailableEOD},
  ufrmAvailableESM in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmAvailableESM.pas' {frmAvailableESM},
  ufrmAvailableMAD in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmAvailableMAD.pas' {frmAvailableMAD},
  ufrmAvailableSonobuoy in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmAvailableSonobuoy.pas' {frmAvailableSonobuoy},
  ufrmSummaryEOD in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmSummaryEOD.pas' {frmSummaryEOD},
  ufrmSummaryESM in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmSummaryESM.pas' {frmSummaryESM},
  ufrmSummaryMAD in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmSummaryMAD.pas' {frmSummaryMAD},
  ufrmSummarySonar in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmSummarySonar.pas' {frmSummarySonar},
  ufrmSummarySonobuoy in '..\LibTTT\LibForms\DatabaseEditorForm\Sensor\ufrmSummarySonobuoy.pas' {frmSummarySonobuoy},
  ufrmAvailableTorpedo in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmAvailableTorpedo.pas' {frmAvailableTorpedo},
  ufrmSummaryBomb in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmSummaryBomb.pas' {frmSummaryBomb},
  ufrmSummaryGun in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmSummaryGun.pas' {frmSummaryGun},
  ufrmSummaryMine in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmSummaryMine.pas' {frmSummaryMine},
  ufrmSummaryMissile in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmSummaryMissile.pas' {frmSummaryMissile},
  ufrmSummaryTorpedo in '..\LibTTT\LibForms\DatabaseEditorForm\Weapon\ufrmSummaryTorpedo.pas' {frmSummaryTorpedo},
  ufrmAvailableAcousticDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableAcousticDecoy.pas' {frmAvailableAcousticDecoy},
  ufrmAvailableAirBubble in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableAirBubble.pas' {frmAvailableAirBubble},
  ufrmAvailableChaff in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableChaff.pas' {frmAvailableChaff},
  ufrmAvailableFloatingDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableFloatingDecoy.pas' {frmAvailableFloatingDecoy},
  ufrmAvailableInfraredDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableInfraredDecoy.pas' {frmAvailableInfraredDecoy},
  ufrmAvailableRadarNoiseJammer in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableRadarNoiseJammer.pas' {frmAvailableRadarNoiseJammer},
  ufrmAvailableSelfDefensiveJammer in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableSelfDefensiveJammer.pas' {frmAvailableSelfDefensiveJammer},
  ufrmAvailableTowedJammerDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmAvailableTowedJammerDecoy.pas' {frmAvailableTowedJammerDecoy},
  ufrmSummaryAcousticDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummaryAcousticDecoy.pas' {frmSummaryAcousticDecoy},
  ufrmSummaryAirBubble in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummaryAirBubble.pas' {frmSummaryAirBubble},
  ufrmSummaryChaff in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummaryChaff.pas' {frmSummaryChaff},
  ufrmSummaryFloatingDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummaryFloatingDecoy.pas' {frmSummaryFloatingDecoy},
  ufrmSummaryInfraredDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummaryInfraredDecoy.pas' {frmSummaryInfraredDecoy},
  ufrmSummaryRadarNoiseJammer in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummaryRadarNoiseJammer.pas' {frmSummaryRadarNoiseJammer},
  ufrmSummarySelfDefensiveJammer in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummarySelfDefensiveJammer.pas' {frmSummarySelfDefensiveJammer},
  ufrmSummaryTowedJammerDecoy in '..\LibTTT\LibForms\DatabaseEditorForm\Countermeasure\ufrmSummaryTowedJammerDecoy.pas' {frmSummaryTowedjammerDecoy},
  ufrmAvailableVehicle in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\ufrmAvailableVehicle.pas' {frmAvailableVehicle},
  ufrmSummaryVehicle in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\ufrmSummaryVehicle.pas' {frmSummaryVehicle},
  ufrmBlindZoneAttachment in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmBlindZoneAttachment.pas' {frmBlindZonesAttachment},
  ufrmChaffAssets in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmChaffAssets.pas' {frmChaffAssets},
  ufrmChaffLauncher in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmChaffLauncher.pas' {frmChaffLauncher},
  ufrmEmbarkedInputName in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmEmbarkedInputName.pas' {frmEmbarkedInputName},
  ufrmLauncherList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmLauncherList.pas' {frmLauncherList},
  ufrmMissileLauncher in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmMissileLauncher.pas' {frmMissileLauncher},
  ufrmPlatformInstanceInput in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmPlatformInstanceInput.pas' {frmPlatformInstanceInput},
  ufrmTorpedoLauncher in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmTorpedoLauncher.pas' {frmTorpedoLauncher},
  ufrmVehicleInputToBase in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmVehicleInputToBase.pas' {frmVehicleInputToBase},
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
  uDBAsset_Weapon in '..\LibTTT\LibData\uDBAsset_Weapon.pas',
  uDBAsset_Sensor in '..\LibTTT\LibData\uDBAsset_Sensor.pas',
  uDBAsset_Countermeasure in '..\LibTTT\LibData\uDBAsset_Countermeasure.pas',
  uDBAsset_Vehicle in '..\LibTTT\LibData\uDBAsset_Vehicle.pas' {/  ufrmUsage in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmUsage.pas' {frmUsage},
  ufrmUsage in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmUsage.pas' {frmUsage},
  uFormula in '..\LibTTT\LibData\uFormula.pas',
  uMapXData in '..\LibTTT\LibComponent\uMapXData.pas',
  uMapXHandler in '..\LibTTT\LibComponent\uMapXHandler.pas',
  uTMapTouch2 in '..\LibTTT\LibComponent\uTMapTouch2.pas',
  WbemScripting_TLB in '..\LibTTT\LibComponent\WbemScripting_TLB.pas',
  ufrmRole in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmRole.pas' {frmSummaryRole},
  ufrmSubRole in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmSubRole.pas' {frmSubRole};

begin

  ReportMemoryLeaksOnShutdown:= True;

  Application.Initialize;
  Application.CreateForm(TdmINWO, dmINWO);
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.CreateForm(TfrmSummaryRadar, frmSummaryRadar);
  Application.CreateForm(TfrmAvailableSonar, frmAvailableSonar);
  Application.CreateForm(TfrmAvailableMissile, frmAvailableMissile);
  Application.CreateForm(TfrmAvailableBomb, frmAvailableBomb);
  Application.CreateForm(TfrmAvailableRadar, frmAvailableRadar);
  Application.CreateForm(TfrmAvailableGun, frmAvailableGun);
  Application.CreateForm(TfrmAvailableMine, frmAvailableMine);
  Application.CreateForm(TfrmShortcutAOTC, frmShortcutAOTC);
  Application.CreateForm(TfrmAvailableEOD, frmAvailableEOD);
  Application.CreateForm(TfrmAvailableESM, frmAvailableESM);
  Application.CreateForm(TfrmAvailableMAD, frmAvailableMAD);
  Application.CreateForm(TfrmAvailableSonobuoy, frmAvailableSonobuoy);
  Application.CreateForm(TfrmSummaryEOD, frmSummaryEOD);
  Application.CreateForm(TfrmSummaryESM, frmSummaryESM);
  Application.CreateForm(TfrmSummaryMAD, frmSummaryMAD);
  Application.CreateForm(TfrmSummarySonar, frmSummarySonar);
  Application.CreateForm(TfrmSummarySonobuoy, frmSummarySonobuoy);
  Application.CreateForm(TfrmAvailableTorpedo, frmAvailableTorpedo);
  Application.CreateForm(TfrmSummaryBomb, frmSummaryBomb);
  Application.CreateForm(TfrmSummaryGun, frmSummaryGun);
  Application.CreateForm(TfrmSummaryMine, frmSummaryMine);
  Application.CreateForm(TfrmSummaryMissile, frmSummaryMissile);
  Application.CreateForm(TfrmSummaryTorpedo, frmSummaryTorpedo);
  Application.CreateForm(TfrmAvailableAcousticDecoy, frmAvailableAcousticDecoy);
  Application.CreateForm(TfrmAvailableAirBubble, frmAvailableAirBubble);
  Application.CreateForm(TfrmAvailableChaff, frmAvailableChaff);
  Application.CreateForm(TfrmAvailableFloatingDecoy, frmAvailableFloatingDecoy);
  Application.CreateForm(TfrmAvailableInfraredDecoy, frmAvailableInfraredDecoy);
  Application.CreateForm(TfrmAvailableRadarNoiseJammer, frmAvailableRadarNoiseJammer);
  Application.CreateForm(TfrmAvailableSelfDefensiveJammer, frmAvailableSelfDefensiveJammer);
  Application.CreateForm(TfrmAvailableTowedJammerDecoy, frmAvailableTowedJammerDecoy);
  Application.CreateForm(TfrmSummaryAcousticDecoy, frmSummaryAcousticDecoy);
  Application.CreateForm(TfrmSummaryAirBubble, frmSummaryAirBubble);
  Application.CreateForm(TfrmSummaryChaff, frmSummaryChaff);
  Application.CreateForm(TfrmSummaryFloatingDecoy, frmSummaryFloatingDecoy);
  Application.CreateForm(TfrmSummaryInfraredDecoy, frmSummaryInfraredDecoy);
  Application.CreateForm(TfrmSummaryRadarNoiseJammer, frmSummaryRadarNoiseJammer);
  Application.CreateForm(TfrmSummarySelfDefensiveJammer, frmSummarySelfDefensiveJammer);
  Application.CreateForm(TfrmSummaryTowedjammerDecoy, frmSummaryTowedjammerDecoy);
  Application.CreateForm(TfrmAvailableVehicle, frmAvailableVehicle);
  Application.CreateForm(TfrmSummaryVehicle, frmSummaryVehicle);
  Application.CreateForm(TfrmBlindZonesAttachment, frmBlindZonesAttachment);
  Application.CreateForm(TfrmChaffAssets, frmChaffAssets);
  Application.CreateForm(TfrmChaffLauncher, frmChaffLauncher);
  Application.CreateForm(TfrmEmbarkedInputName, frmEmbarkedInputName);
  Application.CreateForm(TfrmLauncherList, frmLauncherList);
  Application.CreateForm(TfrmMissileLauncher, frmMissileLauncher);
  Application.CreateForm(TfrmPlatformInstanceInput, frmPlatformInstanceInput);
  Application.CreateForm(TfrmTorpedoLauncher, frmTorpedoLauncher);
  Application.CreateForm(TfrmVehicleInputToBase, frmVehicleInputToBase);
  Application.CreateForm(TfrmAcousticDecoyMount, frmAcousticDecoyMount);
  Application.CreateForm(TfrmAirBubbleMount, frmAirBubbleMount);
  Application.CreateForm(TfrmBombMount, frmBombMount);
  Application.CreateForm(TfrmChaffMount, frmChaffMount);
  Application.CreateForm(TfrmEODMount, frmEODMount);
  Application.CreateForm(TfrmESMMount, frmESMMount);
  Application.CreateForm(TfrmFloatingDecoyMount, frmFloatingDecoyMount);
  Application.CreateForm(TfrmGunMount, frmGunMount);
  Application.CreateForm(TfrmIFFMount, frmIFFMount);
  Application.CreateForm(TfrmInfraredmount, frmInfraredmount);
  Application.CreateForm(TfrmMADMount, frmMADMount);
  Application.CreateForm(TfrmMineMount, frmMineMount);
  Application.CreateForm(TfrmMissileMount, frmMissileMount);
  Application.CreateForm(TfrmRadarJammerMount, frmRadarJammerMount);
  Application.CreateForm(TfrmRadarMount, frmRadarMount);
  Application.CreateForm(TfrmSonarMount, frmSonarMount);
  Application.CreateForm(TfrmSonobuoyMount, frmSonobuoyMount);
  Application.CreateForm(TfrmTorpedoMount, frmTorpedoMount);
  Application.CreateForm(TfrmTowedJammerMount, frmTowedJammerMount);
  Application.CreateForm(TfrmVisualDetectorMount, frmVisualDetectorMount);
  Application.CreateForm(TfrmUsage, frmUsage);
  Application.CreateForm(TfrmSummaryRole, frmSummaryRole);
  Application.CreateForm(TfrmSubRole, frmSubRole);
  uSimDBEditor.StartInitialize;

  Application.Run;
end.



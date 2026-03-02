unit uScriptSimClients;


interface

  procedure BeginGame;
  procedure EndGame;

implementation

uses
   SysUtils, Controls, Forms,
   uScriptCommon, uLibSetting, uSimMgr_Client, uNetHandle_Client, uMapXHandler,
   ufrmTacticalDisplay, uCoordConvertor, uConstantaData, uT3Listener, ufrmSituationBoard, ufrmToteDisplay{, {uGameSetting};

procedure BeginGame;
begin
  BeginGameCommon;

  LoadFF_NetClientSetting(vSettingFile, vNetClientSetting);
  LoadFF_AppSetting(vSettingFile, vAppSetting);
  LoadFF_AppDBSetting('setting.ini' , vGameAreaSetting);

  frmSituationBoard_Instance;
  simMgrClient := TSimMgr_Client.Create(frmSituationBoard.Map1);

  simMgrClient.LoadConsoleID;
  simMgrClient.LoadDataAsset(vGameDataSetting);

  simMgrClient.SessionID := vGameDataSetting.SessionID;

  simMgrClient.OnUpdateGameState  := frmTacticalDisplay.UpdateGameState;

  frmTacticalDisplay.Initialize;
  frmTacticalDisplay.lblConsoleName.Caption := simMgrClient.MyConsoleData.Identifier;

  VNetClient                  := TNetHandler_Client.Create;
  VNetClient.GamePort         := vNetSetting.GamePort;
  VNetClient.CommandPort      := vNetSetting.CommandPort;
  VNetClient.BroadCastAddress := vNetSetting.GameAddress;
  VNetClient.ServerIP         := vNetClientSetting.ServerIP;

  VNetClient.StartNetworking;

  simMgrClient.InitNetwork;

  if simMgrClient.MyConsoleData.Group = cgSituationBoard then
  begin
    frmTacticalDisplay.pnlBackgroundLogin.BringToFront;
    frmTacticalDisplay.pnlSituationBoard.BringToFront;
  end
  else
  begin
    frmTacticalDisplay.pnlHome.BringToFront;
    frmTacticalDisplay.pnlLogin.BringToFront;
  end;
end;

procedure EndGame;
begin
  simMgrClient.GamePause;

  VNetClient.StopNetworking;
  VNetClient.Free;
  simMgrClient.Free;

  VSimMap.Free;
end;



end.



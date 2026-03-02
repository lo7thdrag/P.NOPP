unit uScriptCommon;

interface

  procedure BeginGameCommon;
  procedure EndGameCommon;


implementation

uses
   SysUtils, Controls, Forms,
   uLibSetting,  uDataModule, ufrmDatabaseLogin;


procedure BeginGameCommon;
var iResult: Integer;
    bResult : Boolean;
begin
  FormatSettings.DateSeparator     := '/';
  FormatSettings.TimeSeparator     := ':';
  FormatSettings.DecimalSeparator  := '.';
  FormatSettings.ThousandSeparator := ',';

  vSettingFile := getFileSetting;

  LoadFF_NetSetting(vSettingFile, vNetSetting);
  LoadFF_MapSetting(vSettingFile, vMapSetting);
  LoadFF_GameSetting(vSettingFile, vGameDataSetting);

  LoadFF_dBaseSetting(vSettingFile, vDatabaseSetting);

  if (vGameDataSetting.DemoMode = False) then
  begin
    frmDatabaseLogin := TfrmDatabaseLogin.Create(nil);

    iResult := mrNone;
    repeat
      with vDatabaseSetting do
        bResult := dmINWO.InitZDB(dbServer, dbProto, dbName, dbUser, dbPass);

      if not bResult then
      begin

        with vDatabaseSetting do
        begin
          frmDatabaseLogin.dbServer := DBServer;
          frmDatabaseLogin.dbName   := DBName;
          frmDatabaseLogin.dbUser   := DBUser;
          frmDatabaseLogin.dbPass   := DBPass;
        end;

        iResult := frmDatabaseLogin.ShowModal;

        if iResult = mrOk then
        begin
          vDatabaseSetting.DBServer  := frmDatabaseLogin.dbServer ;
          vDatabaseSetting.DBName    := frmDatabaseLogin.dbName   ;
          vDatabaseSetting.DBUser    := frmDatabaseLogin.dbUser   ;
          vDatabaseSetting.DBPass    := frmDatabaseLogin.dbPass   ;
          vDatabaseSetting.dbProto   := c_defaultDBProto ;
        end;
      end
      else
      begin
        if (iResult = mrOk) then
          SaveFF_dBaseSetting(vSettingFile, vDatabaseSetting);

      end;
    until  bResult or (iResult = mrCancel);
    frmDatabaseLogin.Free;

    if (iResult = mrCancel) then Application.Terminate;
  end;

end;

procedure EndGameCommon;
begin

end;

end.

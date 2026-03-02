unit uScriptCommon;

interface

  procedure BeginGameCommon;
  procedure EndGameCommon;


implementation

uses
   SysUtils, Controls, Forms,
   uLibSettingTTT,  uDataModuleTTT, ufDBSetting;


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
  LoadFF_ExcludeMapArea(vSettingFile, vExcludeMapArea);
  LoadFF_PortMapArea(vSettingFile, vPortMapArea);

  LoadFF_dBaseSetting(vSettingFile, vDBSetting);
  LoadFF_SymbolSetting(vSettingFile, vSymbolSetting);

  if (vGameDataSetting.DemoMode = False) then
  begin
    frmDBSEtting := TfrmDBSetting.Create(nil);

    iResult := mrNone;
    repeat
      with vDBSetting do
        bResult := dmTTT.InitZDB(dbServer, dbProto, dbName, dbUser, dbPass);

      if not bResult then begin

        with vDBSetting do begin
          frmDBSetting.dbServer := DBServer;
          frmDBSetting.dbName   := DBName;
          frmDBSetting.dbUser   := DBUser;
          frmDBSetting.dbPass   := DBPass;
        end;

        iResult := frmDBSEtting.ShowModal;

        if iResult = mrOk then begin
          vDBSetting.DBServer  := frmDBSetting.dbServer ;
          vDBSetting.DBName    := frmDBSetting.dbName   ;
          vDBSetting.DBUser    := frmDBSetting.dbUser   ;
          vDBSetting.DBPass    := frmDBSetting.dbPass   ;
          vDBSetting.dbProto   := c_defaultDBProto ;
        end;
      end
      else begin
        if (iResult = mrOk) then
          SaveFF_dBaseSetting(vSettingFile, vDBSetting);

      end;
    until  bResult or (iResult = mrCancel);
    frmDBSetting.Free;

    if (iResult = mrCancel) then Application.Terminate;
  end;

end;

procedure EndGameCommon;
begin

end;

end.

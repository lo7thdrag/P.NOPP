unit uSimDBEditor;


interface

 uses
  Controls, Classes,sysutils;

 procedure StartInitialize;

implementation

uses
  uLibSetting, ufrmDatabaseLogin, uDataModule;

procedure StartInitialize;
var
  resultTemp1: Integer;
  connectTemp : Boolean;
begin

  {}//later ambil dari server, sementara ambil dari file dulu
  vSettingFile := getFileSetting;

  LoadFF_dBaseSetting(vSettingFile, vDatabaseSetting);

  frmDatabaseLogin := TfrmDatabaseLogin.Create(nil);

  resultTemp1 := mrNone;

  repeat
    with vDatabaseSetting do
    begin
      connectTemp := dmINWO.InitZDB(dbServer, dbProto, dbName, dbUser, dbPass);
    end;

    if not connectTemp then
    begin
      with vDatabaseSetting do
      begin
        frmDatabaseLogin.dbServer := DBServer;
        frmDatabaseLogin.dbName   := DBName;
        frmDatabaseLogin.dbUser   := DBUser;
        frmDatabaseLogin.dbPass   := DBPass;
      end;

      resultTemp1 := frmDatabaseLogin.ShowModal;

      if resultTemp1 = mrOk then
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
      if (resultTemp1 = mrOk) then
        SaveFF_dBaseSetting(vSettingFile, vDatabaseSetting);
    end;
  until  connectTemp or (resultTemp1 = mrCancel);

  frmDatabaseLogin.Free;

//  LoadFF_AppDBSetting('setting.ini' , vAppDBSetting);
end;

end.

program SymbolEntry;

uses
  Forms,
  ufMainEntry in 'ufMainEntry.pas' {Form1},
  uLibSettingTTT in '..\LibTTT\uLibSettingTTT.pas',
  uIniFilesProcs in '..\SimFramework\LibBaseUtils\uIniFilesProcs.pas',
  uCodecBase64 in '..\SimFramework\LibComponent\Base64\uCodecBase64.pas',
  uDMGC in '..\NOPRGameController\uDMGC.pas' {DMGC: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  vSettingFile := getFileSetting;
  LoadFF_dBaseSetting(vSettingFile, vDBSetting);




  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

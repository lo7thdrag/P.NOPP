program restart;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uSetting in 'uSetting.pas',
  uProcessManager in '..\libs\uProcessManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

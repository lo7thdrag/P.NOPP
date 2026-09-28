program RemoteServer;

uses
  Forms,
  uRemoteServer in 'uRemoteServer.pas' {frmMain},
  uRemoteScreen in 'uRemoteScreen.pas',
  uRemoteData in 'uRemoteData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

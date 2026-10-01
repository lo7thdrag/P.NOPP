program controller;

uses
  Vcl.Forms,
  Winapi.Windows,
  UMain in 'UMain.pas' {FrmMain},
  UCommands in '..\commons\UCommands.pas',
  USettings in '..\commons\USettings.pas';

{$R *.res}

var
  hMutex: THandle;
  hHwnd: HWND;
begin
  ReportMemoryLeaksOnShutdown:= True;

  hMutex:= CreateMutex(nil, True, 'Collaboration_Wall_Composer_Mutex_123456789');

  if (hMutex<>0) and (GetLastError=ERROR_ALREADY_EXISTS) then begin
    hHwnd:= FindWindow('TFrmMain','CWC');
    if hHwnd<>0 then begin
      if IsIconic(hHwnd) then
        ShowWindow(hHwnd, SW_RESTORE);
      SetForegroundWindow(hHwnd);
    end;
    Application.Terminate;
  end
  else begin
    try
      Application.Initialize;
      Application.MainFormOnTaskbar := True;
      Application.CreateForm(TFrmMain, FrmMain);
      Application.Run;
    finally
      if hMutex<>0 then
        ReleaseMutex(hMutex);
    end;
  end;
end.

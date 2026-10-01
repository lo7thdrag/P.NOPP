unit uProcessManager;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.TlHelp32, System.SysUtils,
  System.Classes, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TProcessData = record
    PID: DWORD;
    WindowHandle: HWND;
  end;
  PProcessData = ^TProcessData;

  TProcessManager = class
  private
//    class function EnumWindowsProc(Handle: HWND; LParam: LPARAM): BOOL; stdcall;
  public
    { Search for a PID by filename }
    class function GetPIDByName(const ExeName: string): DWORD;

    { Start a new process }
    class function RunExe(const FileName: string; Params: string = ''; Hide: Boolean = False): DWORD;

    { The "Smart Kill" with UI feedback }
    class procedure SmartKill(PID: DWORD; MaxWaitSec: Integer;
      ProgressBar: TProgressBar; StatusLabel: TLabel;
      OnDone: TThreadProcedure);
  end;

var
  // Use an Integer to store the state
  // 0 = False, 1 = True
  SharedFlag: Integer;

implementation

{ TProcessManager }

function IsFlagSet: Boolean;
begin
  // Compare SharedFlag with 0. If it's 0, set it to 0 (no change).
  // This effectively performs a "Thread-Safe Read".
  Result := InterlockedCompareExchange(SharedFlag, 0, 0) <> 0;
end;

//To set to True: InterlockedExchange(SharedFlag, 1);
//
//To set to False: InterlockedExchange(SharedFlag, 0);

function EnumWindowsProc(Handle: HWND; LParam: LPARAM): BOOL; stdcall;
var
  PID: DWORD;
begin
  GetWindowThreadProcessId(Handle, PID);
  if PID = PProcessData(LParam)^.PID then
  begin
    PProcessData(LParam)^.WindowHandle := Handle;
    Result := False;
  end
  else
    Result := True;
end;

class function TProcessManager.GetPIDByName(const ExeName: string): DWORD;
var
  Snapshot: THandle;
  Entry: TProcessEntry32;
begin
  Result := 0;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot <> INVALID_HANDLE_VALUE then
  try
    Entry.dwSize := SizeOf(Entry);
    if Process32First(Snapshot, Entry) then
    repeat
      if SameText(Entry.szExeFile, ExeName) then
      begin
        Result := Entry.th32ProcessID;
        Break;
      end;
    until not Process32Next(Snapshot, Entry);
  finally
    CloseHandle(Snapshot);
  end;
end;

class function TProcessManager.RunExe(const FileName: string; Params: string; Hide: Boolean): DWORD;
var
  SI: TStartupInfo;
  PI: TProcessInformation;
  Cmd: string;
begin
  Result := 0;
  FillChar(SI, SizeOf(SI), 0);
  SI.cb := SizeOf(SI);
  if Hide then
  begin
    SI.dwFlags := STARTF_USESHOWWINDOW;
    SI.wShowWindow := SW_HIDE;
  end;
  Cmd := '"' + FileName + '" ' + Params;
  UniqueString(Cmd);
  if CreateProcess(nil, PChar(Cmd), nil, nil, False, NORMAL_PRIORITY_CLASS, nil, nil, SI, PI) then
  begin
    Result := PI.dwProcessId;
    CloseHandle(PI.hProcess);
    CloseHandle(PI.hThread);
  end;
end;

class procedure TProcessManager.SmartKill(PID: DWORD; MaxWaitSec: Integer;
  ProgressBar: TProgressBar; StatusLabel: TLabel;
  OnDone: TThreadProcedure);
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      hProc: THandle;
      Data: TProcessData;
      i: Integer;
    begin
      // 1. Send WM_QUIT
      Data.PID := PID;
      Data.WindowHandle := 0;
      EnumWindows(@EnumWindowsProc, LPARAM(@Data));
      if Data.WindowHandle <> 0 then begin
        TThread.Queue(nil, procedure begin
          if Assigned(StatusLabel) then StatusLabel.Caption := 'Close Gracefully ...';
        end);
        PostMessage(Data.WindowHandle, WM_QUIT, 0, 0);
      end;

      hProc := OpenProcess(SYNCHRONIZE or PROCESS_TERMINATE, False, PID);
      if hProc = 0 then begin
        Exit;
      end;

      try
        for i := 1 to (MaxWaitSec * 10) do
        begin
          if IsFlagSet or TThread.CheckTerminated then Break;
          if WaitForSingleObject(hProc, 100) = WAIT_OBJECT_0 then Break;

          TThread.Queue(nil, procedure begin
            if Assigned(ProgressBar) then ProgressBar.Position := i;
          end);
        end;


        TThread.Queue(nil, procedure begin
          if Assigned(StatusLabel) then StatusLabel.Caption := 'Time out ! Terminate it ...';
        end);

        // 2. Force Kill if still alive
        TerminateProcess(hProc, 0);

        // 3. Final UI Update
        TThread.Queue(nil, procedure begin
          if Assigned(StatusLabel) then StatusLabel.Caption := 'Terminated.';
          if Assigned(OnDone) then OnDone;
        end);
      finally
        CloseHandle(hProc);
      end;
    end
  ).Start;
end;

end.

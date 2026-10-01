unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  uSetting,
  uProcessManager;

const
  WM_APP_INIT = WM_USER + 1;
  WM_APP_KILL = WM_USER + 2;
  WM_APP_RUN = WM_USER + 3;

type
  TfrmMain = class(TForm)
    lblRestart: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSetting: TSetting;
    procedure WM_APP_INIT_Handler(var AMessage: TMessage); message WM_APP_INIT;
    procedure WM_APP_KILL_Handler(var AMessage: TMessage); message WM_APP_KILL;
    procedure WM_APP_RUN_Handler(var AMessage: TMessage); message WM_APP_RUN;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FSetting:= TSetting.Create;
  FSetting.LoadFromFile;

  PostMessage(Handle, WM_APP_INIT, 0, 0);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(FSetting) then
    FreeAndNil(FSetting);
end;

procedure TfrmMain.WM_APP_INIT_Handler(var AMessage: TMessage);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      Sleep(2000);
      PostMessage(frmMain.Handle, WM_APP_KILL, 0, 0);
    end
  ).Start;
end;

procedure TfrmMain.WM_APP_KILL_Handler(var AMessage: TMessage);
var
  TargetPID: DWORD;
begin
  InterlockedExchange(SharedFlag, 0);
  TargetPID := TProcessManager.GetPIDByName(FSetting.AppName);

  if TargetPID <> 0 then
  begin
    TProcessManager.SmartKill(TargetPID, 5, nil, nil, nil);
  end;

  TThread.CreateAnonymousThread(
    procedure
    begin
      Sleep(3000);
      PostMessage(frmMain.Handle, WM_APP_RUN, 0, 0);
    end
  ).Start;
end;

procedure TfrmMain.WM_APP_RUN_Handler(var AMessage: TMessage);
begin
  TProcessManager.RunExe(FSetting.AppName);
  Close;
end;

end.

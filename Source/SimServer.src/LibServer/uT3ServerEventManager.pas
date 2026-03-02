unit uT3ServerEventManager;

interface

uses
  Classes, Sysutils, Math, WIndows,
  uNetHandle_Server, uT3EventManager, uT3Listener, uClassData;

type

  TT3ServerEventManager = class(TT3EventManager)
  private


  public
    procedure OnUpdateConsoleConnect; override;
    procedure OnUpdateUserStateChange(state : Integer); override;

  end;

implementation

uses
  ufrmMainGameServer;

{ TT3ServerEventManager }

procedure TT3ServerEventManager.OnUpdateUserStateChange(state : Integer);
begin
  inherited;
  frmMainGameServer.UpdateFormClientState;
end;

procedure TT3ServerEventManager.OnUpdateConsoleConnect;
begin
  inherited;
  frmMainGameServer.UpdateFormClientState;
end;

end.

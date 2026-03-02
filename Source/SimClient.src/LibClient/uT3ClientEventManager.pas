unit uT3ClientEventManager;

interface

uses
  {Delphi Uses}
  SysUtils, Variants, ComCtrls, Classes,Math, Windows,

  {Project Uses}
  uConstantaData, uT3Listener, uT3EventManager, uT3SimManager, uBaseCoordSystem, uDataTypes, uClassData, uRecordData,
  ufrmSituationBoard, ufrmDisplayArea;

type
  TT3ClientEventManager = class(TT3EventManager)
  private

  public

    procedure OnUpdateUserStateChange(state : Integer); override;
    procedure OnUpdateSituationBoardTabPropertiesChange; override;
    procedure OnUpdateSituationBoardOverlayChange; override;
    procedure OnUpdateUserRoleChatChange(IdSender, IdReceiver : integer); override;

  end;

implementation

uses
  ufrmTacticalDisplay ;

{ TT3ClientEventManager }

procedure TT3ClientEventManager.OnUpdateSituationBoardOverlayChange;
begin
  inherited;
  frmSituationBoard.Map1.Refresh;
  frmSituationBoard.Map1.Repaint;
end;

procedure TT3ClientEventManager.OnUpdateSituationBoardTabPropertiesChange;
begin
  inherited;

  frmSituationBoard.UpdateTab;
  frmSituationBoard.RefreshTab;

end;

procedure TT3ClientEventManager.OnUpdateUserRoleChatChange(IdSender, IdReceiver : integer);
begin
  inherited;
  frmDisplayArea.UpdateClientHistoryChat(IdSender, IdReceiver);
  frmDisplayArea.UpdateClientChatting;

end;

procedure TT3ClientEventManager.OnUpdateUserStateChange(state: Integer);
begin
  inherited;

  case state of
    CORD_ID_LOGIN  : frmTacticalDisplay.UpdateClientLogin(nil);
    CORD_ID_LOGOUT : frmTacticalDisplay.UpdateClientLogout(nil);
  end;
end;
end.

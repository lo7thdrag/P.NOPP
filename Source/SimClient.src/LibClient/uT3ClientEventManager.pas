unit uT3ClientEventManager;

interface

uses
  {Delphi Uses}
  SysUtils, Variants, ComCtrls, Classes,Math, Windows,

  {Project Uses}
  uConstantaData, uT3Listener, uT3EventManager, uT3SimManager, uBaseCoordSystem, uDataTypes, uClassData, uRecordData,
  ufrmSituationBoard, ufrmDisplayArea, ufPopChat;

type
  TT3ClientEventManager = class(TT3EventManager)
  private

  public

    procedure OnUpdateUserStateChange(state : Integer); override;
    procedure OnUpdateSituationBoardTabPropertiesChange; override;
    procedure OnUpdateSituationBoardOverlayChange; override;
    procedure OnUpdateUserRoleChatChange(IdSender, IdReceiver : integer); override;
    procedure OnUserRoleChatRead(IdUser : Integer); override;
    procedure OnUpdateFileSyncChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string); override;
    procedure OnUpdateFileTransferChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string); override;
    procedure OnUpdateFileSharingChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string); override;

    // File Opened Notifikasi
    procedure OnUpdateFileSyncOpened(IdSender, IdReceiver: Integer; FileName: string); override;
    procedure OnUpdateFileTransferOpened(IdSender, IdReceiver: Integer; FileName: string); override;
    procedure OnUpdateFileSharingOpened(IdSender, IdReceiver: Integer; FileName: string); override;
  end;

implementation

uses
  ufrmTacticalDisplay ;

{ TT3ClientEventManager }

procedure TT3ClientEventManager.OnUpdateFileSharingChange(IdSender, IdReceiver: Integer; FileName: string; FilePath: string);
begin
  inherited;

  if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowFilePopupNotify(IdSender, IdReceiver, FileName,FilePath, fptFileSharing)
end;

procedure TT3ClientEventManager.OnUpdateFileSharingOpened(IdSender,IdReceiver: Integer; FileName: string);
begin
  inherited;

  if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowFileReadNotify(IdSender,IdReceiver,FileName);
end;

procedure TT3ClientEventManager.OnUpdateFileSyncChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string);
begin
  inherited;

 if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowFilePopupNotify(IdSender, IdReceiver, FileName, FilePath, fptTelegram);
end;

procedure TT3ClientEventManager.OnUpdateFileSyncOpened(IdSender, IdReceiver: Integer; FileName: string);
begin
  inherited;

  if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowFileReadNotify(IdSender,IdReceiver,FileName);
end;

procedure TT3ClientEventManager.OnUpdateFileTransferChange(IdSender,IdReceiver: Integer; FileName: string;FilePath: string);
begin
  inherited;

  if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowFilePopupNotify(IdSender, IdReceiver, FileName, FilePath,fptToteDisplay)
end;

procedure TT3ClientEventManager.OnUpdateFileTransferOpened(IdSender, IdReceiver: Integer; FileName: string);
begin
  inherited;

  if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowFileReadNotify(IdSender,IdReceiver,FileName);
end;

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

   if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowChatPopupNotify(IdSender, IdReceiver);
end;

procedure TT3ClientEventManager.OnUpdateUserStateChange(state: Integer);
begin
  inherited;

  case state of
    CORD_ID_LOGIN  : frmTacticalDisplay.UpdateClientLogin(nil);
    CORD_ID_LOGOUT : frmTacticalDisplay.UpdateClientLogout(nil);
  end;
end;

procedure TT3ClientEventManager.OnUserRoleChatRead(IdUser: Integer);
begin
  inherited;

   if Assigned(frmDisplayArea) then
    frmDisplayArea.ShowReadNotify(IdUser);
end;

end.

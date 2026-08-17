unit uT3EventManager;

interface

uses
  Classes, SYsUtils, Windows,

  uConstantaData, uT3Listener, uDataTypes, uClassData;

type

  TT3EventManager = class
  private

  public

    procedure OnUpdateConsoleConnect; virtual;
    procedure OnUpdateUserStateChange(state : Integer); virtual;
    procedure OnUpdateSituationBoardTabPropertiesChange; virtual;
    procedure OnUpdateSituationBoardOverlayChange; virtual;
    procedure OnUpdateUserRoleChatChange(IdSender, IdReceiver : integer); virtual;
    procedure OnUserRoleChatRead(IdUser : Integer); virtual;
    procedure OnUpdateFileSyncChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string); virtual;
    procedure OnUpdateFileTransferChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string); virtual;
    procedure OnUpdateFileSharingChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string); virtual;

    // File Opened Notifikasi
    procedure OnUpdateFileSyncOpened(IdSender, IdReceiver: Integer; FileName: string); virtual;
    procedure OnUpdateFileTransferOpened(IdSender, IdReceiver: Integer; FileName: string); virtual;
    procedure OnUpdateFileSharingOpened(IdSender, IdReceiver: Integer; FileName: string); virtual;
  end;

implementation

uses
  uBaseCoordSystem, uT3SimManager;


{ TT3EventManager }

procedure TT3EventManager.OnUpdateFileSharingChange(IdSender, IdReceiver: Integer; FileName: string; FilePath: string);
begin

end;

procedure TT3EventManager.OnUpdateFileSharingOpened(IdSender,IdReceiver: Integer; FileName: string);
begin

end;

procedure TT3EventManager.OnUpdateFileSyncChange(IdSender : Integer; IdReceiver : Integer; FileName : string; FilePath: string);
begin

end;

procedure TT3EventManager.OnUpdateFileSyncOpened(IdSender, IdReceiver: Integer; FileName: string);
begin

end;

procedure TT3EventManager.OnUpdateFileTransferChange(IdSender,IdReceiver: Integer; FileName: string; FilePath: string);
begin

end;

procedure TT3EventManager.OnUpdateFileTransferOpened(IdSender,IdReceiver: Integer; FileName: string);
begin

end;

procedure TT3EventManager.OnUpdateSituationBoardOverlayChange;
begin

end;

procedure TT3EventManager.OnUpdateSituationBoardTabPropertiesChange;
begin

end;

procedure TT3EventManager.OnUpdateUserRoleChatChange;
begin

end;

procedure TT3EventManager.OnUpdateUserStateChange(state : Integer);
begin

end;

procedure TT3EventManager.OnUserRoleChatRead(IdUser: Integer);
begin

end;

procedure TT3EventManager.OnUpdateConsoleConnect;
begin

end;

end.





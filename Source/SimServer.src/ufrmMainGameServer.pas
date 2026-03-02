unit ufrmMainGameServer;

interface

uses
  Windows, Messages, SysUtils, System.IOUtils, Winapi.ShellAPI, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, OleCtrls, MapXLib_TLB, ExtCtrls, ComCtrls,
  uLibSetting, System.ImageList, Vcl.ImgList, uRecordData, uClassData,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage{, ShellApi} ;

type

  TfrmMainGameServer = class(TForm)
    pnlHeader: TPanel;
    Label4: TLabel;
    lbl: TLabel;
    Label5: TLabel;
    lblSession: TLabel;
    lvConsole: TListView;
    ilClientStateColor: TImageList;
    Label3: TLabel;
    Label6: TLabel;
    lblAppState: TLabel;
    imgHeaderBackground: TImage;
    Label1: TLabel;
    lblTime: TLabel;
    Timer1: TTimer;
    btnLock: TImage;
    btnUnlock: TImage;
    lblGameTime: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    procedure btnLockClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnUnlockClick(Sender: TObject);

  private

  public
//    procedure UpdateClientStateServerLastOn;
    procedure UpdateFormClientState;
    procedure UpdateEventBuffer;

//    procedure UpdateClientLogin;
    procedure UpdateGameState(Sender: TObject);

  end;

var
  frmMainGameServer: TfrmMainGameServer;


implementation

{$R *.dfm}

uses
  uSimMgr_server, uNetHandle_Server, uTCPDatatype, uConstantaData, uConsoleData, uT3SimManager;

procedure TfrmMainGameServer.FormShow(Sender: TObject);
begin
  UpdateFormClientState;
  UpdateGameState(nil);

  lblSession.Caption := IntToStr(SimManager.SessionID);

  if not TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM') then
    Exit;
  if not TDirectory.Exists('D:\Telegram\removeDir.bat') then
    Exit;
  ShellExecute(0, 'open', ('D:\Telegram\removeDir.bat'), nil, nil, SW_SHOW);
end;

procedure TfrmMainGameServer.btnLockClick(Sender: TObject);
var
  r: TRecCmd_GameCtrl;
begin
  r.SessionID := simMgrServer.SessionID;

  r.GameCtrl  := CORD_ID_pause;
  simMgrServer.GamePause;

  VNetServer.SendBroadcastCommand(CPID_CMD_GAME_CTRL , @r);
end;

procedure TfrmMainGameServer.btnUnlockClick(Sender: TObject);
var
  r: TRecCmd_GameCtrl;
begin
  r.SessionID := simMgrServer.SessionID;

  r.GameCtrl  := CORD_ID_start;
  simMgrServer.GameStart;

  VNetServer.SendBroadcastCommand(CPID_CMD_GAME_CTRL , @r);
end;

procedure TfrmMainGameServer.SpeedButton1Click(Sender: TObject);
var
  i: Integer;
  SelectedIndex: Integer;
  ipaddress: string;
  r: TRecTCP_ClientState_Info;
  consoleInfoTemp : TConsoleInfo;
begin
  for i := 0 to simMgrServer.SimConsole.ConsoleList.Count - 1 do
  begin
    consoleInfoTemp := TConsoleInfo(simMgrServer.SimConsole.ConsoleList.Objects[i]);
    SelectedIndex := i;

    if SelectedIndex > -1 then
    begin
      ipaddress := consoleInfoTemp.IPAddress;

      r.SessionID := simMgrServer.SessionID;
//      VNetServer.SendBroadcastCommand(CPID_CMD_CLIENT_STATE_INFO, @r);
    end;
  end;
end;

procedure TfrmMainGameServer.Timer1Timer(Sender: TObject);
var
  dt: TDateTime;
begin
  lblTime.Caption := FormatDateTime('hh:nn:ss', now);

  if Assigned(simMgrServer) then
  begin
    dt := simMgrServer.GameTIME;
    lblGameTime.Caption := FormatDateTime('hh:nn:ss', dt);
  end;
end;

procedure TfrmMainGameServer.UpdateFormClientState;
var
  i : Integer;
  li : TListItem;
  consoleInfoTemp : TConsoleInfo;
  userRoleTemp : TUserRole;
  subRoleTemp : TSubRole;

begin
  lvConsole.Items.Clear;

  for i := 0 to simMgrServer.SimConsole.ConsoleList.Count-1 do
  begin
    consoleInfoTemp := TConsoleInfo(simMgrServer.SimConsole.ConsoleList.Objects[i]);

    li := lvConsole.Items.Add;
    li.Caption := consoleInfoTemp.ConsoleName;
    li.SubItems.Add(consoleInfoTemp.IPAddress);

    if consoleInfoTemp.State then
    begin
      li.SubItems.Add('✔');
      li.StateIndex := 1;
    end
    else
    begin
      li.SubItems.Add('❌');
      li.StateIndex := 0;
    end;

    userRoleTemp := SimManager.SimUserRole.getUserRoleByIPAddress(consoleInfoTemp.IPAddress);

    if Assigned(userRoleTemp) then
    begin
      if userRoleTemp.isInUse then
      begin
        li.SubItems.Add(userRoleTemp.FData.UserRoleAcronim);

        subRoleTemp := SimManager.SimSubRole.getSubRoleByID(userRoleTemp.FData.SubRoleIndex);
        li.SubItems.Add(subRoleTemp.FData.SubRoleAcronim);
      end
      else
      begin
        li.SubItems.Add('');
        li.SubItems.Add('');
      end;
    end;
    li.Data := consoleInfoTemp;
  end;
end;

procedure TfrmMainGameServer.UpdateEventBuffer;
  function  formatTrail(Value : integer) : string;
  var
    I : integer;
    si,t : string;
  begin
    t := IntToStr(Value);
    si := '';
    for I := 0 to (4 - Length(t)) - 1 do
      si := si +'0';
    result := si + t;
  end;
var
  i, id : integer;
  pid: ^TPacketID;
  pBuff : PAnsiChar;
  pSize : word;
begin
//  mmEvents.Clear;

  for i := 0 to VNetServer.PacketBuffer.BuffCount - 1 do begin
    if VNetServer.PacketBuffer.PeekPacket(i, pBuff, pSize) then
    begin
      pid := @pBuff^;
      id := pid^.recID;

      if (id = 31) or (id = 32) then
        continue;
    end;
  end;

end;

procedure TfrmMainGameServer.UpdateGameState(Sender: TObject);
begin
  if SimManager.GetGameState then
  begin
    lblAppState.Caption := 'Running';
  end
  else
  begin
    lblAppState.Caption := 'Lock';
  end;
end;

end.

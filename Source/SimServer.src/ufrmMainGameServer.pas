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
    lvConsoleNTWO: TListView;
    lvConsoleATWO: TListView;
    lvConsoleALWO: TListView;
    lvConsoleCDWO: TListView;
    lvConsoleLFWO: TListView;
    lvConsoleSUWO: TListView;
    pnlPilihan: TPanel;
    pnlINWO: TPanel;
    pnlNTWO: TPanel;
    pnlATWO: TPanel;
    pnlALWO: TPanel;
    pnlCDWO: TPanel;
    pnlLFWO: TPanel;
    pnlSUWO: TPanel;
    procedure btnLockClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnUnlockClick(Sender: TObject);
    procedure PilihanClick(Sender: TObject);


  private

  public
//    procedure UpdateClientStateServerLastOn;
    function  GetTargetListView(const AConsoleName: string): TListView;
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

function TfrmMainGameServer.GetTargetListView(const AConsoleName: string): TListView;
var
  upperName: string;
begin
  Result := nil;
  upperName := UpperCase(Trim(AConsoleName));

  if Pos('INWO', upperName) > 0 then
    Result := lvConsole
  else if Pos('NTWO', upperName) > 0 then
    Result := lvConsoleNTWO
  else if Pos('ATWO', upperName) > 0 then
    Result := lvConsoleATWO
  else if Pos('ALWO', upperName) > 0 then
    Result := lvConsoleALWO
  else if Pos('CDWO', upperName) > 0 then
    Result := lvConsoleCDWO
  else if Pos('LFWO', upperName) > 0 then
    Result := lvConsoleLFWO
  else if Pos('SUWO', upperName) > 0 then
    Result := lvConsoleSUWO;
end;

procedure TfrmMainGameServer.PilihanClick(Sender: TObject);
var
  PanelTag: integer;
  Panel: Tpanel;
begin
  panel := Sender as Tpanel;
  PanelTag := panel.Tag;

  if panel = pnlINWO then
  begin
    if PanelTag = 0 then
    begin
      pnlINWO.Color := RGB(23, 45, 54);
      lvConsole.BringToFront;

      pnlINWO.Tag := 1;
      pnlNTWO.Tag := 0;
      pnlATWO.Tag := 0;
      pnlALWO.Tag := 0;
      pnlCDWO.Tag := 0;
      pnlLFWO.Tag := 0;
      pnlSUWO.Tag := 0;

      pnlNTWO.Color := RGB(10, 19, 23);
      pnlATWO.Color := RGB(10, 19, 23);
      pnlALWO.Color := RGB(10, 19, 23);
      pnlCDWO.Color := RGB(10, 19, 23);
      pnlLFWO.Color := RGB(10, 19, 23);
      pnlSUWO.Color := RGB(10, 19, 23);
    end;
  end

  else if panel = pnlNTWO then
  begin
    if PanelTag = 0 then
    begin
      pnlNTWO.Color := RGB(23, 45, 54);
      lvConsoleNTWO.BringToFront;

      pnlNTWO.Tag := 1;
      pnlINWO.Tag := 0;
      pnlATWO.Tag := 0;
      pnlALWO.Tag := 0;
      pnlCDWO.Tag := 0;
      pnlLFWO.Tag := 0;
      pnlSUWO.Tag := 0;

      pnlINWO.Color := RGB(10, 19, 23);
      pnlATWO.Color := RGB(10, 19, 23);
      pnlALWO.Color := RGB(10, 19, 23);
      pnlCDWO.Color := RGB(10, 19, 23);
      pnlLFWO.Color := RGB(10, 19, 23);
      pnlSUWO.Color := RGB(10, 19, 23);
    end;
  end

  else if panel = pnlATWO then
  begin
    if PanelTag = 0 then
    begin
      pnlATWO.Color := RGB(23, 45, 54);
      lvConsoleATWO.BringToFront;

      pnlATWO.Tag := 1;
      pnlINWO.Tag := 0;
      pnlNTWO.Tag := 0;
      pnlALWO.Tag := 0;
      pnlCDWO.Tag := 0;
      pnlLFWO.Tag := 0;
      pnlSUWO.Tag := 0;

      pnlINWO.Color := RGB(10, 19, 23);
      pnlNTWO.Color := RGB(10, 19, 23);
      pnlALWO.Color := RGB(10, 19, 23);
      pnlCDWO.Color := RGB(10, 19, 23);
      pnlLFWO.Color := RGB(10, 19, 23);
      pnlSUWO.Color := RGB(10, 19, 23);
    end;
  end

  else if panel = pnlALWO then
  begin
    if PanelTag = 0 then
    begin
      pnlALWO.Color := RGB(23, 45, 54);
      lvConsoleALWO.BringToFront;

      pnlALWO.Tag := 1;
      pnlINWO.Tag := 0;
      pnlNTWO.Tag := 0;
      pnlATWO.Tag := 0;
      pnlCDWO.Tag := 0;
      pnlLFWO.Tag := 0;
      pnlSUWO.Tag := 0;

      pnlINWO.Color := RGB(10, 19, 23);
      pnlNTWO.Color := RGB(10, 19, 23);
      pnlATWO.Color := RGB(10, 19, 23);
      pnlCDWO.Color := RGB(10, 19, 23);
      pnlLFWO.Color := RGB(10, 19, 23);
      pnlSUWO.Color := RGB(10, 19, 23);
    end;
  end

  else if panel = pnlCDWO then
  begin
    if PanelTag = 0 then
    begin
      pnlCDWO.Color := RGB(23, 45, 54);
      lvConsoleCDWO.BringToFront;

      pnlCDWO.Tag := 1;
      pnlINWO.Tag := 0;
      pnlNTWO.Tag := 0;
      pnlATWO.Tag := 0;
      pnlALWO.Tag := 0;
      pnlLFWO.Tag := 0;
      pnlSUWO.Tag := 0;

      pnlINWO.Color := RGB(10, 19, 23);
      pnlNTWO.Color := RGB(10, 19, 23);
      pnlATWO.Color := RGB(10, 19, 23);
      pnlALWO.Color := RGB(10, 19, 23);
      pnlLFWO.Color := RGB(10, 19, 23);
      pnlSUWO.Color := RGB(10, 19, 23);
    end;
  end

  else if panel = pnlLFWO then
  begin
    if PanelTag = 0 then
    begin
      pnlLFWO.Color := RGB(23, 45, 54);
      lvConsoleLFWO.BringToFront;

      pnlLFWO.Tag := 1;
      pnlINWO.Tag := 0;
      pnlNTWO.Tag := 0;
      pnlATWO.Tag := 0;
      pnlALWO.Tag := 0;
      pnlCDWO.Tag := 0;
      pnlSUWO.Tag := 0;

      pnlINWO.Color := RGB(10, 19, 23);
      pnlNTWO.Color := RGB(10, 19, 23);
      pnlATWO.Color := RGB(10, 19, 23);
      pnlALWO.Color := RGB(10, 19, 23);
      pnlCDWO.Color := RGB(10, 19, 23);
      pnlSUWO.Color := RGB(10, 19, 23);
    end;
  end

  else if panel = pnlSUWO then
  begin
    if PanelTag = 0 then
    begin
      pnlSUWO.Color := RGB(23, 45, 54);
      lvConsoleSUWO.BringToFront;

      pnlSUWO.Tag := 1;
      pnlINWO.Tag := 0;
      pnlNTWO.Tag := 0;
      pnlATWO.Tag := 0;
      pnlALWO.Tag := 0;
      pnlCDWO.Tag := 0;
      pnlLFWO.Tag := 0;

      pnlINWO.Color := RGB(10, 19, 23);
      pnlNTWO.Color := RGB(10, 19, 23);
      pnlATWO.Color := RGB(10, 19, 23);
      pnlALWO.Color := RGB(10, 19, 23);
      pnlCDWO.Color := RGB(10, 19, 23);
      pnlLFWO.Color := RGB(10, 19, 23);
    end;
  end;
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

  targetLV : TListView;
begin
  lvConsole.Items.Clear;
  lvConsoleNTWO.Items.Clear;
  lvConsoleATWO.Items.Clear;
  lvConsoleALWO.Items.Clear;
  lvConsoleCDWO.Items.Clear;
  lvConsoleLFWO.Items.Clear;
  lvConsoleSUWO.Items.Clear;

  lvConsole.SortType := stText;
  lvConsoleNTWO.SortType := stText;
  lvConsoleATWO.SortType := stText;
  lvConsoleALWO.SortType := stText;
  lvConsoleCDWO.SortType := stText;
  lvConsoleLFWO.SortType := stText;
  lvConsoleSUWO.SortType := stText;

  for i := 0 to simMgrServer.SimConsole.ConsoleList.Count-1 do
  begin
    consoleInfoTemp := TConsoleInfo(simMgrServer.SimConsole.ConsoleList.Objects[i]);
    targetLV := GetTargetListView(consoleInfoTemp.ConsoleName);

    if not Assigned(targetLV) then Continue;
    li := targetLV.Items.Add;
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

unit ufrmMainGameServer;

interface

uses
  Windows, Messages, SysUtils, System.IOUtils, Winapi.ShellAPI, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, OleCtrls, MapXLib_TLB, ExtCtrls, ComCtrls,
  uLibSetting, System.ImageList, Vcl.ImgList, uRecordData, uClassData,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage{, ShellApi} ;

type

  TfrmMainGameServer = class(TForm)
    lvConsole: TListView;
    ilClientStateColor: TImageList;
    Timer1: TTimer;
    lvConsoleNTWO: TListView;
    lvConsoleATWO: TListView;
    lvConsoleALWO: TListView;
    lvConsoleCDWO: TListView;
    lvConsoleLFWO: TListView;
    lvConsoleSUWO: TListView;
    pnlPilihan: TPanel;
    imgMainBackground: TImage;
    img1: TImage;
    Label5: TLabel;
    Label3: TLabel;
    lblSession: TLabel;
    Image1: TImage;
    btnLock: TImage;
    btnUnlock: TImage;
    Label4: TLabel;
    Label6: TLabel;
    lblAppState: TLabel;
    lbl: TLabel;
    Label1: TLabel;
    lblTime: TLabel;
    Image2: TImage;
    Image3: TImage;
    Label2: TLabel;
    Label7: TLabel;
    lblGameTime: TLabel;
    imgINWO: TImage;
    imgATWO: TImage;
    imgNTWO: TImage;
    imgALWO: TImage;
    imgCDWO: TImage;
    imgLFWO: TImage;
    imgSUWO: TImage;
    imgClose: TImage;
    imgMiniMaze: TImage;
    Image4: TImage;
    procedure btnLockClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnUnlockClick(Sender: TObject);
    procedure lvConsoleCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure imgCloseClick(Sender: TObject);
    procedure imgINWOClick(Sender: TObject);
    procedure imgATWOClick(Sender: TObject);
    procedure imgNTWOClick(Sender: TObject);
    procedure imgALWOClick(Sender: TObject);
    procedure imgCDWOClick(Sender: TObject);
    procedure imgLFWOClick(Sender: TObject);
    procedure imgSUWOClick(Sender: TObject);
    procedure imgMiniMazeClick(Sender: TObject);


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

procedure TfrmMainGameServer.imgALWOClick(Sender: TObject);
begin
  if Sender = imgALWO then
  begin
    imgALWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\alwo2.bmp');
  end;
  try
    imgINWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\inwo.bmp');
    imgATWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\atwo.bmp');
    imgNTWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\ntwo.bmp');
    imgCDWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\cdwo.bmp');
    imgLFWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\lfwo.bmp');
    imgSUWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\suwo.bmp');
    lvConsoleALWO.BringToFront;
  finally

  end;
end;

procedure TfrmMainGameServer.imgATWOClick(Sender: TObject);
begin
  if Sender = imgATWO then
  begin
    imgATWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\atwo2.bmp');
  end;
  try
    imgINWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\inwo.bmp');
    imgNTWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\ntwo.bmp');
    imgALWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\alwo.bmp');
    imgCDWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\cdwo.bmp');
    imgLFWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\lfwo.bmp');
    imgSUWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\suwo.bmp');
    lvConsoleATWO.BringToFront;
  finally

  end;
end;

procedure TfrmMainGameServer.imgCDWOClick(Sender: TObject);
begin
  if Sender = imgCDWO then
  begin
    imgCDWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\cdwo2.bmp');
  end;
  try
    imgINWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\inwo.bmp');
    imgATWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\atwo.bmp');
    imgNTWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\ntwo.bmp');
    imgALWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\alwo.bmp');
    imgLFWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\lfwo.bmp');
    imgSUWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\suwo.bmp');
    lvConsoleCDWO.BringToFront;
  finally

  end;
end;

procedure TfrmMainGameServer.imgCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMainGameServer.imgINWOClick(Sender: TObject);
begin
  if Sender = imgInwo then
  begin
    imgInwo.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\inwo2.bmp');
  end;
  try
    imgATWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\atwo.bmp');
    imgNTWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\ntwo.bmp');
    imgALWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\alwo.bmp');
    imgCDWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\cdwo.bmp');
    imgLFWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\lfwo.bmp');
    imgSUWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\suwo.bmp');
    lvConsole.BringToFront;
  finally

  end;
end;

procedure TfrmMainGameServer.imgLFWOClick(Sender: TObject);
begin
  if Sender = imgLFWO then
  begin
    imgLFWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\lfwo2.bmp');
  end;
  try
    imgINWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\inwo.bmp');
    imgATWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\atwo.bmp');
    imgNTWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\ntwo.bmp');
    imgALWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\alwo.bmp');
    imgCDWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\cdwo.bmp');
    imgSUWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\suwo.bmp');
    lvConsoleLFWO.BringToFront;
  finally

  end;
end;

procedure TfrmMainGameServer.imgMiniMazeClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfrmMainGameServer.imgNTWOClick(Sender: TObject);
begin
  if Sender = imgNTWO then
  begin
    imgNTWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\ntwo2.bmp');
  end;
  try
    imgINWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\inwo.bmp');
    imgATWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\atwo.bmp');
    imgALWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\alwo.bmp');
    imgCDWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\cdwo.bmp');
    imgLFWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\lfwo.bmp');
    imgSUWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\suwo.bmp');
    lvConsoleNTWO.BringToFront;
  finally

  end;
end;

procedure TfrmMainGameServer.imgSUWOClick(Sender: TObject);
begin
  if Sender = imgSUWO then
  begin
    imgSUWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\suwo2.bmp');
  end;
  try
    imgINWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\inwo.bmp');
    imgATWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\atwo.bmp');
    imgNTWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\ntwo.bmp');
    imgALWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\alwo.bmp');
    imgCDWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\cdwo.bmp');
    imgLFWO.Picture.LoadFromFile('data\Image Session Server\sesion_server (1)\lfwo.bmp');
    lvConsoleSUWO.BringToFront;
  finally

  end;
end;

procedure TfrmMainGameServer.lvConsoleCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := RGB(1, 12, 30)   // Baris Genap
  else
    Sender.Canvas.Brush.Color := RGB(18, 32, 50);
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
    lblAppState.Font.Color   := clLime;
  end
  else
  begin
    lblAppState.Caption := 'Lock';
    lblAppState.Font.Color   := clRed;
  end;
end;

end.

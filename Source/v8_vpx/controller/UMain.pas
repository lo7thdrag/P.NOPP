unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls,

  System.Hash,

  USettings,

  OverbyteIcsWSocketS,

  UNetLinkServer,
  UDataType,
  UPacketHelper,
  
  UCommands, Vcl.Imaging.pngimage;

const
  WM_APP_STARTUP = WM_USER + 1;
  WM_APP_SHUTDOWN = WM_USER + 2;
  WM_GET_PACKET = WM_USER + 3;

type
  TGroupClient = (gcNone, gcMOC, gcMON);

  TConnectedClientData = class
  public
    Line: TConnectedClient;
    isValid: Boolean;
    MediaPort: Integer;
    isViewerConnectedToCaster: Boolean;
    ID: Integer;
    Role: string;
    Group: TGroupClient;
  end;

  TFrmMain = class(TForm)
    PnlTop: TPanel;
    LbCaster: TListBox;
    MmoLog: TMemo;
    LbViewer: TListBox;
    PnlContent: TPanel;
    tmrGetPacket: TTimer;
    cbViewer: TComboBox;
    cbCaster: TComboBox;
    LblViewer: TLabel;
    LblCaster: TLabel;
    tmrShutdown: TTimer;
    pnlDisplay3: TPanel;
    pnlDisplay4: TPanel;
    lblDisplay3: TLabel;
    lblDisplay4: TLabel;
    gbDisplay3: TGroupBox;
    gbDIsplay4: TGroupBox;
    pnlContentRight: TPanel;
    shpDisplayConnected3: TShape;
    shpDisplayConnected4: TShape;
    lblDisplayConnected3: TLabel;
    lblDisplayConnected4: TLabel;
    cbCasterDisplay3: TComboBox;
    cbCasterDisplay4: TComboBox;
    btnShowDisplay3: TButton;
    btnStopDisplay3: TButton;
    btnShowDisplay4: TButton;
    btnStopDisplay4: TButton;
    btnRestartDisplay4: TButton;
    btnRestartDisplay3: TButton;
    imgSituationBoard1: TImage;
    imgSituationBoard2: TImage;
    grpDisplay1: TGroupBox;
    shpDisplayConnected1: TShape;
    lblDisplayConnected1: TLabel;
    cbCasterDisplay1: TComboBox;
    btnShowDisplay1: TButton;
    btnStopDisplay1: TButton;
    btnRestartDisplay1: TButton;
    grpDisplay2: TGroupBox;
    shpDisplayConnected2: TShape;
    lblDisplayConnected2: TLabel;
    cbCasterDisplay2: TComboBox;
    btnShowDisplay2: TButton;
    btnStopDisplay2: TButton;
    btnRestartDisplay2: TButton;
    pnlDisplay1: TPanel;
    lblDisplay1: TLabel;
    pnlDisplay2: TPanel;
    lblDisplay2: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrGetPacketTimer(Sender: TObject);
    procedure cbCasterChange(Sender: TObject);
    procedure tmrShutdownTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnShowDisplay1Click(Sender: TObject);
    procedure btnStopDisplay1Click(Sender: TObject);
    procedure btnShowDisplay2Click(Sender: TObject);
    procedure btnStopDisplay2Click(Sender: TObject);
    procedure btnShowDisplay3Click(Sender: TObject);
    procedure btnStopDisplay3Click(Sender: TObject);
    procedure btnShowDisplay4Click(Sender: TObject);
    procedure btnStopDisplay4Click(Sender: TObject);
    procedure btnRestartDisplay4Click(Sender: TObject);
    procedure btnRestartDisplay1Click(Sender: TObject);
    procedure btnRestartDisplay2Click(Sender: TObject);
    procedure btnRestartDisplay3Click(Sender: TObject);
  private
    { Private declarations }
    IsClose: Boolean;
    AppSetting: TControllerSetting;
    ConnectedClients: TStringList;

    Server: TNetLinkServer;
    
    procedure Log(AMessage: string);

    procedure Handle_WM_APP_STARTUP(var Msg: TMessage); message WM_APP_STARTUP;
    procedure Handle_WM_APP_SHUTDOWN(var Msg: TMessage); message WM_APP_SHUTDOWN;
    procedure Handle_WM_GET_PACKET(var Msg: TMessage); message WM_GET_PACKET;

    procedure OnClientConnect(const AClient: TConnectedClient; const S: string);
    procedure OnClientDisconnect(const AClient: TConnectedClient; const S: string);

    procedure OnLogReceived(const S: string);

    procedure NetHandle_CMD_MOC_CON_WHOIAM(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandle_CMD_MON_CON_WHOIAM(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandle_CMD_MOC_CON_INFO_PORT(AHeader: TPacketInfo; AContent: TBytes);
    procedure NetHandle_CMD_MON_CON_CAST_STATUS(AHeader: TPacketInfo; AContent: TBytes);

    procedure AssignConsoleToDisplay(DisplayID: Integer; isShow: Boolean);
    procedure RestartDisplay(DisplayID: Integer);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.AssignConsoleToDisplay(DisplayID: Integer; isShow: Boolean);
var
  i, idx, idxCaster: Integer;
  FoundClientData, ClientData, ClientDataCaster, ClientDataViewer: TConnectedClientData;
  s: string;
  ABytes: TBytes;
begin
  ClientDataViewer:= nil;

  idx:= -1;
  FoundClientData:= nil;
  for i := 0 to ConnectedClients.Count-1 do
  begin
    ClientData := TConnectedClientData(ConnectedClients.Objects[i]);
    if (ClientData.Group=gcMON) and (ClientData.ID=DisplayID) then
    begin
      idx:= i;
      FoundClientData:= ClientData;
      Break;
    end;
  end;

  if idx>-1 then
    ClientDataViewer:= FoundClientData;

  ClientDataCaster:= nil;
  case DisplayID of
    1:
      begin
        idxCaster:= cbCasterDisplay1.ItemIndex;
        if idxCaster>0 then
          ClientDataCaster:= TConnectedClientData(cbCasterDisplay1.Items.Objects[idxCaster]);
      end;
    2:
      begin
        idxCaster:= cbCasterDisplay2.ItemIndex;
        if idxCaster>0 then
          ClientDataCaster:= TConnectedClientData(cbCasterDisplay2.Items.Objects[idxCaster]);
      end;
    3:
      begin
        idxCaster:= cbCasterDisplay3.ItemIndex;
        if idxCaster>0 then
          ClientDataCaster:= TConnectedClientData(cbCasterDisplay3.Items.Objects[idxCaster]);
      end;
    4:
      begin
        idxCaster:= cbCasterDisplay4.ItemIndex;
        if idxCaster>0 then
          ClientDataCaster:= TConnectedClientData(cbCasterDisplay4.Items.Objects[idxCaster]);
      end;
  end;

  if Assigned(ClientDataViewer) then
  begin
    if Assigned(ClientDataCaster) then
      if isShow and not ClientDataViewer.isViewerConnectedToCaster then
      begin
        s:= 'CONNECT'+';'+ ClientDataCaster.Line.ConnectedIP+';'+ ClientDataCaster.MediaPort.ToString+';'+ ClientDataCaster.Role;
        ABytes:= TEncoding.UTF8.GetBytes(s);
        Log('Send CMD : CMD_CTRL_CONNECTION_MON_TO_MOC');
        Server.SendTBTo(ClientDataViewer.Line, CMD_CON_MON_CONNECTION_MON_TO_MOC, ABytes);
      end
      else
      begin
        s:= 'DISCONNECT';
        ABytes:= TEncoding.UTF8.GetBytes(s);
        Log('Send CMD : CMD_CTRL_CONNECTION_MON_TO_MOC');
        Server.SendTBTo(ClientDataViewer.Line, CMD_CON_MON_CONNECTION_MON_TO_MOC, ABytes);
      end;
  end;

end;

procedure TFrmMain.RestartDisplay(DisplayID: Integer);
var
  i, idx, idxCaster: Integer;
  FoundClientData, ClientData, ClientDataCaster, ClientDataViewer: TConnectedClientData;
  s: string;
  ABytes: TBytes;
begin
  ClientDataViewer:= nil;

  idx:= -1;
  FoundClientData:= nil;
  for i := 0 to ConnectedClients.Count-1 do
  begin
    ClientData := TConnectedClientData(ConnectedClients.Objects[i]);
    if (ClientData.Group=gcMON) and (ClientData.ID=DisplayID) then
    begin
      idx:= i;
      FoundClientData:= ClientData;
      Break;
    end;
  end;

  if idx>-1 then
    ClientDataViewer:= FoundClientData;

  if Assigned(ClientDataViewer) then
  begin
    s:= 'RESTART';
    ABytes:= TEncoding.UTF8.GetBytes(s);
    Log('Send CMD : CMD_CON_MON_RESTART');
    Server.SendTBTo(ClientDataViewer.Line, CMD_CON_MON_RESTART, ABytes);
  end;

end;

procedure TFrmMain.btnRestartDisplay1Click(Sender: TObject);
begin
  RestartDisplay(1);
end;

procedure TFrmMain.btnRestartDisplay2Click(Sender: TObject);
begin
  RestartDisplay(2);
end;

procedure TFrmMain.btnRestartDisplay3Click(Sender: TObject);
begin
  RestartDisplay(3);
end;

procedure TFrmMain.btnRestartDisplay4Click(Sender: TObject);
begin
  RestartDisplay(4);
end;

procedure TFrmMain.btnShowDisplay1Click(Sender: TObject);
begin
  AssignConsoleToDisplay(1, True);
end;

procedure TFrmMain.btnShowDisplay2Click(Sender: TObject);
begin
  AssignConsoleToDisplay(2, True);
end;

procedure TFrmMain.btnShowDisplay3Click(Sender: TObject);
begin
  AssignConsoleToDisplay(3, True);
end;

procedure TFrmMain.btnShowDisplay4Click(Sender: TObject);
begin
  AssignConsoleToDisplay(4, True);
end;

procedure TFrmMain.btnStopDisplay1Click(Sender: TObject);
begin
  AssignConsoleToDisplay(1, False);
end;

procedure TFrmMain.btnStopDisplay2Click(Sender: TObject);
begin
  AssignConsoleToDisplay(2, False);
end;

procedure TFrmMain.btnStopDisplay3Click(Sender: TObject);
begin
  AssignConsoleToDisplay(3, False);
end;

procedure TFrmMain.btnStopDisplay4Click(Sender: TObject);
begin
  AssignConsoleToDisplay(4, False);
end;

procedure TFrmMain.cbCasterChange(Sender: TObject);
//var
//  idxCaster, idxViewer: Integer;
//  ClientDataCaster, ClientDataViewer: TConnectedClientData;
//  s: string;
//  ABytes: TBytes;
begin
//  idxViewer:= cbViewer.ItemIndex;
//  idxCaster:= cbCaster.ItemIndex;
//
//  ClientDataViewer:= nil;
//  ClientDataCaster:= nil;
//  if idxViewer>0 then
//    ClientDataViewer:= TConnectedClientData(cbViewer.Items.Objects[idxViewer]);
//  if idxCaster>0 then
//    ClientDataCaster:= TConnectedClientData(cbCaster.Items.Objects[idxCaster]);
//
//  if Assigned(ClientDataViewer) then
//  begin
//    if Assigned(ClientDataCaster) then
//    begin
//      s:= 'CONNECT'+';'+
//        ClientDataCaster.Line.ConnectedIP+';'+
//        ClientDataCaster.MediaPort.ToString+';'+
//        ClientDataCaster.Role;
//      ABytes:= TEncoding.UTF8.GetBytes(s);
//      Log('Send CMD : CMD_CTRL_CONNECTION_MON_TO_MOC');
//      Server.SendTBTo(ClientDataViewer.Line, CMD_CON_MON_CONNECTION_MON_TO_MOC, ABytes);
//    end
//    else
//    begin
//      s:= 'DISCONNECT';
//      ABytes:= TEncoding.UTF8.GetBytes(s);
//      Log('Send CMD : CMD_CTRL_CONNECTION_MON_TO_MOC');
//      Server.SendTBTo(ClientDataViewer.Line, CMD_CON_MON_CONNECTION_MON_TO_MOC, ABytes);
//    end;
//  end;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TmrGetPacket.Enabled:= False;
  Server.UnregisterAllProcedure;
  Server.Stop;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not TmrShutdown.Enabled then
  begin
    TmrShutdown.Enabled:= True;
  end;
  CanClose:= IsClose;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  IsClose:= False;
  AppSetting:= TControllerSetting.Create;
  if not AppSetting.LoadFromFile('settings.json') then
  begin
    ShowMessage('Error Loading Setting');
    PostQuitMessage(1);
  end;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  i: Integer;
  AClientData: TConnectedClientData;
begin
  FreeAndNil(Server);

  for i := 0 to ConnectedClients.Count - 1 do
  begin
    AClientData:= TConnectedClientData(ConnectedClients.Objects[i]);
    FreeAndNil(AClientData);
  end;

  FreeAndNil(ConnectedClients);
  FreeAndNil(AppSetting);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  PostMessage(Handle, WM_APP_STARTUP, 0, 0);
end;

procedure TFrmMain.Log(AMessage: string);
begin
  MmoLog.Lines.Add(AMessage);
end;

procedure TFrmMain.Handle_WM_APP_STARTUP(var Msg: TMessage);
var
  i: Integer;
begin
  Log('[App Setting]');
  Log('Port : ' + AppSetting.Port.ToString);
  Log('Consoles :');
  for i := 0 to AppSetting.Consoles.Count-1 do
    Log(' ' + (i+1).ToString + ' - ' + AppSetting.Consoles[i]);
  Log('');

  cbCaster.Sorted:= True;
  cbCaster.AddItem('- No Selection -', nil);
  cbCaster.ItemIndex:= 0;

  cbCasterDisplay1.Sorted:= True;
  cbCasterDisplay1.AddItem('- No Selection -', nil);
  cbCasterDisplay1.ItemIndex:= 0;
  cbCasterDisplay2.Sorted:= True;
  cbCasterDisplay2.AddItem('- No Selection -', nil);
  cbCasterDisplay2.ItemIndex:= 0;
  cbCasterDisplay3.Sorted:= True;
  cbCasterDisplay3.AddItem('- No Selection -', nil);
  cbCasterDisplay3.ItemIndex:= 0;
  cbCasterDisplay4.Sorted:= True;
  cbCasterDisplay4.AddItem('- No Selection -', nil);
  cbCasterDisplay4.ItemIndex:= 0;

  cbViewer.Sorted:= True;
  cbViewer.AddItem('- No Selection -', nil);
  cbViewer.ItemIndex:= 0;

  cbCasterDisplay1.Enabled:= False;
  cbCasterDisplay2.Enabled:= False;
  cbCasterDisplay3.Enabled:= False;
  cbCasterDisplay4.Enabled:= False;

  btnShowDisplay1.Enabled:= False;
  btnShowDisplay2.Enabled:= False;
  btnShowDisplay3.Enabled:= False;
  btnShowDisplay4.Enabled:= False;

  btnStopDisplay1.Enabled:= False;
  btnStopDisplay2.Enabled:= False;
  btnStopDisplay3.Enabled:= False;
  btnStopDisplay4.Enabled:= False;

  btnRestartDisplay1.Enabled:= False;
  btnRestartDisplay2.Enabled:= False;
  btnRestartDisplay3.Enabled:= False;
  btnRestartDisplay4.Enabled:= False;

  ConnectedClients := TStringList.Create;
  ConnectedClients.Sorted := True;
  ConnectedClients.Duplicates := dupError;
  ConnectedClients.CaseSensitive := False;
  ConnectedClients.OwnsObjects:= False;

  Server:= TNetLinkServer.Create;
  Server.OnClient_Connect:= OnClientConnect;
  Server.OnClient_DisConnect:= OnClientDisconnect;

  Server.OnStatusLog:= OnLogReceived;
  Server.OnSendLog:= OnLogReceived;
  Server.OnRecvLog:= OnLogReceived;

  Server.RegisterProcedure(CMD_CON_ALL_WHOAREYOU, nil);
  Server.RegisterProcedure(CMD_MOC_CON_WHOIAM, NetHandle_CMD_MOC_CON_WHOIAM);
  Server.RegisterProcedure(CMD_MON_CON_WHOIAM, NetHandle_CMD_MON_CON_WHOIAM);

  Server.RegisterProcedure(CMD_CON_MOC_GET_INFO_PORT, nil);
  Server.RegisterProcedure(CMD_MOC_CON_INFO_PORT, NetHandle_CMD_MOC_CON_INFO_PORT);

  Server.RegisterProcedure(CMD_CON_MON_CONNECTION_MON_TO_MOC, nil);
  Server.RegisterProcedure(CMD_MON_CON_CAST_STATUS, NetHandle_CMD_MON_CON_CAST_STATUS);

  Server.Listen(AppSetting.Port.ToString);

  TmrGetPacket.Interval:= 1000 div 30;
  TmrGetPacket.Enabled:= True;

  TmrShutdown.Enabled:= False;
  TmrShutdown.Interval:= 1000 div 10;
end;

procedure TFrmMain.Handle_WM_APP_SHUTDOWN(var Msg: TMessage);
var
  AClient: TWSocketClient;
begin
  if Server.ClientCount > 0 then
  begin
    AClient:= Server.Clients[0];
    if Assigned(AClient) then
      Server.DisconnectClient(AClient);
  end
  else
  if Server.ClientCount=0 then
  begin
    tmrShutdown.Enabled:= False;
    IsClose:= True;
    Close
  end;
end;

procedure TFrmMain.Handle_WM_GET_PACKET(var Msg: TMessage);
begin
  Server.GetPacket;
end;

procedure TFrmMain.tmrGetPacketTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_GET_PACKET, 0, 0);
end;

procedure TFrmMain.tmrShutdownTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_APP_SHUTDOWN, 0, 0);
end;

// =============================================================================

procedure TFrmMain.OnClientConnect(const AClient: TConnectedClient;
  const S: string);
var
  AClientData: TConnectedClientData;
  AHash: string;
begin
  Log('A Client Connected. (' + AClient.ConnectedIP + ':' + AClient.ConnectedPort + ')');
  Log('List Length : '+ ConnectedClients.Count.ToString);

  AClientData := TConnectedClientData.Create;
  AClientData.Line := AClient;
  AClientData.isValid:= False;
  AClientData.ID:= -1;
  AClientData.Group:= gcNone;
//  AClientData.Image := nil;
  try
    AHash:= THashSHA2.GetHashString(AClient.ConnectedIP+':'+AClient.ConnectedPort, SHA512);
    ConnectedClients.AddObject(AHash, AClientData);
  except
    //Client.Image.Free;
    FreeAndNil(AClientData);
    raise Exception.Create('Duplicate Hash');
  end;

  Log('List Length : '+ ConnectedClients.Count.ToString);
  Log('');

  Log('Send CMD : CMD_CON_ALL_WHOAREYOU');
  Server.SendTBTo(AClient, CMD_CON_ALL_WHOAREYOU, nil);
end;

procedure TFrmMain.OnClientDisconnect(const AClient: TConnectedClient;
  const S: string);
var
  i: Integer;
  idx: Integer;
  ClientData: TConnectedClientData;
  AClientData: TConnectedClientData;
begin
  Log(AClient.ConnectedIP + ':' + AClient.ConnectedPort + ' Client disconnected');
  Log('List Length : '+ConnectedClients.Count.ToString);

  ClientData:= nil;
  for i := 0 to ConnectedClients.Count - 1 do
  begin
    ClientData := TConnectedClientData(ConnectedClients.Objects[i]);
    if ClientData.Line = AClient then
    begin
//      FreeAndNil(ClientData);
      ConnectedClients.Delete(i);
      Break;
    end;
  end;

  if Assigned(ClientData) then
  begin
    if ClientData.Group=gcMOC then
    begin
      for idx := 0 to lbCaster.Count-1 do
      begin
        AClientData:= TConnectedClientData(lbCaster.Items.Objects[idx]);

        if (AClientData.Line=ClientData.Line) and (AClientData.ID=ClientData.ID) then
        begin
          lbCaster.Items.Delete(idx);
          Break
        end;
      end;

      for idx := 1 to cbCaster.Items.Count-1 do
      begin
        AClientData:= TConnectedClientData(cbCaster.Items.Objects[idx]);
        if (AClientData.Line=ClientData.Line) and
          (AClientData.ID=ClientData.ID)
        then
        begin
          cbCaster.Items.Delete(idx);
          Break
        end
      end;

      for idx := 1 to cbCasterDisplay1.Items.Count-1 do
      begin
        AClientData:= TConnectedClientData(cbCasterDisplay1.Items.Objects[idx]);
        if (AClientData.Line=ClientData.Line) and
          (AClientData.ID=ClientData.ID)
        then
        begin
          cbCasterDisplay1.Items.Delete(idx);
          Break
        end
      end;

      for idx := 1 to cbCasterDisplay2.Items.Count-1 do
      begin
        AClientData:= TConnectedClientData(cbCasterDisplay2.Items.Objects[idx]);
        if (AClientData.Line=ClientData.Line) and
          (AClientData.ID=ClientData.ID)
        then
        begin
          cbCasterDisplay2.Items.Delete(idx);
          Break
        end
      end;

      for idx := 1 to cbCasterDisplay3.Items.Count-1 do
      begin
        AClientData:= TConnectedClientData(cbCasterDisplay3.Items.Objects[idx]);
        if (AClientData.Line=ClientData.Line) and
          (AClientData.ID=ClientData.ID)
        then
        begin
          cbCasterDisplay3.Items.Delete(idx);
          Break
        end
      end;

      for idx := 1 to cbCasterDisplay4.Items.Count-1 do
      begin
        AClientData:= TConnectedClientData(cbCasterDisplay4.Items.Objects[idx]);
        if (AClientData.Line=ClientData.Line) and
          (AClientData.ID=ClientData.ID)
        then
        begin
          cbCasterDisplay4.Items.Delete(idx);
          Break
        end
      end;

      if cbCaster.Items.Count=1 then
      begin
        cbCaster.ItemIndex:= 0;
        //cbCaster.Text:= #0;
        cbCaster.Invalidate;
      end;

      if cbCasterDisplay1.Items.Count=1 then
      begin
        cbCasterDisplay1.ItemIndex:= 0;
        //cbCaster.Text:= #0;
        cbCasterDisplay1.Invalidate;
      end;

      if cbCasterDisplay2.Items.Count=1 then
      begin
        cbCasterDisplay2.ItemIndex:= 0;
        //cbCaster.Text:= #0;
        cbCasterDisplay2.Invalidate;
      end;

      if cbCasterDisplay3.Items.Count=1 then
      begin
        cbCasterDisplay3.ItemIndex:= 0;
        //cbCaster.Text:= #0;
        cbCasterDisplay3.Invalidate;
      end;

      if cbCasterDisplay4.Items.Count=1 then
      begin
        cbCasterDisplay4.ItemIndex:= 0;
        //cbCaster.Text:= #0;
        cbCasterDisplay4.Invalidate;
      end;
    end
    else
    if ClientData.Group=gcMON then
    begin
      for idx := 0 to LbViewer.Count-1 do
      begin
        AClientData:= TConnectedClientData(LbViewer.Items.Objects[idx]);
        if (AClientData.Line=ClientData.Line) and
          (AClientData.ID=ClientData.ID)
        then
        begin
          LbViewer.Items.Delete(idx);
          Break
        end;
      end;

      for idx := 1 to cbViewer.Items.Count-1 do
      begin
        AClientData:= TConnectedClientData(cbViewer.Items.Objects[idx]);
        if (AClientData.Line=ClientData.Line) and
          (AClientData.ID=ClientData.ID)
        then
        begin
          cbViewer.Items.Delete(idx);
          Break
        end
      end;

      case AClientData.ID of
      1: begin
         cbCasterDisplay1.Enabled:= False;
         shpDisplayConnected1.Brush.Color:= clMaroon;
         imgSituationBoard1.Picture.LoadFromFile('Image\offline.png');
         btnShowDisplay1.Enabled:= False;
         btnStopDisplay1.Enabled:= False;
         btnRestartDisplay1.Enabled:= False;
      end;
      2: begin
         cbCasterDisplay2.Enabled:= False;
         shpDisplayConnected2.Brush.Color:= clMaroon;
         imgSituationBoard2.Picture.LoadFromFile('Image\offline.png');
         btnShowDisplay2.Enabled:= False;
         btnStopDisplay2.Enabled:= False;
         btnRestartDisplay2.Enabled:= False;
      end;
      3: begin
         cbCasterDisplay3.Enabled:= False;
         shpDisplayConnected3.Brush.Color:= clMaroon;
         btnShowDisplay3.Enabled:= False;
         btnStopDisplay3.Enabled:= False;
         btnRestartDisplay3.Enabled:= False;
      end;
      4: begin
         cbCasterDisplay4.Enabled:= False;
         shpDisplayConnected4.Brush.Color:= clMaroon;
         btnShowDisplay4.Enabled:= False;
         btnStopDisplay4.Enabled:= False;
         btnRestartDisplay4.Enabled:= False;
      end;
    end;

      if cbViewer.Items.Count=1 then
      begin
        cbViewer.ItemIndex:= 0;
        //cbCaster.Text:= #0;
        cbViewer.Invalidate;
      end;
    end;
    FreeAndNil(ClientData);
  end;

  Log('List Length : '+ConnectedClients.Count.ToString);
  Log('');
end;

procedure TFrmMain.OnLogReceived(const S: string);
begin
  MmoLog.Lines.Add(S);
end;

procedure TFrmMain.NetHandle_CMD_MOC_CON_WHOIAM(AHeader: TPacketInfo; AContent: TBytes);
var
  i, idx: Integer;
  ClientData, FoundClientData: TConnectedClientData;
  s: string;
begin
  Log('CMD : CMD_MOC_CON_WHOIAM');

  idx:= -1;
  FoundClientData:= nil;
  for i := 0 to ConnectedClients.Count-1 do
  begin
    ClientData := TConnectedClientData(ConnectedClients.Objects[i]);
    if (ClientData.Line.ConnectedIP = LongIPToStr(AHeader.SenderAddress)) and
      (ClientData.Line.ConnectedPort = AHeader.SenderPort.ToString) then
    begin
      idx:= i;
      FoundClientData:= ClientData;
      Break;
    end;
  end;

  if idx>-1 then
  begin
    s:= TEncoding.UTF8.GetString(AContent);
    FoundClientData.isValid:= True;
    FoundClientData.ID:= StrToInt(s);
    FoundClientData.Role:= AppSetting.Consoles[FoundClientData.ID-1];
    FoundClientData.Group:= gcMOC;
//    lbCaster.AddItem('MOC-'+FoundClientData.ID.ToString, FoundClientData);
//    cbCaster.AddItem(FoundClientData.ID.ToString, FoundClientData);
    lbCaster.AddItem(FoundClientData.Role, FoundClientData);
    cbCaster.AddItem(FoundClientData.Role, FoundClientData);

    cbCasterDisplay1.AddItem(FoundClientData.Role, FoundClientData);
    cbCasterDisplay2.AddItem(FoundClientData.Role, FoundClientData);
    cbCasterDisplay3.AddItem(FoundClientData.Role, FoundClientData);
    cbCasterDisplay4.AddItem(FoundClientData.Role, FoundClientData);

    Log('Send CMD : CMD_CTRL_GET_INFO_PORT_MOC');
    Server.SendTBTo(FoundClientData.Line, CMD_CON_MOC_GET_INFO_PORT, nil);
  end;

end;

procedure TFrmMain.NetHandle_CMD_MON_CON_CAST_STATUS(AHeader: TPacketInfo;
  AContent: TBytes);
var
  i, idx: Integer;
  ClientData, FoundClientData: TConnectedClientData;
  s: string;
begin
  Log('CMD : NetHandle_CMD_MON_CON_CAST_STATUS');

  idx:= -1;
  FoundClientData:= nil;
  for i := 0 to ConnectedClients.Count-1 do
  begin
    ClientData := TConnectedClientData(ConnectedClients.Objects[i]);
    if (ClientData.Line.ConnectedIP = LongIPToStr(AHeader.SenderAddress)) and
      (ClientData.Line.ConnectedPort = AHeader.SenderPort.ToString) then
    begin
      idx:= i;
      FoundClientData:= ClientData;
      Break;
    end;
  end;

  if idx>-1 then
  begin
    s:= TEncoding.UTF8.GetString(AContent);

    if s='CONNECTED' then begin
      FoundClientData.isViewerConnectedToCaster:= True;
      case FoundClientData.ID of
        1: begin
          cbCasterDisplay1.Enabled:= False;
          btnShowDisplay1.Enabled:= False;
          btnStopDisplay1.Enabled:= True;
        end;
        2: begin
          cbCasterDisplay2.Enabled:= False;
          btnShowDisplay2.Enabled:= False;
          btnStopDisplay2.Enabled:= True;
        end;
        3: begin
          cbCasterDisplay3.Enabled:= False;
          btnShowDisplay3.Enabled:= False;
          btnStopDisplay3.Enabled:= True;
        end;
        4: begin
          cbCasterDisplay4.Enabled:= False;
          btnShowDisplay4.Enabled:= False;
          btnStopDisplay4.Enabled:= True;
        end;
      end;
//      ShowMessage('Monitor To Moc connected');
    end
    else if s='DISCONNECTED' then begin
      FoundClientData.isViewerConnectedToCaster:= False;
      case FoundClientData.ID of
        1: begin
          cbCasterDisplay1.Enabled:= True;
          btnShowDisplay1.Enabled:= True;
          btnStopDisplay1.Enabled:= False;
        end;
        2: begin
          cbCasterDisplay2.Enabled:= True;
          btnShowDisplay2.Enabled:= True;
          btnStopDisplay2.Enabled:= False;
        end;
        3: begin
          cbCasterDisplay3.Enabled:= True;
          btnShowDisplay3.Enabled:= True;
          btnStopDisplay3.Enabled:= False;
        end;
        4: begin
          cbCasterDisplay4.Enabled:= True;
          btnShowDisplay4.Enabled:= True;
          btnStopDisplay4.Enabled:= False;
        end;
      end;
//      ShowMessage('Monitor To Moc disconnected');
    end;
  end;
end;

procedure TFrmMain.NetHandle_CMD_MON_CON_WHOIAM(AHeader: TPacketInfo;
  AContent: TBytes);
var
  i, idx: Integer;
  ClientData, FoundClientData: TConnectedClientData;
  s: string;
begin
  Log('CMD : CMD_MON_CON_WHOIAM');

  idx:= -1;
  FoundClientData:= nil;
  for i := 0 to ConnectedClients.Count-1 do
  begin
    ClientData := TConnectedClientData(ConnectedClients.Objects[i]);
    if (ClientData.Line.ConnectedIP = LongIPToStr(AHeader.SenderAddress)) and
      (ClientData.Line.ConnectedPort = AHeader.SenderPort.ToString) then
    begin
      idx:= i;
      FoundClientData:= ClientData;
      Break;
    end;
  end;

  if idx>-1 then
  begin
    s:= TEncoding.UTF8.GetString(AContent);
    FoundClientData.isValid:= True;
    FoundClientData.ID:= StrToInt(s);
    FoundClientData.Group:= gcMON;
    LbViewer.AddItem('MON'+FoundClientData.ID.ToString, FoundClientData);
    cbViewer.AddItem(FoundClientData.ID.ToString, FoundClientData);

    case FoundClientData.ID of
      1: begin
         cbCasterDisplay1.Enabled:= True;
         shpDisplayConnected1.Brush.Color:= clLime;
         imgSituationBoard1.Picture.LoadFromFile('Image\running.png');
         btnShowDisplay1.Enabled:= True;
         btnStopDisplay1.Enabled:= False;
         btnRestartDisplay1.Enabled:= True;
      end;
      2: begin
         cbCasterDisplay2.Enabled:= True;
         shpDisplayConnected2.Brush.Color:= clLime;
         imgSituationBoard2.Picture.LoadFromFile('Image\running.png');
         btnShowDisplay2.Enabled:= True;
         btnStopDisplay2.Enabled:= False;
         btnRestartDisplay2.Enabled:= True;
      end;
      3: begin
         cbCasterDisplay3.Enabled:= True;
         shpDisplayConnected3.Brush.Color:= clLime;
         btnShowDisplay3.Enabled:= True;
         btnStopDisplay3.Enabled:= False;
         btnRestartDisplay3.Enabled:= True;
      end;
      4: begin
         cbCasterDisplay4.Enabled:= True;
         shpDisplayConnected4.Brush.Color:= clLime;
         btnShowDisplay4.Enabled:= True;
         btnStopDisplay4.Enabled:= False;
         btnRestartDisplay4.Enabled:= True;
      end;
    end;
  end;

end;

procedure TFrmMain.NetHandle_CMD_MOC_CON_INFO_PORT(AHeader: TPacketInfo;
  AContent: TBytes);
var
  i, idx: Integer;
  ClientData, FoundClientData: TConnectedClientData;
  s: string;
begin
  Log('CMD : NetHandle_CMD_MOC_CON_INFO_PORT');

  idx:= -1;
  FoundClientData:= nil;
  for i := 0 to ConnectedClients.Count-1 do
  begin
    ClientData := TConnectedClientData(ConnectedClients.Objects[i]);
    if (ClientData.Line.ConnectedIP = LongIPToStr(AHeader.SenderAddress)) and
      (ClientData.Line.ConnectedPort = AHeader.SenderPort.ToString) then
    begin
      idx:= i;
      FoundClientData:= ClientData;
      Break;
    end;
  end;

  if idx>-1 then
  begin
    s:= TEncoding.UTF8.GetString(AContent);
    FoundClientData.MediaPort:= StrToInt(s);
    Log('MOC-'+FoundClientData.ID.ToString+
      ' media port : '+FoundClientData.MediaPort.ToString);
  end;
end;

end.

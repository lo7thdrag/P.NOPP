unit ufrmTacticalDisplay;

interface

uses
  {Delphi Uses}
  Tlhelp32, ShellAPI, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ComCtrls, OleCtrls, Menus, ToolWin, ImgList, ActnMan, VrControls, VrAnalog, Keyboard, VrWheel,
  RzButton, jpeg, System.ImageList, Vcl.Imaging.pngimage, RzBmpBtn, Printers, Math,

  {Project Uses}
  uClassData, uRecordData, uConstantaData, uConsoleData,uBaseCoordSystem, uCoordConvertor, uLibSetting, uSimObjects,
  uSimMgr_Client, uT3SimManager, ufrmDisplayArea, ufrmSituationBoard, ufrmTelegram, ufrmToteDisplay ;

type

  TfrmTacticalDisplay = class(TForm)
    pnlMainLogin: TPanel;
    pnlLeft: TPanel;
    pnlLogin: TPanel;
    btnShowPassword: TImage;
    btnLogin: TButton;
    edtPassword: TEdit;
    edtUsername: TEdit;
    lblGameArea: TLabel;
    lblPlatform: TLabel;
    Label1: TLabel;
    imgLoginBackground: TImage;
    pnlBackgroundLogin: TPanel;
    imgBackgroundLogin: TImage;
    pnlSituationBoard: TPanel;
    Label3: TLabel;
    Image3: TImage;
    Label7: TLabel;
    btnShow: TButton;
    cbbConsoleName: TComboBox;
    pnlHome: TPanel;
    imgHome: TImage;
    btnPlanning: TRzBmpButton;
    btnPreparation: TRzBmpButton;
    btnImplementation: TRzBmpButton;
    btnTermination: TRzBmpButton;
    btnBack: TButton;
    lblConsoleName: TLabel;
    pnlButton: TPanel;
    cbbSubRole: TComboBox;
    lstUserRoleLogin: TListBox;
    btnLoad: TButton;
    btnConnect: TButton;
    pbLoadSystem: TProgressBar;
    tmrProgressbar: TTimer;
    tmrPBSituationBoard: TTimer;
    pnlCenter: TPanel;
    lblUserIdentifier: TLabel;
    Label5: TLabel;
    pnlLogo: TPanel;
    Image6: TImage;
    pbSituationBoard: TProgressBar;
    lblPb: TLabel;
    lblPbLoadSystem: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure btnShowPasswordClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure cbbConsoleNameDropDown(Sender: TObject);
    procedure btnPlanningClick(Sender: TObject);
    procedure btnPreparationClick(Sender: TObject);
    procedure btnImplementationClick(Sender: TObject);
    procedure btnTerminationClick(Sender: TObject);
    procedure cbbSubRoleSelect(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstUserRoleLoginDblClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure tmrProgressbarTimer(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure tmrPBSituationBoardTimer(Sender: TObject);

  private
//    FTimerbutton : Integer;
    FSelectedSubRole : TSubRole;
    FselectedUserRole : TUserRole;

    procedure AddCbbSubRole(tipeTahapan : Integer);
    procedure AddUserRoleLogin(SubRoleId : integer);

  public
    procedure Initialize;

    procedure UpdateGameState(Sender: TObject);
    procedure UpdateClientLogin(Sender: TObject);
    procedure UpdateClientLogout(Sender: TObject);

  end;

var
  frmTacticalDisplay: TfrmTacticalDisplay;

implementation

{$R *.dfm}

procedure EnableComposited(WinControl:TWinControl);
var
  i:Integer;
  NewExStyle:DWORD;
begin
  NewExStyle := GetWindowLong(WinControl.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED;
  SetWindowLong(WinControl.Handle, GWL_EXSTYLE, NewExStyle);

  for I := 0 to WinControl.ControlCount - 1 do
    if WinControl.Controls[i] is TWinControl then
      EnableComposited(TWinControl(WinControl.Controls[i]));
end;

procedure TfrmTacticalDisplay.btnShowPasswordClick(Sender: TObject);
begin
  if (EdtPassword.PasswordChar = '*') then
  begin
    btnShowPassword.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnShowPassword.png');
    EdtPassword.PasswordChar := #0;
  end
  else
  begin
    btnShowPassword.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnHidePassword.png');
    EdtPassword.PasswordChar := '*';
  end
end;

procedure TfrmTacticalDisplay.btnTerminationClick(Sender: TObject);
begin
  if btnTermination.Down then
  begin
    cbbSubRole.Left := btnTermination.Left;
    lstUserRoleLogin.Left := btnTermination.Left;

    cbbSubRole.Visible := True;

    AddCbbSubRole(3);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;

end;

procedure TfrmTacticalDisplay.btnConnectClick(Sender: TObject);
begin
  simMgrClient.CekGameState;

//  FTimerbutton := 0;

  pbLoadSystem.Visible := True;
  lblPbLoadSystem.Visible := True;

  pbLoadSystem.Position := 0;

  tmrProgressbar.Enabled := True;
  btnConnect.Visible := False;
end;

procedure TfrmTacticalDisplay.cbbConsoleNameDropDown(Sender: TObject);
var
  i : Integer;
  consoleInfoTemp : TConsoleInfo;
  userRoleTemp : TUserRole;

begin
  cbbConsoleName.Clear;

  for i := 0 to simMgrClient.SimConsole.ConsoleList.Count-1 do
  begin
    consoleInfoTemp := TConsoleInfo(simMgrClient.SimConsole.ConsoleList.Objects[i]);

    userRoleTemp := SimManager.SimUserRole.getUserRoleByIPAddress(consoleInfoTemp.IPAddress);

    if Assigned(userRoleTemp) then
    begin
      if userRoleTemp.isInUse then
      begin
        cbbConsoleName.Items.Add(consoleInfoTemp.ConsoleName);
      end
    end;
  end;

end;

procedure TfrmTacticalDisplay.cbbSubRoleSelect(Sender: TObject);
begin
  if cbbSubRole.ItemIndex = -1 then
    Exit;

  FSelectedSubRole := TSubRole(cbbSubRole.Items.Objects[cbbSubRole.ItemIndex]);

  if Assigned(FSelectedSubRole) then
  begin
    AddUserRoleLogin(FSelectedSubRole.FData.SubRoleIndex);
    lstUserRoleLogin.Visible := True;
  end;

end;

procedure TfrmTacticalDisplay.btnShowClick(Sender: TObject);
var
  ipTemp : string;
  userRoleTemp : TUserRole;

begin
  if (cbbConsoleName.ItemIndex = -1) or (cbbConsoleName.Text = '') then
  begin
    ShowMessage('The selected console is not currently in use');
    Exit;
  end;

  ipTemp := simMgrClient.SimConsole.GetIPAddress(cbbConsoleName.Text);
  userRoleTemp := SimManager.SimUserRole.getUserRoleByIPAddress(ipTemp);

  simMgrClient.MyConsoleData.assignUserRoleData(userRoleTemp);

  frmSituationBoard.lblUserRole.Caption := '   User Role : ' + userRoleTemp.FData.UserRoleAcronim;
  frmSituationBoard.lblTabSelect.Caption := ' --- ';
  frmSituationBoard.Show;
end;


procedure TfrmTacticalDisplay.AddCbbSubRole(tipeTahapan : Integer);
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  cbbSubRole.Items.Clear;

  for i := 0 to SimManager.SimSubRole.SubRoleList.Count-1 do
  begin
    subRoleTemp := SimManager.SimSubRole.SubRoleList[i];

    if Assigned(subRoleTemp) then
    begin
      case tipeTahapan of
        0:
        begin
          if subRoleTemp.FData.Perencanaan = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
        1:
        begin
          if subRoleTemp.FData.Persiapan = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
        2:
        begin
          if subRoleTemp.FData.Pelaksanaan = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
        3:
        begin
          if subRoleTemp.FData.Pengakhiran = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
      end;
    end;
  end;
end;

procedure TfrmTacticalDisplay.AddUserRoleLogin(SubRoleId : integer);
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  lstUserRoleLogin.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count-1 do
  begin
    userRoleTemp := SimManager.SimUserRole.UserList[i];

    if Assigned(userRoleTemp) then
    begin
      if userRoleTemp.FData.SubRoleIndex = SubRoleId then
        lstUserRoleLogin.Items.AddObject(userRoleTemp.FData.UserRoleAcronim, userRoleTemp);
    end;
  end;
end;

procedure TfrmTacticalDisplay.btnBackClick(Sender: TObject);
begin
  btnPlanning.Down := False;
  btnPreparation.Down := False;
  btnImplementation.Down := False;
  btnTermination.Down := False;

  cbbSubRole.Visible := False;
  lstUserRoleLogin.Visible := False;

  pnlHome.BringToFront;
end;

procedure TfrmTacticalDisplay.btnLoadClick(Sender: TObject);
var
  rec : TRecTCP_Reconnect;

begin
  if SimManager.GetGameState then
  begin
    rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
    simMgrClient.netSend_CmdReconnect(rec);

//    FTimerbutton := 1;
    pbLoadSystem.Visible := True;
    pbLoadSystem.Position := 0;

    tmrProgressbar.Enabled := True;
    btnLoad.Visible := False;
  end;
end;

procedure TfrmTacticalDisplay.btnImplementationClick(Sender: TObject);
begin
  if btnImplementation.Down then
  begin
    cbbSubRole.Left := btnImplementation.Left;
    lstUserRoleLogin.Left := btnImplementation.Left;

    cbbSubRole.Visible := True;

    AddCbbSubRole(2);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;

end;

procedure TfrmTacticalDisplay.btnLoginClick(Sender: TObject);
var
  rec : TRecTCP_UserState;
  userRoleTemp : TUserRole;

begin
  if not SimManager.GetGameState then
  begin
    ShowMessage('Your consule is not connecting to the server');
    Exit;
  end;

  if not Assigned(FselectedUserRole) then
  begin
    ShowMessage('User role not found, please return to the home page and re-select the user role.');
    Exit;
  end;

  userRoleTemp := SimManager.SimUserRole.getUserRoleByID(FselectedUserRole.FData.UserRoleIndex);

  if not Assigned(userRoleTemp) then
  begin
    ShowMessage('User role inactive, please return to the home page and re-select the other user role.');
    Exit;
  end;

  if simMgrClient.MyConsoleData.Group <>  cgWasdal then
  begin
    if userRoleTemp.isInUse then
    begin
      ShowMessage('User Role is in use ');
      Exit
    end
  end;

  if (userRoleTemp.FData.Username = edtUsername.Text)  and (userRoleTemp.FData.Password = edtPassword.Text) then
  begin
    rec.OrderID       := CORD_ID_LOGIN;
    rec.UserRoleId    := FselectedUserRole.FData.UserRoleIndex;
    rec.ConsoleIP     := simMgrClient.MyConsoleData.IpAdrres;
    rec.ConsoleGroup  := simMgrClient.MyConsoleData.Group;
    rec.UserRoleInUse := True;

    simMgrClient.netSend_CmdUserState(rec);
  end
  else
  begin
    ShowMessage('Invalid username and password ');
  end;

end;

procedure TfrmTacticalDisplay.btnLogoutClick(Sender: TObject);
var
  rec : TRecTCP_UserState;

begin
  if Assigned(simMgrClient.MyConsoleData) then
  begin
    rec.OrderID := CORD_ID_LOGOUT;
    rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
    rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
    rec.ConsoleGroup  := simMgrClient.MyConsoleData.Group;
    rec.UserRoleInUse := False;

    simMgrClient.netSend_CmdUserState(rec);
  end
end;

procedure TfrmTacticalDisplay.btnPlanningClick(Sender: TObject);
begin
  if btnPlanning.Down then
  begin
    cbbSubRole.Left := btnPlanning.Left;
    lstUserRoleLogin.Left := btnPlanning.Left;

    cbbSubRole.Visible := True;

    AddCbbSubRole(0);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;
end;

procedure TfrmTacticalDisplay.btnPreparationClick(Sender: TObject);
begin
  if btnPreparation.Down then
  begin
    cbbSubRole.Left := btnPreparation.Left;
    lstUserRoleLogin.Left := btnPreparation.Left;

    cbbSubRole.Visible := True;

    AddCbbSubRole(1);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;
end;

procedure TfrmTacticalDisplay.FormCreate(Sender: TObject);
begin
  EnableComposited(pnlBackgroundLogin);
  EnableComposited(pnlHome);

  FSelectedSubRole := TSubRole.Create;
  FselectedUserRole := TUserRole.Create;

  Show;
end;

procedure TfrmTacticalDisplay.FormDestroy(Sender: TObject);
begin
  FSelectedSubRole.Free;
  FselectedUserRole.Free;
end;

procedure TfrmTacticalDisplay.FormResize(Sender: TObject);
begin
  lblConsoleName.Left := (pnlHome.Width-lblConsoleName.Width)div 2;
  pnlButton.Left := (pnlHome.Width-pnlButton.Width)div 2;
end;

procedure TfrmTacticalDisplay.FormShow(Sender: TObject);
begin
  lblConsoleName.Left := (pnlHome.Width-lblConsoleName.Width)div 2;
  pnlButton.Left := (pnlHome.Width-pnlButton.Width)div 2;
end;

procedure TfrmTacticalDisplay.Image6Click(Sender: TObject);
begin
  simMgrClient.CekGameState;

  tmrPBSituationBoard.Enabled := True;
  pbSituationBoard.Visible := True;
  lblPb.Visible := True;
end;

procedure TfrmTacticalDisplay.Initialize;
var
  i : Integer;
begin
  width := Screen.Monitors[vGameDataSetting.TacticalScreen].width;
  height := Screen.Monitors[vGameDataSetting.TacticalScreen].height;
  left := Screen.Monitors[vGameDataSetting.TacticalScreen].left;
  top := Screen.Monitors[vGameDataSetting.TacticalScreen].top;
end;

procedure TfrmTacticalDisplay.lstUserRoleLoginDblClick(Sender: TObject);
begin
  if lstUserRoleLogin.ItemIndex = -1 then
    Exit;

  FselectedUserRole := TUserRole(lstUserRoleLogin.Items.Objects[lstUserRoleLogin.ItemIndex]);

  if Assigned(FselectedUserRole) then
  begin

      {$REGION ' pengecekan khusus console instruktur '}
      if simMgrClient.MyConsoleData.Group = cgInstructor then
      begin
        if not ((FselectedUserRole.FData.UserRoleIdentifier = 'instruktur atwo') or (FselectedUserRole.FData.UserRoleIdentifier = 'instruktur ntwo')
            or (FselectedUserRole.FData.UserRoleIdentifier = 'INSTRUKTUR ATWO') or (FselectedUserRole.FData.UserRoleIdentifier = 'INSTRUKTUR NTWO') or
               (FselectedUserRole.FData.UserRoleIdentifier = 'instruktur') or (FselectedUserRole.FData.UserRoleIdentifier = 'instruktur')) then
        begin
          ShowMessage('This User Role can only be used in the instructor console');
          Exit;
        end;
      end
      else
      begin
        if ((FselectedUserRole.FData.UserRoleIdentifier = 'instruktur atwo') or (FselectedUserRole.FData.UserRoleIdentifier = 'instruktur ntwo')
            or (FselectedUserRole.FData.UserRoleIdentifier = 'INSTRUKTUR ATWO') or (FselectedUserRole.FData.UserRoleIdentifier = 'INSTRUKTUR NTWO') or
               (FselectedUserRole.FData.UserRoleIdentifier = 'instruktur') or (FselectedUserRole.FData.UserRoleIdentifier = 'instruktur')) then
        begin
          ShowMessage('This User Role can only be used in the official console');
          Exit;
        end;
      end;
      {$ENDREGION}

      lblUserIdentifier.Caption := FselectedUserRole.FData.UserRoleIdentifier + ' - ' + FselectedUserRole.FSubRoleData.SubRoleAcronim;

//      if FselectedUserRole.FData.SubRoleIndex = 5 then
//        imgBackgroundLogin.Picture.LoadFromFile(vGameDataSetting.ImageBackgroundLogin + 'wallpaperNTWOLogin.png')
//      else if FselectedUserRole.FData.SubRoleIndex = 6 then
//        imgBackgroundLogin.Picture.LoadFromFile(vGameDataSetting.ImageBackgroundLogin + 'wallpaperATWOLogin.png')
//      else if FselectedUserRole.FData.SubRoleIndex = 1 then
//        imgBackgroundLogin.Picture.LoadFromFile(vGameDataSetting.ImageBackgroundLogin + 'wallpaperINWOLogin.png')
//      else if FselectedUserRole.FData.SubRoleIndex = 2 then
//        imgBackgroundLogin.Picture.LoadFromFile(vGameDataSetting.ImageBackgroundLogin + 'wallpaperINWOLogin.png');
  end;

  pnlBackgroundLogin.BringToFront;
end;

procedure TfrmTacticalDisplay.tmrPBSituationBoardTimer(Sender: TObject);
var
  rec : TRecTCP_Reconnect;

begin
  pbSituationBoard.Position := pbSituationBoard.Position + 1 ;

  if pbSituationBoard.Position < 50 then
  begin

    lblPb.Caption := 'Connecting to Server ....'
  end
  else if pbSituationBoard.Position = 50 then
  begin
    if SimManager.GetGameState then
    begin
      rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
      simMgrClient.netSend_CmdReconnect(rec);
    end;
  end
  else if (pbSituationBoard.Position > 50) and (pbSituationBoard.Position < 100) then
  begin
    lblPb.Caption := 'Loading data ....'
  end
  else if pbSituationBoard.Position = 100 then
  begin
    pbSituationBoard.Visible := False;
    lblPb.Visible := False;
    tmrPBSituationBoard.Enabled := False;
  end;
end;

procedure TfrmTacticalDisplay.tmrProgressbarTimer(Sender: TObject);
var
  rec : TRecTCP_Reconnect;

begin
  pbLoadSystem.Position := pbLoadSystem.Position + 1;

  if pbLoadSystem.Position < 50 then
  begin

    lblPbLoadSystem.Caption := 'Connecting to Server ....'
  end
  else if pbLoadSystem.Position = 50 then
  begin
    if SimManager.GetGameState then
    begin
      rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
      simMgrClient.netSend_CmdReconnect(rec);
    end;
  end
  else if (pbLoadSystem.Position > 50) and (pbLoadSystem.Position < 100) then
  begin
    lblPbLoadSystem.Caption := 'Loading data ....'
  end
  else if pbLoadSystem.Position = 100 then
  begin
    tmrProgressbar.Enabled := False;
    lblPbLoadSystem.Visible := False;
    pbLoadSystem.Visible := False;

    if not SimManager.GetGameState then
    begin
      ShowMessage('Server System is stop ');
      btnConnect.Visible := not SimManager.GetGameState;
    end
    else
    begin
      if simMgrClient.MyConsoleData.Group = cgSituationBoard then
      begin
        Label5.Visible := False;
        pnlBackgroundLogin.BringToFront;
        pnlSituationBoard.BringToFront;
        pnlLogo.Visible := True;
      end
      else
      begin
        pnlHome.BringToFront;
        pnlLogin.BringToFront;
        pnlLogo.Visible := False;
      end;

      btnPlanning.Visible := SimManager.GetGameState;
      btnPreparation.Visible := SimManager.GetGameState;
      btnImplementation.Visible := SimManager.GetGameState;
      btnTermination.Visible := SimManager.GetGameState;
    end;
  end;

//  case FTimerbutton of
//    0 : {Timer button connect}
//    begin
//      if pbLoadSystem.Position = 100 then
//      begin
//        pbLoadSystem.Visible := False;
//        tmrProgressbar.Enabled := False;
//        btnLoad.Visible := SimManager.GetGameState;
//        btnConnect.Visible := not SimManager.GetGameState;
//
//        if not SimManager.GetGameState then
//        begin
//          ShowMessage('Server System is stop ');
//        end;
//      end;
//    end;
//    1 : {Timer button load}
//    begin
//      if pbLoadSystem.Position = 100 then
//      begin
//
//        tmrProgressbar.Enabled := False;
//        pbLoadSystem.Visible := False;
//
//        if simMgrClient.MyConsoleData.Group = cgSituationBoard then
//        begin
//          Label5.Visible := False;
//          pnlBackgroundLogin.BringToFront;
//          pnlSituationBoard.BringToFront;
//          pnlLogo.Visible := True;
//        end
//        else
//        begin
//          pnlHome.BringToFront;
//          pnlLogin.BringToFront;
//          pnlLogo.Visible := False;
//        end;
//
//        btnPlanning.Visible := SimManager.GetGameState;
//        btnPreparation.Visible := SimManager.GetGameState;
//        btnImplementation.Visible := SimManager.GetGameState;
//        btnTermination.Visible := SimManager.GetGameState;
//
//        if not SimManager.GetGameState then
//        begin
//          ShowMessage('Server System is stop ');
//          btnConnect.Visible := not SimManager.GetGameState;
//        end;
//      end;
//    end;
//  end;

end;

procedure TfrmTacticalDisplay.UpdateClientLogin(Sender: TObject);
begin
  frmDisplayArea_Instance.Show;
end;

procedure TfrmTacticalDisplay.UpdateClientLogout(Sender: TObject);
var
  i : Integer;
begin
  {$REGION ' User Logout '}
  edtUsername.Text := '';
  edtPassword.Text := '';

   for i := Screen.FormCount - 1 downto 0 do
   begin
     if True then
      if (Screen.Forms[I] <> Self) then
      Screen.Forms[I].Close;
   end;

  pnlLogin.BringToFront;
  {$ENDREGION}
end;

procedure TfrmTacticalDisplay.UpdateGameState(Sender: TObject);
begin

  btnConnect.Visible := True;
  btnLoad.Visible := True;

  btnPlanning.Visible := False;
  btnPreparation.Visible := False;
  btnImplementation.Visible := False;
  btnTermination.Visible := False;
end;

end.

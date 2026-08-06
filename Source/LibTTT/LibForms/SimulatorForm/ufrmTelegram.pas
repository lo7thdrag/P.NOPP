unit ufrmTelegram;

interface

uses
  Winapi.Windows, System.IOUtils, Winapi.Messages, System.SysUtils, System.Variants, System.Win.ComObj, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Winapi.ShellAPI,
  Vcl.ExtCtrls, Vcl.Buttons, ImageButton, Vcl.ComCtrls, Vcl.Imaging.jpeg, uSimMgr_Client, uClassData, uT3SimManager, uRecordData, uLibSetting,
  AdvGroupBox, ufrmFileManager, System.Types,

  ufPopChat;

type
  TfrmTelegram = class(TForm)
    pnlRight: TPanel;
    pnlLeft: TPanel;
    lblBtnTelegramMasuk: TLabel;
    imgbtnDraft: TImageButton;
    lblDraft: TLabel;
    lblBtnTelegramTerkirim: TLabel;
    pnlTelegramMasuk: TPanel;
    pnlDraft: TPanel;
    pnlTelegramTerkirim: TPanel;
    lblTo: TLabel;
    cbbxTo: TComboBox;
    lblTelegram: TLabel;
    pnlSendTelegram: TPanel;
    ImgBtnTelegramMasuk: TImageButton;
    ImgBtnTelegramTerkirim: TImageButton;
    ImgBtnBuatTelegramTerbatas: TImageButton;
    lblBuatTelegramTerbatas: TLabel;
    pnlBuatTelegramTerbatas: TPanel;
    pnlBuatTelegramRahasia: TPanel;
    ImgBtnBuatTelegramRahasia: TImageButton;
    lblBuatTelegramRahasia: TLabel;
    AdvGroupBox1: TAdvGroupBox;
    imgBtnKirimTelegram: TImageButton;
    ImgBtnPilihFile: TImageButton;
    pnlChooseFile: TPanel;
    lblPilihFile: TLabel;
    pnlKirimTelegram: TPanel;
    lblKirimTelegram: TLabel;
    btnClosePanelSendTelegram: TImageButton;
    lblFile: TLabel;
    pnlBase: TPanel;
    lstbxTelegramFileName: TListBox;
    AdvGroupBox2: TAdvGroupBox;
    lblSendTelegram: TLabel;
    pnlSend: TPanel;
    imgbtnSend: TImageButton;
    lblSend: TLabel;
    procedure btnBuatTelegramTerbatasClick(Sender: TObject);
    procedure btnBuatTelegramRahasiaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnOpenTelegramClick(Sender: TObject);
    procedure btnKirimClick(Sender: TObject);
    procedure cbbxToDropDown(Sender: TObject);
    procedure pnlTelegramMasukClick(Sender: TObject);
    procedure pnlTelegramTerkirimClick(Sender: TObject);
    procedure btnClosePanelSendTelegramClick(Sender: TObject);
    procedure imgBtnKirimTelegramClick(Sender: TObject);
    procedure lblPilihFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgbtnDraftClick(Sender: TObject);
    procedure cbbxToSelect(Sender: TObject);
  private
    FLastFileCount: Integer;
    FLastFileName : string;

    ipTelegramSentTo : string;
  public
    { Public declarations }
    fileNameArray : array of string;
    pathFileArray : array of string;

    function GetSenderFromPath(FilePath:string):string;

    procedure UpdateClientTelegramList;
    procedure OpenApplicationFileFolder(FullPath: String);
    procedure UpdateFilenameComboBox;
  end;

var
  frmTelegram: TfrmTelegram;

implementation

{$R *.dfm}

function TfrmTelegram.GetSenderFromPath(FilePath:string):string;
var
  Temp : TStringList;
begin
  Result := 'Unknown';
  Temp   := TStringList.Create;

  try
    ExtractStrings(['\'], [], PChar(FilePath), Temp);

    if Temp.Count >= 3 then
      Result := Temp[Temp.Count-3];
  finally
    Temp.Free;
  end;
end;

procedure TfrmTelegram.btnBuatTelegramRahasiaClick(Sender: TObject);
var
  WordFileName           : string;
  WordFileNameTemplate   : string;
  DraftTemplatePath      : string;
begin
  WordFileNameTemplate := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'data\Template Telegram 2.docx';

  if not FileExists(WordFileNameTemplate) then
  begin
    ShowMessage('Template Telegram Rahasia tidak ditemukan.');
    Exit;
  end;

  DraftTemplatePath := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'Telegram\DRAFT\Template';

  ForceDirectories(DraftTemplatePath);

  WordFileName := IncludeTrailingPathDelimiter(DraftTemplatePath) + 'TelegramRahasia_' + FormatDateTime('dd-mm-yy_hh-nn-ss', Now) + '.docx';

  if not CopyFile(PChar(WordFileNameTemplate), PChar(WordFileName), False) then
  begin
    ShowMessage('Gagal membuat file Telegram Rahasia.');
    Exit;
  end;

  ShellExecute(0, 'open', PChar(WordFileName), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.btnBuatTelegramTerbatasClick(Sender: TObject);
var
  WordFileName         : string;
  WordTemplatePath     : string;
  DraftTemplatePath    : string;
begin
  WordTemplatePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'data\Template Telegram 1.docx';

  if not FileExists(WordTemplatePath) then
  begin
    ShowMessage('Template Telegram Terbatas tidak ditemukan.');
    Exit;
  end;

  DraftTemplatePath := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'Telegram\DRAFT\Template';

  ForceDirectories(DraftTemplatePath);

  WordFileName := IncludeTrailingPathDelimiter(DraftTemplatePath) + 'TelegramTerbatas_' + FormatDateTime('dd-mm-yy_hh-nn-ss', Now) + '.docx';

  if not CopyFile(PChar(WordTemplatePath), PChar(WordFileName), False) then
  begin
    ShowMessage('Gagal membuat file Telegram Terbatas.');
    Exit;
  end;

  ShellExecute(0, 'open', PChar(WordFileName), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.btnClosePanelSendTelegramClick(Sender: TObject);
begin
  ipTelegramSentTo := '';
  pnlSendTelegram.Visible := False;
  cbbxTo.ItemIndex := -1;
  SetLength(fileNameArray,0);
  SetLength(pathFileArray,0);
  lstbxTelegramFileName.Clear;
  frmTelegram.Width := 214;
end;

procedure TfrmTelegram.btnKirimClick(Sender: TObject);
var
  DateTimeNowTemp : string;
  SentPath        : string;

  i           : Integer;
  rec         : TRecTCPFileSync;
  FS          : TFileStream;
  BufferSize  : Integer;
begin
  if cbbxTo.ItemIndex = -1 then
  begin
    ShowMessage('Choose who you want to share file to!');
    Exit;
  end;

  if Length(pathFileArray) = 0 then
  begin
    ShowMessage('Choose file first!');
    Exit;
  end;

  DateTimeNowTemp := FormatDateTime('dd-mm-yy_hh;nn;ss', Now);
  SentPath        := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'Telegram\SENT\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim +
                     '\' + DateTimeNowTemp;
  ForceDirectories(SentPath);

  for i := 0 to High(pathFileArray) do
  begin
    if not FileExists(pathFileArray[i]) then
      Continue;

    try
      FillChar(rec, SizeOf(rec),0);

      {$REGION 'SEND INFO'}
      rec.OrderID    := SEND_FILE_INFO;
      rec.FileName   := fileNameArray[i];
      rec.FolderName := DateTimeNowTemp;
      rec.SenderName := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim;

      FS := TFileStream.Create(pathFileArray[i], fmOpenRead or fmShareDenyNone);

      try
        rec.FileSize := FS.Size;
      finally
        FS.Free;
      end;

      rec.SenderIP           := simMgrClient.MyConsoleData.UserRoleData.ConsoleIP;
      rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
      rec.ReceiverUserRoleId := TUserRole(cbbxTo.Items.Objects[cbbxTo.ItemIndex]).FData.UserRoleIndex;

      simMgrClient.netSend_CmdFileSendTelegram(rec);

      {$ENDREGION}

      {$REGION 'SEND DATA'}
      FS := TFileStream.Create(pathFileArray[i], fmOpenRead or fmShareDenyNone);

      try
        while FS.Position < FS.Size do
        begin
          FillChar(rec.Data,SizeOf(rec.Data), 0);
          BufferSize := FS.Read(rec.Data, SizeOf(rec.Data));

          rec.OrderID            := SEND_FILE_DATA;
          rec.FileName           := fileNameArray[i];
          rec.FolderName         := DateTimeNowTemp;
          rec.SenderName         := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim;
          rec.Position           := FS.Position - BufferSize;
          rec.DataSize           := BufferSize;
          rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
          rec.ReceiverUserRoleId := TUserRole(cbbxTo.Items.Objects[cbbxTo.ItemIndex]).FData.UserRoleIndex;

          simMgrClient.netSend_CmdFileSendTelegram(rec);
        end;

      finally
        FS.Free;
      end;
      {$ENDREGION}

      {$REGION 'SEND FINISH'}
      FillChar(rec.Data, SizeOf(rec.Data), 0);

      rec.OrderID    := SEND_FILE_FINISH;
      rec.FileName   := fileNameArray[i];
      rec.FolderName := DateTimeNowTemp;
      rec.SenderName := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim;

      simMgrClient.netSend_CmdFileSendTelegram(rec);

      CopyFile(PChar(pathFileArray[i]), PChar(IncludeTrailingPathDelimiter(SentPath) + fileNameArray[i]), False);
      {$ENDREGION}

    except
      on E:Exception do
      begin
        ShowMessage('Error send file:'#13#10 + fileNameArray[i] + #13#10 + E.Message);
      end;
    end;
  end;

  btnClosePanelSendTelegramClick(Sender);
  ShowMessage('Telegram successfully sent!');
end;

procedure TfrmTelegram.Button1Click(Sender: TObject);
var
path : string;
begin
  if not Assigned(frmFileManager) then
    frmFileManager := TfrmFileManager.Create(Self);

  frmFileManager.Show;
end;

procedure TfrmTelegram.btnOpenTelegramClick(Sender: TObject);
var
WordApplication, WordFile: Variant;
begin
//
end;

procedure TfrmTelegram.cbbxToDropDown(Sender: TObject);
begin
  UpdateClientTelegramList;
end;

procedure TfrmTelegram.cbbxToSelect(Sender: TObject);
var
  userRoleTemp : TUserRole;
  ipTemp : string;

begin
  if cbbxTo.ItemIndex = -1 then
    Exit;

  userRoleTemp := TUserRole(cbbxTo.Items.Objects[cbbxTo.ItemIndex]);
  ipTelegramSentTo := userRoleTemp.ConsoleIP;
end;

procedure TfrmTelegram.FormShow(Sender: TObject);
begin
  pnlSendTelegram.Visible := False;
  lstbxTelegramFileName.Clear;
  frmTelegram.Width := 214;

  FLastFileCount := 0;
end;

procedure TfrmTelegram.imgBtnKirimTelegramClick(Sender: TObject);
begin
  pnlSendTelegram.Visible := True;
  pnlSendTelegram.BringToFront;
  cbbxTo.ItemIndex := -1;
  ipTelegramSentTo := '';
  frmTelegram.Width := 681;
end;

procedure TfrmTelegram.lblPilihFileClick(Sender: TObject);
var
  OpenDialog   : TOpenDialog;
  i            : Integer;
  TelegramPath : string;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    TelegramPath := IncludeTrailingPathDelimiter(vGameDataSetting.Telegram);

    OpenDialog.InitialDir := TelegramPath;
    OpenDialog.Options    := OpenDialog.Options + [ofAllowMultiSelect];
    OpenDialog.Filter     := 'All Files (*.*)|*.*';

    SetLength(fileNameArray, 0);
    SetLength(pathFileArray, 0);

    if OpenDialog.Execute then
    begin
      SetLength(pathFileArray, OpenDialog.Files.Count);
      SetLength(fileNameArray, OpenDialog.Files.Count);

      for i := 0 to OpenDialog.Files.Count - 1 do
      begin
        pathFileArray[i] := OpenDialog.Files[i];
        fileNameArray[i] := ExtractFileName(OpenDialog.Files[i]);
      end;
    end
    else
    begin
      ShowMessage('Choose file was cancelled');
      Exit;
    end;

  finally
    OpenDialog.Free;
  end;

  UpdateFilenameComboBox;
end;

procedure TfrmTelegram.UpdateFilenameComboBox;
begin
  lstbxTelegramFileName.Clear;
  lstbxTelegramFileName.Items.AddStrings(TArray<string>(fileNameArray));
end;

procedure TfrmTelegram.OpenApplicationFileFolder(FullPath: String);
begin
  ShellExecute(Application.Handle, PChar('open'), PChar(FullPath), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmTelegram.pnlTelegramMasukClick(Sender: TObject);
var
  path : string;
begin
  path := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'Telegram\INBOX';

  if not TDirectory.Exists(path) then
    TDirectory.CreateDirectory(path);

  ShellExecute(0, 'open', PChar(path), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.imgbtnDraftClick(Sender: TObject);
var
  DraftPath: string;
begin
  DraftPath := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'Telegram\DRAFT';

  if not TDirectory.Exists(DraftPath) then
    TDirectory.CreateDirectory(DraftPath);

  ShellExecute(0, 'open', PChar(DraftPath), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.pnlTelegramTerkirimClick(Sender: TObject);
var
  SentPath: string;
begin
  SentPath := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'Telegram\SENT';

  if not TDirectory.Exists(SentPath) then
    TDirectory.CreateDirectory(SentPath);

  ShellExecute(0, 'open', PChar(SentPath), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.UpdateClientTelegramList;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  cbbxTo.Items.Clear;

//  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
//  begin
//    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
//    if Assigned(userRoleTemp) then
//    begin
//      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
//      begin
//        cbbxTo.Items.AddObject(userRoleTemp.FData.UserRoleAcronim + ' - ' + userRoleTemp.FSubRoleData.SubRoleIdentifier, userRoleTemp);
//      end;
//    end;
//  end;

  // Testing
  {$REGION 'Testing chat diri sendiri'}
    cbbxTo.Items.AddObject('[SELF TEST] ' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim, simMgrClient.MyConsoleData.UserRoleData);
  {$ENDREGION}

  if cbbxTo.Items.Count > 0 then
  begin
    cbbxTo.ItemIndex := 0;
    cbbxToSelect(nil);
  end;
end;

end.

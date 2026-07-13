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
    tmrPopUpTelegram: TTimer;
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
    procedure tmrPopUpTelegramTimer(Sender: TObject);
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
WordFileName, WordFileNameTemplateRahasia: String;
WordApplication, WordFile: Variant;
GameTime : TDateTime;
//time : string;
pw : PWideChar;
begin
//  WordFileName := 'C:\\[DENTA]\\aweesdrftyghuijok-Draft.docx';
  WordFileNameTemplateRahasia := 'data\\Template Telegram 2.docx';

  WordApplication := null;
  WordFile := null;

  try
    //create Word OLE
    WordApplication := CreateOleObject('Word.Application');
  except
    WordApplication := Null;
    //add error/exception handling code as desired
  end;

  If VarIsNull(WordApplication) = False then
  begin
    if not (TDirectory.Exists('D:\\Telegram')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram');
    end;

    if not (TDirectory.Exists('D:\\Telegram\\DRAFT')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram\\DRAFT');
    end;

    if not (TDirectory.Exists('D:\\Telegram\\DRAFT\\Template')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram\\DRAFT\\Template');
    end;

    WordFileName := 'D:\\Telegram\\DRAFT\\Template\\TelegramRahasia_'+System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now)+'.docx';
    pw := PWideChar(WordFileName);
    CopyFile(PWideChar(WordFileNameTemplateRahasia), pw, False);
//     try
//        WordApplication.Visible := True; //set to False if you do not want to see the activity in the background
//        WordApplication.DisplayAlerts := True; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.
//        //Open Word File
//        try
//           WordFile := WordApplication.Documents.Open(WordFileName);
//           //reference
//           //https://docs.microsoft.com/en-us/office/vba/api/word.documents.open
//        except
//              WordFile := Null;
//              //add error/exception handling code as desired
//        end;
//
//     finally
//
//     end;

    ShellExecute(0, 'open', (pw), nil, nil, SW_SHOW);
  end;
end;

procedure TfrmTelegram.btnBuatTelegramTerbatasClick(Sender: TObject);
var
WordFileName, WordFileNameTemplateTerbatas: String;
WordApplication, WordFile: Variant;
GameTime : TDateTime;
//time : string;
pw : PWideChar;
begin
//  WordFileName := 'C:\\[DENTA]\\aweesdrftyghuijok-Draft.docx';
  WordFileNameTemplateTerbatas := 'data\\Template Telegram 1.docx';

  WordApplication := null;
  WordFile := null;

  try
    //create Word OLE
    WordApplication := CreateOleObject('Word.Application');
  except
    WordApplication := Null;
    //add error/exception handling code as desired
  end;

  If VarIsNull(WordApplication) = False then
  begin
    if not (TDirectory.Exists('D:\\Telegram')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram');
    end;

    if not (TDirectory.Exists('D:\\Telegram\\DRAFT')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram\\DRAFT');
    end;

    if not (TDirectory.Exists('D:\\Telegram\\DRAFT\\Template')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram\\DRAFT\\Template');
    end;

    WordFileName := 'D:\\Telegram\\DRAFT\\Template\\TelegramTerbatas_'+ System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now) + '.docx';
    pw := PWideChar(WordFileName);
    CopyFile(PWideChar(WordFileNameTemplateTerbatas), pw, False);

    ShellExecute(0, 'open', (pw), nil, nil, SW_SHOW);
  end;
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

  i   : Integer;
  rec : TRecTCPFileSync;
  FS  : TFileStream;

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

  if Length(pathFileArray) <> Length(fileNameArray) then
  begin
    ShowMessage('File array mismatch!');
    Exit;
  end;

  DateTimeNowTemp := FormatDateTime('dd-mm-yy_hh;nn;ss', Now);
  SentPath := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'Telegram\SENT\' + cbbxTo.Text + '\' + DateTimeNowTemp;

  if not DirectoryExists(SentPath) then
    ForceDirectories(SentPath);

  for i := 0 to High(pathFileArray) do
  begin

    if not FileExists(pathFileArray[i]) then
      Continue;

    try
      CopyFile(PChar(pathFileArray[i]), PChar(IncludeTrailingPathDelimiter(SentPath)+ fileNameArray[i]), False);
      FillChar(rec, SizeOf(rec), 0);
      rec.OrderID := SEND_FILE_INFO;
      rec.FileName := fileNameArray[i];
      rec.FolderName := DateTimeNowTemp;
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

    except
      on E: Exception do
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
  addressTemp : string;
  filNameTemp : string;
  openDialog : TOpenDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecTCPSendTelegramUserRole;
  i : Integer;

begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := 'D:\Telegram';
  openDialog.Options := openDialog.Options + [ofAllowMultiSelect];
  openDialog.Filter := 'All Files (*.*)|*.*';

  SetLength(fileNameArray,0);
  SetLength(pathFileArray,0);

  if openDialog.Execute then
  begin

    SetLength(pathFileArray, openDialog.Files.Count);
    SetLength(fileNameArray, openDialog.Files.Count);

    addressTemp := PWideChar(openDialog.FileName);
    filNameTemp := ExtractFileName(openDialog.FileName);

    for i := 0 to openDialog.Files.Count - 1 do
    begin
      addressTemp := openDialog.Files[i];
      filNameTemp := ExtractFileName(openDialog.Files[i]);
      fileNameArray[i] := filNameTemp;
      pathFileArray[i] := addressTemp;
    end;
  end
  else
    ShowMessage('Choose file was cancelled');

  openDialog.Free;

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
  if not (TDirectory.Exists('D:\\Telegram\\INBOX')) then
  begin
    TDirectory.CreateDirectory('D:\\Telegram\\INBOX');
  end;

  ShellExecute(0, 'open', ('D:\\Telegram\\INBOX'), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.imgbtnDraftClick(Sender: TObject);
var
  path : string;
begin
  if not (TDirectory.Exists('D:\\Telegram\\DRAFT')) then
  begin
    TDirectory.CreateDirectory('D:\\Telegram\\DRAFT');
  end;

  ShellExecute(0, 'open', ('D:\\Telegram\\DRAFT'), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.pnlTelegramTerkirimClick(Sender: TObject);
var
  path : string;
begin
  if not (TDirectory.Exists('D:\\Telegram\\SENT')) then
  begin
    TDirectory.CreateDirectory('D:\\Telegram\\SENT');
  end;

  ShellExecute(0, 'open', ('D:\\Telegram\\SENT'), nil, nil, SW_SHOW);
end;

procedure TfrmTelegram.tmrPopUpTelegramTimer(Sender: TObject);
var
  InboxPath : string;
  Files     : TStringDynArray;
  LastFile  : string;
  SenderName: string;
begin
//  InboxPath := IncludeTrailingPathDelimiter(vGameDataSetting.Telegram) + 'INBOX';
//
//  if not TDirectory.Exists(InboxPath) then
//    Exit;
//
//  Files := TDirectory.GetFiles(InboxPath, '*.*', TSearchOption.soAllDirectories);
//
//  if Length(Files)=0 then
//    Exit;
//
//  LastFile := Files[High(Files)];
//
//  if SameText(LastFile, FLastFileName) then
//    Exit;
//
//  FLastFileName := LastFile;
//  SenderName    := GetSenderFromPath(LastFile);
//
//  if not Assigned(frmPopChat) then
//    Application.CreateForm(TfrmPopChat, frmPopChat);
//
//  frmPopChat.ShowMessagePopup(SenderName, 'File masuk : ' + ExtractFileName(LastFile));
end;

procedure TfrmTelegram.UpdateClientTelegramList;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  cbbxTo.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userRoleTemp := simMgrClient.SimUserRole.UserList[i];

    if Assigned(userRoleTemp) then
    begin
      cbbxTo.Items.AddObject(userRoleTemp.FData.UserRoleAcronim + ' - ' + userRoleTemp.FSubRoleData.SubRoleIdentifier, userRoleTemp)
    end;
  end;

  if cbbxTo.Items.Count > 0 then
  begin
    cbbxTo.ItemIndex := 0;
    cbbxToSelect(nil);
  end;
end;

end.

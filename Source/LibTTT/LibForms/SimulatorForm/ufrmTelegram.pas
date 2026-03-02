unit ufrmTelegram;

interface

uses
  Winapi.Windows, System.IOUtils, Winapi.Messages, System.SysUtils, System.Variants, System.Win.ComObj, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Winapi.ShellAPI,
  Vcl.ExtCtrls, Vcl.Buttons, ImageButton, Vcl.ComCtrls, Vcl.Imaging.jpeg, uSimMgr_Client, uClassData, uT3SimManager, uRecordData, uLibSetting,
  AdvGroupBox, ufrmFileManager;

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
    procedure Label1Click(Sender: TObject);
    procedure btnClosePanelSendTelegramClick(Sender: TObject);
    procedure imgBtnKirimTelegramClick(Sender: TObject);
    procedure lblPilihFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgbtnDraftClick(Sender: TObject);
    procedure cbbxToSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    ipTelegramSentTo : string;
  public
    { Public declarations }
    fileNameArray : array of string;
    pathFileArray : array of string;

    procedure UpdateClientTelegramList;
    procedure OpenApplicationFileFolder(FullPath: String);
    procedure UpdateFilenameComboBox;

  end;

var
  frmTelegram: TfrmTelegram;

implementation

{$R *.dfm}

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
//     try
//        WordApplication.Visible := True; //set to False if you do not want to see the activity in the background
//        WordApplication.DisplayAlerts := True; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.
//
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

procedure TfrmTelegram.btnClosePanelSendTelegramClick(Sender: TObject);
begin
//  addressTempFileTelegram := '';
//  fileNameTempTelegram := '';
  ipTelegramSentTo := '';
  pnlSendTelegram.Visible := False;
  cbbxTo.ItemIndex := -1;
  SetLength(fileNameArray,0);
  SetLength(pathFileArray,0);
  lstbxTelegramFileName.Clear;
  frmTelegram.Width := 214;
//  frmTelegram.Position := poScreenCenter;
end;

procedure TfrmTelegram.btnKirimClick(Sender: TObject);
var
//  addressTemp : PWideChar;
  datetimenowtemp : string;
  addressfiletemp : string;
  filenametemp : string;
  i : Integer;
  addressTempFileTelegram : string;
  fileNameTempTelegram : string;
//  saveDialog : TSaveDialog;
//  saveFileTemp : TFile_Data;
//  fileDataTemp : TRecTCPSendTelegramUserRole;
//
begin

    {$REGION 'Code copy lama'}
    // SAVE FILE KE INBOX FOLDER ROLE TUJUAN
//  if (addressTempFileTelegram <> '') and (fileNameTempTelegram <> '') then
//  begin
//    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  cbbxTo.Text + '\\' + 'INBOX')) then
//    begin
//      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX');
//      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
////      TDirectory.de
//    end
//    else
//    begin
//    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
//    end;
//
//    // SAVE FILE KE SENT BOX FOLDER ROLE PENGIRIM
//    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT')) then
//    begin
//      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT');
//      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
//    end
//    else
//    begin
//    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
//    end;
//
//    pnlSendTelegram.Visible := False;
//  end;
    {$ENDREGION}

    if cbbxTo.ItemIndex = -1 then
    begin
      ShowMessage('Choose who you want to share file to!');
      exit;
    end
    else if Length(fileNameArray) = 0 then
    begin
      ShowMessage('Choose which file you want to share!');
      exit;
    end;
  //  else if not (TDirectory.Exists('\\' + SelectedUserRoleIP + '\\File Sharing')) then
  //  begin
  //    ShowMessage('Share folder doesn''t exist');
  //    exit;
  //  end;

    if ipTelegramSentTo <> '' then
    begin
      // SAVE FILE KE INBOX FOLDER ROLE TUJUAN
      if not (TDirectory.Exists('\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX')) then
      begin
        TDirectory.CreateDirectory('\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX');
      end;

      if not (TDirectory.Exists('\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim)) then
      begin
        TDirectory.CreateDirectory('\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX' + '\\'
         + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier);
      end;

      if not (TDirectory.Exists('\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim
              + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now))) then
      begin
        datetimenowtemp := System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now);

        TDirectory.CreateDirectory('\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX' + '\\' +
         simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + datetimenowtemp);

  //      CopyFile(addressTempFileTelegram, PWideChar('\\' + ipTelegramSentTo + '\\' + 'TELEGRAM' + '\\' + 'INBOX' + '\\'
  //       + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '\\' + datetimenowtemp + '\\' + fileNameTempTelegram), False);

//        TFile.Copy(addressTempFileTelegram, '\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX' + '\\'
//         + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '\\' + datetimenowtemp + '\\' + fileNameTempTelegram);
      end;

//      TFile.Copy(addressTempFileTelegram, '\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX' + '\\'
//         + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '\\' + datetimenowtemp + '\\' + fileNameTempTelegram);


      // SAVE FILE KE SENT BOX FOLDER ROLE PENGIRIM
      if not (TDirectory.Exists('D:' + '\\' + 'Telegram' + '\\' +  'SENT')) then
      begin
        TDirectory.CreateDirectory('D:' + '\\' + 'Telegram' + '\\' +  'SENT');
      end;

      if not (TDirectory.Exists('D:' + '\\' + 'Telegram' + '\\' +  'SENT' + '\\' + cbbxTo.Text)) then
      begin
        TDirectory.CreateDirectory('D:' + '\\' + 'Telegram' + '\\' +  'SENT' + '\\' + cbbxTo.Text);
      end;

      if not (TDirectory.Exists('D:' + '\\' + 'Telegram' + '\\' +  'SENT' + '\\' + cbbxTo.Text + '\\' + datetimenowtemp)) then
      begin
        TDirectory.CreateDirectory('D:' + '\\' + 'Telegram' + '\\' +  'SENT' + '\\' + cbbxTo.Text + '\\' + datetimenowtemp);
      end;

//      TFile.Copy(addressTempFileTelegram, 'D:' + '\\' + 'Telegram' + '\\' +  'SENT' + '\\' + cbbxTo.Text
//                                                    + '\\' + datetimenowtemp + '\\' + fileNameTempTelegram);

      for i := 0 to Length(pathFileArray) - 1 do
      begin
        addressTempFileTelegram := pathFileArray[i];
        fileNameTempTelegram := fileNameArray[i];

        TFile.Copy(addressTempFileTelegram, '\\' + ipTelegramSentTo + '\\' + 'Telegram' + '\\' + 'INBOX' + '\\'
         + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + datetimenowtemp + '\\' + fileNameTempTelegram);

        TFile.Copy(addressTempFileTelegram, 'D:' + '\\' + 'Telegram' + '\\' +  'SENT' + '\\' + cbbxTo.Text
         + '\\' + datetimenowtemp + '\\' + fileNameTempTelegram);

    //    CopyFile(addressfiletemp, PWideChar('\\' + SelectedUserRoleIP + '\\File Sharing' + '\\' + filenametemp), False);

//        TFile.Copy(addressfiletemp, '\\' + SelectedUserRoleIP + '\\File Sharing' + '\\' + filenametemp);
      end;

      datetimenowtemp := '';
      pnlSendTelegram.Visible := False;
    end
    else
    begin
      ShowMessage('Please choose Telegram File first!');
      Exit;
    end;
//  end
//  else
//    ShowMessage('Save file was cancelled');
//
//  saveDialog.Free;
    btnClosePanelSendTelegramClick(sender);

    ShowMessage('Telegram has been Successfully Sent!');

////  UpdateDataFile;
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
//  lblNamaFile.Caption := userRoleTemp.ConsoleIP;
  ipTelegramSentTo := userRoleTemp.ConsoleIP;
end;

procedure TfrmTelegram.FormCreate(Sender: TObject);
begin
//  frmTelegram.Position := Screen.Monitors[vGameDataSetting.ToteScreen].
end;

procedure TfrmTelegram.FormShow(Sender: TObject);
begin
  pnlSendTelegram.Visible := False;

  lstbxTelegramFileName.Clear;
  frmTelegram.Width := 214;
//  frmTelegram.Position := poScreenCenter;
end;

procedure TfrmTelegram.imgBtnKirimTelegramClick(Sender: TObject);
begin
  pnlSendTelegram.Visible := True;
  pnlSendTelegram.BringToFront;
//  addressTempFileTelegram := '';
//  fileNameTempTelegram := '';
//  lblNamaFile.Caption := '...';
  cbbxTo.ItemIndex := -1;
  ipTelegramSentTo := '';
  frmTelegram.Width := 681;
//  frmTelegram.Position := poScreenCenter;
end;

procedure TfrmTelegram.Label1Click(Sender: TObject);
begin
//  if not TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM') then
//    Exit;
//
//   ShellExecute(0, 'open', ('C:\[DENTA]\removeDir.bat'), nil, nil, SW_SHOW);

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
//  openDialog.Filter := 'Word file|*.docx|Excel file|*.xlsx|Power Point file|*.pptx';
  openDialog.Filter := 'All Files (*.*)|*.*';

//  saveDialog.DefaultExt := 'docx';

    SetLength(fileNameArray,0);
    SetLength(pathFileArray,0);

//  openDialog.FilterIndex := 1;

  if openDialog.Execute then
  begin

    SetLength(pathFileArray, openDialog.Files.Count);
    SetLength(fileNameArray, openDialog.Files.Count);

    addressTemp := PWideChar(openDialog.FileName);
    filNameTemp := ExtractFileName(openDialog.FileName);
//    lblNamaFile.Caption
//    addressTempFileTelegram := addressTemp;
//    fileNameTempTelegram := filNameTemp;

    for i := 0 to openDialog.Files.Count - 1 do
    begin
      addressTemp := openDialog.Files[i];
      filNameTemp := ExtractFileName(openDialog.Files[i]);
//      filNameTemp := openDialog.Files[i];
      fileNameArray[i] := filNameTemp;
      pathFileArray[i] := addressTemp;

//      lstbxFileShareName.Items.AddStrings(filNameTemp);
  //    lblNamaFile.Caption
//      addressTempFileFileSharing := addressTemp;
//      fileNameTempFileSharing := filNameTemp;

//      lblNamaFile.Caption := fileNameTempFileSharing;
    end;

//    lblNamaFile.Caption := fileNameTempTelegram;

    // SAVE FILE KE INBOX FOLDER ROLE TUJUAN
//    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  cbbxTo.Text + '\\' + 'INBOX')) then
//    begin
//      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX');
//      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
////      TDirectory.de
//    end
//    else
//    begin
//    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
//    end;
//
//    // SAVE FILE KE SENT BOX FOLDER ROLE PENGIRIM
//    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT')) then
//    begin
//      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT');
//      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
//    end
//    else
//    begin
//    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
//    end;
  end
  else
    ShowMessage('Choose file was cancelled');

  openDialog.Free;

//  UpdateDataFile;
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
     //references
     //https://learn.microsoft.com/en-us/windows/win32/api/shellapi/nf-shellapi-shellexecutea
     //https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-showwindow
end;

procedure TfrmTelegram.pnlTelegramMasukClick(Sender: TObject);
var
path : string;
begin
//  path := vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'INBOX';
//  lblTelegramMasuk.Visible := True;
//  lblTelegramTerkirim.Visible := False;
//  LstBxTelegram.Items.Clear;
//
//  if not TDirectory.Exists(path) then
//  begin
//  ShowMessage('Inbox still empty');
//  Exit
//  end
//  else
//  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));

//    if not (TDirectory.Exists('D:\\Telegram')) then
//    begin
//      TDirectory.CreateDirectory('D:\\Telegram');
//    end;

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
//  path := 'D:\Telegram\';
//  lblTelegramMasuk.Visible := True;
//  lblTelegramMasuk.Caption := 'Draft';
//
//  lblTelegramTerkirim.Visible := False;
//  LstBxTelegram.Items.Clear;
//
//  if not TDirectory.Exists(path) then
//  begin
//  ShowMessage('Inbox still empty');
//  Exit
//  end
//  else
//  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));

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
//  path := vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT';
//  lblTelegramMasuk.Visible := False;
//  lblTelegramTerkirim.Visible := True;
//  LstBxTelegram.Items.Clear;
//
//  if not TDirectory.Exists(path) then
//  begin
//  ShowMessage('Sentbox still empty');
//  Exit
//  end
//  else
//  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));

    if not (TDirectory.Exists('D:\\Telegram\\SENT')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram\\SENT');
    end;

    ShellExecute(0, 'open', ('D:\\Telegram\\SENT'), nil, nil, SW_SHOW);
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
      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
      begin
        cbbxTo.Items.AddObject(userRoleTemp.FData.UserRoleAcronim + ' - ' + userRoleTemp.FSubRoleData.SubRoleIdentifier, userRoleTemp);
      end;
    end;
  end;
end;

end.

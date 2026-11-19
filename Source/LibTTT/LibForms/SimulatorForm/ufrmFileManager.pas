unit ufrmFileManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ImageButton, Vcl.ExtCtrls, uClassData, uT3SimManager, uSimMgr_Client,

  uRecordData, uLibSetting, AdvGroupBox, Vcl.ComCtrls, Winapi.ShellAPI;

type
  TfrmFileManager = class(TForm)
    pnlMainFileManager: TPanel;
    pnlSend: TPanel;
    lblShareTo: TLabel;
    cbbxShareTo: TComboBox;
    imgbtnChooseFile: TImageButton;
    pnlChooseFile: TPanel;
    lblPilihFile: TLabel;
    lstbxFileShareName1: TListBox;
    lblNamaFile: TLabel;
    imgbtnShare: TImageButton;
    pnlShare: TPanel;
    Label1: TLabel;
    lstbxFileShareName: TEdit;
    pnlLeft: TPanel;
    lblFileTransfer: TLabel;
    AdvGroupBox2: TAdvGroupBox;
    pnSend: TPanel;
    pnlTelegramMasuk: TPanel;
    ImgBtnTelegramMasuk: TImageButton;
    lblBtnFileTransferMasuk: TLabel;
    pnlTelegramTerkirim: TPanel;
    ImgBtnTelegramTerkirim: TImageButton;
    lblBtnFileTransferTerkirim: TLabel;
    imgBtnKirimTelegram: TImageButton;
    lblSendFileTransfer: TLabel;
    pnlInbox: TPanel;
    lblInbox: TLabel;
    btnCloseInbox: TImageButton;
    btnCloseSend: TImageButton;
    lvInbox: TListView;
    Label2: TLabel;
    imgbtnOpenInbox: TImageButton;
    lblOpenInbox: TLabel;
    pnlSent: TPanel;
    lblSent: TLabel;
    btnCloseSent: TImageButton;
    imgOpenSent: TImageButton;
    lblOpenSent: TLabel;
    lvSent: TListView;
    procedure cbbxShareToDropDown(Sender: TObject);
    procedure cbbxShareToSelect(Sender: TObject);
    procedure imgbtnChooseFileClick(Sender: TObject);
    procedure imgbtnShareClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblSendFileTransferClick(Sender: TObject);
    procedure lblBtnFileTransferMasukClick(Sender: TObject);
    procedure lblBtnFileTransferTerkirimClick(Sender: TObject);
    procedure lvSentSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvInboxSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lblOpenInboxClick(Sender: TObject);
    procedure lblOpenSentClick(Sender: TObject);
    procedure btnCloseInboxClick(Sender: TObject);
  private
    FConsoleList  : TList;
    FFileTransfer : TList;

    addressTemp     : string;
    AddressPath     : string;
    fileNameTemp    : string;

    consolenameTemp : string;
    ipFileTransferSentTo : string;

    FSelectedFileSharing : TFile_Data;
    FSelectedConsole      : TUserRole;
    SaveUserList          : TStringList;

    SourceFile, DestFolder, DestFile, FileName: string;
    FSelectedUserFileTransfer : TUserRole;
    FSelectedFileTransfer : TFileTransfer;
  public
    { Public declarations }
    SelectedUserRoleIP : string;
    fileNameTempFileSharing : string;
    fileNameArray : array of string;
    pathFileArray : array of string;
    addressTempFileFileSharing : PWideChar;


    procedure UpdateUserListFileSharing;
    procedure UpdateFilenameComboBox;

    {Cicil Cantik}
    procedure UpdateSentFileTransfer;
    procedure UpdateInboxFileTransfer;
  end;

var
  frmFileManager: TfrmFileManager;

implementation

{$R *.dfm}

{ TFileManager }

procedure TfrmFileManager.btnCloseInboxClick(Sender: TObject);
begin
  ipFileTransferSentTo := '';
  pnlSend.Visible := False;
  cbbxShareTo.ItemIndex := -1;
  SetLength(fileNameArray,0);
  SetLength(pathFileArray,0);
  frmFileManager.Width := 214;
end;

procedure TfrmFileManager.cbbxShareToDropDown(Sender: TObject);
begin
  UpdateUserListFileSharing;
end;

procedure TfrmFileManager.cbbxShareToSelect(Sender: TObject);
var
  userRoleTemp : TUserRole;
  ipTemp : string;
begin
  if cbbxShareTo.ItemIndex = -1 then
    Exit;

  FSelectedUserFileTransfer := TUserRole(cbbxShareTo.Items.Objects[cbbxShareTo.ItemIndex]);
  SelectedUserRoleIP := FSelectedUserFileTransfer.ConsoleIP;
end;

procedure TfrmFileManager.FormShow(Sender: TObject);
begin
  cbbxShareTo.ItemIndex := -1;
  lstbxFileShareName.Clear;
end;

procedure TfrmFileManager.imgbtnChooseFileClick(Sender: TObject);
{$REGION ' CAECILIA '}
var
  OpenDialog   : TOpenDialog;
  i            : Integer;
  FileTransfer : string;

  ReceiverID, SenderFolderName, DateTimeNowTemp, SentPath : string;
begin
    if cbbxShareTo.ItemIndex = -1 then
  begin
    ShowMessage('Choose who you want to share file to!');
    Exit;
  end;

  OpenDialog := TOpenDialog.Create(Self);
  try
    FileTransfer := IncludeTrailingPathDelimiter(vGameDataSetting.FileTransfer);

    OpenDialog.InitialDir := FileTransfer;
    OpenDialog.Options    := OpenDialog.Options + [ofAllowMultiSelect];
    OpenDialog.Filter     := 'Dokumen Word (*.doc, *.docx)|*.doc;*.docx|File Word (*.doc, *.docx)|*.doc;*.docx|';

    if OpenDialog.Execute then
    begin
      SourceFile := OpenDialog.FileName;

      ReceiverID       := TUserRole(cbbxShareTo.Items.Objects[cbbxShareTo.ItemIndex]).ConsoleIP;
      SenderFolderName := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '-' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier;

      DateTimeNowTemp := FormatDateTime('dd-mm-yy_hh:nn:ss', Now);
      SentPath        := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'File Transfer\' + cbbxShareTo.Text + '\' + DateTimeNowTemp;

      FileName := ExtractFileName(SourceFile);

      if not DirectoryExists(SentPath) then
        ForceDirectories(SentPath);

      DestFolder := FileTransfer + SenderFolderName + '\' + DateTimeNowTemp;

      if not DirectoryExists(DestFolder) then
        ForceDirectories(DestFolder);

      DestFile := DestFolder + '\' + FileName;

      lstbxFileShareName.Clear;
      lstbxFileShareName.Text := FileName;

    end
    else
    begin
      ShowMessage('Choose file was cancelled');
      Exit;
    end;

  finally
    OpenDialog.Free;
  end;

//  UpdateFilenameComboBox;
end;
{$ENDREGION}
{$REGION ' DENTA '}
//var
//  OpenDialog   : TOpenDialog;
//  i            : Integer;
//  FilePath     : string;
//
//begin
//  OpenDialog := TOpenDialog.Create(Self);
//  try
//    FilePath := IncludeTrailingPathDelimiter(vGameDataSetting.FileSharing);
//
//    OpenDialog.InitialDir := FilePath;
//    OpenDialog.Options    := OpenDialog.Options + [ofAllowMultiSelect];
//    OpenDialog.Filter     := 'All Files (*.*)|*.*';
//
//    SetLength(fileNameArray, 0);
//    SetLength(pathFileArray, 0);
//
//    if OpenDialog.Execute then
//    begin
//      SetLength(pathFileArray, OpenDialog.Files.Count);
//      SetLength(fileNameArray, OpenDialog.Files.Count);
//
//      for i := 0 to OpenDialog.Files.Count - 1 do
//      begin
//        pathFileArray[i] := OpenDialog.Files[i];
//        fileNameArray[i] := ExtractFileName(OpenDialog.Files[i]);
//      end;
//    end
//    else
//    begin
//      ShowMessage('Choose file was cancelled');
//      Exit;
//    end;
//
//  finally
//    OpenDialog.Free;
//  end;
//
//  UpdateFilenameComboBox;
//end;
{$ENDREGION}

procedure TfrmFileManager.imgbtnShareClick(Sender: TObject);
var
  rec : TRecTCPFileTransfer;
//  rec : TRecTCPFileSharing;
//
//  userRoleTemp : TUserRole;
//
//  FS : TFileStream;
//
//  bufferSize : Integer;
//  FolderTemp : string;
//
//  TotalSent : Int64;
//  ChunkNo   : Integer;
//  FileSize  : Int64;
//
//  i : Integer;
begin
  {$REGION ' CICIL CANTIK '}

  {$REGION ' Send File '}
  if CopyFile(PChar(SourceFile), PChar(DestFile), False) then
  begin
    {$REGION ' Send Paket '}
    rec.OrderID := SEND_FILE_TRANSFER;
    rec.SenderUserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
    rec.ReceiverUserRoleId := FSelectedUserFileTransfer.FData.UserRoleIndex;
    rec.FileTransferAddres := DestFolder;
    FillChar(rec.FileTransferMessage, SizeOf(rec.FileTransferMessage), 0);
    rec.FileTransferMessage := FileName;
    rec.FileTransferStatus := 0; {centang1}

    simMgrClient.netSend_CmdSendFileTransfer(rec);
    lstbxFileShareName.Text := '';
    {$ENDREGION}

    ShowMessage('File berhasil dikirim ');
  end
  else
  begin
    ShowMessage('Gagal menyalin file. Kode error Windows: ' + IntToStr(GetLastError));
  end;

  {$ENDREGION}

  {$ENDREGION}
  {$REGION ' DENTA '}
//  if cbbxShareTo.ItemIndex = -1 then
//  begin
//    ShowMessage('Select receiver');
//    Exit;
//  end;
//
//  if Length(pathFileArray) = 0 then
//  begin
//    ShowMessage('Select file first');
//    Exit;
//  end;
//
//  userRoleTemp := TUserRole(cbbxShareTo.Items.Objects[cbbxShareTo.ItemIndex]);
//
//  if not Assigned(userRoleTemp) then
//  begin
//    ShowMessage('Receiver not found');
//    Exit;
//  end;
//
//  for i := 0 to High(pathFileArray) do
//  begin
//
//    if not FileExists(pathFileArray[i]) then
//    begin
//      Continue;
//    end;
//
//    FolderTemp := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '-' +  simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier +
//                '\' + FormatDateTime('dd-mm-yy_hh-nn-ss', Now);
//
//    TotalSent := 0;
//    ChunkNo   := 0;
//    FileSize  := 0;
//
//    try
//      {$REGION 'Send Info'}
//      FillChar(rec, SizeOf(rec), 0);
//
//      rec.OrderID    := SEND_FILE_SHARING_INFO;
//      rec.FileName   := fileNameArray[i];
//      rec.FolderName := FolderTemp;
//
//      FS := TFileStream.Create(pathFileArray[i], fmOpenRead or fmShareDenyNone);
//
//      try
//        FileSize     := FS.Size;
//        rec.FileSize := FileSize;
//      finally
//        FS.Free;
//      end;
//
//      rec.SenderIP           := simMgrClient.MyConsoleData.UserRoleData.ConsoleIP;
//      rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
//      rec.ReceiverUserRoleId := userRoleTemp.FData.UserRoleIndex;
//
//      simMgrClient.netSend_CmdFileSharing(rec);
//      {$ENDREGION}
//
//      {$REGION 'Send File Data'}
//      FS := TFileStream.Create(pathFileArray[i],fmOpenRead or fmShareDenyNone);
//
//      try
//        while FS.Position < FS.Size do
//        begin
//          FillChar(rec, SizeOf(rec),0);
//
//          bufferSize := FS.Read(rec.Data,SizeOf(rec.Data));
//
//          if bufferSize <= 0 then
//            Break;
//
//          Inc(ChunkNo);
//
//          Inc(TotalSent, bufferSize);
//
//          rec.OrderID    := SEND_FILE_SHARING_DATA;
//          rec.FileName   := fileNameArray[i];
//          rec.FolderName := folderTemp;
//          rec.Position   := FS.Position - bufferSize;
//          rec.DataSize   := bufferSize;
//
//          rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
//          rec.ReceiverUserRoleId := userRoleTemp.FData.UserRoleIndex;
//
//          simMgrClient.netSend_CmdFileSharing(rec);
//        end;
//      finally
//        FS.Free;
//      end;
//      {$ENDREGION}
//
//      if TotalSent <> FileSize then
//      begin
//        ShowMessage('File tidak selesai dibaca!' + #13#10 + 'File : ' + fileNameArray[i] + #13#10 + 'File Size  : ' + IntToStr(FileSize) +
//                    ' byte' + #13#10 + 'Total Sent : ' + IntToStr(TotalSent) +' byte' + #13#10 + 'Chunk  : ' + IntToStr(ChunkNo));
//
//        Continue;
//      end;
//
//      {$REGION 'Send Finish'}
//      FillChar(rec, SizeOf(rec), 0);
//      rec.OrderID    := SEND_FILE_SHARING_FINISH;
//      rec.FileName   := fileNameArray[i];
//      rec.FolderName := FolderTemp;
//      rec.FileSize   := FileSize;
//
//      rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
//      rec.ReceiverUserRoleId := userRoleTemp.FData.UserRoleIndex;
//
//      simMgrClient.netSend_CmdFileSharing(rec);
//
////      ShowMessage('File berhasil dikirim!' + #13#10 + 'File  : ' + fileNameArray[i] + #13#10 + 'Size  : ' + IntToStr(TotalSent) +
////                  ' byte' + #13#10 + 'Chunk : ' + IntToStr(ChunkNo));
//      {$ENDREGION}
//    except
//      on E: Exception do
//      begin
//        ShowMessage('Transfer failed : ' + #13#10 + 'File : ' + fileNameArray[i] + #13#10 + E.Message);
//      end;
//    end;
//  end;
  {$ENDREGION}
end;

procedure TfrmFileManager.lblBtnFileTransferMasukClick(Sender: TObject);
begin
  pnlSent.Visible := False;
  pnlSend.Visible := False;
  pnlInbox.Visible := True;
  pnlInbox.BringToFront;
  frmFileManager.Width := 672;

  UpdateInboxFileTransfer;
end;

procedure TfrmFileManager.lblBtnFileTransferTerkirimClick(Sender: TObject);
begin
  pnlInbox.Visible := False;
  pnlSend.Visible := False;
  pnlSent.Visible := True;
  pnlSent.BringToFront;
  frmFileManager.Width := 672;

  UpdateSentFileTransfer;
end;

procedure TfrmFileManager.lblOpenInboxClick(Sender: TObject);
var
  rec : TRecTCPFileTransfer;
  path: string;

  sourceFileTemp : string;

begin
  if FSelectedFileTransfer.FileTransferStatus <> 1 then
  begin
    rec.OrderID := READ_FILE_TRANSFER;
    rec.FileTransferId := FSelectedFileTransfer.IdFileTransfer;
    rec.SenderUserRoleId := FSelectedFileTransfer.IdUserRoleSendingFileTransfer;
    rec.ReceiverUserRoleId := FSelectedFileTransfer.IdUserRoleReceiveFileTransfer;
    rec.FileTransferStatus := 1; {centang1}

    simMgrClient.netSend_CmdSendFileTransfer(rec);
  end;

  sourceFileTemp := FSelectedFileTransfer.FileTransferAddres + '\' + FSelectedFileTransfer.FileTransferMessage;

  path := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'File Transfer\INBOX\';

  if not TDirectory.Exists(path) then
    TDirectory.CreateDirectory(path);

  if CopyFile(PChar(sourceFileTemp), PChar(path), False) then
    ShellExecute(0, 'open', PChar(path), nil, nil, SW_SHOW)
  else
    ShowMessage('Data gagal di buka');
end;

procedure TfrmFileManager.lblOpenSentClick(Sender: TObject);
var
  SentPath: string;
begin
  SentPath := IncludeTrailingPathDelimiter(vGameDataSetting.LocalDirectory) + 'File Transfer\SENT';

  if not TDirectory.Exists(SentPath) then
    TDirectory.CreateDirectory(SentPath);

  ShellExecute(0, 'open', PChar(SentPath), nil, nil, SW_SHOW);
end;

procedure TfrmFileManager.lblSendFileTransferClick(Sender: TObject);
begin
  pnlInbox.Visible := False;
  pnlSent.Visible := False;
  pnlSend.Visible := True;
  pnlSend.BringToFront;
  cbbxShareTo.ItemIndex := -1;
  ipFileTransferSentTo := '';
  frmFileManager.Width := 672;
end;

procedure TfrmFileManager.lvInboxSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  lblOpenInbox.Enabled := Selected;
  imgbtnOpenInbox.Enabled := Selected;

  if Selected then
  begin
    if (Item = nil) or (Item.Data = nil) then
    Exit;

    FSelectedFileTransfer := TFileTransfer(lvInbox.Selected.Data);

  end;
end;

procedure TfrmFileManager.lvSentSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
  begin
    if (Item = nil) or (Item.Data = nil) then
    Exit;

    lblOpenSent.Enabled := True;
    imgOpenSent.Enabled := True;
  end;
end;

procedure TfrmFileManager.UpdateFilenameComboBox;
begin
  lstbxFileShareName.Clear;
//  lstbxFileShareName.Items.AddStrings(TArray<string>(fileNameArray));
end;

procedure TfrmFileManager.UpdateInboxFileTransfer;
var
  tempList : TList;
  li : TListItem;
  i : Integer;
  FileTransferTemp : TFileTransfer;
  namaRole : string;

  userTemp : TUserRole;
begin

  tempList := TList.Create;

  SimManager.SimFileTransfer.GetFileTransferByReceiver(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, tempList);

  lvInbox.Clear;

  for i := 0 to tempList.Count - 1 do
  begin
    FileTransferTemp := tempList.Items[i];

    li := lvInbox.Items.Add;

    userTemp := SimManager.SimUserRole.getUserRoleByID(FileTransferTemp.IdUserRoleSendingFileTransfer);

    if Assigned(userTemp) then
      li.Caption := userTemp.FData.UserRoleIdentifier
    else
      li.Caption := FileTransferTemp.IdUserRoleSendingFileTransfer.ToString;

    li.SubItems.Add(FileTransferTemp.FileTransferMessage);

    {Ngeprint Telegram yg kamu kirim}
    if FileTransferTemp.FileTransferStatus = 0 then
      li.SubItems.Add('Belum Terbaca ')
    else
      li.SubItems.Add('Terbaca ');

    li.Data := FileTransferTemp;

  end;
end;

procedure TfrmFileManager.UpdateSentFileTransfer;
var
  tempList : TList;
  li : TListItem;
  i : Integer;
  FileTransferTemp : TFileTransfer;
  namaRole : string;

  userTemp : TUserRole;
begin

  tempList := TList.Create;

  SimManager.SimFileTransfer.GetFileTransferBySender(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, tempList);

  lvSent.Clear;

  for i := 0 to tempList.Count - 1 do
  begin
    FileTransferTemp := tempList.Items[i];

    li := lvSent.Items.Add;

    userTemp := SimManager.SimUserRole.getUserRoleByID(FileTransferTemp.IdUserRoleSendingFileTransfer);

    if Assigned(userTemp) then
      li.Caption := userTemp.FData.UserRoleIdentifier
    else
      li.Caption := FileTransferTemp.IdUserRoleSendingFileTransfer.ToString;

    li.SubItems.Add(FileTransferTemp.FileTransferMessage);

    {Ngeprint Telegram yg kamu kirim}
    if FileTransferTemp.FileTransferStatus = 0 then
      li.SubItems.Add('Terkirim ')
    else
      li.SubItems.Add('Terbaca ');
  end;
end;

procedure TfrmFileManager.UpdateUserListFileSharing;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  cbbxShareTo.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
    if Assigned(userRoleTemp) then
    begin
      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
      begin
        cbbxShareTo.Items.AddObject(userRoleTemp.FData.UserRoleAcronim + ' - ' + userRoleTemp.FSubRoleData.SubRoleIdentifier, userRoleTemp);
      end;
    end;
  end;

  // Testing
//  {$REGION 'Testing chat diri sendiri'}
//    cbbxShareTo.Items.AddObject('[SELF TEST] ' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim, simMgrClient.MyConsoleData.UserRoleData);
//  {$ENDREGION}
end;

end.

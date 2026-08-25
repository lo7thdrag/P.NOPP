unit ufrmFileManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ImageButton, Vcl.ExtCtrls, uClassData, uT3SimManager, uSimMgr_Client,

  uRecordData, uLibSetting;

type
  TfrmFileManager = class(TForm)
    pnlMainFileManager: TPanel;
    lblFileSharing: TLabel;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    lblShareTo: TLabel;
    cbbxShareTo: TComboBox;
    imgbtnChooseFile: TImageButton;
    pnlChooseFile: TPanel;
    lblPilihFile: TLabel;
    lstbxFileShareName: TListBox;
    lblNamaFile: TLabel;
    imgbtnShare: TImageButton;
    pnlShare: TPanel;
    Label1: TLabel;
    procedure cbbxShareToDropDown(Sender: TObject);
    procedure cbbxShareToSelect(Sender: TObject);
    procedure imgbtnChooseFileClick(Sender: TObject);
    procedure imgbtnShareClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FConsoleList  : TList;
    FFileTransfer : TList;

    addressTemp     : string;
    AddressPath     : string;
    fileNameTemp    : string;

    consolenameTemp : string;

    FSelectedFileSharing : TFile_Data;
    FSelectedConsole      : TUserRole;
    SaveUserList          : TStringList;
  public
    { Public declarations }
    SelectedUserRoleIP : string;
    fileNameTempFileSharing : string;
    fileNameArray : array of string;
    pathFileArray : array of string;
    addressTempFileFileSharing : PWideChar;


    procedure UpdateUserListFileSharing;
    procedure UpdateFilenameComboBox;
  end;

var
  frmFileManager: TfrmFileManager;

implementation

{$R *.dfm}

{ TFileManager }

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

  userRoleTemp := TUserRole(cbbxShareTo.Items.Objects[cbbxShareTo.ItemIndex]);
  SelectedUserRoleIP := userRoleTemp.ConsoleIP;
end;

procedure TfrmFileManager.FormShow(Sender: TObject);
begin
  cbbxShareTo.ItemIndex := -1;
  lstbxFileShareName.Clear;
end;

procedure TfrmFileManager.imgbtnChooseFileClick(Sender: TObject);
var
  OpenDialog   : TOpenDialog;
  i            : Integer;
  FilePath     : string;

begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    FilePath := IncludeTrailingPathDelimiter(vGameDataSetting.FileSharing);

    OpenDialog.InitialDir := FilePath;
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

procedure TfrmFileManager.imgbtnShareClick(Sender: TObject);
var
  rec : TRecTCPFileSharing;

  userRoleTemp : TUserRole;

  FS : TFileStream;

  bufferSize : Integer;
  FolderTemp : string;

  TotalSent : Int64;
  ChunkNo   : Integer;
  FileSize  : Int64;

  i : Integer;
begin
  if cbbxShareTo.ItemIndex = -1 then
  begin
    ShowMessage('Select receiver');
    Exit;
  end;

  if Length(pathFileArray) = 0 then
  begin
    ShowMessage('Select file first');
    Exit;
  end;

  userRoleTemp := TUserRole(cbbxShareTo.Items.Objects[cbbxShareTo.ItemIndex]);

  if not Assigned(userRoleTemp) then
  begin
    ShowMessage('Receiver not found');
    Exit;
  end;

  for i := 0 to High(pathFileArray) do
  begin

    if not FileExists(pathFileArray[i]) then
      Continue;

    FolderTemp := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '\' + FormatDateTime('dd-mm-yy_hh-nn-ss', Now);

    TotalSent := 0;
    ChunkNo   := 0;
    FileSize  := 0;

    try
      {$REGION 'Send Info'}
      FillChar(rec, SizeOf(rec), 0);

      rec.OrderID    := SEND_FILE_SHARING_INFO;
      rec.FileName   := fileNameArray[i];
      rec.FolderName := FolderTemp;

      FS := TFileStream.Create(pathFileArray[i], fmOpenRead or fmShareDenyNone);

      try
        FileSize     := FS.Size;
        rec.FileSize := FileSize;
      finally
        FS.Free;
      end;

      rec.SenderIP           := simMgrClient.MyConsoleData.UserRoleData.ConsoleIP;
      rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
      rec.ReceiverUserRoleId := userRoleTemp.FData.UserRoleIndex;

      simMgrClient.netSend_CmdFileSharing(rec);
      {$ENDREGION}

      {$REGION 'Send File Data'}
      FS := TFileStream.Create(pathFileArray[i],fmOpenRead or fmShareDenyNone);

      try
        while FS.Position < FS.Size do
        begin
          FillChar(rec, SizeOf(rec),0);

          bufferSize := FS.Read(rec.Data,SizeOf(rec.Data));

          if bufferSize <= 0 then
            Break;

          Inc(ChunkNo);

          Inc(TotalSent, bufferSize);

          rec.OrderID    := SEND_FILE_SHARING_DATA;
          rec.FileName   := fileNameArray[i];
          rec.FolderName := folderTemp;
          rec.Position   := FS.Position - bufferSize;
          rec.DataSize   := bufferSize;

          rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
          rec.ReceiverUserRoleId := userRoleTemp.FData.UserRoleIndex;

          simMgrClient.netSend_CmdFileSharing(rec);
        end;
      finally
        FS.Free;
      end;
      {$ENDREGION}

      if TotalSent <> FileSize then
      begin
        ShowMessage('File tidak selesai dibaca!' + #13#10 + 'File : ' + fileNameArray[i] + #13#10 + 'File Size  : ' + IntToStr(FileSize) +
                    ' byte' + #13#10 + 'Total Sent : ' + IntToStr(TotalSent) +' byte' + #13#10 + 'Chunk  : ' + IntToStr(ChunkNo));

        Continue;
      end;

      {$REGION 'Send Finish'}
      FillChar(rec, SizeOf(rec), 0);
      rec.OrderID    := SEND_FILE_SHARING_FINISH;
      rec.FileName   := fileNameArray[i];
      rec.FolderName := FolderTemp;
      rec.FileSize   := FileSize;

      rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
      rec.ReceiverUserRoleId := userRoleTemp.FData.UserRoleIndex;

      simMgrClient.netSend_CmdFileSharing(rec);

      ShowMessage('File berhasil dikirim!' + #13#10 + 'File  : ' + fileNameArray[i] + #13#10 + 'Size  : ' + IntToStr(TotalSent) +
                  ' byte' + #13#10 + 'Chunk : ' + IntToStr(ChunkNo));
      {$ENDREGION}
    except
      on E: Exception do
      begin
        ShowMessage('Transfer failed : ' + #13#10 + 'File : ' + fileNameArray[i] + #13#10 + E.Message);
      end;
    end;
  end;
end;

procedure TfrmFileManager.UpdateFilenameComboBox;
begin
  lstbxFileShareName.Clear;
  lstbxFileShareName.Items.AddStrings(TArray<string>(fileNameArray));
end;

procedure TfrmFileManager.UpdateUserListFileSharing;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  cbbxShareTo.Items.Clear;

//  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
//  begin
//    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
//    if Assigned(userRoleTemp) then
//    begin
//      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
//      begin
//        cbbxShareTo.Items.AddObject(userRoleTemp.FData.UserRoleAcronim + ' - ' + userRoleTemp.FSubRoleData.SubRoleIdentifier, userRoleTemp);
//      end;
//    end;
//  end;

  // Testing
  {$REGION 'Testing chat diri sendiri'}
    cbbxShareTo.Items.AddObject('[SELF TEST] ' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim, simMgrClient.MyConsoleData.UserRoleData);
  {$ENDREGION}
end;

end.

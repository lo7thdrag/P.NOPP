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
  fileTemp     : TFile_Data;

  FS : TFileStream;

  bufferSize : Integer;
  FolderTemp : string;
begin
  if cbbxShareTo.ItemIndex = -1 then
  begin
    ShowMessage('Select receiver');
    exit;
  end;

  if FSelectedFileSharing = nil then
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

  fileTemp := FSelectedFileSharing;

  if not FileExists(fileTemp.FData.Directory_Path) then
  begin
    ShowMessage('File not found');
    Exit;
  end;

  FolderTemp := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '\' + FormatDateTime('dd-mm-yy_hh-nn-ss',Now);

  try
    FillChar(rec,SizeOf(rec),0);

    {$REGION 'SEND FILE INFO'}
    rec.OrderID    := SEND_FILE_SHARING_INFO;
    rec.FileName   := fileTemp.FData.Nama_File;
    rec.FolderName := FolderTemp;

    FS := TFileStream.Create(fileTemp.FData.Directory_Path, fmOpenRead or fmShareDenyNone);

    try
      rec.FileSize := FS.Size;
    finally
      FS.Free;
    end;

    rec.SenderIP           := simMgrClient.MyConsoleData.UserRoleData.ConsoleIP;
    rec.SenderUserRoleId   := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
    rec.ReceiverUserRoleId := userRoleTemp.FData.UserRoleIndex;

    simMgrClient.netSend_CmdFileSharing(rec);
    {$ENDREGION}

    {$REGION 'SEND DATA'}
    FS := TFileStream.Create(fileTemp.FData.Directory_Path, fmOpenRead or fmShareDenyNone);

    try
      while FS.Position < FS.Size do
      begin
        FillChar(rec.Data, SizeOf(rec.Data), 0);

        bufferSize     := FS.Read(rec.Data,SizeOf(rec.Data));
        rec.OrderID    := SEND_FILE_SHARING_DATA;
        rec.FileName   := fileTemp.FData.Nama_File;
        rec.FolderName := FolderTemp;
        rec.Position   := FS.Position - bufferSize;
        rec.DataSize   := bufferSize;

        simMgrClient.netSend_CmdFileSharing(rec);
      end;

    finally
      FS.Free;
    end;
    {$ENDREGION}

    {$REGION 'SEND FINISH'}
    FillChar(rec.Data,SizeOf(rec.Data),0);

    rec.OrderID := SEND_FILE_SHARING_FINISH;
    rec.FileName := fileTemp.FData.Nama_File;
    rec.FolderName := FolderTemp;

    simMgrClient.netSend_CmdFileSharing(rec);

    ShowMessage('File transfer successfully sent');
    {$ENDREGION}

  except
    on E:Exception do
    begin
      ShowMessage('Transfer failed : '+ E.Message);
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

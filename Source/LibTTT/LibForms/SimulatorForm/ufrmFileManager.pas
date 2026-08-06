unit ufrmFileManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ImageButton, Vcl.ExtCtrls, uClassData, uT3SimManager, uSimMgr_Client;

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
    { Private declarations }
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
  addressTemp : string;
  filNameTemp : string;
  openDialog : TOpenDialog;
  saveFileTemp : TFile_Data;
  i: Integer;

begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := 'D:\';
  openDialog.Options := openDialog.Options + [ofAllowMultiSelect];
  openDialog.Filter := 'All Files (*.*)|*.*';

  SetLength(fileNameArray,0);
  SetLength(pathFileArray,0);

  if openDialog.Execute then
  begin
    SetLength(pathFileArray, openDialog.Files.Count);
    SetLength(fileNameArray, openDialog.Files.Count);

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

procedure TfrmFileManager.imgbtnShareClick(Sender: TObject);
var
i : Integer;
addressfiletemp : string;
filenametemp : string;
datetimenowtemp : string;
begin

  if cbbxShareTo.ItemIndex = -1 then
  begin
    ShowMessage('Choose who you want to share file to!');
    exit;
  end
  else if Length(fileNameArray) = 0 then
  begin
    ShowMessage('Choose which file you want to share!');
    exit;
  end
  else if not (TDirectory.Exists('\\' + SelectedUserRoleIP + '\\File Sharing')) then
  begin
    ShowMessage('Share folder doesn''t exist');
    exit;
  end;

  if not (TDirectory.Exists('\\' + SelectedUserRoleIP + '\\' + 'File Sharing' + '\\' + 'FROM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim
              + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now))) then
  begin
    datetimenowtemp := System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now);

    TDirectory.CreateDirectory('\\' + SelectedUserRoleIP + '\\' + 'File Sharing' + '\\' + 'FROM' + '\\' +
     simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + datetimenowtemp);
  end;

  if not (TDirectory.Exists('D:' + '\\' + 'File Sharing' + '\\' + 'SENT TO' + '\\' + cbbxShareTo.Text
              + '\\' + datetimenowtemp)) then
  begin
    TDirectory.CreateDirectory('D:' + '\\' + 'File Sharing' + '\\' + 'SENT TO' + '\\' +
     cbbxShareTo.Text + '\\' + datetimenowtemp);
  end;

  for i := 0 to Length(pathFileArray) - 1 do
  begin
    addressfiletemp := pathFileArray[i];
    filenametemp := fileNameArray[i];

    TFile.Copy(addressfiletemp, '\\' + SelectedUserRoleIP + '\\' + 'File Sharing' + '\\' + 'FROM' + '\\' +
     simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier
     + '\\' + datetimenowtemp + '\\' + filenametemp);

    TFile.Copy(addressfiletemp, 'D:' + '\\' + 'File Sharing' + '\\' + 'SENT TO' + '\\' +
     cbbxShareTo.Text + '\\' + datetimenowtemp + '\\' + filenametemp);
  end;

  Close;

  ShowMessage('File has been Successfully Sent!');
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
end;

end.

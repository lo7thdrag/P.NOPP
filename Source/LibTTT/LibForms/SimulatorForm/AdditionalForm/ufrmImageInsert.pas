unit ufrmImageInsert;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs,

  {Project Uses}
  uClassData, uT3SimManager, uSimMgr_Client, uRecordData, uLibSetting;

type
  TfrmImageInsert = class(TForm)
    lbl1: TLabel;
    edtAddress: TEdit;
    dlgOpenPic1: TOpenPictureDialog;
    Button1: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FFileName : string;
    FFileExt : string;

  public
    TabId : Integer;
    TabCaption : string;

  end;

var
  frmImageInsert: TfrmImageInsert;

implementation

{$R *.dfm}

procedure TfrmImageInsert.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImageInsert.btnOKClick(Sender: TObject);
var
  fileAddressTemp : string;
  rec : TRecTCPSendSituationBoardTabProperties;

begin
  {Create Folder Tingkat User Role}
  fileAddressTemp := '\' + IntToStr(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex);
  CreateDir(vMapSetting.ImageGame + fileAddressTemp);

  {Create Folder Tingkat Tab}
  fileAddressTemp := fileAddressTemp + '\' + TabCaption;
  CreateDir(vMapSetting.ImageGame + fileAddressTemp);

  {Create File Name}
  fileAddressTemp := fileAddressTemp + '\' + TabCaption + FFileExt ;

  rec.OrderID := EDIT_TAB;
  rec.TabId := TabId;
  rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
  rec.TabAddres := fileAddressTemp;
  rec.TabCaption := TabCaption;

  simMgrClient.netSend_CmdSituationBoardTabProperties(rec);

  CopyFile(PWideChar(edtAddress.Text), PWideChar(vMapSetting.ImageGame + fileAddressTemp), False);
  Close;
end;

procedure TfrmImageInsert.Button1Click(Sender: TObject);
begin
  if dlgOpenPic1.Execute then
  begin
    FFileName := ExtractFileName(dlgOpenPic1.FileName);
    FFileExt := ExtractFileExt(dlgOpenPic1.FileName);

    edtAddress.Text := dlgOpenPic1.FileName;
  end;
end;

procedure TfrmImageInsert.FormActivate(Sender: TObject);
begin
  edtAddress.Text := '';
end;

end.

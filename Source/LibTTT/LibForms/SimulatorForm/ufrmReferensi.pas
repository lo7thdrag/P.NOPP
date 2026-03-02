unit ufrmReferensi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uConstantaData, uRecordData,
  RzBmpBtn;

type
  TfrmReferensi = class(TForm)
    pnlMain: TPanel;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    Panel1: TPanel;
    imgReferensi: TImage;
    Label2: TLabel;
    Label3: TLabel;
    edtNameDocument: TEdit;
    Label5: TLabel;
    edtKategori: TEdit;
    btnOk: TRzBmpButton;
    btnApply: TRzBmpButton;
    btnCancel: TRzBmpButton;
    btnUpload: TRzBmpButton;
    procedure btnUploadClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editKategoriChange(Sender: TObject);
    procedure edtNameDocumentChange(Sender: TObject);
  private
    FSelectedReferensi : TFile_Data;
    FAddressPath  : string;
    function CekInput: Boolean;

    procedure UpdateReferensi;
  public
    { Public declarations }
    isOk : Boolean;
    AfterClose : Boolean;

    property SelectedReferensi : TFile_Data read FSelectedReferensi write FSelectedReferensi;
  end;

var
  frmReferensi: TfrmReferensi;

implementation

{$R *.dfm}

{$REGION 'Form Event'}

procedure TfrmReferensi.FormShow(Sender: TObject);
var
  fileDataTemp : TRecFile_Data;
begin
  UpdateReferensi;

  with FSelectedReferensi.FData do
    btnApply.Enabled := ID_File = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION 'Button Event'}

procedure TfrmReferensi.btnUploadClick(Sender: TObject);
var
  addressTemp : PWideChar;
  fileNameTemp : string;
  saveDialog : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecFile_Data;

  fileExt: string;
  fileType: TFileExtention;

begin
  saveDialog := TSaveDialog.Create(self);
  saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter :=  'Word file (*.docx; *.doc)|*.docx;*.doc|' +
                        'Excel file (*.xls; *.xlsx)|*.xls;*.xlsx|' +
                        'Power Point file (*.pptx; *.ppt)|*.pptx;*.ppt|' +
                        'PDF file (*.pdf)|*.pdf|' +
                        'Image Files (*.png; *.jpeg; *.jpg)|*.png;*.jpeg;*.jpg';
  saveDialog.DefaultExt := 'docx';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute then
  begin
    FAddressPath := PWideChar(saveDialog.FileName);

    btnApply.Enabled := True;
  end
  else
  ShowMessage('Save file was cancelled');

  saveDialog.Free;
end;

procedure TfrmReferensi.btnApplyClick(Sender: TObject);
var
  addressTemp  : PWideChar;
  saveDialog   : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecFile_Data;

  fileNameTemp : string;

begin
    saveDialog := TSaveDialog.Create(self);

    with FSelectedReferensi.FData do
    begin
      Nama_File           := edtNameDocument.Text;
      Directory_Path      := vGameDataSetting.FileReferensi;
      Encripted_File_Name := ExtractFileName(FAddressPath);
      Tipe_File           := ExtractFileExt(FAddressPath);
      Modified_Date       := DateToStr(Now);
      Kategori            := edtKategori.Text;
      Modified_By         := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier;
      id_User             := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;

      if not CekInput then
      begin
        isOK := False;
        Exit;
      end;

      if ID_File = 0 then
      begin
        if dmINWO.InsertReferensi(FSelectedReferensi.FData) then
        begin
          ShowMessage('Data has been saved');
        end
      end
      else
      begin
        if dmINWO.UpdateFile(FSelectedReferensi.FData) then
        begin
          ShowMessage('Data has been updated');
        end;
      end;

     CopyFile(PWideChar(FAddressPath), PWideChar(vGameDataSetting.FileReferensi + '\' + IntToStr(ID_File) + Tipe_File), False);

    end;

    FAddressPath := '';
    isOK := True;
    AfterClose := True;
    btnApply.Enabled := False;
    btnCancel.Enabled := False;
end;

procedure TfrmReferensi.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmReferensi.btnOkClick(Sender: TObject);
begin
  if btnApply.Enabled then
  btnApplyClick(btnApply);

  if isOk then
    Close;
end;

{$ENDREGION}

{$REGION 'Filter Event'}

procedure TfrmReferensi.editKategoriChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

function TfrmReferensi.CekInput: Boolean;
var
  addressTemp : PWideChar;
  fileDataTemp : TRecFile_Data;
begin
  Result := False;

  if (edtNameDocument.Text = '') or (edtKategori.Text = '') then
  begin
    ShowMessage('Incomplete data input');
    Exit;
  end;

  if FAddressPath = '' then
  begin
    ShowMessage('Incomplete document input');
    Exit;
  end;

  if (dmINWO.GetFilterByReferensi(FSelectedReferensi.FData)>0) and (FSelectedReferensi.FData.ID_File = 0)then
  begin
    ShowMessage('Data already exists in the database');
    Exit;
  end;

  Result := True;
end;

procedure TfrmReferensi.edtNameDocumentChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION 'Additional Event'}

procedure TfrmReferensi.UpdateReferensi;
var
  docPath : string;
begin
  if Assigned(FSelectedReferensi) then
  begin
    with FSelectedReferensi.FData do
    begin
      edtKategori.Text     := Kategori;
      edtNameDocument.Text := Nama_File;

      if ID_File = 0 then
        exit;

      docPath := Directory_Path + '\' + IntToStr(ID_File) + Tipe_File;
      if FileExists(docPath) then
      begin
        FAddressPath := docPath;
      end;
    end;
  end;
end;

{$ENDREGION}

end.

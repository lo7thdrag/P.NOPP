unit ufrmSimbolTaktis;

interface

uses
  {uses Delphi}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uRecordData, RzBmpBtn;

type
  TfrmSimbolTaktis = class(TForm)
    pnlMain: TPanel;
    lbl14: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    imgSimbolTaktisRed: TImage;
    edtKeterangan: TEdit;
    cbbTipe: TComboBox;
    cbbKategori: TComboBox;
    UploadImage: TOpenDialog;
    ImgBackgroundForm: TImage;
    Label2: TLabel;
    lblPlatform: TLabel;
    Panel1: TPanel;
    btnOk: TRzBmpButton;
    btnApply: TRzBmpButton;
    btnCancel: TRzBmpButton;
    btnUploadRed: TRzBmpButton;
    imgSimbolTaktisBlue: TImage;
    Label4: TLabel;
    btnUploadBlue: TRzBmpButton;
    imgSimbolTaktisBlack: TImage;
    Label5: TLabel;
    btnUploadBlack: TRzBmpButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnUploadBlackClick(Sender: TObject);
    procedure btnUploadBlueClick(Sender: TObject);
    procedure btnUploadRedClick(Sender: TObject);
    procedure cbbTipeChange(Sender: TObject);
    procedure cbbKategoriChange(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtKeteranganChange(Sender: TObject);

  private
    FSelectedTacticalSymbol : TTactical_Symbol;
    FPathDirectory   : string;
    FAddressPath     : string;
    FAddressPathBlue : string;
    FAddressPathRed  : string;

    function CekInput: Boolean;

    procedure UpdateTacticalSymbol;

  public
    { Public declarations }
     isOK : Boolean;
     AfterClose : Boolean;

     property SelectedTacticalSymbol : TTactical_Symbol read FSelectedTacticalSymbol write FSelectedTacticalSymbol;
  end;

var
  frmSimbolTaktis: TfrmSimbolTaktis;

implementation

{$R *.dfm}

{$REGION 'Form Event'}

procedure TfrmSimbolTaktis.FormShow(Sender: TObject);
var
  fileDataTemp : TRecTactical_Symbol;
begin
  UpdateTacticalSymbol;

  if Assigned(FSelectedTacticalSymbol) then
  begin
    if FSelectedTacticalSymbol.FData.Id_Tactical_Symbol = 0 then
    begin
      btnApply.Enabled := True;
      btnApply.Visible := True;
    end
    else
    begin
      btnApply.Enabled := True;
      btnApply.Visible := True;
    end;
  end;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;

  btnApply.Visible  := True;
  btnCancel.Visible := True;
  btnOk.Visible     := True;
end;

{$ENDREGION}

{$REGION 'Button Event'}
procedure TfrmSimbolTaktis.btnUploadBlackClick(Sender: TObject);
var
  saveFileTemp : TTactical_Symbol;
begin
  UploadImage := TSaveDialog.Create(self);
  UploadImage.InitialDir := GetCurrentDir;
  UploadImage.Filter := 'Image Files(*.png)|*.png';
  UploadImage.DefaultExt := 'png';
  UploadImage.FilterIndex := 1;

  if UploadImage.Execute then
  begin
    FAddressPath := PWideChar(UploadImage.FileName);

    imgSimbolTaktisBlack.Picture.LoadFromFile(FAddressPath);

    btnApply.Enabled := True;
  end
  else
  ShowMessage('Save file was cancelled');

  UploadImage.Free;
end;

procedure TfrmSimbolTaktis.btnUploadBlueClick(Sender: TObject);
var
  saveFileTemp : TTactical_Symbol;
begin
  UploadImage := TSaveDialog.Create(self);
  UploadImage.InitialDir := GetCurrentDir;
  UploadImage.Filter := 'Image Files(*.png)|*.png';
  UploadImage.DefaultExt := 'png';
  UploadImage.FilterIndex := 1;

  if UploadImage.Execute then
  begin
    FAddressPathBlue := PWideChar(UploadImage.FileName);

    imgSimbolTaktisBlue.Picture.LoadFromFile(FAddressPathBlue);

    btnApply.Enabled := True;
  end
  else
  ShowMessage('Save file was cancelled');

  UploadImage.Free;
end;

procedure TfrmSimbolTaktis.btnUploadRedClick(Sender: TObject);
var
  saveFileTemp : TTactical_Symbol;
begin
  UploadImage := TSaveDialog.Create(self);
  UploadImage.InitialDir := GetCurrentDir;
  UploadImage.Filter := 'Image Files(*.png)|*.png';
  UploadImage.DefaultExt := 'png';
  UploadImage.FilterIndex := 1;

  if UploadImage.Execute then
  begin
    FAddressPathRed := PWideChar(UploadImage.FileName);

    imgSimbolTaktisRed.Picture.LoadFromFile(FAddressPathRed);

    btnApply.Enabled := True;
  end
  else
  ShowMessage('Save file was cancelled');

  UploadImage.Free;
end;

procedure TfrmSimbolTaktis.cbbKategoriChange(Sender: TObject);
begin
  if cbbKategori.ItemIndex = 0 then
    cbbKategori.ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSimbolTaktis.cbbTipeChange(Sender: TObject);
begin
  if cbbTipe.ItemIndex = 0 then
    cbbTipe.ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSimbolTaktis.btnApplyClick(Sender: TObject);
begin

  with FSelectedTacticalSymbol.FData do
  begin
    Tipe            := cbbTipe.ItemIndex;
    Kategori        := cbbKategori.ItemIndex;
    Keterangan      := edtKeterangan.Text;
    Path_Directori  := vGameDataSetting.FileSimbolTaktis;

    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    if Id_Tactical_Symbol = 0 then
    begin
      if dmINWO.InsertTacticalSymbol(FSelectedTacticalSymbol.FData) then
      begin
        ShowMessage('Data has been saved');
      end
    end
    else
    begin
      if dmINWO.UpdateTacticalSymbol(FSelectedTacticalSymbol.FData) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;

    CopyFile(PWideChar(FAddressPath), PWideChar(vGameDataSetting.FileSimbolTaktis + '\'+ IntToStr(Id_Tactical_Symbol) + '.png'), False);
    CopyFile(PWideChar(FAddressPathBlue), PWideChar(vGameDataSetting.FileSimbolTaktis + '\'+ IntToStr(Id_Tactical_Symbol) + '_Blue.png'), False);
    CopyFile(PWideChar(FAddressPathRed), PWideChar(vGameDataSetting.FileSimbolTaktis + '\'+ IntToStr(Id_Tactical_Symbol) + '_Red.png'), False);
  end;

  FAddressPath     := '';
  FAddressPathBlue := '';
  FAddressPathRed  := '';
  isOK := True;
  AfterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;

  btnApply.Visible := False;
  btnCancel.Visible := False;
end;

procedure TfrmSimbolTaktis.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSimbolTaktis.btnOkClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApplyClick(btnApply);

  if isOk then
    Close;
end;

{$ENDREGION}

{$REGION 'Filter Event'}

function TfrmSimbolTaktis.CekInput: Boolean;
var
  fileDataTemp : TRecTactical_Symbol;
  addressTemp  : PWideChar;
begin
  Result := False;

  if cbbTipe.ItemIndex = -1 then
  begin
    ShowMessage('Double check your type');
    Exit;
  end;

  if cbbKategori.ItemIndex = -1 then
  begin
    ShowMessage('Double check your type');
    Exit;
  end;

  {Data ada yg kosong}
  if (edtKeterangan.Text = '') then
  begin
    ShowMessage('Inputan data tidak lengkap');
    Exit;
  end;

  if FAddressPath = '' then
  begin
    ShowMessage('Incomplete data input');
    Exit;
  end;

  if FAddressPathBlue = '' then
  begin
    ShowMessage('Incomplete data input');
    Exit;
  end;

  if FAddressPathRed = '' then
  begin
    ShowMessage('Incomplete image input');
    Exit;
  end;

  {Data sudah ada}
  if (dmINWO.GetFilterByTactical(FSelectedTacticalSymbol.FData)>0) and (FSelectedTacticalSymbol.FData.Id_Tactical_Symbol = 0)then
  begin
    ShowMessage('Data already exists in the database');
    Exit;
  end;
  Result := True;
end;

procedure TfrmSimbolTaktis.edtKeteranganChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION 'Additional Event'}

procedure TfrmSimbolTaktis.UpdateTacticalSymbol;
var
  imagepathBlack, imagepathBlue : string;
  imagepathRed : string;
begin
  if Assigned(FSelectedTacticalSymbol) then
  begin
    with FSelectedTacticalSymbol.FData do
    begin
      cbbTipe.ItemIndex     := Tipe;
      cbbKategori.ItemIndex := Kategori;
      edtKeterangan.Text    := Keterangan;

      if Id_Tactical_Symbol = 0 then
        Exit;

      imagePathBlack := Path_Directori + '\' + IntToStr(Id_Tactical_Symbol) + '.png';
      imagepathBlue  := Path_Directori + '\' + IntToStr(Id_Tactical_Symbol) + '_Blue.png';
      imagepathRed   := Path_Directori + '\' + IntToStr(Id_Tactical_Symbol) + '_Red.png';

      if FileExists(imagePathBlack) then
      begin
        imgSimbolTaktisBlack.Picture.LoadFromFile(imagePathBlack);
        FAddressPath := imagePathBlack;
      end
      else
      begin
          ShowMessage('Image file not found' + imagePathBlack);
      end;

      if FileExists(imagepathBlue) then
      begin
        imgSimbolTaktisBlue.Picture.LoadFromFile(imagepathBlue);
        FAddressPathBlue := imagepathBlue;
      end
      else
      begin
          ShowMessage('Image file not found' + imagepathBlue);
      end;

      if FileExists(imagepathRed) then
      begin
        imgSimbolTaktisRed.Picture.LoadFromFile(imagepathRed);
        FAddressPathRed := imagepathRed;
      end
      else
      begin
          ShowMessage('Image file not found' + imagepathRed);
      end;
    end;
  end;
end;
{$ENDREGION}

end.

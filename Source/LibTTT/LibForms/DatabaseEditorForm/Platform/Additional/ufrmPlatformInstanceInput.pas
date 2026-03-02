unit ufrmPlatformInstanceInput;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage
  {uDBAssetObject, uDBAsset_Vehicle};

type
  TfrmPlatformInstanceInput = class(TForm)
    Image: TImage;
    ImgBackgroundForm: TImage;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtName: TEdit;
    pnl2ModelImage: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    edtModelPath: TEdit;
    btnOpenFile: TSpeedButton;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);


    procedure edtChange(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);


  private
//    FSelectedVehicle : TVehicle_Definition;
//    FSelectedPIIdent : TPlatform_Instance_Identifier;

    procedure UpdatePIIdentData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;
//    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;
//    property SelectedPIIdent : TPlatform_Instance_Identifier read FSelectedPIIdent write FSelectedPIIdent;

  end;

var
  frmPlatformInstanceInput: TfrmPlatformInstanceInput;

implementation

uses
  uDataModule;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmPlatformInstanceInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmPlatformInstanceInput.FormShow(Sender: TObject);
begin
//  UpdatePIIdentData;
//
//  with FSelectedPIIdent.FData do
//    btnOK.Enabled := Instance_Ident_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmPlatformInstanceInput.btnOKClick(Sender: TObject);
var
  i, chkSpace, numSpace: Integer;
begin
//
//  {$REGION ' Jika inputan class name kosong '}
//  if edtName.Text = '' then
//  begin
//    ShowMessage('Please insert platform instance name');
//    Exit;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Jika berisi spasi semua '}
//  if Copy(edtName.Text, 1, 1) = ' ' then
//  begin
//    chkSpace := Length(edtName.Text);
//    numSpace := 0;
//
//    for i := 1 to chkSpace do
//    begin
//      if edtName.Text[i] = #32 then
//      numSpace := numSpace + 1;
//    end;
//
//    if chkSpace = numSpace then
//    begin
//      ShowMessage('Please use another platform instance name');
//      Exit;
//    end;
//  end;
//  {$ENDREGION}
//
//  {$REGION ' Jika Platform Instance Name sudah ada '}
//  if (dmTTT.GetPlatformInstanceIdentifier(FSelectedVehicle.FData.Vehicle_Index, edtName.Text) > 0) then
//  begin
//    {Jika inputan baru}
//    if FSelectedPIIdent.FData.Instance_Ident_Index = 0 then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end
//    else if LastName <> edtName.Text then
//    begin
//      ShowMessage('Please use another class name');
//      Exit;
//    end;
//  end;
//  {$ENDREGION}
//
//  with FSelectedPIIdent do
//  begin
//    FData.Vehicle_Index := FSelectedVehicle.FData.Vehicle_Index;
//    FData.Instance_Identifier := edtName.Text;
//    FData.model_path := edtModelPath.Text;
//    FData.vbs_class_name := edtModelPath.Text;
//
//    if FData.Instance_Ident_Index = 0 then
//    begin
//      if dmTTT.InsertPlatformInstanceIdentifier(FData) then
//        ShowMessage('Data has been saved');
//    end
//    else
//    begin
//      if dmTTT.UpdatePlatformInstanceIdentifier(FData) then
//        ShowMessage('Data has been updated');
//    end;
//  end;
//
//  isOK := True;
//  AfterClose := True;
//  Close;
end;

procedure TfrmPlatformInstanceInput.btnOpenFileClick(Sender: TObject);
//var
//  opDialog : TOpenDialog;
begin
  if edtModelPath.Text = '' then
  begin
    ShowMessage('Please insert vehicle id');
  end;

  try
    Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + edtModelPath.Text + '.PNG');
    btnOK.Enabled := True;
  except
    ShowMessage('Model is not found');
  end;
//  opDialog := TOpenDialog.Create(Self);
//  opDialog.InitialDir := GetCurrentDir;
//
//  opDialog.Options := [ofFileMustExist];
//
//  opDialog.Filter := 'PNG|*.PNG';
//
//  if opDialog.Execute then
//  begin
//    edtModelPath.Text := opDialog.FileName;
//
//    Image.Picture.LoadFromFile(opDialog.FileName);
//    btnOK.Enabled := True;
//  end
//  else
//    ShowMessage('Open file was canceled');
//
//  opDialog.Free;
end;

procedure TfrmPlatformInstanceInput.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmPlatformInstanceInput.edtChange(Sender: TObject);
begin
  btnOK.Enabled := True;
end;

procedure TfrmPlatformInstanceInput.UpdatePIIdentData;
begin
//  with FSelectedPIIdent do
//  begin
//    if FData.Instance_Ident_Index = 0 then
//      edtName.Text := '(Unnamed)'
//    else
//      edtName.Text := FData.Instance_Identifier;
//
//    LastName := FData.Instance_Identifier;
//    edtModelPath.Text := FData.vbs_class_name;
//
//    try
//      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + edtModelPath.Text + '.PNG');
//    except
//    end;
//  end;
end;

{$ENDREGION}

end.

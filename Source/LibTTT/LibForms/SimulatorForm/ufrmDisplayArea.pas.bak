unit ufrmDisplayArea;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Winapi.ShellAPI, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.WinXCalendars, AdvTimePickerDropDown, Vcl.FileCtrl,

  {Project Uses}
  uRecordData, uConstantaData, uSimMgr_Client, uT3SimManager, uClassData, ufrmVideoConference, ufrmSituationBoard,
  ufrmTelegram, uLibSetting, uSimContainers, ufrmSummaryUserRole, ufrmAvailableUserRole , UfrmMapEditor, ufrmSimbolTaktis,
  ufrmAsset, ufrmReferensi, ufrmMapPreview;

type
  TfrmDisplayArea = class(TForm)
    pnlTop: TPanel;
    pnlLeft: TPanel;
    pnlCenter: TPanel;
    pnlMainCenter: TPanel;
    pnlMenejemenPengguna: TPanel;
    pnlMenejemenSimbolTaktis: TPanel;
    pnlMenejemenPeta: TPanel;
    pnlMenejemenReferensi: TPanel;
    imgMainBackground: TImage;
    pnlMainChatting: TPanel;
    pnlRight: TPanel;
    pnlMainBackground: TPanel;
    pnlLogout: TPanel;
    btnLogout: TSpeedButton;
    lblLogOut: TLabel;
    pnlResources: TPanel;
    pnlBottomResources: TPanel;
    pnlUserRole: TPanel;
    btnUserRole: TSpeedButton;
    lblUserRole: TLabel;
    pnlHeaderResouces: TPanel;
    SpeedButton3: TSpeedButton;
    lblResources: TLabel;
    pnlAsset: TPanel;
    btnAsset: TSpeedButton;
    lblAsset: TLabel;
    pnlTacticalSymbol: TPanel;
    btnTacticalSymbol: TSpeedButton;
    lblTacticalSymbol: TLabel;
    PnlMap: TPanel;
    btnMap: TSpeedButton;
    lblMap: TLabel;
    pnlReference: TPanel;
    SpeedButton7: TSpeedButton;
    lblReferensi: TLabel;
    pnlServices: TPanel;
    pnlBottomServices: TPanel;
    pnlOfficeEditor: TPanel;
    btnOfficeEditor: TSpeedButton;
    lblOfficeEditor: TLabel;
    pnlHeaderServices: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    pnlSituationBoard: TPanel;
    btnSituationBoard: TSpeedButton;
    lblSituationBoard: TLabel;
    pnlChatting: TPanel;
    btnChatting: TSpeedButton;
    lblChatting: TLabel;
    pnlTelegram: TPanel;
    btnTelegram: TSpeedButton;
    lblTelegram: TLabel;
    pnlVideoConference: TPanel;
    btnVideoConference: TSpeedButton;
    lblVideoConference: TLabel;
    mmoChat: TMemo;
    pnlSparatorchat: TPanel;
    pnlBottomChat: TPanel;
    btnSendChat: TButton;
    pnlHeaderChat: TPanel;
    btnMessageChat: TSpeedButton;
    btnCloseChat: TSpeedButton;
    btnUserChat: TSpeedButton;
    pnlMainOfficeEditor: TPanel;
    Panel5: TPanel;
    imgMsWord: TImage;
    imgMsExcel: TImage;
    imgMsPowerPoint: TImage;
    imgMsPaint: TImage;
    Label8: TLabel;
    Panel1: TPanel;
    SpeedButton4: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    edtChatBox: TEdit;
    imgChrome: TImage;
    Panel7: TPanel;
    pnlMyDesktop: TPanel;
    btnMyDesktop: TSpeedButton;
    lblMyDesktop: TLabel;
    pnlMenejemenBeranda: TPanel;
    pnlTopSide: TPanel;
    pnlSeparatorBawah: TPanel;
    pnlLogoHeader: TPanel;
    btnAOTC: TSpeedButton;
    lblOrganisasiTugas: TLabel;
    pnlSparatorAtas: TPanel;
    pnlListMyFile: TPanel;
    pnlMdmConsoleName: TPanel;
    Label2: TLabel;
    pnlHeaderMyDeskstop: TPanel;
    ilClientStateColor: TImageList;
    pnlCariPengguna: TPanel;
    pnlListPengguna: TPanel;
    cbbSearchType: TComboBox;
    cbbxFilterSearch: TComboBox;
    lblsearch: TLabel;
    lvUserRole: TListView;
    pnlCariReferensi: TPanel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    pnlListReferensi: TPanel;
    lvReferensi: TListView;
    pnlCariPeta: TPanel;
    Label9: TLabel;
    pnlListPeta: TPanel;
    lvGameArea: TListView;
    pnlCariSimbolTaktis: TPanel;
    Label10: TLabel;
    cbbSearchTipe: TComboBox;
    cbbFilterSearch: TComboBox;
    pnlListSImbolTaktis: TPanel;
    lvTacticalSymbol: TListView;
    lblConsoleName: TLabel;
    pnlMdmOrganisasiTugas: TPanel;
    Label12: TLabel;
    pnlMdmUserRole: TPanel;
    Label14: TLabel;
    lblRole: TLabel;
    lblSubRole: TLabel;
    pnlMdmTahapan: TPanel;
    Label5: TLabel;
    lblUserRoleIdentifier: TLabel;
    lvFileData: TListView;
    pnlHeaderFileData: TPanel;
    Label3: TLabel;
    edtCari: TEdit;
    pnlMdmTools: TPanel;
    pnlSparMdm: TPanel;
    AdvWatch1: TAdvWatch;
    CalendarView1: TCalendarView;
    pnlMdmMainLeft: TPanel;
    pnlHeaderBeranda: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Memo1: TMemo;
    Label6: TLabel;
    pnlHeaderPengguna: TPanel;
    Label7: TLabel;
    pnlSparBottom: TPanel;
    pnlSparLeft: TPanel;
    pnlSparRight: TPanel;
    pnlHeaderReferensi: TPanel;
    Label13: TLabel;
    pnlHeaderSimbolTaktis: TPanel;
    Label15: TLabel;
    pnlHeaderPeta: TPanel;
    Label16: TLabel;
    lstUserChat: TListBox;
    imgUpload: TImage;
    imgDownload: TImage;
    imgHapus: TImage;
    edtSearch: TEdit;
    edtSearchMap: TEdit;
    btnAddTacticalSymbol: TImage;
    btnEditTacticalSymbol: TImage;
    btnDeleteTacticalSymbol: TImage;
    edtTacticalSearch: TEdit;
    pnlRightTactical: TPanel;
    imgPreview: TImage;
    Image1: TImage;
    Label11: TLabel;
    pnlKeteranganGambar: TPanel;
    Label17: TLabel;
    lblKeterangan: TLabel;
    lblTipe: TLabel;
    lblKategori: TLabel;
    Image2: TImage;
    lblNamaGambar: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    pnlMenejemenAsset: TPanel;
    pnlHeaderAsset: TPanel;
    Label18: TLabel;
    pnlCariAsset: TPanel;
    Label19: TLabel;
    pnlListAsset: TPanel;
    lvAsset: TListView;
    Image7: TImage;
    Image8: TImage;
    btnPreview: TImage;
    Image9: TImage;
    Image6: TImage;
    btnAddAsset: TImage;
    btnEditAsset: TImage;
    btnDeleteAsset: TImage;
    btnUnduh: TImage;
    cbbFilter: TComboBox;
    cbbSearch: TComboBox;
    editSearch: TEdit;
    Button1: TButton;

    procedure btnAOTCClick(Sender: TObject);

    {$REGION ' Form Procedure '}
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    {$ENDREGION}

    {$REGION ' Beranda Procedure '}
    procedure BerandaClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);

    procedure lvFileDataSelectItem(Sender: TObject; Item: TListItem;Selected: Boolean);
    procedure pnlBerandaManajemenShow;
    procedure UpdateDataFile;
    {$ENDREGION}

    {$REGION ' Asset Procedure '}
    procedure AssetClick(Sender: TObject);
    procedure pnlAsetManajemenShow;
    procedure UpdateDataAset;
    {$ENDREGION}

    {$REGION ' Simbol Taktis Procedure '}
    procedure SimbolTaktisClick(Sender: TObject);
    procedure btnAddTacticalSymbolClick(Sender: TObject);
    procedure btnEditTacticalSymbolClick(Sender: TObject);
    procedure btnDeleteTacticalSymbolClick(Sender: TObject);
    procedure edtSearchKeyPressTactical(Sender: TObject; var Key: Char);

    procedure cbbFilterSearchSelect(Sender: TObject);
    procedure cbbSearchtipeSelect(Sender: TObject);
    procedure lvTacticalSymbolleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btnUnduhClick(Sender: TObject);

    procedure pnlSimbolTaktisManajemenShow;
    procedure UpdateSimbolTaktis;
    {$ENDREGION}

    {$REGION ' Pengguna Procedure '}
    procedure PenggunaClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);

    procedure cbbxFilterSearchSelect(Sender: TObject);
    procedure cbbSearchTypeSelect(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure lvUserRoleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

    procedure pnlPenggunaManajemenShow;
    procedure UpdateDataPengguna;
    {$ENDREGION}

    {$REGION ' Peta Procedure '}
    procedure PetaClick(Sender: TObject);
    procedure btnAddMapClick(Sender: TObject);
    procedure btnEditMapClick(Sender: TObject);
    procedure btnDeleteMapClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure lvGameAreaSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure edtSearchMapKeyPress(Sender: TObject; var Key: Char);
    procedure DeleteGameAreaDirectory(const aPathName, aFileName: string);
    procedure pnlPetaManajemenShow;
    procedure UpdateGameAreaList;
    {$ENDREGION}

    {$REGION ' Referensi Procedure '}
    procedure ReferensiClick(Sender: TObject);

    procedure btnUploadReferensiClick(Sender: TObject);
    procedure btnDownloadReferensiClick(Sender: TObject);
    procedure pnlReferensiShow;
    procedure UpdateDataReferensi;
    {$ENDREGION}
    
    {$REGION ' Office Editor Procedure '}
    procedure OfficeEditorClick(Sender: TObject);
    procedure imgMsPaintClick(Sender: TObject);
    procedure imgMsPowerPointClick(Sender: TObject);
    procedure imgMsExcelClick(Sender: TObject);
    procedure imgMsWordClick(Sender: TObject);
    procedure imgChromeClick(Sender: TObject);

    procedure IconMenuMouseEnter(Sender: TObject);
    procedure IconMenuMouseLeave(Sender: TObject);
    procedure IconLoad;
    {$ENDREGION}

    {$REGION ' Situation Board Procedure '}
    procedure SituationBoardClick(Sender: TObject);
    {$ENDREGION}
    
    {$REGION ' Obrolan Procedure '}
    procedure ObrolanClick(Sender: TObject);
    procedure btnUserChatClick(Sender: TObject);
    procedure btnMessageChatClick(Sender: TObject);
    procedure btnCloseChatClick(Sender: TObject);
    procedure lstUserChatDblClick(Sender: TObject);

    {$ENDREGION}
     
    {$REGION ' Telegram Procedure '}
    procedure TelegramClick(Sender: TObject);
    {$ENDREGION}

    {$REGION ' Video Conference Procedure '}
    procedure VideoConferenceClick(Sender: TObject);
    {$ENDREGION}

    procedure LogOutClick(Sender: TObject);

    procedure btnSendChatClick(Sender: TObject);
    procedure lvReferensiSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnRemoveReferensiClick(Sender: TObject);
    procedure btnAddAssetClick(Sender: TObject);
    procedure btnDeleteAssetClick(Sender: TObject);
    procedure btnEditAssetClick(Sender: TObject);
    procedure cbbFilterSelect(Sender: TObject);
    procedure editSearchKeyPressAsset(Sender: TObject; var Key: Char);
    procedure cbbSearchSelect(Sender: TObject);
    procedure lvAssetSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button1Click(Sender: TObject);
//    procedure LlvFileDataSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

  private
    iconName : string;
    filePath, imgChoice : string;

    flagTable : Boolean;
    SearchName : string;
    ItemSearchIndex : Integer;

    FFileDataList : TList;
    FFileReferensiList : TList;
    FRoleList : TList;
    FSubRoleList : TList;
    FUserRoleList : TList;
    FGameAreaList : TList;
    FTacticalSymbolList : TList;
    FAssetList : TList;

    FSelectedPengguna : TUserRole;
    FSelectedUserChat : TUserRole;
    FSelectedFileBeranda : TFile_Data;
    FSelectedFileReferensi : TFile_Data;
    FSelectedGameArea : TGame_Area_Definition;
    FSelectedTacticalSymbol : TTactical_Symbol;
    FSelectedAsset : TAsset;

    procedure RoundCornerOf(Control: TWinControl; val1, val2: Integer);
    procedure AddSearchTypeItems;
    procedure AddSearchTacticalSymbolItems;
    procedure AddSearchAssetItems;

    procedure AddCbbRole;
    procedure AddCbbSubRole;
    function GetRoleIndex(id : string):Integer;

  public

    procedure UpdateClientChatting;
    procedure UpdateClientHistoryChat(IdSender, IdReceiver : Integer);


  end;

var
  frmDisplayArea: TfrmDisplayArea;

implementation

uses
  uDataModule;

{$R *.dfm}

procedure EnableComposited(WinControl:TWinControl);
var
  i:Integer;
  NewExStyle:DWORD;
begin
  NewExStyle := GetWindowLong(WinControl.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED;
  SetWindowLong(WinControl.Handle, GWL_EXSTYLE, NewExStyle);

  for I := 0 to WinControl.ControlCount - 1 do
    if WinControl.Controls[i] is TWinControl then
      EnableComposited(TWinControl(WinControl.Controls[i]));
end;

procedure TfrmDisplayArea.RoundCornerOf(Control: TWinControl; val1, val2: Integer);
var
  R : TRect;
  Rgn : HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, val1, val2);
    SetWindowRgn(Handle, Rgn, True) ;
    Invalidate
  end;
end;

procedure TfrmDisplayArea.btnAOTCClick(Sender: TObject);
begin
  if pnlLeft.Width > 50 then
  begin
    pnlLeft.Width := 50;
  end
  else
  begin
    pnlLeft.Width := 250;
  end;
end;

{$REGION ' Form Procedure '}

procedure TfrmDisplayArea.FormCreate(Sender: TObject);
begin
  EnableComposited(pnlMainBackground);
  EnableComposited(pnlTop);
  EnableComposited(pnlLeft);
  EnableComposited(pnlCenter);
  EnableComposited(pnlRight);

  RoundCornerOf(pnlMdmConsoleName, 15, 15);
  RoundCornerOf(pnlMdmOrganisasiTugas, 15, 15);
  RoundCornerOf(pnlMdmUserRole, 15, 15);
  RoundCornerOf(pnlMdmTahapan, 15, 15);

  FFileDataList := TList.Create;
  FRoleList := TList.Create;
  FSubRoleList := TList.Create;
  FUserRoleList := TList.Create;
  FGameAreaList := TList.Create;
  FFileReferensiList := TList.Create;
end;

procedure TfrmDisplayArea.FormDestroy(Sender: TObject);
begin
  FreeItemsAndFreeList(FFileDataList);
  FreeItemsAndFreeList(FRoleList);
  FreeItemsAndFreeList(FSubRoleList);
  FreeItemsAndFreeList(FUserRoleList);
  FreeItemsAndFreeList(FGameAreaList);
  FreeItemsAndFreeList(FFileReferensiList);
end;

procedure TfrmDisplayArea.FormShow(Sender: TObject);
begin
  pnlBerandaManajemenShow;
  pnlRight.Width := 0;
end;

{$ENDREGION}

{$REGION ' Beranda Procedure '}

procedure TfrmDisplayArea.BerandaClick(Sender: TObject);
begin
  pnlBerandaManajemenShow;
end;

procedure TfrmDisplayArea.pnlBerandaManajemenShow;
begin
  pnlMenejemenBeranda.BringToFront;

  with simMgrClient.MyConsoleData do
  begin
    lblConsoleName.Caption := Identifier;
    lblRole.Caption := UserRoleData.FRoleData.RoleAcronim;
    lblSubRole.Caption := UserRoleData.FSubRoleData.SubRoleAcronim;
    lblUserRoleIdentifier.Caption := UserRoleData.FData.UserRoleAcronim;
  end;

  CalendarView1.Date := Now;

  UpdateDataFile;
end;

procedure TfrmDisplayArea.btnDownloadClick(Sender: TObject);
var
  localDirTemp : String;
  serverDirTemp : String;
  localFileTemp : String;

begin
  if Assigned(FSelectedFileBeranda) then
  begin
    SelectDirectory('Select a directory', vGameDataSetting.LocalDirectory, localDirTemp);

    serverDirTemp := vGameDataSetting.FileDirectory + FSelectedFileBeranda.FData.Encripted_File_Name;
    localFileTemp := localDirTemp + '\' + FSelectedFileBeranda.FData.Nama_File;

    CopyFile(PWideChar(serverDirTemp), PWideChar(localFileTemp), False);
  end;

end;

procedure TfrmDisplayArea.btnUploadClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  saveDialog : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecFile_Data;

begin
  saveDialog := TSaveDialog.Create(self);
  saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter := 'Word file|*.docx|Excel file|*.xlsx|Power Point file|*.pptx';
  saveDialog.DefaultExt := 'docx';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute then
  begin
    addressTemp := PWideChar(saveDialog.FileName);
    filNameTemp := ExtractFileName(saveDialog.FileName);

    with fileDataTemp do
    begin
      Nama_File           := filNameTemp;
      Directory_Path      := vGameDataSetting.FileDirectory;
      Encripted_File_Name := '';
      Tipe_File           := ExtractFileExt(saveDialog.FileName);
      Modified_Date       := DateToStr(Now);
      Modified_By         := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim;
      id_User             := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;

      if dmINWO.InsertFile(fileDataTemp) then
      begin
        dmINWO.UpdateFile(fileDataTemp);
        ShowMessage('Data has been saved');
      end;
    end;

    CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\' + fileDataTemp.Encripted_File_Name), False);
  end
  else
    ShowMessage('Save file was cancelled');

  saveDialog.Free;

  UpdateDataFile;
end;

procedure TfrmDisplayArea.btnRemoveClick(Sender: TObject);
var
  warning : Integer;
  serverDirTemp : String;

begin
  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    if Assigned(FSelectedFileBeranda) then
    begin
      serverDirTemp := vGameDataSetting.FileDirectory + FSelectedFileBeranda.FData.Encripted_File_Name;

      with FSelectedFileBeranda.FData do
      begin
        if dmINWO.DeleteFile(ID_File) then
          ShowMessage('Data has been deleted');
      end;

      DeleteFile(serverDirTemp);
      FSelectedFileBeranda := nil;
    end;

    UpdateDataFile;
  end;
end;

procedure TfrmDisplayArea.lvFileDataSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  FSelectedFileBeranda := nil;

  if Selected then
  begin
    if (Item = nil) or (item.Data = nil) then
    begin
      MessageDlg('File Corrupted', mtInformation, [mbOK], 0);
      Exit;
    end;

    FSelectedFileBeranda := Item.Data;
  end
end;

procedure TfrmDisplayArea.UpdateDataFile;
var
  i : Integer;
  fileDataTemp : TFile_Data;
  li : TListItem;

begin
  lvFileData.Items.Clear;

  dmINWO.GetAllFile(FFileDataList);

  for i := 0 to FFileDataList.Count - 1 do
  begin
    fileDataTemp := FFileDataList.Items[i];
    li := lvFileData.Items.Add;
    li.SubItems.Add(fileDataTemp.FData.Nama_File);
    li.StateIndex := Integer(SetFileExtentionToEnum(fileDataTemp.FData.Tipe_File));
    li.SubItems.Add(fileDataTemp.FData.Directory_Path);
    li.SubItems.Add(fileDataTemp.FData.Modified_Date);
    li.SubItems.Add(fileDataTemp.FData.Modified_By);
    li.Data := fileDataTemp;
  end;
end;

{$ENDREGION}

{$REGION ' Asset Procedure '}

procedure TfrmDisplayArea.AssetClick(Sender: TObject);
begin
  pnlAsetManajemenShow;
end;

procedure TfrmDisplayArea.pnlAsetManajemenShow;
begin
  pnlMenejemenAsset.BringToFront;
  UpdateDataAset
end;

procedure TfrmDisplayArea.UpdateDataAset;
var
  i : Integer;
  AssetTemp : TAsset;
  li: TListItem;
begin
  lvAsset.Items.Clear;

  dmINWO.GetAllVehicleDef(FAssetList);

  for i := 0 to FAssetList.Count - 1 do
  begin
    AssetTemp := FAssetList.Items[i];

    li := lvAsset.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add(AssetTemp.FData.Vehicle_Identifier);
    li.SubItems.Add(IntToStr(AssetTemp.FData.Platform_Domain));
    li.SubItems.Add(IntToStr(AssetTemp.FData.Platform_Category));
  end;
end;

procedure TfrmDisplayArea.btnAddAssetClick(Sender: TObject);
begin
  frmAsset := TfrmAsset.Create(Self);
  try
    with frmAsset do
    begin
      SelectedAsset := TAsset.Create;
      Show;
    end;
  finally
    frmAsset.Free;
  end;
    UpdateDataAset;
end;

procedure TfrmDisplayArea.btnDeleteAssetClick(Sender: TObject);
var
  warning : Integer;
begin
  if lvAsset.ItemIndex <> -1 then
  begin
    warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

    if warning = mrOK then
    begin
      with FSelectedAsset.FData do
      begin
        if dmINWO.DeleteVehicleDef(Vehicle_Index) then
          ShowMessage('Data has been deleted');
      end;

      UpdateDataAset;
    end;
  end;
end;

procedure TfrmDisplayArea.btnEditAssetClick(Sender: TObject);
begin
  if lvAsset.ItemIndex <> -1 then
  begin
    frmAsset := TfrmAsset.Create(Self);
    try
      with frmAsset do
      begin
        SelectedAsset := FSelectedAsset;
        Show;
      end;
    finally
      frmAsset.Free;
    end;

    UpdateDataAset;
  end;
end;

procedure TfrmDisplayArea.cbbFilterSelect(Sender: TObject);
begin
  cbbSearch.ItemIndex := 0;

  if cbbFilter.ItemIndex = 0 then
  begin
    editSearch.Clear;
    flagTable := False;
    UpdateDataAset;
    editSearch.BringToFront;
  end
  else if cbbFilter.ItemIndex = 1 then
  begin
    AddSearchAssetItems;
    cbbSearch.BringToFront;
    cbbSearch.ItemIndex := 0;
  end
  else if cbbFilter.ItemIndex = 2 then
  begin
    AddSearchAssetItems;
    cbbSearch.BringToFront;
    cbbSearch.ItemIndex := 0;
  end
  else if cbbFilter.ItemIndex = 3 then
  begin
    AddSearchAssetItems;
    cbbSearch.BringToFront;
    cbbSearch.ItemIndex := 0;
  end;
end;

procedure TfrmDisplayArea.editSearchKeyPressAsset(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (editSearch.Text <> '') and (cbbFilter.ItemIndex > 0) then
    begin
      ItemSearchIndex := cbbFilter.ItemIndex;
      SearchName := editSearch.Text;
      flagTable := True;
      UpdateDataAset;
    end
    else if editSearch.Text = '' then
    begin
      flagTable := False;
      UpdateDataAset;
    end;
  end;
end;

procedure TfrmDisplayArea.cbbSearchSelect(Sender: TObject);
begin
  ItemSearchIndex := cbbFilter.ItemIndex;
  SearchName := IntToStr(cbbSearch.ItemIndex);
  flagTable := True;
  UpdateDataAset;
end;

procedure TfrmDisplayArea.AddCbbRole;
var
  i : Integer;
  roleTemp : TRole;
begin
  cbbSearchType.Items.Clear;

  dmINWO.GetAllRole(FRoleList);

  for i := 0 to FRoleList.Count - 1 do
  begin
    roleTemp := FRoleList.Items[i];
    cbbSearchType.Items.AddObject(roleTemp.FData.RoleAcronim, roleTemp);
  end;
end;

function TfrmDisplayArea.GetRoleIndex(id: string): Integer;
var
  i : Integer;
  roleTemp : TRole;
begin
  Result := 0;

  for i := 0 to FRoleList.Count - 1 do
  begin
    roleTemp := FRoleList.Items[i];

    if roleTemp.FData.RoleAcronim = id then
    begin
      Result := roleTemp.FData.RoleIndex;
      Break;
    end;
  end;
end;

procedure TfrmDisplayArea.AddCbbSubRole;
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  cbbSearchType.Items.Clear;

  dmINWO.GetAllSubRole(FSubRoleList);

  for i := 0 to FSubRoleList.Count - 1 do
  begin
    subRoleTemp := FSubRoleList.Items[i];
    cbbSearchType.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
  end;
end;

procedure TfrmDisplayArea.AddSearchAssetItems;
begin
  if cbbFilter.ItemIndex = 1 then
  begin
    cbbSearch.Items.Clear;
    cbbSearch.Items.Add('Air');
    cbbSearch.Items.Add('Surface');
    cbbSearch.Items.Add('Subsurface');
    cbbSearch.Items.Add('Land');
    cbbSearch.Items.Add('Amphibious');
  end
  else if cbbFilter.ItemIndex = 2 then
  begin
    cbbSearch.Items.Clear;
    cbbSearch.Items.Add('Combatant');
    cbbSearch.Items.Add('Non-Combatant');
    cbbSearch.Items.Add('Non-Naval');
    cbbSearch.Items.Add('Other');
  end
  else if cbbFilter.ItemIndex = 3 then
  begin
    cbbSearch.Items.Clear;
    cbbSearch.Items.Add('Frigate, Guided Missile (FFG)');
    cbbSearch.Items.Add('Destroyer, Guided Missile (DDG)');
    cbbSearch.Items.Add('Cruiser, Guided Missile (CG/CGN)');
    cbbSearch.Items.Add('Aircraft Carrier (CV/CVN)');
    cbbSearch.Items.Add('Patrol Craft (PT/PTG)');
    cbbSearch.Items.Add('Mine Warfare');
    cbbSearch.Items.Add('Auxiliary');
    cbbSearch.Items.Add('Merchant');
    cbbSearch.Items.Add('utility Vessel');
    cbbSearch.Items.Add('Destroyer (DD)');
    cbbSearch.Items.Add('Frigate (FF)');
    cbbSearch.Items.Add('Amphibious Warfare');
    cbbSearch.Items.Add('other');
  end;
end;

procedure TfrmDisplayArea.lvAssetSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
  begin
    if (Item = nil) or (Item.Data = nil) then
      Exit;

    FSelectedAsset := TAsset(lvAsset.Selected.Data);
  end;
end;

{$ENDREGION}

{$REGION ' Simbol Taktis Procedure '}

procedure TfrmDisplayArea.SimbolTaktisClick(Sender: TObject);
begin
  pnlSimbolTaktisManajemenShow;
end;

procedure TfrmDisplayArea.pnlSimbolTaktisManajemenShow;
begin
  pnlMenejemenSimbolTaktis.BringToFront;

  UpdateSimbolTaktis;
end;


procedure TfrmDisplayArea.AddSearchTacticalSymbolItems;
begin
  if cbbFilterSearch.ItemIndex = 1 then
  begin
    cbbSearchTipe.Items.Clear;
    cbbSearchTipe.Items.Add('TAKTIS TNI AL');
  end
  else if cbbFilterSearch.ItemIndex = 2 then
  begin
    cbbSearchTipe.Items.Add('PESAWAT TERBANG SAYAP PUTAR');
    cbbSearchTipe.Items.Add('ALAT KENDALI OPS');
    cbbSearchTipe.Items.Add('ANGKATAN LAIN');
    cbbSearchTipe.Items.Add('KAPAL');
    cbbSearchTipe.Items.Add('KEGIATAN-MANUVERA');
    cbbSearchTipe.Items.Add('KOMANDO');
    cbbSearchTipe.Items.Add('KOMANDO OPERASIONAL');
    cbbSearchTipe.Items.Add('LAINNYA');
    cbbSearchTipe.Items.Add('MARINIR');
    cbbSearchTipe.Items.Add('MEDAN');
    cbbSearchTipe.Items.Add('PANGKALAN');
    cbbSearchTipe.Items.Add('PESAWAT TERBANG SAYAP TETAP');
  end;
end;

procedure TfrmDisplayArea.cbbSearchtipeSelect(Sender: TObject);
begin
  ItemSearchIndex := cbbFilterSearch.ItemIndex;
  SearchName := IntToStr(cbbSearchTipe.ItemIndex);
  flagTable := True;
  UpdateSimbolTaktis;
end;

procedure TfrmDisplayArea.cbbFilterSearchSelect(Sender: TObject);
begin
  cbbSearchTipe.Clear;

  case cbbFilterSearch.ItemIndex of
    0: {All}
    begin
      edtTacticalSearch.Clear;
      flagTable := False;
      UpdateSimbolTaktis;
      edtTacticalSearch.BringToFront;
    end;
    1: {Tipe}
    begin
      AddSearchTacticalSymbolItems;
      cbbSearchTipe.ItemIndex := 0;
      cbbSearchTipe.BringToFront;
    end;
    2: {Kategori}
    begin
      AddSearchTacticalSymbolItems;
      cbbSearchTipe.ItemIndex := 0;
      cbbSearchTipe.BringToFront;
    end;

  end;
end;

procedure TfrmDisplayArea.UpdateSimbolTaktis;
var
  i : Integer;
  tacticalSymbolTemp : TTactical_Symbol;
  li : TListItem;
begin
  lvTacticalSymbol.Items.Clear;

  if flagTable = true then
     dmINWO.GetSearchTacticalSymbol(ItemSearchIndex, SearchName, FTacticalSymbolList)
  else
     dmINWO.GetAllTacticalSymbol(FTacticalSymbolList);

  for i := 0 to FTacticalSymbolList.Count -1 do
  begin
     tacticalSymbolTemp := FTacticalSymbolList.Items[i];

     li := lvTacticalSymbol.Items.Add;
     li.Caption := IntToStr(i+1);
     li.SubItems.Add(tacticalSymbolTemp.FData.Keterangan);
     li.SubItems.Add(IntToStr(tacticalSymbolTemp.FData.Tipe));
     li.SubItems.Add(IntToStr(tacticalSymbolTemp.FData.Kategori));
     li.SubItems.Add(tacticalSymbolTemp.FData.Path_Directori);

     li.Data := tacticalSymbolTemp;
  end;

end;

procedure TfrmDisplayArea.btnAddTacticalSymbolClick(Sender: TObject);
begin
  frmSimbolTaktis := TfrmSimbolTaktis.Create(Self);
  try
    with frmSimbolTaktis do
    begin
      SelectedTacticalSymbol := TTactical_Symbol.Create;
      Show;
    end;
  finally
    frmSimbolTaktis.Free;
  end;
    UpdateSimbolTaktis;
end;

procedure TfrmDisplayArea.lvTacticalSymbolleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  imagepath :  string;
  serverDirTemp : String;
  localFileTemp : String;

begin
  FSelectedTacticalSymbol := nil;
  imgPreview.Picture := nil;
  lblNamaGambar.Caption := 'Nama Gambar: ';
  lblKeterangan.Caption := 'Keterangan: ';
  lblTipe.Caption       := 'Tipe: ';
  lblKategori.Caption   := 'Kategori: ';

  if Selected then
  begin
    if (Item = nil) or (Item.Data = nil) then
      Exit;

    FSelectedTacticalSymbol := TTactical_Symbol(lvTacticalSymbol.Selected.Data);

    imagepath := FSelectedTacticalSymbol.FData.Path_Directori + '\' + IntToStr(FSelectedTacticalSymbol.FData.Id_Tactical_Symbol) + '.bmp';
    if FileExists(imagepath) then
    begin
      imgPreview.Picture.LoadFromFile(imagepath);
      pnlRightTactical.Visible := True;
    end
    else
    begin
      ShowMessage('File gambar tidak ditemukan' + imagepath);
    end;

    lblNamaGambar.Caption := 'Nama Gambar: ' + IntToStr(FSelectedTacticalSymbol.FData.Id_Tactical_Symbol) + '.bmp';
    lblKeterangan.Caption := 'Keterangan: ' + Item.SubItems[0];
    lblTipe.Caption       := 'Tipe: ' + Item.SubItems[1];
    lblKategori.Caption   := 'Kategori: ' + Item.SubItems[2];

    FSelectedTacticalSymbol := Item.Data;
  end;
end;

procedure TfrmDisplayArea.btnEditTacticalSymbolClick(Sender: TObject);
begin
   if lvTacticalSymbol.ItemIndex <> -1 then
   begin
      frmSimbolTaktis := TfrmSimbolTaktis.Create(Self);
      try
        with frmSimbolTaktis do
        begin
          SelectedTacticalSymbol := FSelectedTacticalSymbol;
          Show;
        end;
      finally
         frmSimbolTaktis.Free;
      end;
   end;

   UpdateSimbolTaktis;

end;

procedure TfrmDisplayArea.btnDeleteTacticalSymbolClick(Sender: TObject);
var
  warning: Integer;
  serverDirTemp : String;
begin

  if lvTacticalSymbol.ItemIndex < 0  then
    Exit;

  warning := MessageDlg('Are you sure delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    if Assigned(FSelectedTacticalSymbol) then
    begin
      serverDirTemp := vGameDataSetting.FileSimbolTaktis + '\' + IntToStr(FSelectedTacticalSymbol.FData.Id_Tactical_Symbol) + '.bmp';

      with FSelectedTacticalSymbol.FData do
      begin
        if dmINWO.DeleteTacticalSymbol(Id_Tactical_Symbol)then
           ShowMessage('Data has been deleted');
      end;
    end;

    DeleteFile(serverDirTemp);
    FSelectedTacticalSymbol := nil;

    UpdateSimbolTaktis;
  end;
end;

procedure TfrmDisplayArea.edtSearchKeyPressTactical(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (edtTacticalSearch.Text <> '') and (cbbFilterSearch.ItemIndex > 0) then
    begin
      ItemSearchIndex := cbbFilterSearch.ItemIndex;
      SearchName := edtTacticalSearch.Text;
      flagTable := true;
      UpdateSimbolTaktis;
    end
    else if edtTacticalSearch.Text = '' then
    begin
      flagTable := false;
      UpdateSimbolTaktis;
    end;
  end;
end;

procedure TfrmDisplayArea.btnUnduhClick(Sender: TObject);
var
  localDirTemp : String;
  serverDirTemp : String;
  localFileTemp : String;
begin
  if Assigned(FSelectedTacticalSymbol) then
  begin
    SelectDirectory('Select a directory', vGameDataSetting.LocalDirectory, localDirTemp);

    serverDirTemp := vGameDataSetting.FileSimbolTaktis + '\' + IntToStr(FSelectedTacticalSymbol.FData.Id_Tactical_Symbol) + '.bmp';
    localFileTemp := localDirTemp + '\' + IntToStr(FSelectedTacticalSymbol.FData.Id_Tactical_Symbol) + '.bmp';

    CopyFile(PWideChar(serverDirTemp), PWideChar(localFileTemp), False);
  end;
end;

{$ENDREGION}

{$REGION ' Pengguna Procedure '}

procedure TfrmDisplayArea.PenggunaClick(Sender: TObject);
begin
  pnlPenggunaManajemenShow;
end;

procedure TfrmDisplayArea.pnlPenggunaManajemenShow;
begin
  pnlMenejemenPengguna.BringToFront;
  UpdateDataPengguna
end;

procedure TfrmDisplayArea.UpdateDataPengguna;
var
  i : Integer;
  roleTemp : TRole;
  subRoleTemp : TSubRole;
  userRoleTemp : TUserRole;
  li : TListItem;

begin
  lvUserRole.Items.Clear;

  if flagTable = true then
    dmINWO.GetSearchUserRole(ItemSearchIndex, SearchName, FUserRoleList)
  else
    dmINWO.GetAllUserRole(FUserRoleList);

  for i := 0 to FUserRoleList.Count - 1 do
  begin
    userRoleTemp := FUserRoleList.Items[i];
    li := lvUserRole.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add(userRoleTemp.FData.UserRoleAcronim);

    subRoleTemp := SimManager.SimSubRole.getSubRoleByID(userRoleTemp.FData.SubRoleIndex);
    if Assigned(subRoleTemp) then
      li.SubItems.Add(subRoleTemp.FData.SubRoleAcronim)
    else
      li.SubItems.Add('');

    roleTemp := SimManager.SimRole.getRoleByID(userRoleTemp.FData.RoleIndex);
    if Assigned(roleTemp) then
      li.SubItems.Add(roleTemp.FData.RoleAcronim)
    else
      li.SubItems.Add('');

    li.SubItems.Add(userRoleTemp.FData.Username);
    li.SubItems.Add(userRoleTemp.FData.Password);

    li.Data := userRoleTemp;
  end;
end;

procedure TfrmDisplayArea.AddSearchTypeItems ;
begin
   if cbbxFilterSearch.ItemIndex = 2 then
  begin
    cbbSearchType.Items.Clear;
    cbbSearchType.Items.Add('INWO');
    cbbSearchType.Items.Add('NTWO');
    cbbSearchType.Items.Add('ATWO');
    cbbSearchType.Items.Add('LFWO');
    cbbSearchType.Items.Add('ALWO');
    cbbSearchType.Items.Add('CDWO');
    cbbSearchType.Items.Add('SUWO');
  end
  else if cbbxFilterSearch.ItemIndex = 3 then
  begin
    cbbSearchType.Items.Clear;
    cbbSearchType.Items.Add('KPL');
    cbbSearchType.Items.Add('STAFLAT');
    cbbSearchType.Items.Add('WASDAL');
    cbbSearchType.Items.Add('KOGAB');
    cbbSearchType.Items.Add('KOGASGABLA');
    cbbSearchType.Items.Add('KOGASGABFIB');
    cbbSearchType.Items.Add('PASRAT');
    cbbSearchType.Items.Add('KOGASRATMIN');
    cbbSearchType.Items.Add('KOGASHANTAI');
    cbbSearchType.Items.Add('SATGASDUK');
  end;
end;


procedure TfrmDisplayArea.btnAddClick(Sender: TObject);
begin
  frmSummaryUserRole := TfrmSummaryUserRole.Create(self) ;
  try
    with frmSummaryUserRole do
    begin
      SelectedUserRole := TUserRole.Create;
      Show;
      SelectedUserRole.Free;
    end;
  finally
    frmSummaryUserRole.Free
  end;

  UpdateDataPengguna;
end;

procedure TfrmDisplayArea.btnEditClick(Sender: TObject);
begin
 if lvUserRole.ItemIndex <> -1 then
  begin
    frmSummaryUserRole := TfrmSummaryUserRole.Create(Self);
    try
      with frmSummaryUserRole do
      begin
        SelectedUserRole := FSelectedPengguna;
        Show;
//        FUpdateList := AfterClose;
      end;
    finally
      frmSummaryUserRole.Free;
    end;

//    if FUpdateList then
      UpdateDataPengguna;
  end;
end;

procedure TfrmDisplayArea.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lvUserRole.ItemIndex <> -1 then
  begin
    warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

    if warning = mrOK then
    begin
      with FSelectedPengguna.FData do
      begin
        if dmINWO.DeleteUserRole(UserRoleIndex) then
          ShowMessage('Data has been deleted');
      end;

      UpdateDataPengguna;
    end;
  end;
end;

procedure TfrmDisplayArea.lvUserRoleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected  then
  begin
    if (Item = nil) or (item.Data = nil) then
      Exit;

    FSelectedPengguna := TUserRole(lvUserRole.Selected.Data);
  end;
end;

procedure TfrmDisplayArea.cbbSearchTypeSelect(Sender: TObject);
var
  roleTemp : TRole;
  subRoleTemp : TSubRole;

begin
  if cbbSearchType.ItemIndex = -1 then
    Exit;

  case cbbxFilterSearch.ItemIndex of
    1:
    begin
      roleTemp := TRole(cbbSearchType.Items.Objects[cbbSearchType.ItemIndex]);

      if Assigned(roleTemp) then
      begin
        SearchName := IntToStr(roleTemp.FData.RoleIndex);
      end;
    end;
    2:
    begin
      subRoleTemp := TSubRole(cbbSearchType.Items.Objects[cbbSearchType.ItemIndex]);

      if Assigned(subRoleTemp) then
      begin
        SearchName := IntToStr(subRoleTemp.FData.SubRoleIndex);
      end;
    end;
  end;

  ItemSearchIndex := cbbxFilterSearch.ItemIndex;
  flagTable := true;
  UpdateDataPengguna;
end;

procedure TfrmDisplayArea.cbbxFilterSearchSelect(Sender: TObject);
begin
  cbbSearchType.ItemIndex := 0;

  {All}
  if cbbxFilterSearch.ItemIndex = 0 then
  begin
    edtSearch.Clear;
    flagTable := false;
    UpdateDataPengguna;
    edtSearch.BringToFront;
  end
  {Role}
  else if cbbxFilterSearch.ItemIndex = 1 then
  begin
    AddCbbRole;

    if cbbSearchType.Items.Count > 0 then
      cbbSearchType.ItemIndex := 0;

    cbbSearchType.BringToFront;
  end
  {Sub Role}
  else if cbbxFilterSearch.ItemIndex = 2 then
  begin
    AddCbbSubRole;

    if cbbSearchType.Items.Count > 0 then
      cbbSearchType.ItemIndex := 0;

    cbbSearchType.BringToFront;
  end
  {User Role}
  else if cbbxFilterSearch.ItemIndex = 3 then
  begin
    edtSearch.BringToFront;
  end;
end;


procedure TfrmDisplayArea.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (edtSearch.Text <> '') and (cbbxFilterSearch.ItemIndex > 0) then
    begin
      ItemSearchIndex := cbbxFilterSearch.ItemIndex;
      SearchName := edtSearch.Text;
      flagTable := true;
      UpdateDataPengguna;
    end
    else if edtSearch.Text = '' then
    begin
      flagTable := false;
      UpdateDataPengguna;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Peta Procedure '}

procedure TfrmDisplayArea.PetaClick(Sender: TObject);
begin
  pnlPetaManajemenShow;
end;

procedure TfrmDisplayArea.pnlPetaManajemenShow;
begin
  pnlMenejemenPeta.BringToFront;

  UpdateGameAreaList;
end;

procedure TfrmDisplayArea.btnAddMapClick(Sender: TObject);
begin
  frmMapEditor := TfrmMapEditor.Create(Self);
  try
    with frmMapEditor do
    begin
      SelectedGameArea := TGame_Area_Definition.Create;
      SelectedGameArea.FData.Detail_Map := 'ENC';
      Show;
//      FUpdateList := AfterClose;
    end;
  finally
    frmMapEditor.Free;
  end;

//  if FUpdateList then
    UpdateGameAreaList;
end;

procedure TfrmDisplayArea.btnEditMapClick(Sender: TObject);
begin
  if lvGameArea.ItemIndex = -1 then
  begin
    ShowMessage('Select Game Area !');
    Exit;
  end;

  frmMapEditor := TfrmMapEditor.Create(Self);
  try
    with frmMapEditor do
    begin
      SelectedGameArea := FSelectedGameArea;
      Show;
//      FUpdateList := AfterClose;
    end;
  finally
    frmMapEditor.Free;
  end;

//  if FUpdateList then
    UpdateGameAreaList;
end;

procedure TfrmDisplayArea.btnPreviewClick(Sender: TObject);
begin
  if lvGameArea.ItemIndex = -1 then
  begin
    ShowMessage('Select Game Area !');
    Exit;
  end;

  frmMapPreview := TfrmMapPreview.Create(Self);
  try
    with frmMapPreview do
    begin
      SelectedGameArea := FSelectedGameArea;
      Show;
    end;
  finally
    frmMapPreview.Free;
  end;

end;

procedure TfrmDisplayArea.btnDeleteMapClick(Sender: TObject);
var
  warning : Integer;
  tempList : TList;
  MapDirPath : string;

begin
  if lvGameArea.ItemIndex = -1 then
  begin
    ShowMessage('Select Game Area !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this Game Area ?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedGameArea.FData do
    begin
      {Pengecekan Relasi Dengan Tabel Game Environment Definition}
      tempList := TList.Create;

      MapDirPath := vGameAreaSetting.MapGSTGame + '\' + Game_Area_Identifier;
      DeleteGameAreaDirectory(MapDirPath, MapDirPath);

      if dmINWO.DeleteGameAreaDef(Game_Area_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateGameAreaList;
  end;
end;

procedure TfrmDisplayArea.lvGameAreaSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected  then
  begin
    if (Item = nil) or (item.Data = nil) then
      Exit;

    FSelectedGameArea := TGame_Area_Definition(lvGameArea.Selected.Data);
  end;
end;

procedure TfrmDisplayArea.edtSearchMapKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  gameArea : TGame_Area_Definition;
begin
  if Key = #13 then
  begin
    UpdateGameAreaList
  end;
end;

procedure TfrmDisplayArea.UpdateGameAreaList;
var
  i : Integer;
  gameAreaTemp : TGame_Area_Definition;
  li : TListItem;

begin
  lvGameArea.Items.Clear;

  if edtSearchMap.Text <> '' then
  begin
    dmINWO.GetFilterGameAreaDef(FGameAreaList, edtSearchMap.Text)
  end
  else if edtSearch.Text = '' then
  begin
    dmINWO.GetAllGameAreaDef(FGameAreaList);
  end;

  for i := 0 to FGameAreaList.Count - 1 do
  begin
    gameAreaTemp := FGameAreaList.Items[i];
    li := lvGameArea.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add(gameAreaTemp.FData.Game_Area_Identifier);
    li.Data := gameAreaTemp;
  end;

end;

procedure TfrmDisplayArea.DeleteGameAreaDirectory(const aPathName,aFileName: string);
var
  F : TSearchRec;
begin
  if FindFirst(aFileName + '*.*', faAnyFile, F) = 0 then
  begin
    try
      repeat
        if (F.Attr and faDirectory <> 0) then
        begin
          if (F.Name <> '.') and (F.Name <> '..') then
            DeleteGameAreaDirectory(aPathName, aFileName + '\' + F.Name);
        end
        else
          DeleteFile(aPathName + '\' + F.Name);
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;

    RemoveDir(aPathName);
  end;
end;

{$ENDREGION}

{$REGION ' Referensi Procedure '}

procedure TfrmDisplayArea.ReferensiClick(Sender: TObject);
begin
  pnlReferensiShow;
end;

procedure TfrmDisplayArea.pnlReferensiShow;
begin
  pnlMenejemenReferensi.BringToFront;

  UpdateDataReferensi;
end;

procedure TfrmDisplayArea.btnDownloadReferensiClick(Sender: TObject);
var
  localDirTemp : String;
  serverDirTemp : String;
  localFileTemp : String;

begin
  if Assigned(FSelectedFileReferensi) then
  begin
    SelectDirectory('Select a directory', vGameDataSetting.LocalDirectory, localDirTemp);

    serverDirTemp := vGameDataSetting.FileReferensi + '\' + IntToStr(FSelectedFileReferensi.FData.ID_File) + '.docx';
    localFileTemp := localDirTemp + '\' + IntToStr(FSelectedFileReferensi.FData.ID_File) + '.docx';

    CopyFile(PWideChar(serverDirTemp), PWideChar(localFileTemp), False);
  end;
end;

procedure TfrmDisplayArea.btnUploadReferensiClick(Sender: TObject);
begin
  frmReferensi := TfrmReferensi.Create(Self);
  try
    with frmReferensi do
    begin
      SelectedReferensi := TFile_Data.Create;
      ShowModal;
    end;
  finally
    frmReferensi.Free;
  end;

  UpdateDataReferensi;
end;

procedure TfrmDisplayArea.btnRemoveReferensiClick(Sender: TObject);
var
  warning : Integer;
  serverDirTemp : String;

begin
  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    if Assigned(FSelectedFileReferensi) then
    begin
      serverDirTemp := vGameDataSetting.FileReferensi + '\' + IntToStr(FSelectedFileReferensi.FData.ID_File) + '.docx';

      with FSelectedFileReferensi.FData do
      begin
        if dmINWO.DeleteReferensi(ID_File) then
          ShowMessage('Data has been deleted');
      end;

      DeleteFile(serverDirTemp);
      FSelectedFileReferensi := nil;
    end;

    UpdateDataReferensi;
  end;
end;

procedure TfrmDisplayArea.lvReferensiSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  docxpath :  string;
  serverDirTemp : String;
  localFileTemp : String;
begin
  FSelectedFileReferensi := nil;

  if Selected then
  begin
    if (Item = nil) or (item.Data = nil) then
      Exit;

    FSelectedFileReferensi := TFile_Data(lvReferensi.Selected.Data);
    docxpath := FSelectedFileReferensi.FData.Directory_Path + '\' + IntToStr(FSelectedFileReferensi.FData.ID_File) + '.docx';

    FSelectedFileReferensi := Item.Data;
  end
end;

procedure TfrmDisplayArea.UpdateDataReferensi;
var
  i : Integer;
  fileDataTemp : TFile_Data;
  li : TListItem;

begin
  lvFileData.Items.Clear;

  dmINWO.GetAllFile(FFileDataList);

  for i := 0 to FFileDataList.Count - 1 do
  begin
    fileDataTemp := FFileDataList.Items[i];
    li := lvFileData.Items.Add;
    li.SubItems.Add(fileDataTemp.FData.Nama_File);
    li.StateIndex := Integer(SetFileExtentionToEnum(fileDataTemp.FData.Tipe_File));
    li.SubItems.Add(fileDataTemp.FData.Directory_Path);
    li.SubItems.Add(fileDataTemp.FData.Modified_Date);
    li.SubItems.Add(fileDataTemp.FData.Modified_By);

    li.Data := fileDataTemp;
  end;
end;

{$ENDREGION}

{$REGION ' Office Editor Procedure '}

procedure TfrmDisplayArea.OfficeEditorClick(Sender: TObject);
begin
  pnlRight.Width := 130;
  pnlMainOfficeEditor.BringToFront;
end;

procedure TfrmDisplayArea.IconLoad;
begin
  if iconName = 'imgMsWord' then
  begin
    imgMsWord.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgMsExcel' then
  begin
    imgMsExcel.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgMsPowerPoint' then
  begin
    imgMsPowerPoint.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgMsPaint' then
  begin
    imgMsPaint.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgChrome' then
  begin
    imgChrome.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
end;

procedure TfrmDisplayArea.IconMenuMouseEnter(Sender: TObject);
begin
  iconName := TImage(sender).Name;
  filePath := 'data\Image DBEditor\Interface\Background\';
  imgChoice := '_Select.png';

  IconLoad;
end;

procedure TfrmDisplayArea.IconMenuMouseLeave(Sender: TObject);
begin
  iconName := TImage(sender).Name;
  filePath := 'data\Image DBEditor\Interface\Background\';
  imgChoice := '.png';

  IconLoad;
end;

procedure TfrmDisplayArea.imgMsExcelClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('EXCEL'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgMsPaintClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('mspaint'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgMsPowerPointClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('POWERPNT'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgMsWordClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('WINWORD'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgChromeClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('chrome'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

{$ENDREGION}

{$REGION ' Situation Board Procedure '}

procedure TfrmDisplayArea.SituationBoardClick(Sender: TObject);
begin
  frmSituationBoard.Show;
//  frmSituationBoard := TfrmSituationBoard.Create(Self);
//  try
//    with frmSituationBoard do
//    begin
//      Show;
//    end;
//
//  finally
//    frmSituationBoard.Free;
//  end;
end;

{$ENDREGION}

{$REGION ' Obrolan Procedure '}

procedure TfrmDisplayArea.ObrolanClick(Sender: TObject);
begin
  pnlRight.Width := 430;
  pnlMainChatting.BringToFront;
  UpdateClientChatting;
end;

procedure TfrmDisplayArea.btnCloseChatClick(Sender: TObject);
begin
  pnlRight.Width := 0;
  lstUserChat.BringToFront;
  mmoChat.Clear;
  edtChatBox.Clear;
  pnlBottomChat.Visible := False;

end;

procedure TfrmDisplayArea.btnMessageChatClick(Sender: TObject);
begin
  mmoChat.BringToFront;
end;

procedure TfrmDisplayArea.btnUserChatClick(Sender: TObject);
begin
  edtChatBox.Clear;
  pnlBottomChat.Visible := False;
  mmoChat.Clear;
  lstUserChat.BringToFront;
  UpdateClientChatting;
end;

procedure TfrmDisplayArea.Button1Click(Sender: TObject);
var
  i : Integer;
  userroleTemp : TUserRole;

begin
  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userroleTemp := SimManager.SimUserRole.UserList[i];

    if Assigned(userroleTemp) then
    begin
//      if userroleTemp.isInUse then
        Memo1.Lines.Add(userroleTemp.FData.UserRoleAcronim)

    end;
  end;
end;

procedure TfrmDisplayArea.lstUserChatDblClick(Sender: TObject);
begin
  if lstUserChat.ItemIndex = -1 then
    Exit;

  FSelectedUserChat := TUserRole(lstUserChat.Items.Objects[lstUserChat.ItemIndex]);
  mmoChat.BringToFront;
  pnlBottomChat.Visible := True;
  UpdateClientHistoryChat(FSelectedUserChat.FData.UserRoleIndex, simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex);
end;

procedure TfrmDisplayArea.UpdateClientHistoryChat(IdSender, IdReceiver: Integer);
var
tempList : TList;
i : Integer;
chattingTemp : TChatting;
userRoleTemp : TUserRole;
namaRole : string;
begin
  tempList := TList.Create;
  try
  if ((Assigned(FSelectedUserChat)) and ((IdSender = simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) and
     (IdReceiver = FSelectedUserChat.FData.UserRoleIndex))) or ((Assigned(FSelectedUserChat)) and ((IdReceiver = simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) and
     (IdSender = FSelectedUserChat.FData.UserRoleIndex)))then
  begin
    SimManager.SimChatting.GetChattingBySending(IdReceiver, IdSender, tempList);
//
    mmoChat.Clear;
    for i := 0 to tempList.Count - 1 do
    begin
      chattingTemp := tempList.Items[i];
//      if (IdSender = simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) and (IdReceiver =  then
//      begin
        if chattingTemp.IdUserRoleSending = simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex then
        begin
          mmoChat.Font.Color := clBlack;
          mmoChat.Lines.Add('You :');
  //        mmoChat.Lines.Add('/n');
          mmoChat.Lines.Add(chattingTemp.ChatMessage);
          mmoChat.Lines.Add('');
  //        mmoChat.Lines.Add('/n');
        end;

        if (chattingTemp.IdUserRoleSending = FSelectedUserChat.FData.UserRoleIndex) then
        begin
          mmoChat.Font.Color := clBlue;
  //        mmoChat.Lines.Add(FSelectedUserChat.FData.UserRoleIdentifier + ' :');
//          mmoChat.Lines.Add(IntToStr(FSelectedUserChat.FData.UserRoleIndex) + ' :');
            mmoChat.Lines.Add(FSelectedUserChat.FData.UserRoleIdentifier + ' :');
  //        mmoChat.Lines.Add('/n');
          mmoChat.Lines.Add(chattingTemp.ChatMessage);
          mmoChat.Lines.Add('');
  //        mmoChat.Lines.Add('/n');
        end;
//      end;


  //    userRoleTemp := SimUserRole.getUserRoleByID(rec.UserRoleId);
  //    mmoChat.Lines.Add(chattingTemp.IdUserRoleReceive, chattingTemp.ChatMessage);
  //    mmoChat.Lines.Add(IntToStr(chattingTemp.IdUserRoleSending));
  //    mmoChat.Lines.Add(IntToStr(chattingTemp.IdUserRoleReceive));
  //    mmoChat.Lines.Add(chattingTemp.ChatMessage);
    end;
  end;
  finally
    tempList.Free;
  end;


end;

procedure TfrmDisplayArea.btnSendChatClick(Sender: TObject);
var
//i : Integer;
rec : TRecTCPSendChatUserRole;
begin
   rec.OrderID := 0;
   rec.SenderUserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
   rec.ReceiverUserRoleId := FSelectedUserChat.FData.UserRoleIndex;
   FillChar(rec.ChatMessage, SizeOf(rec.ChatMessage), 0);
   rec.ChatMessage := edtChatBox.Text;

   simMgrClient.netSend_CmdSendMessage(rec);
   edtChatBox.Clear;
end;

procedure TfrmDisplayArea.UpdateClientChatting;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  lstUserChat.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
    if Assigned(userRoleTemp) then
    begin
      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
//      if userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex then
      begin
        lstUserChat.Items.AddObject(userRoleTemp.FData.UserRoleIdentifier, userRoleTemp);
      end;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Telegram Procedure '}

procedure TfrmDisplayArea.TelegramClick(Sender: TObject);
begin
  frmTelegram.Show;
end;


{$ENDREGION}

{$REGION ' Video Conference Procedure '}

procedure TfrmDisplayArea.VideoConferenceClick(Sender: TObject);
begin
  frmVideoConference := TfrmVideoConference.Create(Self);
  try
    with frmVideoConference do
    begin
      Show;
    end;

  finally
    frmVideoConference.Free;
  end;
end;

{$ENDREGION}

procedure TfrmDisplayArea.LogOutClick(Sender: TObject);
var
  rec : TRecTCP_UserState;

begin
  if Assigned(simMgrClient.MyConsoleData) then
  begin
    rec.OrderID := CORD_ID_LOGOUT;
    rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
    rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
    rec.UserRoleInUse := False;

    simMgrClient.netSend_CmdUserState(rec);
  end;

  Close;
end;

end.

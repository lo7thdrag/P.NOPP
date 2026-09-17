unit ufrmBrowseMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, CheckLst, ExtCtrls, OleCtrls, StrUtils,
  MapXLib_TLB, ImgList, uLibSetting, uMapXHandler, System.ImageList,

  uRecordData, uT3SimManager, uSimMgr_Client;

type
  TfrmBrowseMap = class(TForm)
    ImageList1: TImageList;
    mpLayer: TMap;
    PanelLeft: TPanel;
    grp1: TGroupBox;
    PanelTop: TPanel;
    toolbar2: TToolBar;
    btnNormal: TToolButton;
    btnPan: TToolButton;
    btn1: TToolButton;
    btnDecreaseScale: TToolButton;
    btn2: TToolButton;
    cbbSetScale: TComboBox;
    btn3: TToolButton;
    btnIncreaseScale: TToolButton;
    btnZoom: TToolButton;
    btnZoomOut: TToolButton;
    btnDragFilter: TToolButton;
    lstGSTGame: TListBox;
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lstGSTGameClick(Sender: TObject);
    procedure btnNormalClick(Sender: TObject);
    procedure btnPanClick(Sender: TObject);
    procedure btnDecreaseScaleClick(Sender: TObject);
    procedure cbbSetScaleChange(Sender: TObject);
    procedure mpLayerMapViewChanged(Sender: TObject);
    procedure btnIncreaseScaleClick(Sender: TObject);
    procedure btnZoomClick(Sender: TObject);
    procedure btnZoomOutClick(Sender: TObject);
    procedure btnDragFilterClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FLyrDraw : CMapXLayer;

    procedure GetFilename(const dir : string; list : TStrings);
    procedure Load_Map(geoSet : string);

  public
    TabId : Integer;
    TabCaption : string;
    gGSTGame : string;
    gFilename : string;

  end;

var
  frmBrowseMap: TfrmBrowseMap;

implementation

uses
  ufrmSituationBoard;
{$R *.dfm}

procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;

procedure TfrmBrowseMap.btnCancelClick(Sender: TObject);
begin
  frmSituationBoard.btnGameArea.ImageIndex := 10;
  frmBrowseMap.Close;
end;

procedure TfrmBrowseMap.btnDecreaseScaleClick(Sender: TObject);
begin
  btnNormal.Down        := False;
  btnPan.Down           := false;
  btnDecreaseScale.Down := true;
  btnIncreaseScale.Down := false;
  btnZoom.Down          := false;
  btnZoomOut.Down              := false;
  btnDragFilter.Down    := false;

  if btnDecreaseScale.Down then
  begin
    mpLayer.MousePointer := miZoomInCursor;

    if  cbbSetScale.ItemIndex >  0 then
    begin
      cbbSetScale.ItemIndex := cbbSetScale.ItemIndex  - 1;
      btnIncreaseScale.Enabled := true;
    end;

    cbbSetScaleChange(cbbSetScale);

    if cbbSetScale.ItemIndex = 0 then
     btnDecreaseScale.Enabled := false
    else
     btnDecreaseScale.Enabled := true;
  end;
end;

procedure TfrmBrowseMap.btnDragFilterClick(Sender: TObject);
begin
  btnNormal.Down        := False;
  btnPan.Down           := false;
  btnDecreaseScale.Down := false;
  btnIncreaseScale.Down := false;
  btnZoom.Down          := false;
  btnZoomOut.Down              := false;
  btnDragFilter.Down    := True;

  if btnDragFilter.Down then
  begin
    mpLayer.CurrentTool   := miArrowTool;
    mpLayer.MousePointer  := miCrossCursor;

    mpLayer.ZoomTo(3072, mpLayer.CenterX, mpLayer.CenterY);
  end;
end;

procedure TfrmBrowseMap.btnIncreaseScaleClick(Sender: TObject);
begin
  btnNormal.Down        := False;
  btnPan.Down           := false;
  btnDecreaseScale.Down := false;
  btnIncreaseScale.Down := true;
  btnZoom.Down          := false;
  btnZoomOut.Down              := false;
  btnDragFilter.Down    := false;

  if btnIncreaseScale.Down then
  begin
    mpLayer.MousePointer := miZoomOutCursor;

    if (cbbSetScale.ItemIndex <= 500) then
    begin
      cbbSetScale.ItemIndex := cbbSetScale.ItemIndex + 1;
      btnDecreaseScale.Enabled := true;
    end;

    cbbSetScaleChange(cbbSetScale);

    if (cbbSetScale.ItemIndex = 0) then //sampai batas akhir
      btnIncreaseScale.Enabled := true
    else
      btnIncreaseScale.Enabled := true;
  end;
end;

procedure TfrmBrowseMap.btnNormalClick(Sender: TObject);
begin
  btnNormal.Down        := True;
  btnPan.Down           := false;
  btnDecreaseScale.Down := false;
  btnIncreaseScale.Down := false;
  btnZoom.Down          := false;
  btnZoomOut.Down              := false;
  btnDragFilter.Down    := false;

  if btnNormal.Down then
  begin
    mpLayer.CurrentTool   := miArrowTool;
    mpLayer.MousePointer  := crDefault;
  end;
end;

procedure TfrmBrowseMap.btnPanClick(Sender: TObject);
begin
  btnNormal.Down        := False;
  btnPan.Down           := True;
  btnDecreaseScale.Down := false;
  btnIncreaseScale.Down := false;
  btnZoom.Down          := false;
  btnZoomOut.Down              := false;
  btnDragFilter.Down    := false;

  if btnPan.Down then
  begin
    mpLayer.CurrentTool  := miPanTool;
    mpLayer.MousePointer := miPanCursor;
  end;
end;

procedure TfrmBrowseMap.btnOkClick(Sender: TObject);
var
  baseDir: string;
begin
  if lstGSTGame.ItemIndex < 0 then
  begin
    ShowMessage('Pilih peta terlebih dahulu!');
    Exit;
  end;

  gFilename := lstGSTGame.Items[lstGSTGame.ItemIndex];

  baseDir := Trim(dbEditSett.MapGSTGame);
  if (baseDir = '') or not DirectoryExists(baseDir) then
    baseDir := 'C:\Program Files (x24)\Docs\Map\GameArea';

  // Simpan full path peta ke variabel global gGSTGame
  gGSTGame := IncludeTrailingPathDelimiter(baseDir) + gFilename + PathDelim + gFilename + '.gst';

  if FileExists(gGSTGame) then
  begin
    ModalResult := mrOk; // Ini akan menutup form BrowseMap dan mengembalikan nilai mrOk
  end
  else
  begin
    ShowMessage('File peta tidak ditemukan di:' + sLineBreak + gGSTGame);
  end;
end;

procedure TfrmBrowseMap.btnZoomClick(Sender: TObject);
begin
  btnNormal.Down        := false;
  btnPan.Down           := false;
  btnDecreaseScale.Down := false;
  btnIncreaseScale.Down := false;
  btnZoom.Down          := true;
  btnZoomOut.Down              := false;
  btnDragFilter.Down    := false;

  if btnZoom.Down then
  begin
    mpLayer.CurrentTool  := miZoomInTool;
    mpLayer.MousePointer := miZoomInCursor;
  end;
end;

procedure TfrmBrowseMap.btnZoomOutClick(Sender: TObject);
begin
  btnNormal.Down        := false;
  btnPan.Down           := false;
  btnDecreaseScale.Down := false;
  btnIncreaseScale.Down := false;
  btnZoom.Down          := false;
  btnZoomOut.Down              := True;
  btnDragFilter.Down    := false;

  if btnZoomOut.Down then
  begin
    mpLayer.CurrentTool  := miZoomOutTool;
    mpLayer.MousePointer := miZoomOutCursor;
  end;
end;

procedure TfrmBrowseMap.cbbSetScaleChange(Sender: TObject);
var z : Double;
    s : string;
begin
  mpLayer.OnMapViewChanged := nil;
  if cbbSetScale.ItemIndex < 0  then Exit;

  if (cbbSetScale.ItemIndex <= 500) then
  begin
    s := cbbSetScale.Items[cbbSetScale.ItemIndex];
    try
     z := StrToFloat(s);
     mpLayer.ZoomTo(z, mpLayer.CenterX, mpLayer.CenterY);
    finally

    end;
  end
  else cbbSetScale.ItemIndex := cbbSetScale.ItemIndex -1 ;
  mpLayer.OnMapViewChanged := mpLayerMapViewChanged;
end;

procedure TfrmBrowseMap.FormShow(Sender: TObject);
var
  dirP : string;
begin

  if Assigned(mpLayer) then
  begin
    mpLayer.Layers.RemoveAll;

    mpLayer.BackColor := clWhite;
    mpLayer.Refresh;
    mpLayer.Repaint;
  end;

  lstGSTGame.Clear;
  gFilename := '';
  gGSTGame := '';

  dirP := Trim(dbEditSett.MapGSTGame);

  if (dirP = '') or not DirectoryExists(dirP) then
    dirP := 'C:\Program Files (x24)\Docs\Map\GameArea';

  GetFilename(dirP, lstGSTGame.Items);
end;

procedure TfrmBrowseMap.GetFilename(const dir: string; list: TStrings);
var
  sr: TSearchRec;
  targetDir: string;
begin
  targetDir := Trim(dir);
  if targetDir = '' then Exit;

  targetDir := IncludeTrailingPathDelimiter(targetDir);

  list.BeginUpdate;
  try
    list.Clear;
    if FindFirst(targetDir + '*.*', faDirectory, sr) = 0 then
    begin
      repeat
        if ((sr.Attr and faDirectory) <> 0) and (sr.Name <> '.') and (sr.Name <> '..') then
        begin
          if not SameText(sr.Name, 'indonesia') then
            list.Add(sr.Name);
        end;
      until FindNext(sr) <> 0;
    end;
  finally
    FindClose(sr);
    list.EndUpdate;
  end;
end;

procedure TfrmBrowseMap.Load_Map(geoSet: string);
var
  i: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin
  if mpLayer = nil then Exit;

  InitOleVariant(z);
  mpLayer.Layers.RemoveAll;

  mpLayer.Geoset := geoSet;

  if geoSet <> '' then
  begin
    for i := 1 to mpLayer.Layers.Count do
    begin
      mpLayer.Layers.Item(i).Selectable := False;
      mpLayer.Layers.Item(i).Editable   := False;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw;
    mInfo.AddParameter('Name', 'LYR_DRAW');
    FLyrDraw := mpLayer.Layers.Add(mInfo, 1);

    mpLayer.Layers.AnimationLayer := FLyrDraw;
    mpLayer.MapUnit := miUnitNauticalMile;
  end;

  mpLayer.BackColor := RGB(192, 224, 255);
end;


procedure TfrmBrowseMap.lstGSTGameClick(Sender: TObject);
var
  baseDir, fullPathGST: string;
begin
  if lstGSTGame.ItemIndex < 0 then Exit;

  gFilename := lstGSTGame.Items[lstGSTGame.ItemIndex];

  baseDir := Trim(dbEditSett.MapGSTGame);
  if (baseDir = '') or not DirectoryExists(baseDir) then
    baseDir := 'C:\Program Files (x24)\Docs\Map\GameArea';

  fullPathGST := IncludeTrailingPathDelimiter(baseDir) +
                 gFilename + PathDelim + gFilename + '.gst';

  if FileExists(fullPathGST) then
  begin
    gGSTGame := fullPathGST;
    Load_Map(fullPathGST);
  end
  else
  begin
    ShowMessage('File GST tidak ditemukan di:' + sLineBreak + fullPathGST);
  end;
end;

procedure TfrmBrowseMap.mpLayerMapViewChanged(Sender: TObject);
var
  tempZoom : double;
begin
  if mpLayer.CurrentTool = miZoomInTool then
  begin
    if mpLayer.Zoom <= 0.125 then tempZoom := 0.125;
    if (mpLayer.Zoom > 0.125) AND (mpLayer.Zoom < 1) then tempZoom := mpLayer.Zoom;
    if (mpLayer.Zoom >= 1) AND (mpLayer.Zoom <= 2500) then tempZoom := round(mpLayer.Zoom);
    if mpLayer.Zoom > 2500 then tempZoom := 2500;

    mpLayer.OnMapViewChanged := nil;
    mpLayer.ZoomTo(tempZoom, mpLayer.CenterX, mpLayer.CenterY);

    if (mpLayer.Zoom > 0.125) AND (mpLayer.Zoom < 0.25) then
    begin
      cbbSetScale.Text := FormatFloat('0.000', tempZoom);
    end
    else if (mpLayer.Zoom >= 0.25) AND (mpLayer.Zoom < 0.5) then
    begin
      cbbSetScale.Text := FormatFloat('0.00', tempZoom);
    end
    else if (mpLayer.Zoom >= 0.5) AND (mpLayer.Zoom < 1) then
    begin
      cbbSetScale.Text := FormatFloat('0.0', tempZoom);
    end
    else
      cbbSetScale.Text := floattostr(tempZoom);
    mpLayer.OnMapViewChanged := mpLayerMapViewChanged;
  end;
end;

end.

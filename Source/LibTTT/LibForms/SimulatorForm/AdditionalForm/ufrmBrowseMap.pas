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
  rec : TRecTCPSendSituationBoardTabProperties;

begin
  rec.OrderID := EDIT_TAB;
  rec.TabId := TabId;
  rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
  rec.TabAddres := '\' + gFilename + '\' + gFilename + '.gst';
  rec.TabCaption := TabCaption;

  simMgrClient.netSend_CmdSituationBoardTabProperties(rec);

  frmSituationBoard.RefreshTab;
  frmSituationBoard.btnGameArea.ImageIndex := 10;

  Close;
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
  i : Integer;
  dirP : string;
begin
  lstGSTGame.Clear;
  dirP := vMapSetting.MapGSTGame;
  GetFilename(dirP, lstGSTGame.Items);
end;

procedure TfrmBrowseMap.GetFilename(const dir: string; list: TStrings);
var
  sr : TSearchRec;
  str : string;
  I : Integer;
begin
  try
    if FindFirst(IncludeTrailingPathDelimiter(dir)+'*.*', faDirectory, sr) < 0 then
      Exit
    else
    begin
      repeat
        if ((sr.Attr and faDirectory <> 0) and (sr.Name <> '.') and (sr.Name <> '..')) then
        begin
          if (sr.Name <> 'indonesia-Background') then
            list.Add(sr.Name);
        end;

      until FindNext(sr) <> 0;
    end;
  finally
    FindClose(SR);
  end;
end;

procedure TfrmBrowseMap.Load_Map(geoSet: string);
var
  i,j: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin
  if mpLayer = nil then
    Exit;
  InitOleVariant(z);
  mpLayer.Layers.RemoveAll;

  mpLayer.Geoset := Geoset;

  if geoSet <> '' then
  begin
    for i := 1 to mpLayer.Layers.Count do
    begin
      mpLayer.Layers.Item(i).Selectable := false;
      mpLayer.Layers.Item(i).Editable   := false;
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
begin
  gFilename := lstGSTGame.Items[(Sender as TListBox).ItemIndex];
  gGSTGame := vMapSetting.MapGSTGame + '\' + gFilename + '\' + gFilename + '.gst';

  if FileExists(gGSTGame) then
    Load_Map(gGSTGame);
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

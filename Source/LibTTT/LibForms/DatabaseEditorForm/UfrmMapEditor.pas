unit UfrmMapEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  ImageButton, Vcl.StdCtrls, Vcl.OleCtrls, MapXLib_TLB, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin,

  uClassData, Vcl.CheckLst, uDataModule, uLibSetting, uCoordConvertor;

type
  E_MapCursor = (mcSelect, mcMultiSelect, mcZoom, mcGameCenter, mcPan);

  TfrmMapEditor = class(TForm)
    pnlLeft: TPanel;
    pnlLeftBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    pnlLeftTop: TPanel;
    Label1: TLabel;
    edtName: TEdit;
    Label2: TLabel;
    edtSearch: TEdit;
    pnlMap: TPanel;
    ENCMap: TMap;
    pnlToolBar: TPanel;
    pnlAlignToolBar: TPanel;
    ToolBar1: TToolBar;
    btnDecrease: TToolButton;
    cbSetScale: TComboBox;
    btnIncrease: TToolButton;
    btnPan: TToolButton;
    btnCenterGame: TToolButton;
    btnZoom: TToolButton;
    ImageList1: TImageList;
    chklstArea: TCheckListBox;
    ProgressBar1: TProgressBar;
    pnlLeftMain: TPanel;
    btnSelect: TToolButton;
    btnout: TToolButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnDecreaseClick(Sender: TObject);
    procedure cbSetScaleChange(Sender: TObject);
    procedure btnIncreaseClick(Sender: TObject);
    procedure btnPanClick(Sender: TObject);
    procedure btnCenterGameClick(Sender: TObject);
    procedure btnZoomClick(Sender: TObject);
//    procedure lbxMapEditorClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure chklstAreaClickCheck(Sender: TObject);
    procedure ENCMapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
      hOutputDC, hAttributeDC: Integer; const RectFull, RectInvalid: IDispatch);
    procedure ENCMapMapViewChanged(Sender: TObject);
    procedure ENCMapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ENCMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ENCMapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure btnOutclick(Sender: TObject);

  private
    FSelectedGameArea : TGame_Area_Definition;

    FListMapIndex : TStringList;
    FListFiltered : TStringList;
    FIsMouseDown : Boolean;
    FSelectionStartX, FSelectionStartY : single;
    FSelectionEndX, FSelectionEndY : single;

    FCanvas : TCanvas;
    FConverter : TCoordConverter;
    FLyrDraw : CMapXLayer;
    FMap1 : TMap;

    FMapCursor : E_MapCursor;

    procedure LoadList;
    procedure SetChecked;
    procedure SetMapArea;
    procedure DrawCheckedLayer;
    procedure SelectionArea;
    procedure CreateGeosetFile;
    procedure UpdateGeosetFile;
    procedure DeleteGameAreaDirectory(const aPathName, aFileName: string);

    procedure LoadENC(ENCGeoset: string);

  public
    xx, yy : Double;
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    function CekInput: Boolean;
    property SelectedGameArea : TGame_Area_Definition read FSelectedGameArea write FSelectedGameArea;
  end;

const
  DIMENSION = 1024;

var
  frmMapEditor: TfrmMapEditor;

implementation

{$R *.dfm}
procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).VType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;

function SeparateString(const s: string; del: char; var s1, s2: string): boolean;
var
  i, l: integer;
begin
  result := false;
  l := Length(s);
  i := Pos(del, s);

  if (l < 2) or (i < 1) then
    Exit;

  s1 := Copy(s, 1, i - 1);
  s2 := Copy(s, i + 1, l - i);

  s1 := Trim(s1);
  s2 := Trim(s2);
  result := (s1 <> '') and (s2 <> '');
end;

procedure TfrmMapEditor.btnCancelClick(Sender: TObject);
begin
Close
end;

procedure TfrmMapEditor.btnCenterGameClick(Sender: TObject);
begin
//  LoadNormalButtonImage;
  FMapCursor := mcGameCenter;

  ENCMap.CurrentTool := miArrowTool;
  ENCMap.MousePointer := miCrossCursor;

//  btnCenterGame.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnCenterOnHook_Select.PNG');
end;

procedure TfrmMapEditor.btnDecreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 16 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex + 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmMapEditor.btnIncreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 0 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex - 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmMapEditor.btnOkClick(Sender: TObject);
begin
  with FSelectedGameArea do
  begin
    if not CekInput  then
      Exit;

    if (FData.Game_Centre_Lat = 0) or (FData.Game_Centre_Long = 0) then
    begin
      ShowMessage('Game Center has not been set.');
      Exit;
    end;

    FData.Game_Area_Identifier := edtName.Text;
    FData.Game_X_Dimension := DIMENSION;
    FData.Game_Y_Dimension := DIMENSION;
    FData.Use_Real_World := 0;
    FData.Use_Artificial_Landmass := 0;
    FData.Detail_Map := 'ENC';

    {Buat Game Area Baru}
    if FData.Game_Area_Index = 0 then
    begin
      dmINWO.InsertGameAreaDef(FData);
      CreateGeosetFile;
    end
    {Update Game Area}
    else
    begin
      dmINWO.UpdateGameAreaDef(FData);
      UpdateGeosetFile;
    end;
  end;

  AfterClose := True;
  Close;
end;

procedure TfrmMapEditor.btnOutclick(Sender: TObject);
begin
  if btnZoom.Down then
    btnZoom.Down := False;

  btnout.Down := not btnout.Down;
  btnPan.Down := false;

  FMapCursor := mcSelect;

  ENCMap.CurrentTool := miZoomoutTool;
  ENCMap.MousePointer := miZoomoutCursor;

  btnout.ImageIndex := 8;
end;

procedure TfrmMapEditor.btnPanClick(Sender: TObject);
begin
//  LoadNormalButtonImage;
  FMapCursor := mcPan;

  ENCMap.CurrentTool := miPanTool;
  ENCMap.MousePointer := miPanCursor;

//  btnPan.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnMove_Select.PNG');
end;

procedure TfrmMapEditor.btnSelectClick(Sender: TObject);
begin
  FMapCursor := mcSelect;

  ENCmap.CurrentTool := miSelectTool;
  ENCmap.MousePointer := miDefaultCursor;
end;

procedure TfrmMapEditor.btnZoomClick(Sender: TObject);
begin
//  LoadNormalButtonImage;
  FMapCursor := mcZoom;

  ENCMap.CurrentTool := miZoomInTool;
  ENCMap.MousePointer := miZoomInCursor;

//  btnZoom.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnZoomIn_Select.PNG');
end;

//procedure TfrmSummaryGameAreaEditor.LoadNormalButtonImage;
//begin
//  btnSelect.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnCursor_Normal.PNG');
//  btnZoom.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnZoomIn_Normal.PNG');
//  btnCenterOnGameCenter.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnCenterOnHook_Normal.PNG');
//  btnPan.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnMove_Normal.PNG');
//end;

procedure TfrmMapEditor.cbSetScaleChange(Sender: TObject);
var
  z : Double;
  s : string;
begin
  ENCMap.OnMapViewChanged := nil;

  if cbSetScale.ItemIndex < 0  then Exit;

  if (cbSetScale.ItemIndex <= 500) then
  begin
   s := cbSetScale.Items[cbSetScale.ItemIndex];
   try
     z := StrToFloat(s);
     ENCMap.ZoomTo(z, ENCMap.CenterX, ENCMap.CenterY);
   finally

   end;
  end
  else cbSetScale.ItemIndex := cbSetScale.ItemIndex -1 ;
//  ENCmap.OnMapViewChanged := ENCmapMapViewChanged;
end;

function TfrmMapEditor.CekInput: Boolean;
var
  i, chkSpace, numSpace: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (edtName.Text = '')then
  begin
    ShowMessage('Please insert class name');
    Exit;
  end;

  {Jika berisi spasi semua}
  if Copy(edtName.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtName.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtName.Text[i] = #32 then
      numSpace := numSpace + 1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  {Jika Class Name sudah ada}
  if (dmINWO.GetGameAreaDef(edtName.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedGameArea.FData.Game_Area_Index = 0 then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end
    else if LastName <> edtName.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmMapEditor.chklstAreaClickCheck(Sender: TObject);
var
  layerStr, layerID, layerName : string;
  i, foundIndex : Integer;
  layer : CMapXLayer;
begin
  layerStr := chklstArea.Items[chklstArea.ItemIndex];
  SeparateString(layerStr, '=', layerID, layerName);

  if FListFiltered.Find(layerID, foundIndex) then
    FListFiltered.Delete(foundIndex)
  else
    FListFiltered.Add(layerID);

  SetMapArea;

//  FListFiltered.Sort;
//
//  for i := 1 to ENCmap.Layers.Count do
//  begin
//    layer := ENCmap.Layers.Item(i);
//
//    if (layer.Name = 'Indonesia_Coastline_Darat') or (layer.Name = 'LYR_DRAW') then
//      Continue;
//
//    SeparateString(layer.Name, '_', layerID, layerName);
//
//    if FListFiltered.Find(layerID, foundIndex) then
//    begin
//      layer.OverrideStyle := True;
//      layer.Style.RegionColor := clRed;
//    end
//    else
//      layer.OverrideStyle := False;
//  end;
end;

procedure TfrmMapEditor.CreateGeosetFile;
var
  myFile : TextFile;
  i, j : Integer;
  fileSource, fileDest : string;
  dirP   : string;

  indx   : string;
  mtype  : string;
  ProgressPos : Integer;

begin
  AssignFile(myFile, 'ConfigureLayerENC.txt');
  ReWrite(myFile);

  for i := 0 to FListFiltered.Count - 1 do
    Writeln(myFile, FListFiltered[i]);

  CloseFile(myFile);

  dirP := vGameAreaSetting.MapGSTGame + '\' + edtName.Text;
  CreateDir(dirP);

  fileSource := ExtractFilePath(ParamStr(0)) + '\ConfigureLayerENC.txt';
  fileDest := dirP + '\' + edtName.Text + '.txt';

  CopyFile(PChar(fileSource), PChar(fileDest), False);

  FMap1.Layers.RemoveAll;

  ProgressBar1.Visible := True;
  ProgressBar1.Position := 0;

  if FListFiltered.Count > 0 then
    ProgressPos := Round(100/FListFiltered.Count)
  else
  begin
    for j := 0 to Random(80) do
      ProgressBar1.Position := j;
  end;

  {Memaksa memberi background indonesia}
  fileDest := vGameAreaSetting.Pattern;
  FMap1.Layers.AddGeoSetLayers(fileDest);

  for i := 0 to FListFiltered.Count - 1 do
  begin
    if SeparateString(FListFiltered.Strings[I], '\', indx, mtype)then
    begin
      fileDest := vGameAreaSetting.MapTypePath + '\' + mtype + '\' + indx + '\' + indx + '.gst';
    end
    else
    begin
      fileDest := vGameAreaSetting.MapTypePath + '\_MAP_ENC\' + FListFiltered[i] + '\' + FListFiltered[i] + '.gst';
    end;

    FMap1.Layers.AddGeoSetLayers(fileDest);

    ProgressBar1.Position := ProgressBar1.Position + ProgressPos;
  end;

  fileDest := dirP + '\' + edtName.Text + '.gst';
  FMap1.SaveMapAsGeoset('final', fileDest);

  ProgressBar1.Position := 100;
  ProgressBar1.Visible := False;
end;

procedure TfrmMapEditor.DeleteGameAreaDirectory(const aPathName,aFileName: string);
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

procedure TfrmMapEditor.DrawCheckedLayer;
var
  i, j : Integer;
  layer : CMapXLayer;
  layerID, layerName : string;
begin
  for i := 1 to ENCMap.Layers.Count do
  begin
    layer := ENCMap.Layers.Item(i);

    if (layer.Name = 'Indonesia_Coastline_Darat') or
      (layer.Name = 'LYR_DRAW') then
      Continue;

    if SeparateString(layer.Name, '_', layerID, layerName) then
    begin
      for j := 0 to FListFiltered.Count - 1 do
      begin
        if FListFiltered[j] = layerID then
        begin
          layer.OverrideStyle := True;
          layer.Style.RegionColor := clRed;
        end;
      end;
    end;
  end;
end;

procedure TfrmMapEditor.edtSearchKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  str_details, str_id : string;
begin
  if Key = #13 then
  begin
    chklstArea.Items.Clear;

    if edtSearch.Text = '' then
      chklstArea.Items := FListMapIndex
    else
    begin
      for i := 0 to FListMapIndex.Count - 1 do
      begin
        if Pos(edtSearch.Text, FListMapIndex[i]) <> 0 then
          chklstArea.Items.Add(FListMapIndex[i]);
      end;
    end;
    SetChecked;
  end;
end;

procedure TfrmMapEditor.ENCMapDrawUserLayer(ASender: TObject; const Layer: IDispatch; hOutputDC, hAttributeDC: Integer; const RectFull, RectInvalid: IDispatch);
begin
  with FCanvas do
  begin
    Handle := hOutputDC;

    if FIsMouseDown then
    begin
      Pen.Color := clYellow;
      Pen.Width := 3;
      Brush.Style := bsClear;
      Rectangle(Round(FSelectionStartX), Round(FSelectionStartY), Round(FSelectionEndX), Round(FSelectionEndY));
//      Rectangle(FSelectionStartX, FSelectionStartY), Round(FSelectionEndX), Round(FSelectionEndY));
    end;
  end;
end;

procedure TfrmMapEditor.ENCMapMapViewChanged(Sender: TObject);
var
  tempZoom : double;
begin
  if (ENCmap.CurrentTool = miZoomInTool)  or (ENCmap.CurrentTool = miZoomOutTool) then
  begin
     if ENCmap.Zoom <= 0.125 then tempZoom := 0.125;
     if (ENCmap.Zoom > 0.125) AND (ENCmap.Zoom < 1) then tempZoom := ENCmap.Zoom;
     if (ENCmap.Zoom >= 1) AND (ENCmap.Zoom <= 2500) then tempZoom := round(ENCmap.Zoom);
     if ENCmap.Zoom > 2500 then tempZoom := 2500;

     ENCmap.OnMapViewChanged := nil;
     ENCmap.ZoomTo(tempZoom, ENCmap.CenterX, ENCmap.CenterY);

     if (ENCmap.Zoom > 0.125) AND (ENCmap.Zoom < 0.25) then
     begin
       cbSetScale.Text := FormatFloat('0.000', tempZoom);
     end
     else if (ENCmap.Zoom >= 0.25) AND (ENCmap.Zoom < 0.5) then
     begin
       cbSetScale.Text := FormatFloat('0.00', tempZoom);
     end
     else if (ENCmap.Zoom >= 0.5) AND (ENCmap.Zoom < 1) then
     begin
       cbSetScale.Text := FormatFloat('0.0', tempZoom);
     end
     else
       cbSetScale.Text := floattostr(tempZoom);

     ENCmap.OnMapViewChanged := ENCmapMapViewChanged;
  end;
end;

procedure TfrmMapEditor.ENCMapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  castX, castY : single;
  i : Integer;
  layer : CMapXLayer;
begin

  {$Region ' Select '}
  if FMapCursor = mcSelect then
  begin
    FSelectionStartX := X;
    FSelectionStartY := Y;
    FSelectionEndX := X;
    FSelectionEndY := Y;
  end;
  {$ENDREGION}

  {$Region ' Multiselect '}
  if FMapCursor = mcMultiSelect then
  begin
    FIsMouseDown := True;

    FListFiltered.Clear;

    FSelectionStartX := X;
    FSelectionStartY := Y;
    FSelectionEndX := X;
    FSelectionEndY := Y;

//    for i := 1 to ENCmap.Layers.Count do
//    begin
//      layer := ENCmap.Layers.Item(i);
//
//      if (layer.Name = 'Indonesia_Coastline_Darat') or (layer.Name = 'LYR_DRAW') then
//        Continue;
//
//      layer.OverrideStyle := False;
//    end;
//
//    ENCmap.Repaint;
  end;
  {$ENDREGION}

  {$Region ' Set Game Center '}

  if FMapCursor = mcGameCenter then
  begin

    FConverter.ConvertToMap(X, Y, FSelectedGameArea.FData.Game_Centre_Long, FSelectedGameArea.FData.Game_Centre_Lat);

  end;
  {$ENDREGION}
end;

procedure TfrmMapEditor.ENCMapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  centerX, centerY : Double;

begin
//  if (FMapCursor = mcMultiSelect) and FIsMouseDown then
//  begin
//    FSelectionEndX := X;
//    FSelectionEndY := Y;
//
//    ENCmap.Repaint;
//  end;

  FConverter.ConvertToMap(X, Y, xx, yy);

  centerX := FSelectedGameArea.FData.Game_Centre_Long;
  centerY := FSelectedGameArea.FData.Game_Centre_Lat;


//  lblBearing.Caption := FormatFloat('0.00', CalcBearing(centerX, centerY, xx, yy));
//  lblDistance.Caption := FormatFloat('0.00',CalcRange(centerX, centerY, xx, yy));
//  getGridCursorPos;

end;

procedure TfrmMapEditor.ENCMapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if FMapCursor = mcSelect then
  begin
    SelectionArea;
    ENCmap.Repaint;
  end;

  if (FMapCursor = mcMultiSelect) and FIsMouseDown then
  begin
    FIsMouseDown := False;
//    FSelectionRectEnd := Point(X, Y);
    FSelectionEndX := X;
    FSelectionEndY := Y;
    SelectionArea;
    ENCmap.Repaint;
  end;

end;

procedure TfrmMapEditor.FormCreate(Sender: TObject);
var
  itemMaxWidth, i, itemWidth : Integer;
begin
  FListMapIndex := TStringList.Create;
  FListFiltered := TStringList.Create;
  FCanvas := TCanvas.Create;
  FConverter := TCoordConverter.Create;
  FMap1 := TMap.Create(Self);

  FListMapIndex.LoadFromFile(vGameAreaSetting.MapENC + '\' + 'mapindex.ini');
  chklstArea.Items := FListMapIndex;

  //Set Checklist Area Width
  itemMaxWidth := 0;
  for i := 0 to chklstArea.Items.Count - 1 do
  begin
    itemWidth := chklstArea.Canvas.TextWidth(chklstArea.Items.Strings[i]);

    if itemWidth > itemMaxWidth then
      itemMaxWidth := itemWidth;
  end;
  SendMessage(chklstArea.Handle, LB_SETHORIZONTALEXTENT, itemMaxWidth + 20, 0);
end;

procedure TfrmMapEditor.FormResize(Sender: TObject);
begin
  WindowState := wsMaximized;
  pnlAlignToolBar.Width := round((pnlToolBar.Width - 433) / 2);
end;

procedure TfrmMapEditor.FormShow(Sender: TObject);
var
  i, itemMaxWidth, itemWidth : Integer;
  sourceCopy, destCopy : string;
begin
  LoadENC(vGameAreaSetting.MapSourceGeosetENC);
  FConverter.FMap := ENCMap;

  btnSelectClick(nil);
  cbSetScale.ItemIndex := cbSetScale.Items.Count - 1;
  cbSetScaleChange(cbSetScale);

  with FSelectedGameArea.FData do
  begin
    if Game_Area_Index = 0 then
      edtName.Text := '(Unnamed)'
    else
      edtName.Text := Game_Area_Identifier;

    LastName := edtName.Text;
  end;

  edtSearch.Text := '';

  ProgressBar1.Visible := True;

  ProgressBar1.Position := 0;
  for i := 0 to Random(80) do
    ProgressBar1.Position := i;

  LoadList;
  chklstArea.Items := FListMapIndex;
  SetChecked;
  SetMapArea;
  ProgressBar1.Position := 90;
  DrawCheckedLayer;

  ProgressBar1.Position := 100;
  ProgressBar1.Visible := False;
end;

//procedure TfrmMapEditor.lbxMapEditorClick(Sender: TObject);
//var
//  layerStr, layerID, layerName : string;
//  i, foundIndex : Integer;
//  layer : CMapXLayer;
//begin
//  layerStr := chklstArea.Items[chklstArea.ItemIndex];
//  SeparateString(layerStr, '=', layerID, layerName);
//
//  if FListFiltered.Find(layerID, foundIndex) then
//    FListFiltered.Delete(foundIndex)
//  else
//    FListFiltered.Add(layerID);
//
//  SetMapArea;
//
////  FListFiltered.Sort;
////
////  for i := 1 to ENCmap.Layers.Count do
////  begin
////    layer := ENCmap.Layers.Item(i);
////
////    if (layer.Name = 'Indonesia_Coastline_Darat') or (layer.Name = 'LYR_DRAW') then
////      Continue;
////
////    SeparateString(layer.Name, '_', layerID, layerName);
////
////    if FListFiltered.Find(layerID, foundIndex) then
////    begin
////      layer.OverrideStyle := True;
////      layer.Style.RegionColor := clRed;
////    end
////    else
////      layer.OverrideStyle := False;
////  end;
//end;

procedure TfrmMapEditor.LoadENC(ENCGeoset: string);
var
  z : OleVariant;
  i : Integer;
  mInfo : CMapXLayerInfo;
begin
  if ENCMap = nil then
    Exit;

  InitOleVariant(z);
  ENCMap.Layers.RemoveAll;
  ENCMap.Geoset := ENCGeoset;

  if ENCGeoset <> '' then
  begin
    for i := 1 to ENCMap.Layers.Count do
    begin
      ENCMap.Layers.Item(i).Selectable := False;
      ENCMap.Layers.Item(i).Editable := False;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw;
    mInfo.AddParameter('Name', 'LYR_DRAW');
    FLyrDraw := ENCMap.Layers.Add(mInfo, 1);

    ENCMap.Layers.AnimationLayer := FLyrDraw;
    ENCMap.MapUnit := miUnitNauticalMile;
  end;

  ENCMap.BackColor := RGB(192, 224, 255);
end;

procedure TfrmMapEditor.LoadList;
var
  pathConFile, nameGameArea : string;
begin
  FListFiltered.Clear;

  if Assigned(FSelectedGameArea) then
  begin
    nameGameArea := FSelectedGameArea.FData.Game_Area_Identifier;
    pathConFile := vGameAreaSetting.MapGSTGame + '\' + nameGameArea;

    if FileExists(pathConFile + '\' + nameGameArea  + '.txt') then
      FListFiltered.LoadFromFile(pathConFile + '\' + nameGameArea  + '.txt');
  end;
end;

procedure TfrmMapEditor.SelectionArea;
var
  startX, startY, endX, endY,
  i, foundIndex : Integer;
  startLat, startLong, endLat, endLong : Double;
  layer : CMapXLayer;
  layerID, layerName : string;
begin

  {$REGION ' Validation Point Cursor '}
  if FSelectionStartX < FSelectionEndX then
  begin
    startX := Round(FSelectionStartX);
    endX := Round(FSelectionEndX);
  end
  else
  begin
    startX := Round(FSelectionEndX);
    endX := Round(FSelectionStartX);
  end;

  if FSelectionStartY < FSelectionEndY then
  begin
    startY := Round(FSelectionStartY);
    endY := Round(FSelectionEndY);
  end
  else
  begin
    startY := Round(FSelectionEndY);
    endY := Round(FSelectionStartY);
  end;

  FConverter.ConvertToMap(startX, startY, startLong, startLat);
  FConverter.ConvertToMap(endX, endY, endLong, endLat);

  {$ENDREGION}

  {$REGION ' Select Area '}

  for i := 1 to ENCmap.Layers.Count do
  begin
    layer := ENCmap.Layers.Item(i);

    if (layer.Name = 'Indonesia_Coastline_Darat') or (layer.Name = 'LYR_DRAW') or (layer.Name = 'ID2000_land')then
      Continue;

    if FMapCursor = mcSelect then
    begin
      {$REGION ' Select Single Area '}
      if (startLong >= layer.Bounds.XMin) and (startLat <= layer.Bounds.YMax) and
        (endLong <= layer.Bounds.XMax) and (endLat >= layer.Bounds.YMin) then
      begin
        SeparateString(layer.Name, '_', layerID, layerName);

        if FListFiltered.Find(layerID, foundIndex) then
          FListFiltered.Delete(foundIndex)
        else
          FListFiltered.Add(layerID);
      end;
      {$ENDREGION}
    end
    else if FMapCursor = mcMultiSelect then
    begin
      {$REGION ' Select Multi Area '}
      if (layer.Bounds.XMin >= startLong) and (layer.Bounds.YMax <= startLat) and
        (layer.Bounds.XMax <= endLong) and (layer.Bounds.YMin >= endLat) then
      begin
        SeparateString(layer.Name, '_', layerID, layerName);

        if FListFiltered.Find(layerID, foundIndex) then
        begin
          FListFiltered.Delete(foundIndex);
//          layer.OverrideStyle := False;
        end
        else
        begin
          FListFiltered.Add(layerID);
//          layer.OverrideStyle := True;
//          layer.Style.RegionColor := clRed;
        end;
      end;
      {$ENDREGION}
    end;
  end;

  {$ENDREGION}

  SetChecked;
  SetMapArea;
end;

procedure TfrmMapEditor.SetChecked;
var
  i, j : Integer;
  layerStr, layerID, layerName : string;
  checked : Boolean;
begin
  for i := 0 to chklstArea.Count - 1 do
  begin
    layerStr := chklstArea.Items[i];
    SeparateString(layerStr, '=', layerID, layerName);

    checked := False;
    for j := 0 to FListFiltered.Count - 1 do
    begin
      if FListFiltered[j] = layerID then
      begin
        checked := True;
        Break;
      end;
    end;

    chklstArea.Checked[i] := checked;
  end;
end;

procedure TfrmMapEditor.SetMapArea;
var
  i, foundIndex : Integer;
  layerID, layerName : string;
  layer : CMapXLayer;
begin
  FListFiltered.Sort;

  for i := 1 to ENCMap.Layers.Count do
  begin
    layer := ENCMap.Layers.Item(i);

    if (layer.Name = 'Indonesia_Coastline_Darat') or (layer.Name = 'LYR_DRAW') then
      Continue;

    SeparateString(layer.Name, '_', layerID, layerName);

    if FListFiltered.Find(layerID, foundIndex) then
    begin
      layer.OverrideStyle := True;
      layer.Style.RegionColor := clRed;
    end
    else
      layer.OverrideStyle := False;
  end;
end;

procedure TfrmMapEditor.UpdateGeosetFile;
var
  MapDirPath : string;
begin
  MapDirPath := vGameAreaSetting.MapGSTGame + '\' + LastName;
  DeleteGameAreaDirectory(MapDirPath, MapDirPath);
  CreateGeosetFile;
end;

end.

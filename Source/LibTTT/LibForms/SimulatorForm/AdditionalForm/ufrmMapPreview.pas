unit ufrmMapPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Types,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.OleCtrls, MapXLib_TLB,
  Vcl.ExtCtrls,

  uClassData, uCoordConvertor, uLibSetting ;

type
  E_MapCursor = (mcSelect, mcMultiSelect, mcZoom, mcGameCenter, mcPan);

  TfrmMapPreview = class(TForm)
    pnlMap: TPanel;
    ENCMap: TMap;
    pnlToolBar: TPanel;
    pnlAlignToolBar: TPanel;
    ToolBar1: TToolBar;
    btnDecrease: TToolButton;
    cbSetScale: TComboBox;
    btnIncrease: TToolButton;
    btnSelect: TToolButton;
    btnCenterGame: TToolButton;
    btnZoom: TToolButton;
    btnPan: TToolButton;
    ImageList1: TImageList;
    btnout: TToolButton;
    btnLayerTool: TToolButton;
    btnCancelPriview: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDecreaseClick(Sender: TObject);
    procedure cbSetScaleChange(Sender: TObject);
    procedure btnIncreaseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnCenterGameClick(Sender: TObject);
    procedure btnZoomClick(Sender: TObject);
    procedure btnPanClick(Sender: TObject);
    procedure btnoutclick(Sender: TObject);
    procedure btnLayerToolClick(Sender: TObject);
    procedure btnCancelPriviewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ENCMapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
      hOutputDC, hAttributeDC: Integer; const RectFull, RectInvalid: IDispatch);
    procedure ENCMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ENCMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ENCMapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ENCMapMapViewChanged(Sender: TObject);

  private
    FSelectedGameArea : TGame_Area_Definition;

    FCanvas: TCanvas;
    FLyrDraw: CMapXLayer;
    FConverter: TCoordConverter;
    FMapCursor : E_MapCursor;

    FIsMouseDown : Boolean;
    FSelectionRectStart : Types.TPoint;
    FSelectionRectEnd : Types.TPoint;
    FZoomRectStart :Types.TPoint;
    FZoomRectEnd : Types.TPoint;

    procedure UpAllToolbarButton;

  public
    procedure LoadMap(Geoset: String);

    property SelectedGameArea : TGame_Area_Definition read FSelectedGameArea write FSelectedGameArea;

  end;

var
  frmMapPreview: TfrmMapPreview;

implementation

{$R *.dfm}


procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;


procedure TfrmMapPreview.btnCenterGameClick(Sender: TObject);
begin
  UpAllToolbarButton;
  btnCenterGame.Down := True;
  FMapCursor := mcGameCenter;

  ENCMap.CurrentTool := miArrowTool;
  ENCMap.MousePointer := miCrossCursor;
end;

procedure TfrmMapPreview.btnDecreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 16 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex + 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmMapPreview.btnIncreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 0 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex - 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmMapPreview.btnLayerToolClick(Sender: TObject);
var
  vHelpFile, vHelpID : OleVariant;
begin
  UpAllToolbarButton;
  btnLayerTool.Down := True;

  if btnLayerTool.ImageIndex = 16 then
  begin
    btnLayerTool.ImageIndex := 15;
    try
      ENCMap.Layers.LayersDlg(vHelpFile, vHelpID);
    finally
      btnLayerTool.ImageIndex := 16;
    end;
  end;
end;

procedure TfrmMapPreview.btnoutclick(Sender: TObject);
begin
  UpAllToolbarButton;
  btnout.Down := True;

//  btnout.Down := not btnout.Down;
//  btnPan.Down := false;

  FMapCursor := mcSelect;

  ENCMap.CurrentTool := miZoomoutTool;
  ENCMap.MousePointer := miZoomoutCursor;

//  btnout.ImageIndex := 8;
end;

procedure TfrmMapPreview.btnPanClick(Sender: TObject);
begin
  UpAllToolbarButton;
  btnPan.Down := True;
  FMapCursor := mcPan;

  ENCMap.CurrentTool := miPanTool;
  ENCMap.MousePointer := miPanCursor;
end;

procedure TfrmMapPreview.btnSelectClick(Sender: TObject);
begin
  UpAllToolbarButton;
  btnSelect.Down := True;
  FMapCursor := mcSelect;

  ENCmap.CurrentTool := miSelectTool;
  ENCmap.MousePointer := miDefaultCursor;
end;

procedure TfrmMapPreview.btnZoomClick(Sender: TObject);
begin
  UpAllToolbarButton;
  btnZoom.Down := True ;
  FMapCursor := mcZoom;

  ENCMap.CurrentTool := miZoomInTool;
  ENCMap.MousePointer := miZoomInCursor;

//  ENCMap.CurrentTool := miZoomInTool;
//  ENCMap.MousePointer := miZoomInCursor;
end;

procedure TfrmMapPreview.btnCancelPriviewClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMapPreview.cbSetScaleChange(Sender: TObject);
var
  z : Double;
  s : string;
begin
  ENCMap.OnMapViewChanged := nil;

  if (cbSetScale.ItemIndex < 0) or (cbSetScale.ItemIndex >= cbSetScale.Items.Count) then
    Exit;

  s := cbSetScale.Items[cbSetScale.ItemIndex];
  z := StrToFloatDef(s, 0); // Jika gagal konversi, default ke 0

  if z > 0 then
    ENCMap.ZoomTo(z, ENCMap.CenterX, ENCMap.CenterY);
end;

procedure TfrmMapPreview.ENCMapDrawUserLayer(ASender: TObject;
  const Layer: IDispatch; hOutputDC, hAttributeDC: Integer; const RectFull,
  RectInvalid: IDispatch);
begin
  with FCanvas do
  begin
    Handle := hOutputDC;

    if FIsMouseDown then
    begin
      Pen.Color := clYellow;
      Pen.Width := 3;
      Brush.Style := bsClear;
      Rectangle(FSelectionRectStart.X, FSelectionRectStart.Y, FSelectionRectEnd.X, FSelectionRectEnd.Y);
    end;

    if FIsMouseDown and btnZoom.Down then
    begin
      Pen.Color := clWhite;
      Pen.Width := 1;
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(FZoomRectStart.X, FZoomRectStart.Y, FZoomRectEnd.X, FZoomRectEnd.Y);
    end;
  end;
end;

procedure TfrmMapPreview.ENCMapMapViewChanged(Sender: TObject);
var
  tempZoom : double;
begin
  if (ENCMap.CurrentTool = miZoomInTool)  or (ENCMap.CurrentTool = miZoomOutTool) then
  begin
     if ENCMap.Zoom <= 0.125 then tempZoom := 0.125;
     if (ENCMap.Zoom > 0.125) AND (ENCMap.Zoom < 1) then tempZoom := ENCMap.Zoom;
     if (ENCMap.Zoom >= 1) AND (ENCMap.Zoom <= 3500) then tempZoom := round(ENCMap.Zoom);
     if ENCMap.Zoom > 3500 then tempZoom := 3500;

     ENCMap.OnMapViewChanged := nil;
     ENCMap.ZoomTo(tempZoom, ENCMap.CenterX, ENCMap.CenterY);

     if (ENCMap.Zoom > 0.125) AND (ENCMap.Zoom < 0.25) then
     begin
       cbSetScale.Text := FormatFloat('0.000', tempZoom);
     end
     else if (ENCMap.Zoom >= 0.25) AND (ENCMap.Zoom < 0.5) then
     begin
       cbSetScale.Text := FormatFloat('0.00', tempZoom);
     end
     else if (ENCMap.Zoom >= 0.5) AND (ENCMap.Zoom < 1) then
     begin
       cbSetScale.Text := FormatFloat('0.0', tempZoom);
     end
     else
       cbSetScale.Text := floattostr(tempZoom);

     ENCMap.OnMapViewChanged := ENCMapMapViewChanged;
  end;
end;

procedure TfrmMapPreview.ENCMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {$Region ' Set Zoom '}
  if btnZoom.Down then
  begin
    FIsMouseDown := True;

    FZoomRectStart := Types.Point(X, Y);
    FZoomRectEnd := Types.Point(X, Y);
  end;
  {$ENDREGION}
end;

procedure TfrmMapPreview.ENCMapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  {$Region ' Set Zoom '}
  if btnZoom.Down and FIsMouseDown then
  begin
    FZoomRectEnd := Types.Point(X, Y);
    ENCMap.Repaint;
  end;
  {$ENDREGION}
end;

procedure TfrmMapPreview.ENCMapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  if btnZoom.Down and FIsMouseDown then
  begin
    FIsMouseDown := False;
    FZoomRectEnd:= Types.Point(X, Y);
    ENCMap.OnMapViewChanged := ENCMapMapViewChanged;
    ENCMap.Repaint;
end;
end;

procedure TfrmMapPreview.FormCreate(Sender: TObject);
begin
  FCanvas := TCanvas.Create;
  FConverter := TCoordConverter.Create;
end;

procedure TfrmMapPreview.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCanvas);
  FreeAndNil(FConverter);
end;

procedure TfrmMapPreview.FormResize(Sender: TObject);
begin
  WindowState := wsMaximized;
  pnlAlignToolBar.Width := round((pnlToolBar.Width - 433) / 2);
end;

procedure TfrmMapPreview.FormShow(Sender: TObject);
var
  aGeoset, ENCGeoset, VektorGeoset, GameAreaName: string;
begin
  LoadMap(dbEditSett.MapGSTGame + '\' + SelectedGameArea.FData.Game_Area_Identifier + '\' + SelectedGameArea.FData.Game_Area_Identifier + '.gst');

  FConverter.FMap := ENCMap;

  cbSetScale.ItemIndex := cbSetScale.Items.Count - 1;
  cbSetScaleChange(Sender);

  cbSetScale.Text := cbSetScale.Items.Strings[cbSetScale.ItemIndex];
  btnSelect.OnClick(btnSelect);

  cbSetScaleChange(Sender);
end;

procedure TfrmMapPreview.LoadMap(Geoset: String);
var
  i: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin
  if ENCMap = nil then
    Exit;

  InitOleVariant(z);
  ENCMap.Layers.RemoveAll;

  ENCMap.Geoset := Geoset;

  if Geoset <> '' then
  begin
    for i := 1 to ENCMap.Layers.Count do
    begin
      ENCMap.Layers.Item(i).Selectable := false;
      ENCMap.Layers.Item(i).Editable := false;
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

procedure TfrmMapPreview.UpAllToolbarButton;
begin
  btnSelect.Down := False;
  btnPan.Down := False;
  btnZoom.Down := False;
  btnCenterGame.Down := False;
  btnLayerTool.Down := False;

  ENCMap.CurrentTool := miArrowTool;
  ENCMap.MousePointer := miDefaultCursor;
end;

end.

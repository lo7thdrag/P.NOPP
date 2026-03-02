unit uMapXHandler;

interface

uses
  MapXLib_TLB, Windows, Classes, Graphics, Controls,
  uCoordConvertor, tttData, Sysutils, Math, uTMapTouch2;

type
  TScreenPt = record
    X : Single;
    Y : Single;
  end;

//==============================================================================
  TNotifyDraw = procedure (aCanvas: TCanvas) of object;
  TMapMouseMove = procedure (sender: TObject; Shift: TShiftState; X, Y: Integer) of object;
  TMapMouseDown = procedure (sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer) of object;
  TMapMouseUp = procedure (sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer) of object;
  TMapMouseDouble = procedure (Sender: TObject) of object;
  TMapMouseSingle = procedure (Sender: TObject) of object;
  TMapMouseExit = procedure (Sender: TObject) of object;
  TMapKeyDown = procedure (Sender: TObject; var Key: Word; Shift: TShiftState) of object;

//==============================================================================

  TSimMap = class
  private

    FLyrDraw    : CMapXLayer;
    FCanvas     : TCanvas;

    FLyrLetter: CMapXLayer;
    FlyrHorizontalLine: CMapXLayer;
    FlyrVerticalLine: CMapXLayer;
    FDtSetLetter: CMapXDataset;
    FDtSetHorizontalLine: CMapXDataset;
    FDtSetVerticalLine  : CMapXDataset;
    FMPoint     : CMapXPoint;
    FRowLyrVal  : CMapXRowValues;
    FLetterLastFeatKey : string;
    FHorizontalLineLastFeatKey : string;
    FVerticalLineLastFeatKey : string;
    FLastInd1, FLastInd2, FLastInd3, FLastInd4 : string;
    FSTDBMapType : string;

    STBDMapPath : string;

    FConverter  : TCoordConverter;

    FRectZoom : TRect;
    FMouseIsDown: boolean;

//    FDrawContainer: TDrawContainers;
    FOnDrawToCanvas: TNotifyDraw;

    FOnMapChange: TNotifyEvent;
    FOnKeyDown : TMapKeyDown;
    FOnAddWayoint: TEventAddWaypoint;
    FOnEditWayoint: TEventEditWaypoint;
    FOnToolUsed: TEventToolMapUsed;
    FOnMapMouseMove: TMapMouseMove;
    FOnMapMouseDown: TMapMouseDown;
    FOnMapMouseUp: TMapMouseUp;
    FOnMapMouseDouble : TMapMouseDouble;
    FOnMapMouseSingle : TMapMouseSingle;
    FOnMapMouseExit : TMapMouseExit;
    FOnLogTemporary: TGetStrProc;

    //myFile      : TextFile;              // farah
    //fromFileTPA : Array of TPoint;
    //tempTPA     : Array of TPoint;

    procedure CreateMapTool;
    procedure SetMapComponent;
    //procedure EventOnDrawCycler(sender: TObject);
    procedure SetOnAddWayoint(const Value: TEventAddWaypoint);
    procedure SetOnEditWayoint(const Value: TEventEditWaypoint);
    procedure SetOnToolUsed(const Value: TEventToolMapUsed);
    procedure SetOnMapMouseMove(const Value: TMapMouseMove);
    procedure SetOnMapMouseDown(const Value: TMapMouseDown);
    procedure SetOnMapMouseUp(const Value: TMapMouseUp);
    procedure SetOnMapMouseDouble(const Value: TMapMouseDouble);
    procedure SetOnMapMouseSingle(const Value: TMapMouseSingle);
    procedure SetOnMapMouseExit(const Value: TMapMouseExit);
    procedure SetOnLogTemporary(const Value: TGetStrProc);
    procedure SetOnKeyDown(const Value: TMapKeyDown);

  public
    FMap : TMapXTouch;
    DMap : TMap;

    constructor Create(aMap: TMapXTouch);
    destructor Destroy; override;

    procedure LoadMap(aGeoset: String);

    {karvak}
    procedure LoadDataMap(const dtMap : string);
    procedure GetValLayerKarvak(const x,y : Double; var ind1, ind2, ind3, ind4 : string);
    {-----}

    procedure applySetting(const MapZoom: integer;
      const mX, mY: double; const Colorbg : TColor);

    procedure DrawMap;

    procedure SetMapCenter(const x, y: double);
    procedure SetMapZoom(const z: double);

    procedure MapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
      hOutputDC, hAttributeDC: Integer;
      const RectFull, RectInvalid: IDispatch);
    procedure MapToolUsed(ASender: TObject; ToolNum: Smallint;
      X1, Y1, X2, Y2, Distance: double; Shift, Ctrl: WordBool;
      var EnableDefault: WordBool);

    procedure MapMouseDown(sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapMouseMove(sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MapMouseUp(sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);


    procedure MapMouseDouble(sender: TObject);
    procedure MapMouseSingle(sender: TObject);
    procedure MapMouseExit(sender: TObject);

    procedure MapViewChanged(Sender: TObject);

    procedure MapKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    { farah }
   { procedure drawPattern;
    procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings) ;
    procedure LoadPredefinedPattern(fPatternName: String);   }

//    procedure overlayMouseDown (X, Y : Integer);
//    procedure overlayMouseMove (X, Y : Integer);
//    procedure overlayMouseUp   (X, Y : Integer);
  public
//    down   : Boolean;
//    radius : Integer;
//    LineStart, LineEnd : TScreenPt;
//    TableStart, TableEnd : TScreenPt;
//    RectStart, RectEnd : TScreenPt;
//    EllipseStart, EllipseEnd : TScreenPt;
//    CircleStart, CircleEnd : TScreenPt;
//    TextStart : TScreenPt;

    property OnDrawToCanvas: TNotifyDraw
      read FOnDrawToCanvas write FOnDrawToCanvas;

    property OnMapChange: TNotifyEvent
      read FOnMapChange write FOnMapChange;

    property OnKeyDown: TMapKeyDown
      read FOnKeyDown write SetOnKeyDown;

    property OnToolUsed : TEventToolMapUsed read FOnToolUsed write SetOnToolUsed;
    property OnAddWayoint : TEventAddWaypoint read FOnAddWayoint write SetOnAddWayoint;
    property OnEditWayoint : TEventEditWaypoint read FOnEditWayoint write SetOnEditWayoint;
    property OnMapMouseMove : TMapMouseMove read FOnMapMouseMove write SetOnMapMouseMove;
    property OnMapMouseDown : TMapMouseDown  read FOnMapMouseDown write SetOnMapMouseDown;
    property OnMapMouseUp   : TMapMouseUp  read FOnMapMouseUp write SetOnMapMouseUp;
    property OnMapMouseDouble : TMapMouseDouble read FOnMapMouseDouble write SetOnMapMouseDouble;
    property OnMapMouseSingle: TMapMouseSingle read FOnMapMouseSingle write SetOnMapMouseSingle;
    property OnMapMouseExit: TMapMouseExit read FOnMapMouseExit write SetOnMapMouseExit;
    property OnLogTemporary: TGetStrProc read FOnLogTemporary write SetOnLogTemporary;
  end;

var
  VSimMap: TSimMap;

implementation

uses
  Dialogs, ComObj;
//uses uOverlayEditForm{, uOverlayHandler};

procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;

{ TSimMapXHandler }

procedure TSimMap.applySetting(const MapZoom: integer; const mX, mY: double;
  const Colorbg: TColor);
begin
  FMap.ZoomTo(MapZoom, mX, mY);
  FMap.BackColor := Colorbg;

end;

constructor TSimMap.Create(aMap: TMapXTouch);
begin
  FCanvas         := TCanvas.Create;
  FConverter      := TCoordConverter.Create;
  FConverter.FMap := aMap;

  // Timer FInterval := 10;

  FMap := aMap;
//  FMap.DoubleBuffered := True;

  {karvak}
  DMap := TMap.Create(nil);
  FMPoint := CoPoint.Create;
  {-----}


  CreateMapTool;

  SetMapComponent;
end;

destructor TSimMap.Destroy;
begin
  inherited;

  FMap := nil;
  FCanvas.Free;
  FConverter.Free;
end;

procedure TSimMap.CreateMapTool;
begin
  FMap.CreateCustomTool(mtAddWaypoint, 0, miCrossCursor, miCrossCursor);
  FMap.CreateCustomTool(mtEditWaypoint, 0, miCrossCursor, miCrossCursor);
  FMap.CreateCustomTool(mtSelectObject, 0, miSelectRectPlusCursor);
  FMap.CreateCustomTool(mtDeployPosition, 0, miCrossCursor);
  FMap.CreateCustomTool(mtCenterOnHook, 0, miCrossCursor);

  {Mubdi}
  FMap.CreateCustomTool(mtRuler, 0, miCrossCursor);


  FMap.CreateCustomTool(mtAnchorTool, 0, miCrossCursor);

  {nando}
  FMap.CreateCustomTool(mtAimpoint, 0, miCrossCursor, miCrossCursor);

  {farid}
  FMap.CreateCustomTool(mtDeployChaff, 0, miCrossCursor);

  {mk}
  FMap.CreateCustomTool(mtDeployNGS, 0, miCrossCursor);

  FMap.CreateCustomTool(mtRocketBomb, 0, miCrossCursor);

  {Hambali}
  FMap.CreateCustomTool(mtEditOverlayDynamic, 0, miCrossCursor);
  FMap.CreateCustomTool(mtEditOverlayStatic, 0, miCrossCursor);
  FMap.CreateCustomTool(mtAddOverlay, 0, miCrossCursor);
  FMap.CreateCustomTool(mtMultiMode, 0, miCrossCursor);
  FMap.CreateCustomTool(mtAddLogistic, 0, miCrossCursor);
  FMap.CreateCustomTool(mtEditLogistic, 0, miCrossCursor);
  FMap.CreateCustomTool(mtAddPlotting, 0, miCrossCursor);

  {choco}
  FMap.CreateCustomTool(mtLayerInfo, 0, miInfoCursor);
  FMap.CreateCustomTool(mtCameraPosition, 0, miCrossCursor);
  FMap.CreateCustomTool(mtDeployMine, 0, miCrossCursor);
end;

procedure TSimMap.DrawMap;
var
  i : Integer;
begin
//  FDrawCycler.Run;
//  if Assigned(vFilter) then
//  begin
//    for i := 1 to FMap.Layers.Count do
//    begin
//      if (i = 1) and vFilter.Show(pftSubsurface, 'Wrecks', 'Cartographic data') then
//        FMap.Layers.Item(i).Visible := True
//      else
//        FMap.Layers.Item(i).Visible := False;
//    end;
//  end;

  FMap.Repaint;
end;



procedure TSimMap.GetValLayerKarvak(const x, y: Double; var ind1, ind2,
  ind3, ind4 : string);
var
  mapLetterFs, mapHorizontalLineFs, mapVerticalLineFs : CMapXFeatures;
  mapLetterF, mapHorizontalLineF, mapVerticalLineF : CMapXFeature;
  I : Integer;
begin
  if FLyrLetter = nil then
    Exit;

  if FlyrHorizontalLine = nil then
    Exit;

  if FlyrVerticalLine = nil then
    Exit;

  ind1 := '';
  ind2 := '';
  ind3 := '';
  ind4 := '';

  FMPoint.Set_(x,y);

  try
    mapLetterFs := FLyrLetter.SearchAtPoint(FMPoint);
    mapHorizontalLineFs := FlyrHorizontalLine.SearchAtPoint(FMPoint);
    mapVerticalLineFs := FlyrVerticalLine.SearchAtPoint(FMPoint);
  except
    on E:Exception do begin
      mapLetterFs := nil;
      mapHorizontalLineFs := nil;
      mapVerticalLineFs := nil;
    end;
  end;

  if not Assigned(mapLetterFs) then
    Exit;

  if not Assigned(mapHorizontalLineFs) then
    Exit;

  if not Assigned(mapVerticalLineFs) then
    Exit;

  if mapLetterFs.Count > 0 then
  begin
    try
      mapLetterF := mapLetterFs.Item(1);
//      if mapLetterF.FeatureKey <> FLetterLastFeatKey then
//      begin
        FRowLyrVal := FDtSetLetter.RowValues[mapLetterF.FeatureKey];

        ind1 := FRowLyrVal.Item('LargeLetter').Value;
        ind2 := FRowLyrVal.Item('SmallLetter').Value;

//        FLetterLastFeatKey := mapLetterF.FeatureKey;
//        FLastInd1 := ind1;
//        FLastInd2 := ind2;
//      end;
    except
      ind1 := '';
      ind2 := '';
    end;
  end;

  if mapHorizontalLineFs.Count > 0 then
  begin
    try
      mapHorizontalLineF := mapHorizontalLineFs.Item(1);
//      if mapHorizontalLineF.FeatureKey <> FHorizontalLineLastFeatKey then
//      begin
        FRowLyrVal := FDtSetHorizontalLine.RowValues[mapHorizontalLineF.FeatureKey];

        ind3 := FRowLyrVal.Item('HorizontalLineVal').Value;

//        FHorizontalLineLastFeatKey := mapHorizontalLineF.FeatureKey;
//        FLastInd3 := ind3;
//      end;
    except
      ind3 := '';
    end;
  end;

  if mapVerticalLineFs.Count > 0 then
  begin
    try
      mapVerticalLineF := mapVerticalLineFs.Item(1);
//      if mapVerticalLineF.FeatureKey <> FVerticalLineLastFeatKey then
//      begin
        FRowLyrVal := FDtSetVerticalLine.RowValues[mapVerticalLineF.FeatureKey];

        ind4 := FRowLyrVal.Item('VerticalLineVal').Value;

//        FVerticalLineLastFeatKey := mapVerticalLineF.FeatureKey;
//        FLastInd4 := ind4;
//      end;
    except
      ind4 := '';
    end;
  end;
end;

{procedure TSimMap.EventOnDrawCycler(sender: TObject);
begin
   FMap.Repaint;
end;}

procedure TSimMap.LoadDataMap(const dtMap: string);
const
  CLetterName = 'situbondo_LetterIdentArea';
  CHorizontalLineName = 'situbondo_HorizontalIdentLine';
  CVerticalLineName = 'situbondo_VerticalIdentLine';
var
  I : Integer;
  z : OleVariant;
begin
  DMap.Layers.RemoveAll;
  InitOleVariant(z);

  FLyrLetter := nil;
  FDtSetLetter := nil;
  FLetterLastFeatKey := '';

  FlyrHorizontalLine := nil;
  FDtSetHorizontalLine := nil;
  FHorizontalLineLastFeatKey := '';

  FlyrVerticalLine := nil;
  FDtSetVerticalLine := nil;
  FVerticalLineLastFeatKey := '';

  if not FileExists(dtMap) then
    Exit;

  DMap.Geoset := dtMap;

  try
    if DMap.Layers.Count > 0 then
      FLyrLetter := DMap.Layers.Item(CLetterName);
  except
    on EOleException do
      FLyrLetter := nil;
  end;
   FDtSetLetter := DMap.Datasets.Add(miDataSetLayer, FLyrLetter, CLetterName, Z, Z, Z, Z, Z );

  try
    if DMap.Layers.Count > 0 then
      FlyrHorizontalLine := DMap.Layers.Item(CHorizontalLineName);
  except
    on EOleException do
      FlyrHorizontalLine := nil;
  end;
  FDtSetHorizontalLine := DMap.Datasets.Add(miDataSetLayer, FlyrHorizontalLine, CHorizontalLineName, Z, Z, Z, Z, Z );

  try
    if DMap.Layers.Count > 0 then
      FlyrVerticalLine := DMap.Layers.Item(CVerticalLineName);
  except
    on EOleException do
      FlyrVerticalLine := nil;
  end;
  FDtSetVerticalLine := DMap.Datasets.Add(miDataSetLayer, FlyrVerticalLine, CVerticalLineName, Z, Z, Z, Z, Z );
end;

procedure TSimMap.LoadMap(aGeoset: String);
var
  i: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin
  if FMap = nil then
    Exit;
  InitOleVariant(z);
  FMap.Layers.RemoveAll;

  FMap.Geoset := aGeoset;

  if aGeoset <> '' then
  begin
    for i := 1 to FMap.Layers.Count do
    begin
      FMap.Layers.Item(i).Selectable := False;
      FMap.Layers.Item(i).Editable := False;
      FMap.Layers.Item(i).AutoLabel := False;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw;
    mInfo.AddParameter('Name', 'LYR_DRAW');
    FLyrDraw := FMap.Layers.Add(mInfo, 1);

    FMap.Layers.AnimationLayer := FLyrDraw;
    FMap.MapUnit := miUnitNauticalMile;
    FMap.Title.Visible := False;
  end;
  FMap.BackColor := RGB(192, 224, 255);
  FConverter.FMap := FMap;
end;

{procedure TSimMap.Split (const Delimiter: Char; Input: string; const Strings: TStrings) ;
begin
   Assert(Assigned(Strings));
   Strings.Clear;
   Strings.Delimiter     := Delimiter;
   Strings.DelimitedText := Input;
end;

procedure TSimMap.LoadPredefinedPattern(fPatternName: String);
var
  //i, j, lengthTempTPA : Integer;
  A : TStringList;
  myString : string;
  pX, pY : Integer;
  LongX, LattY : Double;
begin
  //i := 0;  //lengthTempTPA := 1;
  A := TStringList.Create;
  try
  begin
    AssignFile(myFile, fPatternName);
    FileMode := fmOpenRead;
    reset(myFile);
    //seek(myfile,i);
    while not Eof(myFile) do
    begin
        Readln(myFile, myString);
        Split(',', myString, A) ;
        pX := StrToInt(A[0]);
        pY := StrToInt(A[1]);
        FConverter.ConvertToMap(pX,pY,LongX,LattY);
        if Assigned(FOnAddWayoint) then FOnAddWayoint(LongX,LattY);
    end;
    CloseFile(myFile);
  end;
  finally
    A.Free;
  end;

//  if Assigned (pList) then
//    pList.Clear
//  else pList := TList.Create;

//  SetLength(fromFileTPA, lengthTempTPA-2);
//  for j := 0 to lengthTempTPA - 2 do
//  begin
//    patternPoint.X := tempTPA[j].X;
//    patternPoint.Y := tempTPA[j].Y;
//    pList.Add(patternPoint);
//      fromFileTPA[j].X := tempTPA[j].X;
//      fromFileTPA[j].Y := tempTPA[j].Y;
//  end;
end;

procedure TSimMap.drawPattern;
begin
  FCanvas.Pen.color   := clRed;
  FCanvas.Polyline(fromFileTPA);
end;  }

procedure TSimMap.MapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
  hOutputDC, hAttributeDC: Integer; const RectFull, RectInvalid: IDispatch);
//var
//  S : string;
begin
  if not Assigned(FCanvas) then
    Exit;

  FCanvas.Handle := hOutputDC;

//  try
    if Assigned(FOnDrawToCanvas) then
      FOnDrawToCanvas(FCanvas);
//  except
//    on EAccessViolation do
//    begin
//      S:= 'ERROR ACCESS VIOLATION WHEN MAP DRAW USER LAYER';

//      if Assigned(OnLogTemporary) then
//        OnLogTemporary(S);
//    end;
//  end;

  if FMouseIsDown then begin
    if FMap.CurrentTool = miZoomInTool then begin
       FCanvas.Brush.Color := clWhite;
       FCanvas.FrameRect(FRectZoom);
    end
    else if FMap.CurrentTool = mtMultiMode then begin
       FCanvas.Brush.Color := clBlue;
       FCanvas.FrameRect(FRectZoom);
    end;
  end;

  // farah -> ngeload pattern
  // drawPattern;

end;

procedure TSimMap.MapMouseDouble(sender: TObject);
begin
  if Assigned(FOnMapMouseDouble) then
    FOnMapMouseDouble(sender);

  if FMouseIsDown then
  begin
    if (FMap.CurrentTool = miZoomInTool) or (FMap.CurrentTool = mtMultiMode) then
    begin
      FRectZoom.Left   := FMap.X;
      FRectZoom.Top    := FMap.Y;
      FRectZoom.Right  := FMap.X;
      FRectZoom.Bottom := FMap.Y;
    end;

    FMap.Repaint;
  end;

end;

procedure TSimMap.MapKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Assigned(FOnKeyDown) then
    FOnKeyDown(sender,Key,shift);
end;

procedure TSimMap.MapMouseDown(sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  mx, my: double;
begin
  FConverter.ConvertToMap(X, Y, mx, my);
  if Assigned(FOnMapMouseDown) then
    FOnMapMouseDown(sender,Button,shift,X,Y);

  FMouseIsDown := Button = mbLeft;
  if FMouseIsDown then begin
    if (FMap.CurrentTool = miZoomInTool) or (FMap.CurrentTool = mtMultiMode) then begin
     FRectZoom.Left   := x;
     FRectZoom.Top    := y;
     FRectZoom.Right  := x;
     FRectZoom.Bottom := y;

    end;

    FMap.Repaint;
  end;

end;

procedure TSimMap.MapMouseExit(sender: TObject);
begin
  if Assigned(FOnMapMouseExit) then
    FOnMapMouseExit(sender);

  if FMouseIsDown then
  begin
    if (FMap.CurrentTool = miZoomInTool) or (FMap.CurrentTool = mtMultiMode) then
    begin
      FRectZoom.Left   := FMap.X;
      FRectZoom.Top    := FMap.Y;
      FRectZoom.Right  := FMap.X;
      FRectZoom.Bottom := FMap.Y;
    end;

    FMap.Repaint;
  end;
end;

procedure TSimMap.MapMouseMove(sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  mx, my: double;
begin
  FConverter.ConvertToMap(X, Y, mx, my);
  if Assigned(FOnMapMouseMove) then
    FOnMapMouseMove(sender,shift,X,Y);

  if FMouseIsDown then begin
    if (FMap.CurrentTool = miZoomInTool) or (FMap.CurrentTool = mtMultiMode) then begin
     FRectZoom.Right  := x;
     FRectZoom.Bottom := y;
    end;

    FMap.Repaint;
  end;

end;

procedure TSimMap.MapMouseSingle(sender: TObject);
begin
  if Assigned(FOnMapMouseSingle) then
    FOnMapMouseSingle(sender);

  if FMouseIsDown then
  begin
    if (FMap.CurrentTool = miZoomInTool) or (FMap.CurrentTool = mtMultiMode) then
    begin
      FRectZoom.Left   := FMap.X;
      FRectZoom.Top    := FMap.Y;
      FRectZoom.Right  := FMap.X;
      FRectZoom.Bottom := FMap.Y;
    end;

    FMap.Repaint;
  end;

end;

procedure TSimMap.MapMouseUp(sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
//var
//  S : string;
begin
//  try
    if Assigned(FOnMapMouseUp) then
      FOnMapMouseUp(sender,Button,shift,X,Y);


    if FMouseIsDown then
       FMap.Repaint;

    FMouseIsDown := false;
//  except
//    on EAccessViolation do
//    begin
//      S:= 'ERROR ACCESS VIOLATION WHEN MAP MOUSE UP';

//      if Assigned(OnLogTemporary) then
//        OnLogTemporary(S);
//    end;
//  end;
end;

procedure TSimMap.MapToolUsed(ASender: TObject; ToolNum: Smallint;
  X1, Y1, X2, Y2, Distance: double; Shift, Ctrl: WordBool;
  var EnableDefault: WordBool);
begin
  if Assigned(FOnToolUsed) then
    FOnToolUsed(ASender, ToolNum, X1, Y1, X2, Y2,
            Distance, Shift, Ctrl, EnableDefault);

  case ToolNum of
    mtAddWaypoint : if Assigned(FOnAddWayoint) then FOnAddWayoint(X1,Y1);
    mtEditWaypoint : if Assigned(FOnEditWayoint) then FOnEditWayoint(X1,Y1);
  end;
end;

procedure TSimMap.MapViewChanged(Sender: TObject);
begin
  if Assigned(FOnMapChange) then
    FOnMapChange(FMap)
end;


procedure TSimMap.SetMapComponent;
begin
  FMap.OnDrawUserLayer  := MapDrawUserLayer;
  FMap.OnMouseMove      := MapMouseMove;
  FMap.OnMouseUp        := MapMouseUp;
  FMap.OnMouseDown      := MapMouseDown;
  FMap.OnDblClick       := MapMouseDouble;
  FMap.OnClick          := MapMouseSingle;
  FMap.OnExit           := MapMouseExit;
  FMap.OnToolUsed       := MapToolUsed;
  FMap.OnMapViewChanged := MapViewChanged;
  FMap.OnKeyDown        := MapKeyDown;

end;

procedure TSimMap.SetOnAddWayoint(const Value: TEventAddWaypoint);
begin
  FOnAddWayoint := Value;
end;

procedure TSimMap.SetOnEditWayoint(const Value: TEventEditWaypoint);
begin
  FOnEditWayoint := Value;
end;

procedure TSimMap.SetOnKeyDown(const Value: TMapKeyDown);
begin
  FOnKeyDown := Value;
end;

procedure TSimMap.SetOnLogTemporary(const Value: TGetStrProc);
begin
  FOnLogTemporary := Value;
end;

procedure TSimMap.SetOnMapMouseDouble(const Value: TMapMouseDouble);
begin
  FOnMapMouseDouble := Value;
end;

procedure TSimMap.SetOnMapMouseDown(const Value: TMapMouseDown);
begin
  FOnMapMouseDown := Value;
end;

procedure TSimMap.SetOnMapMouseExit(const Value: TMapMouseExit);
begin
  FOnMapMouseExit := Value;
end;

procedure TSimMap.SetOnMapMouseMove(const Value: TMapMouseMove);
begin
  FOnMapMouseMove := Value;
end;

procedure TSimMap.SetOnMapMouseSingle(const Value: TMapMouseSingle);
begin
  FOnMapMouseSingle := Value;
end;

procedure TSimMap.SetOnMapMouseUp(const Value: TMapMouseUp);
begin
  FOnMapMouseUp := Value;
end;

procedure TSimMap.SetOnToolUsed(const Value: TEventToolMapUsed);
begin
  FOnToolUsed := Value;
end;

procedure TSimMap.SetMapCenter(const x, y: double);
begin
  FMap.ZoomTo(FMap.Zoom, X, Y);
end;

procedure TSimMap.SetMapZoom(const z: double);
begin
  FMap.ZoomTo(Z, FMap.CenterX, FMap.CenterY);
end;

end.

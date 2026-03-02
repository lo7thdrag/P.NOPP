unit uObjectVisuals;

interface

uses
  Windows, Graphics, uSimVisuals, uCoordConvertor, uDataTypes, uConstantaData,
  GdiPlus, GDIPAPI, GDIPOBJ;

type

//------------------------------------------------------------------------------

  TTextVisual = class(TDrawElement)
  public
    Text : string;

  public
    constructor Create;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  TLineVisual = class(TDrawElement)
  private
    sx1,sy1,sx2,sy2 : integer;
    FRange, FBearing : double;
    once : boolean;
    FShowRangeBearing: Boolean;

    procedure SetBearing(const Value: double);
    procedure SetRange(const Value: double);

    procedure SetShowRangeBearing(const Value: Boolean);
  public
    X1, Y1{, X2, Y2} : double;
    LineStyles : TPenStyle;

    constructor Create;
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
    function isPointOnLine(X,Y : double) : boolean;

    property Range    : double read FRange write SetRange;
    property Bearing  : double read FBearing write SetBearing;
    property IsOnce   : Boolean read once write once;
    {show range bearing caption}
    property ShowRangeBearing : Boolean read FShowRangeBearing write SetShowRangeBearing;
  end;

//------------------------------------------------------------------------------
  TSpeedVectorVisual = class(TDrawElement)
  protected
    ptL,
    ptR,
    ptH : TPoint;
  public
    Course  : single; // compas, 0 -  360
    Speed   : single;  // knot
    Ratio   : single;

    constructor Create;
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

//------------------------------------------------------------------------------

  TSeekerVisual = class(TDrawElement)
  private
    FLeftPT : TPoint;
    FMidPT : TPoint;
    FRightPT : TPoint;

    point : TRect;
  public
    Azimuth : Double;
    Bearing : Double;
    Range : Double;

    {torpedo}
    Tipe : Integer;

    constructor Create;
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

//------------------------------------------------------------------------------

  TBitmapSymbol = class(TDrawElement)
  private
    FBSize: integer;
//    FBmpOrg: TBitmap;
//    FBmpClr: TBitmap;
//    FBmp   : TBitmap;
//    FBmpTemp : TBitmap;
    FBitmapName : string;

    function getBMPHeight: integer;
    function getBMPWidth: integer;

  protected
    procedure SetFColor(const Value: TColor); override;

  public
    FDegr : Integer;

    constructor Create;
    destructor Destroy; override;

    procedure Draw(aCnv: TCanvas); override;
    procedure DrawBitmap(aCnv : TCanvas); override;
    procedure LoadBitmapLikeDB(fName: string; aColor: TColor); overload;
    procedure LoadBitmap(fName: string; aColor: TColor); overload;
    procedure LoadBitmap(fName: string); overload;

    property BitmapWidth  : integer read getBMPWidth;
    property BitmapHeigth : integer read getBMPHeight;
    property BitmapName   : string read FBitmapName write FBitmapName;

{    procedure ReloadBitmap;overload;
    procedure ReloadBitmap(clr : TColor);overload;}
  end;

  TBitmapSymbolLDropPoint = class(TBitmapSymbol)
  private
    FPosX: double;
    FPosY: double;
    procedure SetPosX(const Value: double);
    procedure SetPosY(const Value: double);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Draw(aCnv: TCanvas); override;
    property PosX : double read FPosX write SetPosX;
    property PosY : double read FPosY write SetPosY;
    procedure ConvertCoord(cvt: TCoordConverter); override;
  end;

//------------------------------------------------------------------------------

// circle view for radar range / weapon range
  TRangeVisual = class(TDrawElement)
  private
    FRects : TRect;

  public
    LineStyles : TPenStyle;
    mX, mY: Double;
    Range : Single;        // nautical miles

    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

// rectangle area for mine area
  TRectAreaVisual = class(TDrawElement)
    private
      FRects : TRect;

    public
      LineStyles : TPenStyle;
      mX, mY: Double;
      Range: Single;    // nautical miles

      constructor Create;
      destructor Destroy; override;

      procedure ConvertCoord(cvt: TCoordConverter); override;
      procedure Draw(aCanvas: TCanvas); override;
  end;

//------------------------------------------------------------------------------
  TRangeRingsVisual = class(TDrawElement)
  private
    FRects : array of TRect;
    FNumOfRanges   : integer;

    procedure SetNumOfRange(const i: integer);

  public
    mX, mY: Double;
    Interval : Single;        // nautical miles

    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

    property  RangeNum: Integer read FNumOfRanges write SetNumOfRange;
  end;

  TSwapLineVisual = class (TDrawElement)
  private
    FHeading : double;
    FRanges: single;
    FAngle: single;
    FRelativeAngle: double;
    FPoint : t2DPoint;

    procedure SetAngle(const Value: single);
    //procedure SetRelativeAngle(const Value: double);
    function getRelativeAngle : double;
  public
    mX, mY: Double;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

    property Ranges : single read FRanges write FRanges;
    property Angle : single  read FAngle write SetAngle;
    property Heading : double read FHeading write FHeading;
    property RelativeAngle : double  read getRelativeAngle;
  end;

//------------------------------------------------------------------------------
  TBlindZoneVisual = class(TDrawElement)
  private
    FHeading : double;
    FAngles : array [0..1] of single;
    FRanges: single;
    FStartPoint, FEndPoint : t2DPoint;
    FRects : TRect;
    FRelativeStartAngle: double;
    FRelativeEndAngle : double;
    FSx, FSy, FEx, FEy : double;

    function getAngle(index : integer) : single;
    procedure setAngle(index : integer; angle : single);
    function getRelativeAngle(index : integer) : double;
  public
    mX, mY, mx1, my1: Double;
    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

    procedure UpdateRelatifAngle;

    property Ranges : single read FRanges write FRanges;
    property StartAngle : single index 0 read getAngle write setAngle;
    property EndAngle : single index 1 read getAngle write setAngle;
    property Heading : double read FHeading write FHeading;

    property RelativeStartAngle : double index 0 read getRelativeAngle;
    property RelativeEndAngle : double index 1 read getRelativeAngle;
  end;

//------------------------------------------------------------------------------
  THistoryVisual  = class(TDrawElement)
  private
    FTrailCapacity   : Word;
    FTrailCount      : Word;
    FTrails         : array of t2DPoint;
    FPixelTrails     : array of TPoint;
  public
    VisibleCount     : integer;
    Selected         : boolean;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

    procedure AddPoint(dX, dY: double);
    procedure ClearHistory;
  end;

  TFormationRange = class(TDrawElement)
  private
    FBaseBearing: Double;
    FLine_0    : TLineVisual;
    FLine_45   : TLineVisual;
    FLine_90   : TLineVisual;
    FLine_135  : TLineVisual;
    FLine_180  : TLineVisual;
    FLine_225  : TLineVisual;
    FLine_270  : TLineVisual;
    FLine_315  : TLineVisual;
    FRange_1  : TRangeVisual;
    FRange_2  : TRangeVisual;
    FRange_3  : TRangeVisual;
    FRange_4  : TRangeVisual;
  public
    x,y : Double;
    constructor Create;
    destructor Destroy; override;

    procedure Draw(aCanvas: TCanvas); override;
    procedure SetBaseBearing(value: Double);
    property BaseBearing : Double read FBaseBearing write SetBaseBearing;
  end;

  TTacticalSymbolVisual = class(TDrawElement)
  public
    CharSymbol : Char;
  private

    FControlled: boolean;
    FSelected: boolean;
    FColorSelected : TColor;
    FRectArea : TRect;

    procedure SetControlled(const Value: boolean);
    procedure SetSelected(const Value: boolean);
  public
    FDegr : Integer;

    constructor Create;
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
    property Selected       : boolean read FSelected write SetSelected ;
    property Controlled     : boolean read FControlled write SetControlled;
    property RectArea       : TRect read FRectArea;
  end;

  TTacticalSymbol = class (TDrawElement)
  private
//    FSymbol         : TBitmapSymbol;
//    FSymbolBMP      : TBitmapSymbol;
    FSymbolMode     : Byte;
    FSpeedVector    : TSpeedVectorVisual;
    FSeeker         : TSeekerVisual;
    FSelected       : boolean;

    FColorSelected  : TColor;
    FControlled     : booLEan;
    FMerged         : boolean;

    FSymbolVisual : TTacticalSymbolVisual;
    FisInstructor : Boolean;
    FisNRP        : Boolean;
    FisVehicle    : Boolean;
    FisWreck      : Boolean;

    {3 rows call sign}
    FCallSigns     : array [0..2] of string;
    FTextVisuals   : array [0..2] of TTextVisual;

    //procedure SetSpeedVector(const Value: TSpeedVectorVisual);
    //procedure SetSymbol(const Value: TBitmapSymbol);
    procedure SetSelected(const Value: boolean);
    //procedure SetText(const Value: TTextVisual);
    procedure SetControlled(const Value: boolean);

    procedure SetInstructor(const Value: Boolean);
    procedure SetNRP(const Value: Boolean);
    procedure setVehicle(const Value : Boolean);

    procedure setWreck(const Value: Boolean);
    function getCallSign(const Index: Integer): string;

    procedure setCallSign(const Index: Integer; const Value: string);  protected
    procedure SetFColor(const clr: TColor); override;
    procedure SetCenter(const Value: TPoint); override;
    procedure SetMerged(const Value : boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

    {set visual text prop }
    procedure SetTextVisibility(Value : Boolean);
    procedure SetTextColor(Value : TColor);
    procedure SetTextCenter(Value : TPoint);

//    property Symbol         : TBitmapSymbol read FSymbol;
//    property SymbolBMP      : TBitmapSymbol read FSymbolBMP;
    property SymbolMode     : Byte read FSymbolMode write FSymbolMode;
    property SpeedVector    : TSpeedVectorVisual read FSpeedVector;
    property Seeker         : TSeekerVisual read FSeeker;
    property Selected       : boolean read FSelected write SetSelected ;
    property Controlled     : boolean read FControlled write SetControlled;
    property Merged         : boolean read FMerged write SetMerged;
    property SymbolVisual   : TTacticalSymbolVisual read FSymbolVisual;
    property isInstructor   : Boolean read FisInstructor write SetInstructor;
    property isNRP          : Boolean read FisNRP write SetNRP;
    property isVehicle      : Boolean read FisVehicle write setVehicle;
    property isWreck        : Boolean read FisWreck write setWreck;

    property CallSign1      : string index 0 read getCallSign write setCallSign;
    property CallSign2      : string index 1 read getCallSign write setCallSign;
    property CallSign3      : string index 2 read getCallSign write setCallSign;

  end;



  TSubEnvironmentArea = class (TDrawElement)
  private
    FRects : TRect;

  public
    LineStyles : TPenStyle;
    X1, Y1, X2, Y2 : Double;
    isVisible : Boolean;
    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  TTargetVisual = class(TDrawElement)
  private
     FCircle : TRect;
  public
    LineStyles : TPenStyle;
    Center : TPoint;

    constructor create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  TPlatformInfoBalloon = class(TDrawElement)
  private
    FRect : TRect;
    FBalloonCenter : TPoint;
    FCallSigns : array [0..2] of string;
    FHeight : Integer;
    FWidth : Integer;
    FCallSignCount : Integer;

    function GetCallSign(const aIndex: Integer): string;

    procedure SetCallSign(const aIndex: Integer; const aValue: string);
    procedure SetCenter(const aValue: TPoint); override;
    procedure CalcBalloonSize;
  public
    constructor Create;

    procedure Draw(aCanvas: TCanvas); override;
    procedure DragBalloon(const aOffsetX, aOffsetY: Integer);

    property BalloonRect : TRect read FRect;
    property CallSign1 : string index 0 read GetCallSign write SetCallSign;
    property CallSign2 : string index 1 read GetCallSign write SetCallSign;
    property CallSign3 : string index 2 read GetCallSign write SetCallSign;
  end;

  TRangeLandingPlatform = class(TDrawElement)
  public
    point : TRect;
    isShow : Boolean;
    radius : Double;
    postCenter : t2DPoint;

    constructor Create;
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  TLogisticsLine = class (TDrawElement)
  public
    pointSelf, pointTarget: t2DPoint;
    posSelf, posTarget: Tpoint;

    constructor Create;
    destructor Destroy; override;
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

implementation

uses
  SysUtils, Math, Types, uBaseCoordSystem;

procedure DrawRectFrameWithoutbsClear(aCnv : TCanvas; rDraw : TRect);
var
  pts : array[0..4] of TPoint;
begin
  pts[0] := Point(rDraw.Left, rDraw.Top);
  pts[1] := Point(rDraw.Right, rDraw.Top);
  pts[2] := Point(rDraw.Right, rDraw.Bottom);
  pts[3] := Point(rDraw.Left, rDraw.Bottom);
  pts[4] := Point(rDraw.Left, rDraw.Top);

  aCnv.Polyline(pts);

end;

{ TSubEnvironmentArea }
constructor TSubEnvironmentArea.Create;
begin
  inherited;

  Color := clYellow;
  LineStyles := psSolid;
  isVisible := False;

end;

destructor TSubEnvironmentArea.Destroy;
begin

  inherited;
end;

procedure TSubEnvironmentArea.ConvertCoord(cvt: TCoordConverter);
//var r : integer;
//    rDegree: double;
//    dx, dy: double;
//    pt : TPoint;
begin
  inherited;

  if not Assigned(cvt) then Exit;
  if isVisible then
  begin
    cvt.ConvertToScreen(X1,Y1,FRects.Left,FRects.Top);
    cvt.ConvertToScreen(X2,Y2,FRects.Right,FRects.Bottom);
  end;

end;

procedure TSubEnvironmentArea.Draw(aCanvas: TCanvas);
begin
  inherited;
  if not Visible then
    Exit;

  if isVisible then
  begin
    aCanvas.Pen.Style := psSolid;
    aCanvas.Pen.Color := Color;
    aCanvas.Pen.Style := LineStyles;
    aCanvas.Brush.Style := bsClear;
    aCanvas.Rectangle(FRects);
    //aCanvas.Arc(FRects.Left, FRects.Top , FRects.Right , FRects.Bottom,
    // 0, 0, 0, 0);
  end;

end;

{ TTextVisual }
constructor TTextVisual.Create;
begin
  inherited;
  Offset.X := 20;
  Offset.Y := 0;
  Size     := 7;
end;

procedure TTextVisual.Draw(aCanvas: TCanvas);
begin
  with aCanvas do
  begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psDot;

    Font.Name := 'Courier';
    Font.Size := Size;
    Font.Color := Color;
    Font.Orientation := 0;
    SetBkMode(aCanvas.Handle, TRANSPARENT);

    TextOut(Center.X + Offset.X, Center.Y + Offset.Y , Text);
  end;
end;

{ TSpeedVectorVisual }
procedure TSpeedVectorVisual.ConvertCoord(cvt: TCoordConverter);
const
    CSPEED_VECTOR_WIDTH = 8.0;
    CMin_Length = 0;

var headEast, spdKnots : double;
    sinA, cosA: extended;
begin

  headEast := DegToRad( ConvCompass_To_Cartesian(Course));

//  if Speed > 2000 then
//      spdKnots := 2000
//  else
//      spdKnots := CMin_Length + sqrt(abs(Speed)) * Ratio;

  spdKnots := CMin_Length + Speed;

  if Speed < 0 then   //  kapal mundur
    spdKnots := - spdKnots;

  if Speed = 0 then spdKnots := 0;

  //Calculate SpeedVector Coordinate
  SinCos(headEast, SinA, CosA);

  ptH.X :=  Round(Center.X + spdKnots * CosA);
  ptH.Y :=  Round(Center.Y - spdKnots * sinA);
end;

constructor TSpeedVectorVisual.Create;
begin
  Ratio := 0.5;
  Color  := clGray;
  Visible := True;
end;

procedure TSpeedVectorVisual.Draw(aCanvas: TCanvas);
begin
  inherited;

  if not Visible then
    exit;

  with aCanvas do begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psSolid;

 //    r := ptToRect(Center.X, Center.Y , 3, 3);
 //   Arc(r.Left, r.Top, r.Right, r.Bottom, 0,0,0,0);

    MoveTo(Center.X, Center.Y);
    LineTo(ptH.X, ptH.Y);
  end;
end;

{ TBitmapSymbol }

constructor TBitmapSymbol.Create;
begin
  FBSize := 32;

//  FBmpOrg := TBitmap.Create;
//  with FBmpOrg do begin
//    PixelFormat := pf8Bit;
//    Width  := FBSize;
//    Height := FBSize;
//  end;
//
//  FBmpClr := TBitmap.Create;
//  with FBmpClr do begin
//    PixelFormat := pf8Bit;
//    Width  := FBSize;
//    Height := FBSize;
//  end;
//
//  FBmp := TBitmap.Create;
//  with FBmp do begin
//    PixelFormat := pf24bit;
//    Width  := FBmpOrg.Width;
//    Height := FBmpOrg.Height;
//    FBmp.Transparent      := true;
//    FBmp.TransparentMode  := tmFixed;
//    FBmp.TransparentColor := clBlack;
//  end;
//
//  FBmpTemp := TBitmap.Create;
//  with FBmpTemp do
//  begin
//    PixelFormat := pf24bit;
//    Width  := FBmpOrg.Width;
//    Height := FBmpOrg.Height;
//    FBmpTemp.Transparent := True;
//    FBmpTemp.TransparentMode := tmFixed;
//    FBmpTemp.TransparentColor := clBlack;
//  end;

  Color := clBlue;
end;

destructor TBitmapSymbol.Destroy;
begin
//  with FBmp do begin
//    Dormant;
//    FreeImage;
//    ReleaseHandle;
//    Free;
//  end;
//  FBmpClr.Free;
//  FBmpOrg.Free;
//  FBmpTemp.Free;

  inherited;
end;

procedure TBitmapSymbol.Draw(aCnv: TCanvas);
var
  h: integer;
begin
  inherited;
//  h := FBmp.Width shr 1;
//
//  FBmp.TransparentColor := clBlack;
  aCnv.CopyMode := cmSrcCopy;
//  aCnv.Draw(Center.X - h, Center.Y -  h , FBmp);
end;

procedure TBitmapSymbol.DrawBitmap(aCnv : TCanvas);
  procedure RotateBitmapGDIP(Bmp: TBitmap; Degs: Integer; BkColor: TColor);
  var
    Tmp: TGPBitmap;
    Matrix: TGPMatrix;
    C: Single;
    S: Single;
    NewSize: TSize;
    Graphs: TGPGraphics;
    P: TGPPointF;
    w, h : Integer;
  begin
    Matrix := TGPMatrix.Create;

    try
      w := Bmp.Width;
      h := Bmp.Height;

      C := Cos(DegToRad(45));
      S := Sin(DegToRad(45));
      NewSize.cx := Round(Bmp.Width * Abs(C) + Bmp.Height * Abs(S));
      NewSize.cy := Round(Bmp.Width * Abs(S) + Bmp.Height * Abs(C));
      Bmp.Width := NewSize.cx;
      Bmp.Height := NewSize.cy;

      Tmp := TGPBitmap.Create(Bmp.Handle, Bmp.Palette);

      Matrix.Translate((Bmp.Width - w) div 2, (Bmp.Height - h) div 2);
      Matrix.RotateAt(Degs, MakePoint(0.5 * w, 0.5 * h));
      Graphs := TGPGraphics.Create(Bmp.Canvas.Handle);
      try
        Graphs.Clear(ColorRefToARGB(ColorToRGB(BkColor)));
        Graphs.SetTransform(Matrix);
        Graphs.DrawImage(Tmp, (Cardinal(Bmp.Width) - Tmp.GetWidth) div 2,
          (Cardinal(Bmp.Height) - Tmp.GetHeight) div 2);
      finally
        Graphs.Free;
      end;
    finally
      Matrix.Free;
      Tmp.Free;
    end;
  end;
var
  h : Integer;
  wd, hg : Integer;
  ws, hs : Integer;
begin
  inherited;
//  h := FBmp.Width shr 1;
//
//  wd := FBmp.Width;
//  hg := FBmp.Height;
//
//  FBmpTemp.Width := wd;
//  FBmpTemp.Height := hg;
//  FBmpTemp.Canvas.Draw(0,0, FBmp);
//
//  FBmpTemp.TransparentColor := clWhite;
//  FBmpTemp.Transparent := True;
//
//  RotateBitmapGDIP(FBmpTemp, FDegr, FBmpTemp.TransparentColor);
//
//  ws := (FBmpTemp.Width - wd) div 2;
//  hs := (FBmpTemp.Height - hg) div 2;

//  aCnv.Draw((Center.X - h)- ws, (Center.Y -  h)- hs, FBmpTemp);
end;

function TBitmapSymbol.getBMPHeight: integer;
begin
//  result := FBmp.Height;
end;

function TBitmapSymbol.getBMPWidth: integer;
begin
//  result := FBmp.Width;
end;

procedure changeBitmapIndex(bmp: TBitmap; clr: TColor);
type
    TArrayByte = array[0..255] of Byte;
    PAByte = ^TArrayByte;
var i, j: Integer;
    pB : PAByte;
    hPal: HPALETTE;
    dClr, bClr : byte;
begin
  bmp.PixelFormat := pf8bit;
  hPal   := bmp.Palette;
  bClr := GetNearestPaletteIndex(hPal, clBlack);
  dClr := GetNearestPaletteIndex(hPal, clr);

  for j := 0 to bmp.Height - 1 do begin
    pb := bmp.ScanLine[j];
    for i := 0 to bmp.Width-1  do  begin
      if pB[i] = bClr then
        pB[i] := dClr
      else
        pB[i] := bClr;
    end;
  end;
end;

procedure TBitmapSymbol.LoadBitmap(fName: string; aColor: TColor);
begin
  if not FileExists(fname) then
	exit;

  if (fName <> FBitmapName)  then begin
//    FBitmapName := fName;
//    FBmpOrg.LoadFromFile(fName);
//
//    FBmpClr.Width   := FBmpOrg.Width;
//    FBmpClr.Height  := FBmpOrg.Height;
//
//    FBmp.Width  := FBmpOrg.Width;
//    FBmp.Height := FBmpOrg.Height;
  end;

//  if (aColor <> FColor) then
  SetFColor(aColor);
end;

procedure TBitmapSymbol.LoadBitmap(fName: string);
begin
  if not FileExists(fname) then exit;

  if (fName <> FBitmapName)  then begin

//    FBitmapName := fName;
//    FBmpOrg.LoadFromFile(fName);
//
//    FBmpClr.Width   := FBmpOrg.Width;
//    FBmpClr.Height  := FBmpOrg.Height;
//
//    FBmp.Width  := FBmpOrg.Width;
//    FBmp.Height := FBmpOrg.Height;
  end;

  SetFColor(FColor);
end;

procedure TBitmapSymbol.LoadBitmapLikeDB(fName: string; aColor: TColor);
begin
  FBitmapName := fName;
//  FBmpOrg.LoadFromFile(fName);
//
//  FBmpClr.Width := FBmpOrg.Width;
//  FBmpClr.Height := FBmpOrg.Height;
//
//  with FBmpClr.Canvas do
//  begin
//    Brush.Color := aColor;
//    Pen.Color := aColor;
//    Pen.Width := 2;
//    FillRect(Rect(0,0, FBmpClr.Width, FBmpClr.Height));
//  end;
//
//  FBmp.Width := FBmpOrg.Width;
//  FBmp.Height := FBmpOrg.Height;
//
//  FBmp.Canvas.Draw(0,0, FBmpOrg);
//  FBmp.Canvas.CopyMode := cmSrcPaint;
//  FBmp.Canvas.Draw(0,0, FBmpClr);
//
//  FBmp.TransparentColor := clWhite;
end;

procedure TBitmapSymbol.SetFColor(const Value: TColor);
begin
  inherited;
//  FBmpClr.Canvas.CopyMode := cmSrcCopy;
//  FBmpClr.Canvas.Draw(0,0, FBmpOrg);
//
//  changeBitmapIndex(FBmpClr, Value);
//
//  FBmp.Canvas.Draw(0,0, FBmpClr);
//  FBmp.TransparentColor := clBlack;
end;

{procedure TBitmapSymbol.LoadBitmap(fName: string; color: TColor);
begin
  FBitmapName := fName;
  FBmpOrg.LoadFromFile(fName);

  FBmpColor.Width := FBmpOrg.Width;
  FBmpColor.Height := FBmpOrg.Height;

  with FBmpColor.Canvas do begin
    Brush.Color := color;
    Pen.Color   := color;
    Pen.Width   := 2;
    FillRect(Rect(0,0, FBmpColor.Width, FBmpColor.Height));
  end;

  FBmp.Width  := FBmpOrg.Width;
  FBmp.Height := FBmpOrg.Height;

  FBmp.Canvas.Draw(0,0, FBmpOrg);
  FBmp.Canvas.CopyMode := cmSrcPaint;
  FBmp.Canvas.Draw(0,0, FBmpColor);

  FBmp.TransparentColor := clWhite;
end;
}



{ TRangeRing }

constructor TRangeRingsVisual.Create;
begin
  FNumOfRanges := 6;
  SetLength(FRects, FNumOfRanges);

  mX := 0.0;
  mY := 0.0;
  Interval  := 0.2; // nautical miles
  RangeNum  := 6;

end;

destructor TRangeRingsVisual.Destroy;
begin

  inherited;
end;

procedure TRangeRingsVisual.SetNumOfRange(const i: integer);
begin
  FNumOfRanges := i;
  SetLength(FRects, FNumOfRanges);

end;

procedure TRangeRingsVisual.ConvertCoord(cvt: TCoordConverter);
var i : integer;
    r : integer;
    rDegree: double;
    dx, dy: double;
    pt : TPoint;
begin
  inherited;
  cvt.ConvertToScreen(mx, my, FCenter.X, FCenter.Y);

  if abs(Interval) < 0.0000001 then exit;

  rDegree := Interval * C_NauticalMile_To_Degree;
  dx := mX + rDegree;
  dy := mY;

  cvt.ConvertToScreen(dx, dy, pt.X, pt.Y );

  r := Abs(pt.X - Center.X);
  for i := 0 to FNumOfRanges-1 do begin

    FRects[i].Left   := Center.X - r * (i + 1);
    FRects[i].Top    := Center.Y - r * (i + 1);
    FRects[i].Right  := Center.X + r * (i + 1);
    FRects[i].Bottom := Center.Y + r * (i + 1);
  end;

end;

procedure TRangeRingsVisual.Draw(aCanvas: TCanvas);
var i : integer;
begin
//  inherited;
//
//  if not (Visible and vFilter.Show(pftNone, 'Range rings', 'Display information')) then
//    Exit;
//
//  for i := 0 to FNumOfRanges - 1 do
//  begin
//    aCanvas.Pen.Color := Color;
//    aCanvas.Pen.Style := psSolid;
//    aCanvas.Arc(FRects[i].Left, FRects[i].Top, FRects[i].Right, FRects[i].Bottom, 0, 0, 0, 0);
//  end;
end;

//procedure TRangeRingsVisual.SetRangeInterval(const Value: integer);
//var i : integer;
//begin
//  FRangeInterval := Value;
//  for i := 0 to FNumOfRanges-1 do begin
//    FRects[i].Left   := Center.X - FRangeInterval ;
//    FRects[i].Top    := Center.Y - FRangeInterval;
//    FRects[i].Right  := Center.X + FRangeInterval;
//    FRects[i].Bottom := Center.Y + FRangeInterval;
//  end;
//end;

{ TRangeVisual }
{ color blue radar, green sonar, red weapon

}

constructor TRangeVisual.Create;
begin
  inherited;

  Color := clBlue;
  LineStyles := psDot;

end;

destructor TRangeVisual.Destroy;
begin

  inherited;
end;

procedure TRangeVisual.ConvertCoord(cvt: TCoordConverter);
var r : integer;
    rDegree: double;
    dx, dy: double;
    pt : TPoint;
begin
  inherited;

  cvt.ConvertToScreen(mx, my, FCenter.X, FCenter.Y);

  if abs(Range) < 0.0000001 then exit;

  rDegree := Range * C_NauticalMile_To_Degree;
  dx := mX + rDegree;
  dy := mY;

  cvt.ConvertToScreen(dx, dy, pt.X, pt.Y);
  r := Abs(pt.X - Center.X);

  FRects.Left   := Center.X - r;
  FRects.Top    := Center.Y - r;
  FRects.Right  := Center.X + r;
  FRects.Bottom := Center.Y + r;

end;

procedure TRangeVisual.Draw(aCanvas: TCanvas);
begin
  inherited;
  if not Visible then
    Exit;

  aCanvas.Pen.Style := psSolid;
  aCanvas.Pen.Color := Color;
  aCanvas.Pen.Style := LineStyles;
  aCanvas.Brush.Style := bsClear;
  aCanvas.Ellipse(FRects);
  //aCanvas.Arc(FRects.Left, FRects.Top , FRects.Right , FRects.Bottom,
  // 0, 0, 0, 0);

end;

{ TFormationRange }

constructor TFormationRange.Create;
begin
  inherited;

  FLine_0    := TLineVisual.Create;
  FLine_45   := TLineVisual.Create;
  FLine_90   := TLineVisual.Create;
  FLine_135  := TLineVisual.Create;
  FLine_180  := TLineVisual.Create;
  FLine_225  := TLineVisual.Create;
  FLine_270  := TLineVisual.Create;
  FLine_315  := TLineVisual.Create;
  FRange_1  := TRangeVisual.Create;
  FRange_2  := TRangeVisual.Create;
  FRange_3  := TRangeVisual.Create;
  FRange_4  := TRangeVisual.Create;

  FLine_0.Visible := true;
  FLine_45.Visible := true;
  FLine_90.Visible := true;
  FLine_135.Visible := true;
  FLine_180.Visible := true;
  FLine_225.Visible := true;
  FLine_270.Visible := true;
  FLine_315.Visible := true;
  FRange_1.Visible  := true;
  FRange_2.Visible  := true;
  FRange_3.Visible  := true;
  FRange_4.Visible  := true;

  FLine_0.IsOnce := false;
  FLine_45.IsOnce := false;
  FLine_90.IsOnce := false;
  FLine_135.IsOnce := false;
  FLine_180.IsOnce := false;
  FLine_225.IsOnce := false;
  FLine_270.IsOnce := false;
  FLine_315.IsOnce := false;
end;

destructor TFormationRange.Destroy;
begin
  FLine_0.Free;
  FLine_45.Free;
  FLine_90.Free;
  FLine_135.Free;
  FLine_180.Free;
  FLine_225.Free;
  FLine_270.Free;
  FLine_315.Free;
  FRange_1.Free;
  FRange_2.Free;
  FRange_3.Free;
  FRange_4.Free;

  inherited;


end;

procedure TFormationRange.Draw(aCanvas: TCanvas);
begin

  FLine_0.X1 := x;   FLine_0.Y1 := y;
  FLine_45.X1 := x;  FLine_45.Y1 := y;
  FLine_90.X1 := x;  FLine_90.Y1 := y;
  FLine_135.X1 := x; FLine_135.Y1 := y;
  FLine_180.X1 := x; FLine_180.Y1 := y;
  FLine_225.X1 := x; FLine_225.Y1 := y;
  FLine_270.X1 := x; FLine_270.Y1 := y;
  FLine_315.X1 := x; FLine_315.Y1 := y;
  FRange_1.mX  := x; FRange_1.mY  := y;
  FRange_2.mX  := x; FRange_2.mY  := y;
  FRange_3.mX  := x; FRange_3.mY  := y;
  FRange_4.mX  := x; FRange_4.mY  := y;

  if not Assigned(Converter) then exit;

  FLine_0.ConvertCoord(Converter);
  FLine_45.ConvertCoord(Converter);
  FLine_90.ConvertCoord(Converter);
  FLine_135.ConvertCoord(Converter);
  FLine_180.ConvertCoord(Converter);
  FLine_225.ConvertCoord(Converter);
  FLine_270.ConvertCoord(Converter);
  FLine_315.ConvertCoord(Converter);
  FRange_1.ConvertCoord(Converter);
  FRange_2.ConvertCoord(Converter);
  FRange_3.ConvertCoord(Converter);
  FRange_4.ConvertCoord(Converter);

  FLine_0.LineStyles  := psSolid;
  FLine_45.LineStyles := psSolid;
  FLine_90.LineStyles := psSolid;
  FLine_135.LineStyles := psSolid;
  FLine_180.LineStyles := psSolid;
  FLine_225.LineStyles := psSolid;
  FLine_270.LineStyles := psSolid;
  FLine_315.LineStyles := psSolid;
  FRange_1.LineStyles  := psSolid;
  FRange_2.LineStyles  := psSolid;
  FRange_3.LineStyles  := psSolid;
  FRange_4.LineStyles  := psSolid;

  FLine_0.Color := clDkGray;
  FLine_45.Color := clDkGray;
  FLine_90.Color := clDkGray;
  FLine_135.Color := clDkGray;
  FLine_180.Color := clDkGray;
  FLine_225.Color := clDkGray;
  FLine_270.Color := clDkGray;
  FLine_315.Color := clDkGray;
  FRange_1.Color := clDkGray;
  FRange_2.Color := clDkGray;
  FRange_3.Color := clDkGray;
  FRange_4.Color := clDkGray;

  FLine_0.Bearing := BaseBearing;
  FLine_45.Bearing := BaseBearing + 45;
  FLine_90.Bearing := BaseBearing + 90;
  FLine_135.Bearing := BaseBearing + 135;
  FLine_180.Bearing := BaseBearing + 180;
  FLine_225.Bearing := BaseBearing + 225;
  FLine_270.Bearing := BaseBearing + 270;
  FLine_315.Bearing := BaseBearing + 315;

  if FLine_45.Bearing > 360 then FLine_45.Bearing := FLine_45.Bearing - 360;
  if FLine_90.Bearing > 360 then FLine_90.Bearing := FLine_90.Bearing - 360;
  if FLine_135.Bearing > 360 then FLine_135.Bearing := FLine_135.Bearing - 360;
  if FLine_180.Bearing > 360 then FLine_180.Bearing := FLine_180.Bearing - 360;
  if FLine_225.Bearing > 360 then FLine_225.Bearing := FLine_225.Bearing - 360;
  if FLine_270.Bearing > 360 then FLine_270.Bearing := FLine_270.Bearing - 360;
  if FLine_315.Bearing > 360 then FLine_315.Bearing := FLine_315.Bearing - 360;

  FLine_0.Range  := 4;
  FLine_45.Range  := 4;
  FLine_90.Range  := 4;
  FLine_135.Range  := 4;
  FLine_180.Range  := 4;
  FLine_225.Range  := 4;
  FLine_270.Range  := 4;
  FLine_315.Range  := 4;

  FRange_1.Range  := 1;
  FRange_2.Range  := 2;
  FRange_3.Range  := 3;
  FRange_4.Range  := 4;

  FLine_0.Draw(aCanvas);
  FLine_45.Draw(aCanvas);
  FLine_90.Draw(aCanvas);
  FLine_135.Draw(aCanvas);
  FLine_180.Draw(aCanvas);
  FLine_225.Draw(aCanvas);
  FLine_270.Draw(aCanvas);
  FLine_315.Draw(aCanvas);
  FRange_1.Draw(aCanvas);
  FRange_2.Draw(aCanvas);
  FRange_3.Draw(aCanvas);
  FRange_4.Draw(aCanvas);

end;

procedure TFormationRange.SetBaseBearing(value: Double);
begin
  FBaseBearing := value;

end;

{ THistoryVisual }

constructor THistoryVisual.Create;
begin
  inherited;

  VisibleCount := 230;
  Selected := true;
  ClearHistory;
  FTrailCapacity := 250;     //50
end;

destructor THistoryVisual.Destroy;
begin
  FTrailCount := 0;
  SetLength(FTrails, 0);
  SetLength(FPixelTrails, 0);

  inherited;
end;

procedure THistoryVisual.AddPoint(dX, dY: double);
var i : integer;
begin
  if FTrailCount = FTrailCapacity then
  begin
    for i := 0 to FTrailCount - 2 do
      FTrails[i] := FTrails[i+1];
  end
  else
  begin
    FTrailCount := FTrailCount + 1;
    SetLength(FTrails, FTrailCount);
    SetLength(FPixelTrails, FTrailCount);
  end;

  FTrails[FTrailCount-1].X := dX;
  FTrails[FTrailCount-1].Y := dY;
end;

procedure THistoryVisual.ClearHistory;
begin
  SetLength(FTrails, 0);
  SetLength(FPixelTrails, 0);
  FTrailCount := 0;
end;

procedure THistoryVisual.ConvertCoord(cvt: TCoordConverter);
var i: integer;
    dx, dy: double;
begin
  inherited;

  for i := 0 to FTrailCount-1 do begin
    dx := FTrails[i].x;
    dy := FTrails[i].y;
    cvt.ConvertToScreen(dx, dy, FPixelTrails[i].X ,  FPixelTrails[i].Y );
  end;
end;

procedure THistoryVisual.Draw(aCanvas: TCanvas);
var i: integer;
    mnTrail : integer;
    r :TRect;
    x,y : integer;
begin
  inherited;

//  if not (Visible and vFilter.Show(pftNone, 'Track history', 'Track symbol')) then
//    Exit;

  if VisibleCount = 0 then
    Exit;

  if VisibleCount > 0 then
  begin        //30
    mnTrail := Max(0, FTrailCount-VisibleCount-2);

    with aCanvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := Color;
      Pen.Color := Color;

      for i := FTrailCount - 2 downto mnTrail do
      begin
        x := FPixelTrails[i].X;
        y := FPixelTrails[i].Y;
        r := ptToRect(x,y, 2, 2);

        FillRect(r);
      end;
    end;
  end
  else
  begin //-1
    with aCanvas do
    begin
      Brush.Color := Color;
      Pen.Color := Color;

      for i := FTrailCount - 1 downto 0 do
      begin
        x := FPixelTrails[i].X;
        y := FPixelTrails[i].Y;
        r := ptToRect(x,y, 2, 2);

        FillRect(r);
      end
    end
  end;
end;

{ TBlindZoneVisual }

procedure TBlindZoneVisual.ConvertCoord(cvt: TCoordConverter);
var r, r1 : integer;
    rDegree, rDegree1: double;
    dx, dy, dx1, dy1: double;
    pt : TPoint;
    rStart, rEnd: Double;
begin
  inherited;
  if StartAngle = EndAngle then exit;

  cvt.ConvertToScreen(mx, my, FCenter.X, FCenter.Y);

  rDegree := (Ranges - (0.2 * Ranges)) * C_NauticalMile_To_Degree;
  dx := mX + rDegree;
  dy := mY;

  cvt.ConvertToScreen(dx, dy, pt.X, pt.Y);
  r := Abs(pt.X - Center.X);

  rDegree1 := Ranges * C_NauticalMile_To_Degree;
  dx1 := mX + rDegree1;
  dy1 := mY;

  cvt.ConvertToScreen(dx1, dy1, pt.X, pt.Y);
  r1 := Abs(pt.X - Center.X);

{  dipindah di procedure updaterelatifAngle
  FRelativeStartAngle := StartAngle;
  FRelativeStartAngle := ConvCompass_To_Cartesian(FRelativeStartAngle);
  FRelativeStartAngle := ConvCustomAngleStart(FRelativeStartAngle,FHeading);
  FRelativeStartAngle := FRelativeStartAngle * C_DegToRad;

  FRelativeEndAngle := EndAngle;
  FRelativeEndAngle := ConvCompass_To_Cartesian(FRelativeEndAngle);
  FRelativeEndAngle := ConvCustomAngleStart(FRelativeEndAngle,FHeading);
  FRelativeEndAngle := FRelativeEndAngle * C_DegToRad;
}
  rStart := ConvCompass_To_Cartesian(FRelativeStartAngle)  * C_DegToRad;
  rEnd   := ConvCompass_To_Cartesian(FRelativeEndAngle)  * C_DegToRad;

  FEndPoint.X := Center.X + Round(Cos(rEnd) * r1);
  FEndPoint.Y := Center.Y - Round(Sin(rEnd) * r1);

  FStartPoint.X   := Center.X + Round(Cos(rStart) * r1);
  FStartPoint.Y   := Center.Y - Round(Sin(rStart) * r1);

//  FStartPoint.X   := Center.X + Round(Cos(FRelativeEndAngle * C_DegToRad) * r1);
//  FStartPoint.Y   := Center.Y + Round(Sin(FRelativeEndAngle* C_DegToRad) * r1);

  FRects.Left   := Center.X - r;
  FRects.Top    := Center.Y - r;
  FRects.Right  := Center.X + r;
  FRects.Bottom := Center.Y + r;

  cvt.ConvertToMap(Round(FStartPoint.X), Round(FStartPoint.Y), FSx, FSy);
  cvt.ConvertToMap(Round(FEndPoint.X), Round(FEndPoint.Y), FEx, FEy);

end;

constructor TBlindZoneVisual.Create;
begin

end;

destructor TBlindZoneVisual.Destroy;
begin

  inherited;
end;

procedure TBlindZoneVisual.Draw(aCanvas: TCanvas);
{var
  bitmap : TBitmap;}
begin
  inherited;

  if StartAngle = EndAngle then exit;

  {bitmap := TBitmap.Create;
  bitmap.Width  := FRects.Right - FRects.Left;
  bitmap.Height := FRects.Top - FRects.Bottom;}

  with aCanvas do begin
    //CopyRect();

    Pen.Style := psSolid;
    Pen.Color := Color;

    //Brush.Style := bsSolid;
    //Brush.Color := clBlue;
    //Ellipse(FRects);

    Arc(FRects.Left,FRects.Top,FRects.Right,FRects.Bottom,
        Round(FEndPoint.X),Round(FEndPoint.Y),
        Round(FStartPoint.X),Round(FStartPoint.Y));

    MoveTo(Center.X,Center.Y);
    LineTo(Round(FStartPoint.X),Round(FStartPoint.Y));

    MoveTo(Center.X,Center.Y);
    LineTo(Round(FEndPoint.X),Round(FEndPoint.Y));

    //TextOut(Round(FEndPoint.X),Round(FEndPoint.Y), 'End: ' +
    //FormatCourse(RelativeEndAngle));  // cek end angel

    Brush.Style := bsClear;
  end;
end;

procedure TBlindZoneVisual.UpdateRelatifAngle;
begin
  FRelativeStartAngle := ValidateRange(FHeading + StartAngle, 360.0);
  FRelativeEndAngle   := ValidateRange(FHeading + EndAngle, 360.0);

{ FRelativeStartAngle := StartAngle;
  FRelativeStartAngle := ConvCompass_To_Cartesian(FRelativeStartAngle);
  FRelativeStartAngle := ConvCustomAngleStart(FRelativeStartAngle,FHeading);
  //  FRelativeStartAngle := FRelativeStartAngle * C_DegToRad;
  //  FRelativeStartAngle := FRelativeStartAngle dalam cartesian
  FRelativeEndAngle := EndAngle;
  FRelativeEndAngle := ConvCompass_To_Cartesian(FRelativeEndAngle);
  FRelativeEndAngle := ConvCustomAngleStart(FRelativeEndAngle,FHeading);
  //  FRelativeEndAngle := FRelativeEndAngle * C_DegToRad;}
end;

function TBlindZoneVisual.getAngle(index: integer): single;
begin
  result := FAngles[index];
end;

procedure TBlindZoneVisual.setAngle(index: integer; angle: single);
begin
  FAngles[index] := angle;
end;

function TBlindZoneVisual.getRelativeAngle(index: integer): double;
begin
  Result := 0;

  case index of
//    0 : result := CalcBearing(mx,my,FSx,FSy);
//    1 : result := CalcBearing(mx,my,FEx,FEy);
    0 : result := FRelativeStartAngle;
    1 : result := FRelativeEndAngle;

  end;
end;


{ TSwapLineVisual }

procedure TSwapLineVisual.ConvertCoord(cvt: TCoordConverter);
var //i : integer;
    r : integer;
    rDegree: double;
    dx, dy: double;
    pt : TPoint;
begin
  inherited;
  cvt.ConvertToScreen(mx, my, FCenter.X, FCenter.Y);

  rDegree := Ranges * C_NauticalMile_To_Degree;
  dx := mX + rDegree;
  dy := mY;

  cvt.ConvertToScreen(dx, dy, pt.X, pt.Y);
  r := Abs(pt.X - Center.X) ;

  FRelativeAngle := Angle;
  FRelativeAngle := ConvCompass_To_Cartesian(FRelativeAngle);
  FRelativeAngle := ConvCustomAngleStart(FRelativeAngle,FHeading);
  FRelativeAngle := FRelativeAngle * C_DegToRad;

  FPoint.X := Center.X + Round(Cos(FRelativeAngle) * r);
  FPoint.Y := Center.Y + Round(Sin(FRelativeAngle) * r);
end;

procedure TSwapLineVisual.Draw(aCanvas: TCanvas);
begin
  inherited;

  with aCanvas do begin
    Pen.Style := psSolid;
    Pen.Color := Color;

    MoveTo(Center.X,Center.Y);
    LineTo(Round(FPoint.X),Round(FPoint.Y));

    Pen.Style := psClear;
  end;
end;

function TSwapLineVisual.getRelativeAngle: double;
begin
  Result := 0;
end;

procedure TSwapLineVisual.SetAngle(const Value: single);
begin
  FAngle := Value;
end;

//procedure TSwapLineVisual.SetRelativeAngle(const Value: double);
//begin
//  FRelativeAngle := Value;
//end;

{ TLineVisual }

procedure TLineVisual.ConvertCoord(cvt: TCoordConverter);
var
  X2, Y2 : double;
begin
  inherited;

  cvt.ConvertToScreen(X1,Y1,sx1,sy1);

  if not once  then begin
    RangeBearingToCoord(FRange,FBearing,X2,Y2);
    X2 := X1 + X2;
    Y2 := Y1 + Y2;

    cvt.ConvertToScreen(X2,Y2,sx2,sy2);
  end else begin
    sx2 := sx1;
    sy2 := -1500;
    cvt.ConvertToMap(sx2,sy2,X2,Y2);
  end;

end;

constructor TLineVisual.Create;
begin
  once    := true;
  LineStyles := psSolid;
  Color := clYellow;
end;

procedure TLineVisual.Draw(aCanvas: TCanvas);
var
  sr, sb : String;
  h : integer;
begin
  inherited;

  if not Visible then exit;

  with aCanvas do begin
    Pen.Style := LineStyles;
    Pen.Color := Color;
    pen.Width := 1;

    MoveTo(sx1,sy1);
    LineTo(sx2,sy2);

    Brush.Color := Color;
    Brush.Style := bsSolid;

    Rectangle(sx2-2,sy2-2,sx2+2,sy2+2);

    if ShowRangeBearing then
    begin

      sr := FormatFloat('0.00',FRange) + ' nM';
      sb := FormatFloat('0.00',FBearing) + 'º';

      TextOut(sx2,sy2,  sr);
      h := TextHeight(sr);
      TextOut(sx2,sy2+h,sb);

    end;
  end;
end;

function TLineVisual.isPointOnLine(X,Y : double): boolean;
var sX,sY : integer;
  pt1,pt2,pt3 : T2dPoint;
  dist : double;
begin

  Converter.ConvertToScreen(X,Y,sx,sy);

  result := false;

  pt1.X := sx1;
  pt1.Y := sy1;
  pt2.X := sx2;
  pt2.Y := sy2;
  pt3.X := sx;
  pt3.Y := sy;

  dist := ptToLineDistance(pt1,pt2,pt3);

  if dist < 3 then begin
    once := false;
    result := true;
  end;
  
end;

procedure TLineVisual.SetBearing(const Value: double);
begin
  FBearing := Value;
end;

procedure TLineVisual.SetRange(const Value: double);
begin
  FRange := Value;
end;

procedure TLineVisual.SetShowRangeBearing(const Value: Boolean);
begin
  FShowRangeBearing := Value;
end;

{ procedure TLineVisual.SetShowRangeBearing(const Value: Boolean);
begin
  FShowRangeBearing := Value;
end;

TTacticalSymbol }


constructor TTacticalSymbol.Create;
var
  I : integer;
begin
  FColorSelected := clrSelected;

//  FSymbol       := TBitmapSymbol.Create;
//  FSymbol.Color := color;

//  FSymbolBMP    := TBitmapSymbol.Create;
//  FSymbolBMP.Color := Color;

  FSpeedVector  := TSpeedVectorVisual.Create;
  FSpeedVector.Color := color;

  FSeeker       := TSeekerVisual.Create;
  FSeeker.Color := Color;

  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[I] := TTextVisual.Create;
    FTextVisuals[I].FontName := 'Tahoma';
    FTextVisuals[I].Size     := 6;
  end;

  FSelected     := false;
  FControlled   := false;
  FMerged       := false;

  FSymbolVisual := TTacticalSymbolVisual.Create;
  FSymbolVisual.CharSymbol := '4';
  FSymbolVisual.Color := color;
end;

destructor TTacticalSymbol.Destroy;
begin

  inherited;
end;

procedure TTacticalSymbol.ConvertCoord(cvt: TCoordConverter);
var
  I : integer;
begin
  inherited;

  if not Assigned(cvt) then
    Exit;

//  FSymbol.Center := Center;
//  FSymbol.ConvertCoord(cvt);

  FSymbolVisual.Center := Center;
  FSymbolVisual.ConvertCoord(cvt);

  FSpeedVector.Center := FSymbolVisual.Center;
  FSpeedVector.ConvertCoord(cvt);

  FSeeker.Center := FSymbolVisual.Center;
  FSeeker.ConvertCoord(cvt);

//  FSymbolVisual.Center := FSymbol.Center;
//  FSymbolVisual.ConvertCoord(cvt);

//  FSymbolBMP.Center := Center;
//  FSymbolBMP.ConvertCoord(cvt);
end;

procedure TTacticalSymbol.SetFColor(const clr: TColor);
begin
  inherited;

  if not FSelected then begin
//    FSymbol.Color       := clr;
    FSpeedVector.Color  := clr;
    FSymbolVisual.Color := clr;
//    FSymbolBMP.Color    := clr;
  end;
//  FText.Color         := clr;
end;

procedure TTacticalSymbol.SetInstructor(const Value: Boolean);
begin
  FisInstructor := Value;
end;

procedure TTacticalSymbol.SetCenter(const Value: TPoint);
var
  I : integer;
begin
  FCenter             := Value;
//  FSymbol.Center      := Value;
  FSpeedVector.Center := Value;
  FSymbolVisual.Center := Value;
//  FSymbolBMP.Center   := Value;

  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[I].Center := Value;
  end;

end;

procedure TTacticalSymbol.SetMerged(const Value: Boolean);
begin
  FMerged := Value;
end;


procedure TTacticalSymbol.SetNRP(const Value: Boolean);
begin
  FisNRP := Value;
end;

procedure TTacticalSymbol.setVehicle(const Value: Boolean);
begin
  FisVehicle := Value;
end;

procedure TTacticalSymbol.setWreck(const Value: Boolean);
begin
  FisWreck := Value;
end;

procedure TTacticalSymbol.Draw(aCanvas: TCanvas);
var
  w, h : Integer;
  rect : TRect;
  i : Integer;
begin
  inherited;

  FSymbolVisual.Draw(aCanvas);

//  if vFilter.Show(pftNone, 'Track leader', 'Track symbol') then
//    FSpeedVector.Draw(aCanvas);

  {$REGION ' Menggambar Seeker '}
  FSeeker.Draw(aCanvas);
  {$ENDREGION}

  {$REGION ' Menggambar Tactical Info (call sign) '}
  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[i].Text := FCallSigns[i];
    FTextVisuals[i].Center := Center;
    FTextVisuals[i].Offset.X := 0;

    if isInstructor and not isNRP and isVehicle and not isWreck then
      FTextVisuals[i].Offset.Y := Abs(FSymbolVisual.RectArea.Top - Center.Y) + ( 10 * i)
    else
      FTextVisuals[i].Offset.Y := 10 * I;
  end;
  {$ENDREGION}

  {$REGION ' Dipindah ke TTacticalSymbol.FSymbolVisual.Draw '}
//  if vFilter.Show(pftNone, 'Track number', 'Track label') then
//    for i := 0 to Length(FTextVisuals) - 1 do
//      FTextVisuals[I].Draw(aCanvas);

//  if not (isInstructor) then
//  begin
    if FSelected then
    begin
      with aCanvas do
      begin
        Pen.Style := psSolid;
//        Pen.Width := 1;
        Pen.Color := FColorSelected;
        Brush.Style := bsClear;

        if not isInstructor then
        begin
//          w := ((FSymbol.BitmapWidth  + 1) div 2) + 4;
//          h := ((FSymbol.BitmapHeigth + 1) div 2) + 4;
//          Rectangle(FSymbol.Center.X - w, FSymbol.Center.Y - h,
//            FSymbol.Center.X + w, FSymbol.Center.Y + h);
        end
        else
        begin
//          w := ((FSymbolBMP.BitmapWidth + 1) div 2) + 4;
//          h := ((FSymbolBMP.BitmapHeigth + 1) div 2) + 4;

          if w > h then
          begin
            h := w;

//            Rectangle(FSymbolBMP.Center.X - w, FSymbolBMP.Center.Y - h,
//            FSymbolBMP.Center.X + w, FSymbolBMP.Center.Y + h);
          end
          else
          begin
            w := h;

//            Rectangle(FSymbolBMP.Center.X - w, FSymbolBMP.Center.Y - h,
//            FSymbolBMP.Center.X + w, FSymbolBMP.Center.Y + h);
          end;

        end;
      end;
    end;

    if FControlled then
    begin
      with aCanvas do
      begin
        Pen.Width := 1;
        pen.Style := psSolid;
        Pen.Color := clWhite;
        Brush.Style := bsClear;

//        if not isInstructor then
//        begin
////          w := (FSymbol.BitmapWidth div 2) + 2;
////          h := (FSymbol.BitmapHeigth div 2) + 2;
////
////          rect.Left := FSymbol.Center.X - w;
////          rect.Top  := FSymbol.Center.Y - h;
////          rect.Right:= FSymbol.Center.X + w;
////          rect.Bottom := FSymbol.Center.Y + h;
////
////          Rectangle(rect);
//        end
//        else
//        begin
////          w := (FSymbolBMP.BitmapWidth div 2) + 2;
////          h := (FSymbolBMP.BitmapHeigth div 2) + 2;
//
//          if w > h then
//          begin
//            h := w;
//
////            rect.Left := FSymbolBMP.Center.X - w;
////            rect.Top  := FSymbolBMP.Center.Y - h;
////            rect.Right:= FSymbolBMP.Center.X + w;
////            rect.Bottom := FSymbolBMP.Center.Y + h;
//          end
//          else
//          begin
//            w := h;
//
////            rect.Left := FSymbolBMP.Center.X - w;
////            rect.Top  := FSymbolBMP.Center.Y - h;
////            rect.Right:= FSymbolBMP.Center.X + w;
////            rect.Bottom := FSymbolBMP.Center.Y + h;
//          end;
//
//          Rectangle(rect);
//        end;
      end;
    end;
//  end;

  if FMerged then
  begin
    with aCanvas do
    begin
      Pen.Style := psSolid;
      Pen.Width := 1;

      if Selected then
        Pen.Color := FColorSelected
      else
        Pen.Color := clBlack;

      Brush.Style := bsClear;

      if not isInstructor then
      begin
//        w := ((FSymbol.BitmapWidth  + 1) div 2) + 3;
//        h := ((FSymbol.BitmapHeigth + 1) div 2) + 3;
//        Rectangle(FSymbol.Center.X - w, FSymbol.Center.Y + h,
//          FSymbol.Center.X - w + 4, FSymbol.Center.Y + h + 4);
      end
      else
      begin
//        w := ((FSymbolBMP.BitmapWidth  + 1) div 2) + 3;
//        h := ((FSymbolBMP.BitmapHeigth + 1) div 2) + 3;
//        Rectangle(FSymbolBMP.Center.X - w, FSymbolBMP.Center.Y + h,
//          FSymbolBMP.Center.X - w + 4, FSymbolBMP.Center.Y + h + 4);
      end;
    end;
  end;
  {$ENDREGION}

end;

function TTacticalSymbol.getCallSign(const Index: Integer): string;
begin
  result := FCallSigns[Index];
end;

procedure TTacticalSymbol.setCallSign(const Index: Integer;
  const Value: string);
begin
  FCallSigns[Index] := Value;
end;

procedure TTacticalSymbol.SetControlled(const Value: boolean);
begin
  FControlled := Value;
  FSymbolVisual.Controlled := Value;
  if Value then
    FSpeedVector.Ratio := 5
  else
    FSpeedVector.Ratio := 0.5;
end;

procedure TTacticalSymbol.SetSelected(const Value: boolean);
var
  I : Integer;
begin
  FSelected := Value;
  FSymbolVisual.Selected := Value;

  if FSelected  then begin
//    FSymbol.Color       := FColor;
    FSpeedVector.Color  := FColor;
    FSymbolVisual.Color := FColor;
//    FSymbolBMP.Color    := FColor;
    for I := 0 to Length(FTextVisuals) - 1 do
      FTextVisuals[I].Color         := FColorSelected;
  end
  else begin
//    FSymbol.Color       := FColor;
    FSpeedVector.Color  := FColor;
    FSymbolVisual.Color := FColor;
//    FSymbolBMP.Color    := FColor;
    for I := 0 to Length(FTextVisuals) - 1 do
      FTextVisuals[I].Color         := FColor;
  end;
end;

procedure TTacticalSymbol.SetTextCenter(Value: TPoint);
var
  I : Integer;
begin
  for I := 0 to Length(FTextVisuals) - 1 do
    FTextVisuals[I].Center         := Value;
end;

procedure TTacticalSymbol.SetTextColor(Value: TColor);
var
  I : Integer;
begin
  for I := 0 to Length(FTextVisuals) - 1 do
    FTextVisuals[I].Color         := Value;
end;

procedure TTacticalSymbol.SetTextVisibility(Value: Boolean);
var
  I : Integer;
begin
  for I := 0 to Length(FTextVisuals) - 1 do
    FTextVisuals[I].Visible         := Value;
end;

//procedure TTacticalSymbol.SetSpeedVector(const Value: TSpeedVectorVisual);
//begin
//  FSpeedVector := Value;
//end;

//procedure TTacticalSymbol.SetSymbol(const Value: TBitmapSymbol);
//begin
//  FSymbol := Value;
//end;

//procedure TTacticalSymbol.SetText(const Value: TTextVisual);
//begin
//  FText := Value;
//end;

{ TTacticalSymbolVisual }

procedure TTacticalSymbolVisual.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

end;

constructor TTacticalSymbolVisual.Create;
begin
  inherited;
  Size := 24;
  Color := clLime;
  FColorSelected := clrSelected;
end;

procedure TTacticalSymbolVisual.Draw(aCanvas: TCanvas);
var sz: TSize;
    hw, hh: Integer;
    pt: TPoint;

  lf : TLogFont;
  tf : TFont;
//  q : TPoint;
//  sinX, cosX : extended;
  rDraw : TRect;

begin
  inherited;

   with aCanvas do begin
    Font.Name  :=  FontName;
    Font.Size  :=  Size;
    Font.Color :=  Color;
    Font.Style := [fsBold];

    tf := TFont.Create;
    tf.Assign(Font);
    GetObject(tf.Handle, sizeof(lf), @lf);

    tf.Handle := CreateFontIndirect(lf);
    Font.Assign(tf);
    tf.Free;

    SetTextAlign(handle, TA_CENTER or VTA_CENTER);
    sz := TextExtent(CharSymbol);

    hw := (sz.cx + 1) shr 1;
    hh := (sz.cy + 2) shr 1;

    pt.X := Center.X + 4;// - hw;
    pt.Y := Center.Y - hh - 1;

    SetBkMode(Handle, TRANSPARENT);

    //Font.Orientation := FDegr * 10;
    TextOut(pt.X , pt.Y,  CharSymbol);
    Font.Style := [];

    Brush.Style := bsClear;


    FRectArea.Left := Center.X - ( sz.cy div 2 );
    FRectArea.Top  := Center.y - ( sz.cy div 2 );
    FRectArea.Right := Center.X + ( sz.cy div 2 );
    FRectArea.Bottom := Center.Y + ( sz.cy div 2 );

    if FSelected then
    begin
      with aCanvas do
      begin

        Pen.Style := psSolid;
        Pen.Width := 1;
        Pen.Color := FColorSelected;
        Brush.Style := bsClear;

//        Rectangle(
//            FRectArea.Left - 2, FRectArea.Top - 2,
//            FRectArea.Right + 2,FRectArea.Bottom + 2);

        rDraw := Rect(FRectArea.Left - 2, FRectArea.Top -2, FRectArea.Right +2, FRectArea.Bottom + 2);

        DrawRectFrameWithoutbsClear(aCanvas, rDraw);
      end;
    end;

    if FControlled then
    begin
      with aCanvas do
      begin
        Pen.Width := 1;
        pen.Style := psSolid;
        Pen.Color := clWhite;
        Brush.Style := bsClear;

//        Rectangle(FRectArea);
        rDraw := Rect(FRectArea.Left - 2, FRectArea.Top -2, FRectArea.Right +2, FRectArea.Bottom + 2);

        DrawRectFrameWithoutbsClear(aCanvas, rDraw);

      end;
    end;

  end;

end;

procedure TTacticalSymbolVisual.SetControlled(const Value: boolean);
begin
  FControlled := Value;
end;

procedure TTacticalSymbolVisual.SetSelected(const Value: boolean);
begin
  FSelected := Value;
end;

{procedure TTacticalSymbolVisual.SetSelected(const Value: boolean);
begin

end;

 TBitprocedure TTacticalSymbolVisual.SetControlled(const Value: boolean);
begin
  FControlled := Value;
end;

mprocedure TTacticalSymbolVisual.SetSelected(const Value: boolean);
begin
  FSelected := Value;
end;

apSymbolLDropPoint }

procedure TBitmapSymbolLDropPoint.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

  cvt.ConvertToScreen(FPosX, FPosY, FCenter.X, FCenter.Y);
end;

constructor TBitmapSymbolLDropPoint.Create;
begin
  inherited;

  Color := clWhite;
end;

destructor TBitmapSymbolLDropPoint.Destroy;
begin

  inherited;
end;

procedure TBitmapSymbolLDropPoint.Draw(aCnv: TCanvas);
begin
  if not Visible then
    exit;

  inherited;
end;

procedure TBitmapSymbolLDropPoint.SetPosX(const Value: double);
begin
  FPosX := Value;
end;

procedure TBitmapSymbolLDropPoint.SetPosY(const Value: double);
begin
  FPosY := Value;
end;

{ TSeekerVisual }

procedure TSeekerVisual.ConvertCoord(cvt: TCoordConverter);
var
  fromAngle, toAngle, dx, dy, centerX, centerY : Double;
//  sinA, cosA : Extended;
  cx, cy, tx, ty, r: Integer;
begin
  inherited;

  fromAngle := Bearing - Azimuth;
  if fromAngle < 0 then
    fromAngle := fromAngle + 360;

  toAngle := Bearing + Azimuth;
  if toAngle >= 360 then
    toAngle := toAngle - 360;

  RangeBearingToCoord(Range, fromAngle, dx, dy);
  cvt.ConvertToMap(Center.X, Center.Y, centerX, centerY);
  centerX := centerX + dx;
  centerY := centerY + dy;
  cvt.ConvertToScreen(centerX, centerY, FLeftPT.X, FLeftPT.Y);

  RangeBearingToCoord(Range, toAngle, dx, dy);
  cvt.ConvertToMap(Center.X, Center.Y, centerX, centerY);
  centerX := centerX + dx;
  centerY := centerY + dy;
  cvt.ConvertToScreen(centerX, centerY, FRightPT.X, FRightPT.Y);

  {Prince}
  cvt.ConvertToMap(Center.X, Center.Y, centerX, centerY);
  cvt.ConvertToScreen(CenterX, CenterY, cx, cy);
  dx := CenterX + Range/60;
  dy := CenterY ;

  cvt.ConvertToScreen(dx, dy, tx, ty);
  r := Abs(cx - tx);

  point.Left    := cx - r;
  point.Top     := cy - r;
  point.Right   := cx + r;
  point.Bottom  := cy + r;
end;

constructor TSeekerVisual.Create;
begin
  Tipe := 0;
end;

procedure TSeekerVisual.Draw(aCanvas: TCanvas);
begin
  inherited;

  if not Visible then
    Exit;

  with aCanvas do
  begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psSolid;

    if Tipe = 1 then
    begin
      Pen.Style := psDash;
      Arc(point.Left, point.Top, point.Right, point.Bottom, FRightPT.X, FRightPT.Y, FLeftPT.X, FLeftPT.Y);
      MoveTo(Center.X, Center.Y); LineTo(FLeftPT.X, FLeftPT.Y);
      MoveTo(Center.X, Center.Y); LineTo(FRightPT.X, FRightPT.Y);
    end
    else
    begin
//          r := ptToRect(Center.X, Center.Y , 3, 3);
 //   Arc(r.Left, r.Top, r.Right, r.Bottom, 0,0,0,0);

      MoveTo(Center.X, Center.Y);
      LineTo(FLeftPT.X, FLeftPT.Y);
  //    MoveTo(Center.X, Center.Y);
  //    LineTo(FMidPT.X, FMidPT.Y);
      MoveTo(Center.X, Center.Y);
      LineTo(FRightPT.X, FRightPT.Y);
    end;


  end;
end;

{ TRectAreaVisual }

procedure TRectAreaVisual.ConvertCoord(cvt: TCoordConverter);
var r : integer;
    rDegree: double;
    dx, dy: double;
    pt : TPoint;
begin
  inherited;

  cvt.ConvertToScreen(mx, my, FCenter.X, FCenter.Y);

  if abs(Range) < 0.0000001 then exit;

  rDegree := Range * C_NauticalMile_To_Degree;
  dx := mX + rDegree;
  dy := mY;

  cvt.ConvertToScreen(dx, dy, pt.X, pt.Y);
  r := Abs(pt.X - Center.X);

  FRects.Left   := Center.X - r;
  FRects.Top    := Center.Y - r;
  FRects.Right  := Center.X + r;
  FRects.Bottom := Center.Y + r;

end;

constructor TRectAreaVisual.Create;
begin
  inherited;

  Color := clRed;
  LineStyles := psDot;
end;

destructor TRectAreaVisual.Destroy;
begin

  inherited;
end;

procedure TRectAreaVisual.Draw(aCanvas: TCanvas);
begin
  inherited;
  if not Visible then
    Exit;

  aCanvas.Pen.Style := psSolid;
  aCanvas.Pen.Color := Color;
  aCanvas.Pen.Style := LineStyles;
  aCanvas.Brush.Style := bsDiagCross;
  aCanvas.Brush.Color := clRed;
//  aCanvas.Rectangle(FRects);
  aCanvas.Ellipse(FRects);

end;

{ TPlatformInfoBalloon }


procedure TPlatformInfoBalloon.CalcBalloonSize;
var
  i, w : Integer;
begin
  FHeight := 0;
  FWidth := 0;
  FCallSignCount := 0;

  for i := 0 to Length(FCallSigns) - 1 do
  begin
    if FCallSigns[i] <> '' then
     FCallSignCount := i+1;

      //Inc(FCallSignCount);

    w := Length(FCallSigns[i]) * 8 + 6;

    if FWidth < w then
      FWidth := w;
  end;

  FHeight := FCallSignCount * 14
end;

constructor TPlatformInfoBalloon.Create;
begin
  Offset.X := 0;
  Offset.Y := 60;
end;

procedure TPlatformInfoBalloon.DragBalloon(const aOffsetX, aOffsetY: Integer);
begin
  Offset.X := Offset.X + aOffsetX;
  Offset.Y := Offset.Y + aOffsetY;
end;

procedure TPlatformInfoBalloon.Draw(aCanvas: TCanvas);
var
  i : Integer;
begin
  inherited;

  with aCanvas do
  begin
    Pen.Color := FColor;
    Pen.Style := psSolid;
    Brush.Color := clSilver;
    Brush.Style := bsSolid;

    Font.Name := 'Courier';
    Font.Size := 7;
    Font.Color := Color;
    SetBkMode(aCanvas.Handle, TRANSPARENT);
    SetTextAlign(Handle, TA_CENTER or VTA_CENTER);

    with FRect do
    begin
      Left := FBalloonCenter.X - (FWidth div 2);
      Top := FBalloonCenter.Y - (FHeight div 2);
      Right := FBalloonCenter.X + (FWidth div 2);
      Bottom := FBalloonCenter.Y + (FHeight div 2);
    end;

    if FCallSignCount > 0 then
    begin
      MoveTo(FCenter.X, FCenter.Y);
      LineTo(FBalloonCenter.X, FBalloonCenter.Y);
    end;

    Rectangle(FRect);

    for i := 0 to Length(FCallSigns) - 1 do
      TextOut(FBalloonCenter.X, FRect.Top + (i * 14), FCallSigns[i]);
  end;
end;

function TPlatformInfoBalloon.GetCallSign(const aIndex: Integer): string;
begin
  Result := FCallSigns[aIndex];
end;

procedure TPlatformInfoBalloon.SetCallSign(const aIndex: Integer;
  const aValue: string);
begin
  FCallSigns[aIndex] := aValue;

  CalcBalloonSize;
end;

procedure TPlatformInfoBalloon.SetCenter(const aValue: TPoint);
begin
  inherited;

  FBalloonCenter.X := FCenter.X + Offset.X;
  FBalloonCenter.Y := FCenter.Y + Offset.Y;
end;

{ TRangeLandingPlatform }

procedure TRangeLandingPlatform.ConvertCoord(cvt: TCoordConverter);
var
  r : integer;
  rDegree: double;
  dx, dy: double;
  pt : TPoint;
begin
  inherited;
  cvt.ConvertToMap(Center.X, Center.Y, postCenter.X, postCenter.Y);

  radius := 0.25;

  rDegree := radius * C_NauticalMile_To_Degree;
  dx := postCenter.X + rDegree;
  dy := postCenter.Y;

  cvt.ConvertToScreen(dx, dy, pt.X, pt.Y);
  r := Abs(pt.X - Center.X);

  point.Left   := Center.X - r;
  point.Top    := Center.Y - r;
  point.Right  := Center.X + r;
  point.Bottom := Center.Y + r;
end;

constructor TRangeLandingPlatform.Create;
begin

end;

procedure TRangeLandingPlatform.Draw(aCanvas: TCanvas);
begin
  inherited;

  with aCanvas do
  begin
    Pen.Color := Color;
    Pen.Style := psDash;
    Brush.Style := bsClear;

    if isShow then
     Ellipse(point.Left, point.Top, point.Right, point.Bottom);
  end;
end;

{ TLogisticsLine }

procedure TLogisticsLine.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

  cvt.ConvertToScreen(pointSelf.X, pointSelf.Y, posSelf.X, posSelf.Y);
  cvt.ConvertToScreen(pointTarget.X, pointTarget.Y, posTarget.X, posTarget.Y);
end;

constructor TLogisticsLine.Create;
begin

end;

destructor TLogisticsLine.Destroy;
begin
  inherited;
end;

procedure TLogisticsLine.Draw(aCanvas: TCanvas);
begin
  inherited;

  with aCanvas do
  begin
    Pen.Color := Color;
    Pen.Style := psDashDot;
    Brush.Style := bsClear;

    MoveTo(posSelf.X, posSelf.Y);
    LineTo(posTarget.X, posTarget.Y);

    Brush.Style := bsSolid;
    Brush.Color := clLime;
    Pen.Color := clLime;
    Rectangle(posSelf.X-3, posSelf.Y-3, posSelf.X+3, posSelf.Y+3);

    Brush.Style := bsClear;
  end;
end;

{ TTargetVisual }

procedure TTargetVisual.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

end;

constructor TTargetVisual.create;
begin
  inherited;

  Color := clBlue;
  LineStyles := psSolid;
end;

destructor TTargetVisual.Destroy;
begin

  inherited;
end;

procedure TTargetVisual.Draw(aCanvas: TCanvas);
begin
  inherited;

  FCircle.Left   := Center.X - 5;
  FCircle.Top    := Center.Y - 5;
  FCircle.Right  := Center.X + 5;
  FCircle.Bottom := Center.Y + 5;
  aCanvas.Pen.Width := 1;
  aCanvas.Pen.Color := clBlue;
  aCanvas.Pen.Style := psSolid;
  aCanvas.Brush.Color := clred;
  aCanvas.Brush.Style := bsSolid;
  aCanvas.Ellipse(FCircle.Left, FCircle.Top, FCircle.Right, FCircle.Bottom);
  FCircle.Left   := Center.X - 7;
  FCircle.Top    := Center.Y - 7;
  FCircle.Right  := Center.X + 7;
  FCircle.Bottom := Center.Y + 7;
  aCanvas.Pen.Width := 1;
  aCanvas.Pen.Color := clBlue;
  aCanvas.Pen.Style := psSolid;
  aCanvas.Brush.Style := bsClear;
  aCanvas.Ellipse(FCircle.Left, FCircle.Top, FCircle.Right, FCircle.Bottom);

  aCanvas.MoveTo(Center.X, Center.y + 7);
  aCanvas.LineTo(Center.X, Center.Y - 7);

  aCanvas.MoveTo(Center.X + 7, Center.y);
  aCanvas.LineTo(Center.X - 7, Center.Y);

end;

end.

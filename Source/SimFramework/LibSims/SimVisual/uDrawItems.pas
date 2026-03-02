unit uDrawItems;

interface

uses
  Classes, Windows, Graphics, uDataTypes, uCoordConvertor,
   uSimDrawing, uShipView;

type

  //==============================================================================
  TCharSymbol = class(TDrawElement)
  public
    CharSymbol: Char;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;

  end;

  //==============================================================================
  TRotateCharSymbol = class(TDrawElement)
  private
    FBSize: integer;

    FRotation: single;
    Fbmp: TBitmap;
    RBmp: TBitmap;
    FCharSymbol: Char;

    procedure ReSetBmp;

    procedure SetRotation(const Value: single);
    function getRotation: single;
    procedure SetCharSymbol(const Value: Char);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Draw(aCnv: TCanvas); override;

    property Rotation: single read getRotation write SetRotation;
    property CharSymbol: Char read FCharSymbol write SetCharSymbol;
  end;

  //==============================================================================
  TSimpleLabel = class(TDrawElement)

  public
    Caption: string;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;
  end;

  //==============================================================================
  TInfoLabel = class(TDrawElement)
  public
    Line1: string;
    Line2: string;
    Line3: string;
    LineDebug: string;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;
  end;

  //============================================================================
  tHistPoint = record
    X, Y: double;
    T: TDateTime;
  end;

  THistory = class(TDrawElement)
  private
    FTrailCapacity: Word;
    FTrailCount: Word;
    FTrails: array of tHistPoint;
    FPixelTrails: array of TPoint;
    function getlastItem: tHistPoint;

  public
    VisibleCount: integer;
    //Converter : TCoordConverter;

    constructor Create();
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCnv: TCanvas); override;

    procedure AddPoint(const dX, dY: double; const dt: TDateTime);
    procedure ClearHistory;

    procedure SaveToFile(const fName: string);
    property lastItem: tHistPoint read getlastItem;

  end;

  //============================================================================
  TLineView = class(TDrawElement)
  public
    ptStart, ptEnd: TPoint;
    mStart, mEnd: t2DPoint;

    constructor Create();

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCnv: TCanvas); override;
  end;

  //============================================================================
  TToolRangeBearing = class(TLineView)
  public
    Active: boolean;
    Range, bearing: double;
    Caption: string;
    TextColor: TColor;
    TextUnit: string;

    constructor Create();

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCnv: TCanvas); override;
  end;

  //==============================================================================
  TCharCursor = class(TCharSymbol)
  protected
    procedure DrawMode_0(aCnv: TCanvas);
    procedure DrawMode_1(aCnv: TCanvas);
  public
    Mode: byte;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
  end;

  //==============================================================================
  TBitmapSymbol = class(TDrawElement)
  private
    FBSize: integer;

    FBmp: TBitmap;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Draw(aCnv: TCanvas); override;
    procedure LoadBitmap(fName: string);

    procedure BitmapDraw(bmp: TBitmap);
    procedure getBitmap(var b: TBitmap);
  end;

  //============================================================================
  TCanvasTote = class(TDrawElement)
  private
    FRect: TRect;
    FBmp: TBitmap;
    FTitle: array[0..7] of string;

    FLab: array[0..7] of string;
    function getLabel(const Index: Integer): string;
    procedure setlabel(const Index: Integer; const Value: string);
  public
    Offset: TPoint;

    constructor Create;
    destructor Destroy; override;

    procedure DrawBackGround;
    procedure Draw(aCnv: TCanvas); override;
    procedure ConvertCoord(cvt: TCoordConverter); override;

    property IShipName: string index 0 read getLabel write setlabel;
    property ICallSign: string index 1 read getLabel write setlabel;
    property ICourse: string index 2 read getLabel write setlabel;
    property ISpeed: string index 3 read getLabel write setlabel;
    property IShipX: string index 4 read getLabel write setlabel;
    property IShipY: string index 5 read getLabel write setlabel;
    property IRange: string index 6 read getLabel write setlabel;
    property IBearing: string index 7 read getLabel write setlabel;

  end;

  TSelectionMarker = class(TDrawElement)
  public
    procedure Draw(aCnv: TCanvas); override;
    procedure ConvertCoord(cvt: TCoordConverter); override;

  end;

  TShipTopView = class(TDrawElement)
  private
    pt: array [0..4] of TPoint;
  public
    FShape : TRecShipShape;

    procedure Draw(aCnv: TCanvas); override;
    procedure ConvertCoord(cvt: TCoordConverter); override;
  end;


  //============================================================================
  TLineDebugView = class(TDrawElement)
  public
    ptStart, ptEnd: TPoint;
    mStart, mEnd: t2DPoint;

    constructor Create();

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCnv: TCanvas); override;
  end;

implementation

uses
  Math, Types, SysUtils, uBaseCoordSystem, uGraphics, uSimFunction;

procedure DestroyBitmap(var bmp: TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

{ TCharSymbol }
//==============================================================================

constructor TCharSymbol.Create;
begin
  inherited;
  Size := 20;

  CharSymbol := 'U';
end;

procedure TCharSymbol.Draw(aCnv: TCanvas);
var
  sz: TSize;
begin
  if not Visible then exit;

  inherited;

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    sz := TextExtent(CharSymbol);
    //aligned center
    TextOut(Offset.x + Center.X - sz.cx shr 1,
      Offset.y + Center.y - sz.cy shr 1,
      CharSymbol);
  end;
end;

{ TRotateCharSymbol }
//==============================================================================

constructor TRotateCharSymbol.Create;
begin
  inherited;

  FontName := 'ShipSymbol';

  FBSize := 64;
  //  FHSize := 20;

  Size := 21;
  FBmp := TBitmap.Create;
  with FBmp do begin
    PixelFormat := pf24Bit;

    Width := FBSize;
    Height := FBSize;
    TransparentMode := tmFixed;
    TransparentColor := RGB(0, 0, 0);
    Transparent := true;
  end;
  Rbmp := TBitmap.Create;
  Rbmp.PixelFormat := pf24Bit;
  Rbmp.Width := FBSize;
  Rbmp.Height := FBSize;
end;

destructor TRotateCharSymbol.Destroy;
begin

  DestroyBitmap(Fbmp);
  Fbmp.Free;

  DestroyBitmap(RBmp);
  Rbmp.Free;

  inherited;

end;

function TRotateCharSymbol.getRotation: single;
begin
  result := FRotation;
end;

procedure TRotateCharSymbol.SetRotation(const Value: single);
var
  r: integer;
begin
  // Frotation is cartesian;
  r := Round(EnsureRange(Value, 0.0, 360.0));
  if r <> Round(FRotation) then begin
    FRotation := Value;
    ReSetBmp;
  end;
end;

procedure TRotateCharSymbol.ReSetBmp;
var
  sz: TSize;
  rx, rY: integer;

begin

  with Rbmp.Canvas do begin

    Font.Size := Size;
    Font.Color := Color;
    Font.Style := [fsBold];
    Font.Name := FontName;

    sz := TextExtent(FCharSymbol);

    rx := (FBSize - sz.cx) shr 1;
    ry := (FBSize - sz.cy) shr 1;

    Brush.Color := clBlack;
    Pen.Color := clBlack;
    FillRect(Rect(0, 0, FBSize, FBSize));

    TextOut(rx, ry, FCharSymbol);
  end;

  with FBmp.Canvas do begin
    Brush.Color := clBlack;
    Pen.Color := clBlack;
    FillRect(Rect(0, 0, FBSize, FBSize));
  end;
  //  bmp24_Fill(Fbmp);

  bmp24_Rotate(Rbmp, Fbmp, FRotation);

  //bmp.Width :=

end;

procedure TRotateCharSymbol.Draw(aCnv: TCanvas);
var
  h: integer;
begin
  h := FBSize shr 1;
  aCnv.Draw(Center.X - h, Center.Y - h, fBmp);

  {  p := Center;
    with aCnv do begin
      MoveTo(p.X, p.Y - 5);
      LineTo(p.X, p.Y + 5);

      MoveTo(p.X - 5, p.Y );
      LineTo(p.X + 5, p.Y );
    end;
  }
end;

procedure TRotateCharSymbol.SetCharSymbol(const Value: Char);
begin
  FCharSymbol := Value;
  ReSetBmp;
end;

{procedure TRotateCharSymbol.Draw(aCnv: TCanvas);
var
  lf : TLogFont;
  tf : TFont;
  sz: TSize;
  p, q : TPoint;
  sinX, cosX : extended;
  rx, rY : integer;
begin
  with aCnv do begin
    p := Center;
    Pen.Color := clFuchsia;
    Pen.Mode := pmCopy;

    Font.Name  :=  FontName;
    Font.Size  :=  Size;
    Font.Color :=  Color;

    MoveTo(p.X, p.Y - 5);
    LineTo(p.X, p.Y + 5);

    MoveTo(p.X - 5, p.Y );
    LineTo(p.X + 5, p.Y );

    tf := TFont.Create;
    tf.Assign(Font);
    GetObject(tf.Handle, sizeof(lf), @lf);

    lf.lfEscapement  := FRotation;
    lf.lfOrientation := FRotation;
    lf.lfWeight := 900;

    tf.Handle := CreateFontIndirect(lf);
    Font.Assign(tf);
    tf.Free;

    SetTextAlign(handle, TA_CENTER or VTA_CENTER );
    sz := TextExtent(CharSymbol);

    SetBkMode(Handle, TRANSPARENT);
    SinCos(0.1 * C_DegToRad * FRotation, sinX, cosX );
    rX := Round( 0.5 * sz.cy * sinX);
    rY := Round( 0.5 * sz.cy * cosX);
    q.X := p.X - rx;
    q.Y := p.Y - rY;
    TextOut(q.X,  q.Y ,  CharSymbol);
  end;
end;
}

{ TSimpleLabel }

constructor TSimpleLabel.Create;
begin
  inherited;
  Size := 8;
  FontName := 'Arial';

  Caption := '*';

  Offset.x := 24;
  Offset.y := -10;
end;

procedure TSimpleLabel.Draw(aCnv: TCanvas);
var
  p: TSmallPoint;
begin

  if not Visible then exit;

  inherited;

  p.x := Center.x + Offset.x;
  p.y := Center.y + Offset.y;

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    TextOut(p.x, p.y, Caption);
  end;

end;
{ TInfoLabel }
//==============================================================================

constructor TInfoLabel.Create;
begin
  inherited;
  Size := 8;
  FontName := 'Arial';

  Line1 := ' ';
  Line2 := ' ';
  Line3 := ' ';
  LineDebug := ' ';

  Offset.x := 24;
  Offset.y := 0;

end;

procedure TInfoLabel.Draw(aCnv: TCanvas);
var
  p: TSmallPoint;
begin

  if not Visible then exit;

  inherited;

  p.x := Center.x + Offset.x;
  p.y := Center.y + Offset.y;

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin

    TextOut(p.x, p.y - 10, Line1);
    TextOut(p.x, p.y, Line2);
    TextOut(p.x, p.y + 10, Line3);
    TextOut(p.x, p.y + 20,  LineDebug);
  end;

end;

{
procedure TfrmMapWindow.DrawRangeBearing(aCnv: TCanvas);
var str: string;
    sz : TSize;
    px, py: integer;
begin
  with  aCnv do begin
    Pen.Color := clYellow;
    Font.Color := clYellow;

    MoveTo(pt1.X, pt1.Y);
    LineTo(pt2.X, pt2.Y);

    Font.Name := 'Arial';
//    Font.Color := RGB(80, 40, 0);
    Font.Color := clYellow;

    Font.Size := 8;
    str := Format('%2.0f nm ~ %2.0f°',[range, bearing]);
    sz := TextExtent(str);

    px := (pt1.X + pt2.X - sz.cx) shr 1;
    py := (pt1.Y + pt2.Y) shr 1;

    if (bearing <= 45 )then
      pX := pX + 12
    else if pY < 135 then
      pY := pY + 12
    else if pY < 225 then
      pY := pY - 12 -sz.cy
    else
     pX := pX - sz.cx - 12;

    SetBKMode(aCnv.Handle, TRANSPARENT);
    TextOut(pX, pY, str);

  end
end;
}

{ THistory }

constructor THistory.Create;
begin
  VisibleCount := -1;
  Visible := True;
  Color := clFuchsia;

end;

destructor THistory.Destroy;
begin
  FTrailCount := 0;
  SetLength(FTrails, 0);
  SetLength(FPixelTrails, 0);

  inherited;
end;

//procedure THistory.AddPoint(const dX, dY: double; const iX, iY: integer);

procedure THistory.AddPoint(const dX, dY: double; const dt: TDateTime);
begin
  inc(FTrailCount);
  if FTrailCount >= FTrailCapacity then begin
    FTrailCapacity := FTrailCapacity + 32;
    SetLength(FTrails, FTrailCapacity);
    SetLength(FPixelTrails, FTrailCapacity);
  end;

  FTrails[FTrailCount - 1].x := dX;
  FTrails[FTrailCount - 1].y := dY;
  FTrails[FTrailCount - 1].T := dt;

end;

procedure THistory.ClearHistory;
begin
  FTrailCapacity := 32;
  FTrailCount := 0;
  SetLength(FTrails, FTrailCapacity);
  SetLength(FPixelTrails, FTrailCapacity);
end;

procedure THistory.Draw(aCnv: TCanvas);
var
  i: integer;
  mnTrail: integer;
begin
  if not Visible or (VisibleCount = 0) then exit;

  if VisibleCount > 0 then
    mnTrail := Max(0, FTrailCount - VisibleCount - 2)
  else
    mnTrail := 0;

  for i := FTrailCount - 2 downto mnTrail do
    aCnv.Pixels[FPixelTrails[i].X, FPixelTrails[i].Y] := Color;
end;

procedure THistory.ConvertCoord(cvt: TCoordConverter);
var
  i: integer;
  mnTrail: integer;
begin
  if not Visible or (VisibleCount = 0) then exit;

  if VisibleCount > 0 then
    mnTrail := Max(0, FTrailCount - VisibleCount - 2)
  else
    mnTrail := 0;

  for i := FTrailCount - 2 downto mnTrail do
    cvt.ConvertToScreen(FTrails[i].X, FTrails[i].Y,
      FPixelTrails[i].X,
      FPixelTrails[i].Y);
end;

procedure THistory.SaveToFile(const fName: string);
var
  i: integer;
  strs: TStrings;
  s: string;

begin
  strs := TStringList.Create;
  for i := 0 to FTrailCount - 1 do begin
    s :=
      FormatDateTime('dd-mm-yyyy hh:nn:ss', Ftrails[i].T)
      + ',' + formatDMS_long(Ftrails[i].X)
      + ',' + formatDMS_lat(Ftrails[i].Y);
    strs.Add(s);
  end;
  strs.SaveToFile(fName);

  strs.Free;
end;

function THistory.getlastItem: tHistPoint;
begin
  if FTrailCount > 0 then begin
    Result.X := FTrails[FTrailCount - 1].x;
    Result.Y := FTrails[FTrailCount - 1].y;
    Result.T := FTrails[FTrailCount - 1].T;
  end;

end;

{ TLineView }

procedure TLineView.ConvertCoord(cvt: TCoordConverter);
begin
  //  cvt.ConvertToScreen(mStart.X, mStart.Y, ptStart.X, ptSTart.Y);
  //  cvt.ConvertToScreen(mEnd.X, mEnd.Y, ptEnd.X, ptEnd.Y);
  Center.X := (ptStart.X + ptEnd.X) div 2;
  Center.Y := (ptStart.Y + ptEnd.Y) div 2;
end;

constructor TLineView.Create;
begin
  Size := 8;
  Color := RGB(64, 54, 128);
end;

procedure TLineView.Draw(aCnv: TCanvas);
begin
  inherited;

  aCnv.Pen.Color := Color;
  aCnv.Pen.Width := 1;
  aCnv.Pen.Mode := pmCopy;
  //  aCnv.Pen.Mode := pmXor;
  aCnv.MoveTo(ptStart.X, ptStart.Y);
  aCnv.LineTo(ptEnd.X, ptEnd.Y);

end;

{ TToolRangeBearing }

procedure TToolRangeBearing.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;
  Caption := FormatCourse(bearing) + '° ~ ' + Format('%3.1f ', [Range]) + TextUnit;

end;

constructor TToolRangeBearing.Create;
begin
  inherited;
  FontName := 'Arial';
  TextColor := $8000A0;

  TextUnit := 'nm';

end;

procedure TToolRangeBearing.Draw(aCnv: TCanvas);
var
  sz: TSize;
  p: TPoint;
begin
  if not Visible then Exit;

  inherited;

  aCnv.MoveTo(ptStart.X - 4, ptStart.Y);
  aCnv.LineTo(ptStart.X + 5, ptStart.Y);
  aCnv.MoveTo(ptStart.X, ptStart.Y - 4);
  aCnv.LineTo(ptStart.X, ptStart.Y + 5);

  aCnv.Ellipse(ptStart.X - 2, ptStart.Y - 2, ptStart.X + 3, ptStart.Y + 3);

  aCnv.Font.Color := TextColor;
  aCnv.Font.Name := FontName;
  aCnv.Font.Size := Size;
  sz := aCnv.TextExtent(Caption);

  if (bearing > 0) and (bearing < 180) then
    p := Point(Center.X, Center.Y + sz.cy)

  else
    p := Point(Center.X, Center.Y - sz.cy);

  aCnv.Brush.Color := $00ECFCFC;
  aCnv.FillRect(Rect(p.X - 2, p.Y - 2, p.X + sz.cx + 2, p.Y + sz.cy + 2));
  aCnv.TextOut(p.X, p.Y, Caption)

end;

{ TCursor }

constructor TCharCursor.Create;
begin
  inherited;
  Size := 12;
  Color := clWhite;
end;

procedure TCharCursor.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

end;

procedure TCharCursor.DrawMode_0(aCnv: TCanvas);
const
  W = 3;
var
  h: byte;
begin
  h := Size shr 1;
  with aCnv, Center do begin
    Pen.Color := Color;
    Pen.Mode := pmNotMask;
    Pen.Width := 2;
    MoveTo(X, Y - h);
    LineTo(X + h, Y);
    LineTo(X, Y + h);
    LineTo(X - h, Y);
    LineTo(X, Y - h);

    {    MoveTo(X        , Y - h -1 );
        LineTo(X + h +1 , Y    );
        LineTo(X        , Y + h + 1);
        LineTo(X - h -1  , Y);
        LineTo(X         , Y - h -1);
    }

    Pen.Width := 1;
    Pen.Mode := pmNot;
    MoveTo(X, Y - h - W);
    LineTo(X, Y - h + W);

    MoveTo(X, Y + h - W);
    LineTo(X, Y + h + W);

    MoveTo(X - h - W, Y);
    LineTo(X - h + W, Y);

    MoveTo(X + h - W, Y);
    LineTo(X + h + W, Y);
  end;
  //  inherited;
end;

procedure TCharCursor.DrawMode_1(aCnv: TCanvas);
begin

end;

procedure TCharCursor.Draw(aCnv: TCanvas);
begin
  case Mode of
    1: DrawMode_1(aCnv);
  else
    DrawMode_0(aCnv);
  end;

end;

{ TBitmapSymbol }

procedure TBitmapSymbol.BitmapDraw(bmp: TBitmap);
begin

  FBmp.Assign(bmp);
  //  FBmp.Canvas.Draw(0,0, bmp);
end;

procedure TBitmapSymbol.getBitmap(var b: TBitmap);
begin
  b.Assign(Fbmp);
end;

constructor TBitmapSymbol.Create;
begin
  FBSize := 32;

  FBmp := TBitmap.Create;
  with FBmp do begin
    PixelFormat := pf24Bit;

    Width := FBSize;
    Height := FBSize;
    TransparentMode := tmFixed;
    TransparentColor := RGB(255, 255, 255);
    Transparent := true;
  end;
end;

destructor TBitmapSymbol.Destroy;
begin
  DestroyBitmap(fbmp);

  inherited;
end;

procedure TBitmapSymbol.Draw(aCnv: TCanvas);
var
  h: integer;
begin
  inherited;
  h := FBSize shr 1;
  aCnv.Draw(Center.X - h, Center.Y - h, fBmp);

end;

procedure TBitmapSymbol.LoadBitmap(fName: string);
begin
  Fbmp.LoadFromFile(fName);
end;

{ TCanvasTote }

constructor TCanvasTote.Create;
begin
  FRect := Rect(0, 0, 180, 160);
  {  Fbmp        := TBitmap.Create;
    Fbmp.PixelFormat := pf24bit;

    Fbmp.Width  := FRect.Right;
    Fbmp.Height := FRect.Bottom;
    FBmp.Canvas.Brush.Color := clBlack;
    FBmp.Canvas.FillRect(FRect);

    DrawBackGround;
  }

  Offset.X := 40;
  Offset.Y := -170;

  FTitle[0] := ''; // ship name
  FTitle[1] := ' CallSign ';
  FTitle[2] := ' Course ';
  FTitle[3] := ' Speed ';
  FTitle[4] := ' Long ';
  FTitle[5] := ' Latt ';
  FTitle[6] := ' Range ';
  FTitle[7] := ' Bearing ';

end;

destructor TCanvasTote.Destroy;
begin
  //  DestroyBitmap(FBmp);
  inherited;
end;

procedure TCanvasTote.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

end;

procedure TCanvasTote.DrawBackGround;
var
  i: Integer;
  r, r1, r2: TRect;
  ofTxt: TPoint;
  yspc: Integer;
  w: Integer;
  sz: TSize;
begin
  FBmp.Canvas.FillRect(FRect);

  r := FRect;

  with FBmp.Canvas do begin
    Brush.Style := bsSolid;
    CopyMode := cmSrcCopy;

    Brush.Color := RGB(64, 64, 64);
    Pen.Color := clWhite;
    Pen.Style := psSolid;
    Pen.Mode := pmCopy;

    FillRect(FRect);
    InflateRect(r, -2, -2);

    Brush.Color := RGB(127, 127, 127);
    FrameRect(r);
  end;

  r.Top := r.Top + 4;
  r.Left := r.Left + 4;
  ofTxt.X := 24;
  ofTxt.Y := 24;
  //  ofc := 64;
  yspc := 17;
  with FBmp.Canvas do begin
    Font.Size := 9;
    Font.Name := 'Tahoma';
    r1.Top := r.Top;
    r1.Bottom := r1.Top + yspc + 4;
    r1.Left := r.Left;
    r1.Right := r.Right - 4;
    Brush.Color := RGB(127, 127, 127);
    FillRect(r1);

    w := (r1.Left + r1.Right) shr 1;
    Font.Style := [fsBold];
    sz := TextExtent(FLab[0]);

    TextOut(w - (sz.cx shr 1), r1.Top + 1, FLab[0]);
    Font.Style := [];

    r1.Top := r.Top + 24;
    r1.Bottom := r1.Top + yspc;
    r1.Left := r.Left;
    r1.Right := r.Left + 60;

    r2.Left := r1.Right + 4;
    r2.Right := r2.Left + 104;
    ;
    r2.Top := r1.Top;
    r2.Bottom := r1.Bottom;

    InflateRect(r1, -1, -1);
    InflateRect(r2, -1, -1);

    SetTextAlign(handle, TA_LEFT);
    for i := 1 to 7 do begin
      Brush.Color := RGB(127, 127, 127);
      FillRect(r1);
      Brush.Color := RGB(144, 144, 144);
      FrameRect(r1);
      SetBkMode(Handle, TRANSPARENT);
      FillRect(r2);
      OffsetRect(r1, 0, yspc);
      OffsetRect(r2, 0, yspc);
    end;
  end;
end;

procedure TCanvasTote.Draw(aCnv: TCanvas);
var
  i: Integer;
  r, r1, r2: TRect;
  ofTxt: TPoint;
  ofc, yspc: Integer;
  w: Integer;
  sz: TSize;
begin
  if not Visible then Exit;
  inherited;
  r := FRect;
  OffsetRect(r, Center.X, Center.y);
  OffsetRect(r, Offset.X, offset.y);

  aCnv.Brush.Style := bsSolid;
  aCnv.CopyMode := cmSrcCopy;

  aCnv.Brush.Color := RGB(64, 64, 64);
  aCnv.Pen.Color := clWhite;
  aCnv.Pen.Style := psSolid;
  aCnv.Pen.Mode := pmCopy;

  aCnv.FillRect(r);
  InflateRect(r, -2, -2);

  aCnv.Brush.Color := RGB(127, 127, 127);
  aCnv.FrameRect(r);

  r.Top := r.Top + 4;
  r.Left := r.Left + 4;
  ofTxt.X := 24;
  ofTxt.Y := 24;
  ofc := 64;
  yspc := 17;
  with aCnv do begin
    Font.Size := 9;
    Font.Name := 'Tahoma';
    r1.Top := r.Top;
    r1.Bottom := r1.Top + yspc + 4;
    r1.Left := r.Left;
    r1.Right := r.Right - 4;
    Brush.Color := RGB(127, 127, 127);
    FillRect(r1);

    w := (r1.Left + r1.Right) shr 1;
    Font.Style := [fsBold];
    sz := TextExtent(FLab[0]);

    TextOut(w - (sz.cx shr 1), r1.Top + 1, FLab[0]);
    Font.Style := [];

    r1.Top := r.Top + 24;
    r1.Bottom := r1.Top + yspc;
    r1.Left := r.Left;
    r1.Right := r.Left + 60;

    r2.Left := r1.Right + 4;
    r2.Right := r2.Left + 104;
    ;
    r2.Top := r1.Top;
    r2.Bottom := r1.Bottom;

    InflateRect(r1, -1, -1);
    InflateRect(r2, -1, -1);

    SetTextAlign(handle, TA_LEFT);
    for i := 1 to 7 do begin
      Brush.Color := RGB(127, 127, 127);
      FillRect(r1);
      Brush.Color := RGB(144, 144, 144);
      FrameRect(r1);
      SetBkMode(Handle, TRANSPARENT);
      //       TextOut(r.Left,  4 + r.Top + yspc * i, FTitle[i] );
      TextOut(r.Left, r1.Top, FTitle[i]);

      FillRect(r2);

      TextOut(r.Left + ofc + 8, r2.Top, Flab[i]);
      OffsetRect(r1, 0, yspc);
      OffsetRect(r2, 0, yspc);
    end;
  end;

  //  aCnv.TextOut(ofTxt.X, ofTxt.Y,  );

  //  aCnv.Draw(r.Left, r.Top, FBmp);

  {  AlphaBlend(aCnv.Handle , r.Left, r.Top, 180, 120,
              Fbmp.Canvas.Handle, 0, 0, 180, 120, b);

                          }// do cleanup
end;

(*procedure TCanvasTote.Draw(aCnv: TCanvas);
var r: TRect;
    b: TBlendFunction;
begin
  if not Visible then Exit;

//  DrawBackGround;

  r := FRect;
  OffsetRect(r, Center.X, Center.y);
  OffsetRect(r, Offset.X, offset.y);

  b.AlphaFormat := 0;
  b.BlendOp :=  AC_SRC_OVER;
  b.BlendFlags := 0;
  b.SourceConstantAlpha := 160;

 AlphaBlend(aCnv.Handle , r.Left, r.Top, FRect.Right, FRect.Bottom,
            Fbmp.Canvas.Handle, 0, 0, FRect.Right, FRect.Bottom, b);

end;
*)

function TCanvasTote.getLabel(const Index: Integer): string;
begin
  if (index >= 0) and (Index < 8) then
    Result := FLab[Index];
end;

procedure TCanvasTote.setlabel(const Index: Integer; const Value: string);
begin
  if (index >= 0) and (Index < 8) then
    FLab[Index] := Value;
end;

{ TSelectionMarker }

procedure TSelectionMarker.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

end;

function ptToRect(const px, py, dx, dy: integer): TRect;
begin
  with result do begin
    Left := px - dx;
    Right := px + dx;
    Top := py - dy;
    Bottom := py + dy;
  end;
end;

procedure TSelectionMarker.Draw(aCnv: TCanvas);
var
  rct: TRect;
  hsz: Integer;
begin
  if not Visible then exit;

  with aCnv do begin
    //    Pen.Color := $0058ffff;
    Pen.Color := clFuchsia;
    hsz := 10;

    rct := ptToRect(Center.X, Center.Y, hsz + 3, hsz + 3);
    hsz := 4;

    MoveTo(rct.Left + hsz, rct.Top);
    LineTo(rct.Left, rct.Top);
    LineTo(rct.Left, rct.Top + hsz);

    MoveTo(rct.Left, rct.Bottom - hsz);
    LineTo(rct.Left, rct.Bottom);
    LineTo(rct.Left + hsz, rct.Bottom);

    MoveTo(rct.Right - hsz, rct.Bottom);
    LineTo(rct.Right, rct.Bottom);
    LineTo(rct.Right, rct.Bottom - hsz);

    MoveTo(rct.Right, rct.Top + hsz);
    LineTo(rct.Right, rct.Top);
    LineTo(rct.Right - hsz, rct.Top);
  end;
end;

{ TShipTopView }

procedure TShipTopView.ConvertCoord(cvt: TCoordConverter);
var i: Integer;
begin
  for i := 0 to 4 do
  begin
    cvt.ConvertToScreen(FShape.pts[i].X,  FShape.pts[i].Y,
     pt[i].X, pt[i].Y);

  end;


end;

procedure TShipTopView.Draw(aCnv: TCanvas);

begin
  if not Visible then exit;

  with aCnv do begin
    Pen.Color := clFuchsia;

     MoveTo(pt[0].X, pt[0].Y);
     LineTo(pt[1].X, pt[1].Y);
     LineTo(pt[2].X, pt[2].Y);
     LineTo(pt[3].X, pt[3].Y);
     LineTo(pt[4].X, pt[4].Y);
     LineTo(pt[0].X, pt[0].Y);

     //   MoveTo(ptFront.X, ptFront.Y);
     //   LineTo(ptLeftFront.X, ptLeftFront.Y);
     //   LineTo(ptLeftBack.X, ptLeftBack.Y);
     //   LineTo(ptRightBack.X, ptRightBack.Y);
     //   LineTo(ptRightFront.X, ptRightFront.Y);
     //   LineTo(ptFront.X, ptFront.Y);
  end;

end;

{ TLineDebugView }


constructor TLineDebugView.Create;
begin

end;

procedure TLineDebugView.ConvertCoord(cvt: TCoordConverter);
begin
  cvt.ConvertToScreen(mStart.X, mStart.Y, ptStart.X, ptSTart.Y);
  cvt.ConvertToScreen(mEnd.X, mEnd.Y, ptEnd.X, ptEnd.Y);

end;

procedure TLineDebugView.Draw(aCnv: TCanvas);
begin
  aCnv.Pen.Color := Color;
  aCnv.Pen.Width := 1;
  aCnv.Pen.Mode := pmCopy;

  aCnv.MoveTo(ptStart.X, ptStart.Y);
  aCnv.LineTo(ptEnd.X, ptEnd.Y);

  aCnv.MoveTo(ptEnd.X - 4, ptEnd.Y);
  aCnv.LineTo(ptEnd.X + 5, ptEnd.Y);
  aCnv.MoveTo(ptEnd.X, ptEnd.Y - 4);
  aCnv.LineTo(ptEnd.X, ptEnd.Y + 5);

  aCnv.Ellipse(ptEnd.X - 2, ptEnd.Y - 2, ptEnd.X + 3, ptEnd.Y + 3);


end;

end.

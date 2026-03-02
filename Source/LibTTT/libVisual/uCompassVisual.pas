unit uCompassVisual;

interface

uses
  Classes, Windows, Graphics;

type

  //kompas kotak ala ASTT
  TCompassVisual  = class
  private
    FHalfWidth, FHalfHeight : Integer;
    FWidth : Integer;
    FHeight: Integer;

    procedure setSize(const Index, Value: Integer);
  public
    ptC       : TPoint;
    Color     : TColor;
    FontColor : TColor;

    constructor Create;
    procedure DrawCompass(aCnv: TCanvas);

  public

    property Width: Integer index 1 read FWidth write setSize;
    property Height: Integer index 2 read FHeight write setSize;
 end;

implementation

uses
  Math, SysUtils;

type

 t2DPoint = record
   X : double;
   Y : double;
 end;

function RoundPoint(const d: t2DPoint): TPoint;
begin
 Result.X := Round(d.X);
 Result.Y := Round(d.Y);
end;

function ConvCoordPolar_To_Cartesian(const aAngleRadian, aRadius: double): t2DPoint;
begin
  Result.x := aRadius * Cos(aAngleRadian);
  Result.y := aRadius * Sin(aAngleRadian);
end;

procedure TranslatePoint(const ct: TPoint; var pt: TPoint);
begin
  pt.x := ct.X + pt.X;
  pt.y := ct.Y - pt.Y;
end;

function getInRangeCorrection(const pt: tPoint; const bx, bY: integer): TPoint;
begin
  result := Point(0, 0);

  if (pt.X >= bx) then
    result.X := 1
  else if (pt.X <= -bx) then
    result.X := -1;

  if (pt.Y >= by) then
    result.Y := 1
  else if (pt.Y <= -by) then
    result.Y := -1;
end;

//function calcRect(const pt: tPoint; const r: integer): tRect;
//var d: integer;
//begin
//  d := abs(r);
//  Result := Rect(pt.X - d, pt.Y - d, pt.X + d, pt.Y + d)
//end;

//function makeInRange(const pt: tPoint; bx, bY: integer): TPoint;
//begin
//  result := pt;
//  if pt.X > bx then
//     result.X :=  bx;
//  if pt.X < - bx then
//    result.X :=  -bx;
//  if pt.y > by then
//     result.y :=  by;
//  if pt.y < - by then
//    result.y :=  -by;
//end;

function ValidateDegree(const degreeOrg: double): double;
begin
  result := degreeOrg - (Floor(degreeOrg / 360.0) * 360.0);
end;

{ TDrawCompass }
constructor TCompassVisual.Create;
begin
  Width  := 600;
  Height := 600;
  Color :=  clBlack;
end;

function makeXPoint(const aErr, aHWidth, aOffset: integer;
                   const aTanDeg: double;
                   const aPtC: TPoint): TPoint;
begin
  result.X := aErr * (aHWidth - aOffset);
  result.Y := Round(aTanDeg * result.X);
  TranslatePoint(aPtC, Result);
end;

function makeYPoint(const aErr, aHHeight, aOffset: integer;
                   const aTanDeg: double;
                   const aPtC: TPoint): TPoint;
begin
  result.Y := aErr * (aHHeight - aOffset);
  result.x := Round( result.Y / aTanDeg );
  TranslatePoint(aPtC, Result);
end;

procedure TCompassVisual.DrawCompass(aCnv: TCanvas);
var
  i : Integer;
  aDeg : Double;
  iDeg : Integer;
  pt, pte, pt1, pt2, pt3: TPoint;
  r, tanVal : Double;
  sz : TSize;
  s : string;
begin
//  if not vFilter.Show(pftNone, 'Compass card', 'Display information') then
//    Exit;

  aCnv.Pen.Color := Color;
  aCnv.Font.Color := Color;
  SetBkMode(aCnv.Handle, TRANSPARENT);

  r := Sqrt(Abs(Sqr(FHalfWidth) + Sqr(FHalfHeight)));

  for i := 0 to 35 do
  begin
    aDeg := DegToRad(i * 10);
    tanVal := Tan(aDeg);

    iDeg := Round( ValidateDegree( 90 - i * 10));
    s := Format('%3d', [iDeg]);
    sz := aCnv.TextExtent(s);

    pt := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, r));
    pte := getInRangeCorrection(pt, FHalfWidth, FHalfHeight);

    if pte.X <> 0 then
    begin
      pt1 := makeXPoint(pte.X, FHalfWidth, 1, tanVal, ptC);
      pt2 := makeXPoint(pte.X, FHalfWidth, 16, tanVal, ptC);
      pt3 := makeXPoint(pte.X, FHalfWidth, 22, tanVal, ptC);

//      aCnv.Pen.Color := clRed;
    end;

    if  pte.Y <> 0 then
    begin
      pt1 := makeYPoint(pte.Y, FHalfHeight, 1, tanVal, ptC);
      pt2 := makeYPoint(pte.Y, FHalfHeight, 16, tanVal, ptC);
      pt3 := makeYPoint(pte.Y, FHalfHeight, 22, tanVal, ptC);

//      aCnv.Pen.Color := clGreen;
    end;

    aCnv.MoveTo (pt2.X, pt2.Y);
    aCnv.LineTo (pt1.X, pt1.Y);

    aCnv.Font.Size := 12;
    aCnv.Font.Name := 'Maiandra GD';
    aCnv.TextOut(pt3.X - ((sz.cx + 1) div 2), (pt3.Y - ((sz.cy + 1) div 2)), s);
  end;
end;

procedure TCompassVisual.setSize(const Index, Value: Integer);
begin
  case index of
    1 : begin
      FWidth      := Value;
      FHalfWidth  := (Value + 1) div 2 ;
      ptC.X       := (Value + 1) div 2 ;

    end;
    2 : begin
      FHeight  := Value;
      FHalfHeight  := (Value + 1) div 2 ;
      ptC.Y    := (Value + 1) div 2
    end;
  end;
end;


end.

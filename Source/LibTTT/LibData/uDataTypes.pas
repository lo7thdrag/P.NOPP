unit uDataTypes;

interface
uses
  Types;
const

  C_2_Pi: double = 2.0 * Pi;

  C_RadToDeg = 180.0 / Pi;
  C_DegToRad = Pi / 180.0;

  C_KnotsToMeterPerSecond = 0.5144444;

type

  // double precission point
  t2DPoint = record
    X,
    Y: double;
  end;

  TPoly2DPoint = array of t2DPoint;

  t3DPoint = record
    X,
    Y,
    Z: double;
  end;

  t3DDirection = record
    H,
      V: double;
  end;

  tICounter = record
    Count: Word;
    MaxCount: Word;
  end;

  T2DRect = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: double);
      1: (TopLeft, BottomRight: t2DPoint);
  end;

  T2DPolygon = record
    Point1 : t2DPoint;
    Point2 : t2DPoint;
    Point3 : t2DPoint;
    Point4 : t2DPoint;
  end;

  tRangeBearingPoint = record
    Range,
    Bearing: double;
  end;

  //Range Outside vehicle
  tRangeOutSide = record
    DKi, DTe, DKa,
    SKi, SKa,
    BKi, BTe, BKa: Double;
  end;

  tPointOutSide = record
    LT, RT,
    LB, RB: t2DPoint;
  end;

  TPntOutSide = record
    LT, RT,
    LB, RB: TPoint;
  end;

  tOutSide = record
    osL, osR,
    osT, osB: Double;
  end;

  function Make2DPoint(const dx, dy: double): t2DPoint;
  function Translate2DPoint(const org, offset: t2DPoint): t2DPoint;
  function Scale2DPoint(const org, scale: t2DPoint ): t2DPoint;

  function Rotate2DPoint(const td: t2DPoint; const aSin, aCos: double): t2DPoint; overload;
  function Rotate2DPoint(const td: t2DPoint; const aRad: double): t2DPoint; overload;

  function Make3DPoint(const dx, dy, dz: double): t3DPoint;

  function ValidateRange(const aVal, aMaxVal: double): double;

implementation

uses Math;
// 2D point operation

  function Make2DPoint(const dx, dy: double): t2DPoint;
  begin
    Result.X := dX;
    Result.Y := dY;
  end;

  function Translate2DPoint(const org, offset: t2DPoint): t2DPoint;
  begin
    Result.X := org.X + offset.X;
    Result.Y := org.Y + offset.Y;
  end;

  function Scale2DPoint(const org, scale: t2DPoint ): t2DPoint;
  begin
    Result.X := org.X * scale.X;
    Result.Y := org.Y * scale.Y;
  end;

  function Rotate2DPoint(const td: t2DPoint; const aSin, aCos: double): t2DPoint;
  begin
  //    x' = (x * cos A) - (y * sin A)
  //    y' = (x * sin A) + (y * cos A)
    Result.X := td.X * aCos - td.Y * aSin;
    Result.Y := td.X * aSin + td.Y * aCos;
  end;

  function Rotate2DPoint(const td: t2DPoint; const aRad: double): t2DPoint;
  var aSin, aCos: Extended;
  begin
    SinCos(aRad, aSin, aCos);
  //    x' = (x * cos A) - (y * sin A)
  //    y' = (x * sin A) + (y * cos A)
    Result.X := td.X * aCos - td.Y * aSin;
    Result.Y := td.X * aSin + td.Y * aCos;
  end;

function Make3DPoint(const dx, dy, dz: double): t3DPoint;
begin
  Result.X := dX;
  Result.Y := dY;
  Result.Z := dZ;
end;

function ValidateRange(const aVal, aMaxVal: double): double;
begin
  if aMaxVal = 0.0 then
    result := 0.0
  else
    result := aVal - (Floor(aVal / aMaxVal) * aMaxVal);
end;

end.

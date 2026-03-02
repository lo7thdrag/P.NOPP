unit uFormula;

interface
uses MapXLib_TLB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
     math, uMapXHandler, uCoordConvertor, uBaseCoordSystem, uMainOverlay, uDataTypes;

  type

  TFormula = class
  public
    FCoordPlatformConv : TCoordConverter;

    function getXFromAngle (centLong: Double; sdt: Integer; radius: Double) : Double;
    function getYFromAngle (centLatt: Double; sdt: Integer; radius: Double) : Double;

    function getBearing (X : Single; Y : Single; Map1 : TMap) : String;
    function getDistance(X : Single; Y : Single; Map1 : TMap) : String;

    function getX_fromRotation(Point : TScreenPt; cent : TScreenPt; sdt: Integer): Single;
    function getY_fromRotation(Point : TScreenPt; cent : TScreenPt; sdt: Integer): Single;

    function getGradien(Point_Start: TScreenPt; Point_End: TScreenPt):Integer;

    { function for check position }
    function assignRect(x1: Single; y1: Single): TRect;
    function checkText (x1: Single; y1: Single; Size : Integer; words: string): TRect;
    function checkXYPosition(x1 : single; y1 : single; x2 : single; y2 : single): TRect;

    function isPoint_OnLine    (Point : TScreenPt; Point_Start : TScreenPt; Point_End : TScreenPt): Boolean;
    function isPoint_OnCircle  (Point : TScreenPt; cent : TScreenPt; radius: Integer): Boolean;
    function isPoint_OnEllipse (Point : TScreenPt; a_Major : Integer; b_minor : Integer) : Boolean;

    function PointTo2D (pX, pY : Integer) : t2DPoint;
    function RangeBearingTop2D (pt : tRangeBearingPoint) : t2DPoint;
    function p2DToRangeBearing (pt : t2DPoint) : tRangeBearingPoint;
  end;

implementation

function TFormula.getGradien(Point_Start: TScreenPt; Point_End: TScreenPt):Integer;
begin
   Result := Round((Point_End.Y - Point_Start.Y) / (POint_End.X - Point_Start.X));
end;

function TFormula.isPoint_OnLine    (Point : TScreenPt; Point_Start : TScreenPt; Point_End : TScreenPt): Boolean;
var
  m1, m2 : Integer;
begin
  m1 := getGradien(Point_Start, Point_End);
  m2 := getGradien(Point_Start, Point);

  if m1 = m2 then
     Result := true
  else
     Result := false;
end;

function TFormula.PointTo2D(pX, pY: Integer): t2DPoint;
var
  point2D : t2DPoint;

begin
  point2D.X    := pX;
  point2D.Y    := pY;

  Result := point2D;
end;

function TFormula.RangeBearingTop2D(pt: tRangeBearingPoint): t2DPoint;
  var
    val : t2DPoint;
begin
  val.X := pt.Range;
  val.Y := pt.Bearing;

  Result := val;
end;
function TFormula.p2DToRangeBearing(pt: t2DPoint): tRangeBearingPoint;
  var
    val : tRangeBearingPoint;
begin
  val.Range := pt.X;
  val.Bearing := pt.Y;

  Result := val;
end;

function TFormula.isPoint_OnCircle (Point : TScreenPt; cent : TScreenPt; radius: Integer): Boolean;
var
  left, right : Double;
begin
  left  := (Power((Point.X - cent.X), 2) + Power((Point.Y - cent.Y), 2));
  right := (Power(radius, 2));

  if left = right then
      Result := True
  else
      Result := False;
end;

function TFormula.isPoint_OnEllipse (Point : TScreenPt; a_Major : Integer; b_minor : Integer) : Boolean;
var
  left, right : Double;
begin
  left   := (Power(Point.X, 2)) / (Power(b_minor, 2));
  right  := (Power(Point.Y, 2)) / (Power(a_Major, 2));

  if (left + right) = 1 then
     Result := True
  else
     Result := false;
end;

function TFormula.getX_fromRotation(point : TScreenPt; cent : TScreenPt; sdt: Integer): Single;
begin
  Result := (((point.x-cent.X)*cos(DegToRad(90-sdt))) + ((point.y-cent.Y)*sin(DegToRad(90-sdt)))) + cent.X;
end;

function TFormula.getY_fromRotation(Point : TScreenPt; cent : TScreenPt; sdt: Integer): Single;
begin
  Result := (((Point.y-cent.Y)*cos(DegToRad(90-sdt))) - ((Point.x-cent.X)*sin(DegToRad(90-sdt)))) + cent.Y;
end;

function TFormula.getXFromAngle(CentLong :Double; sdt: Integer; radius: Double) : Double;
begin
  Result := 0;

  if (sdt > 0) and (sdt < 90) then
  begin
    Result := centLong + (cos(DegToRad(90-sdt))*radius);
    if Result > 180 then
    begin
       Result := (Result-180) - 180;
    end;
  end
  else if (sdt > 90) and (sdt < 180) then
  begin
    Result := centLong + (cos(DegToRad(sdt-90))*radius);
    if Result > 180 then
    begin
       Result := (Result-180) - 180;
    end;
  end
  else if (sdt > 180) and (sdt < 270) then
  begin
    Result := centLong - (cos(DegToRad(270-sdt))*radius);
  end
  else if (sdt > 270) and (sdt < 360) then
  begin
    Result := centLong - (cos(DegToRad(sdt-270))*radius);
  end;
end;

function TFormula.getYFromAngle(Centlatt : Double; sdt: Integer; radius: Double) : Double;
begin
  Result := 0;

  if (sdt > 0) and (sdt < 90) then
  begin
    Result := Centlatt + (sin(DegToRad(90-sdt))*radius);
  end
  else if (sdt > 90) and (sdt < 180) then
  begin
    Result := Centlatt - (sin(DegToRad(sdt-90))*radius);
  end
  else if (sdt > 180) and (sdt < 270) then
  begin
    Result := Centlatt - (sin(DegToRad(270-sdt))*radius);
  end
  else if (sdt > 270) and (sdt < 360) then
  begin
    Result := Centlatt + (sin(DegToRad(sdt-270))*radius);
  end;
end;

function TFormula.getBearing(X : Single; Y : Single; Map1 : TMap) : String;
var
    cursorLong, cursorLat  : double;
begin
    Map1.ConvertCoord(X, Y,  cursorLong, cursorLat, miScreenToMap);

    Result  := FormatFloat('0.00', CalcBearing(Map1.CenterX, MAp1.CenterY, cursorLong, cursorLat));
end;

function TFormula.getDistance(X : Single; Y : Single; Map1 : TMap) : String;
var
    cursorLong, cursorLat  : double;
begin
    Map1.ConvertCoord(X, Y,  cursorLong, cursorLat, miScreenToMap);

    Result := FormatFloat('0.00', FCoordPlatformConv.Distance_nmi(Map1.CenterX, MAp1.CenterY, cursorLong, cursorLat));
end;

function TFormula.checkXYPosition(x1 : single; y1 : single; x2 : single; y2 : single): TRect;
var
  temp : single;
  rect : TRect;
begin
  if round(x2) >= round(x1) then                                   //kuadran 4
  begin
     if round(y2) >= round(y1) then
     begin        end
     else if round(y2) <= round(y1) then                           //kuadran 1
     begin
        temp := y1;
        y1   := y2;
        y2   := temp;
     end;
  end;
  if round(x2) <= round(x1) then
  begin
     if round(y2) >= round(y1) then                                //kuadran 3
     begin
        temp := x1;
        x1   := x2;
        x2   := temp;
     end
     else if round(y2) <= round(y1) then                           //kuadran 2
     begin
        temp := y1;
        y1   := y2;
        y2   := temp;

        temp := x1;
        x1   := x2;
        x2   := temp;
     end;
  end;
  rect.Left   := Round(x1);      rect.Top    := Round(y1);
  rect.Right  := Round(x2);      rect.Bottom := Round(y2);
  result      := rect;
end;

function TFormula.assignRect(x1: Single; y1: Single): TRect;
const
  RANGE       = 5;
var
  rect        :  TRect;
begin
  rect.Left   := Round(x1) - RANGE;
  rect.Top    := Round(y1) - RANGE;
  rect.Right  := Round(x1) + RANGE;
  rect.Bottom := Round(y1) + RANGE;
  result      := rect;
end;

function TFormula.checkText(x1: Single; y1: Single; Size : Integer; words: string): TRect;
var
  rect :  TRect;
  l, v, h : Double;
  t,lf  : Double;
begin
  l := length(words);

//  {tinggi 10: ; 15:19 ; 20: 26}
//  if Size = 10 then
//  begin
//    h := l * 7.5;
//    v := 14;
//  end
//  else if Size = 15 then
//  begin
//    h := l * 11;
//    v := 19;
//  end
//  else
//  begin
//    h := l * 14.5;
//    v := 26;
//  end;
//  rect.Left   := Round(x1);
//  rect.Top    := Round(y1);
//  rect.Right  := Round(x1) + Round(h);
//  rect.Bottom := Round(y1) + Round(v);
//  result      := rect;

  h := (Size*0.7)*l ;
  v := (Size*1.2);
  t := (Size*0.4);
  lf := (Size*0.15);

  rect.Left   := Round(x1) - Round(lf);
  rect.Top    := Round(y1) + Round(t) ;
  rect.Right  := Round(x1) + Round(h);
  rect.Bottom := Round(y1) + Round(v);
  result      := rect;
end;
end.

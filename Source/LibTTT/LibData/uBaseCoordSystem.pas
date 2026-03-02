unit uBaseCoordSystem;
{  system coordinate cartesian, polar,  degree - radian
}

interface

uses

  uDataTypes, Windows, uConstantaData, uCoordConvertor, {IdHashSHA1,} Classes;

type
  TPointBOL = record
     x, y : Double;
   end;

//==============================================================================
  function trueDistance(const x1, y1, x2, y2: double): double;
    { desc : menghitung jarak antara 2 titik di lingkaran besar.
      input: Koordinat long lat 2 titik
      ouput: jarak (nautical miles)

    }
  function CalcRange(const x1, y1, x2, y2: double): Double;
  function CalcRange3D(const x1, y1, x2, y2, z1, z2: double): Double;
  function CalcMove(const x1, y1: double): Extended;
   { Euclid distance }

  function CalcBearing(const x1, y1, x2, y2: double): Double;

  {Point Form Leader}
  procedure FindPoint(postCont: t2DPoint; var postValue : t2DPoint; vr, vb: Double);

  {Range, Bearing Pt Form Ship}
  procedure CalcKuadranPt(const ptS, ptF : t2DPoint; ShipHeading: double; var rToPt, bToPt: Double; var kuadPt : Integer);

  function CalcRelativeHeading(OwnHeading, TargetHeading : Double): Integer;

  {Range, Bearing Ship to crash}
  procedure CalcKuadranCrash(ptShip, ptColl : t2DPoint; ShipHeading: double; var SudutHindar: Double; var KuadColl : Integer);

  procedure CalcBearingToCollision(const x1, y1, x2, y2, ShipHeading: double; var degree: Double; var section : Integer);

  { arc tan}
  procedure CalcForward(const x1, y1, aDist, aCourse: double; var x2, y2: double);

  { Direction Conversion }
  function ConvCartesian_To_Compass(const degree: double): double;
  function ConvCompass_To_Cartesian(const degree: double): double;
  function ConvCustomAngleStart(const degree,startAngle: Double):Double;

  {Kompas direction}
  function DegComp_IsBeetwen(const aDegTes: double;
    const aDeg1, aDeg2: double): boolean;

  {Prince}
  function ptToLine(const ptFrom, ptTo, pt: t2DPoint): Boolean;
  function ptToArea(const rect : TRect ; pt: t2DPoint): Boolean;
  function ptToCircle(const cent, pt: t2DPoint; r : Double): Boolean;
  function ptToArc(const cent, pt: t2DPoint; r1, r2 : Double; sA, eA, id : Integer): Boolean;
  function MapToArea(const rect : tOutSide ; pt: t2DPoint): Boolean;

  function ptToLineDistance(const ptFrom, ptTo, pt: t2DPoint): double;
  function ValidateDegree(const degreeOrg: double): double;

  function ptBetween2Point(const ptC, ptFrom, ptTo : t2DPoint; ratDiff : double): boolean;

 { ToString conversion - formatting }
  function formatDMS_long(const x: double): string;
  function formatDMS_latt(const y: double): string;
  //aldy
  function formatDM_longitude(const x: double): string;
  function formatDM_latitude(const y: double): string;

  function dmsToLong(const s: string): Double;
  function dmsToLatt(const s: string): Double;

  //aldy
  function dmToLongitude(const s: string): Double;
  function dmToLatitude(const s: string): Double;

  function FormatTrackNumber(const i: integer): string;

  function FormatCourse(const d: double): string; overload;
  function FormatCourse(const d: single): string; overload;

  function FormatSpeed(const d: double): string;
  function FormatRange(const d: double): string;

  function FormatTurnRate(const d: double): string;           // added by mizuki

  function FormatAltitude(const s: single): string;
  function FormatAltitudeTrack(const s: single):string;

  procedure RangeBearingToCoord(const r, b: double; var mx, my : double);

  function DistanceToHorizon(const h: double): double;
  function IsVisibleByHorizon(const x1, y1, h1: double; const x2, y2, h2: double): boolean;

  function IsInsideCircle(ctrX, ctrY, X, Y, radius : double; ctrZ, Z : double; mode : integer):boolean;
  function IsPointInPolygon (const x,y : integer; x1, y1, x2, y2, x3, y3, x4, y4 : Integer): boolean;

  function IsInsideSector(centX, centY, ptX, ptY, startAngle, endAngle, radius : double):boolean;

  function ConvDegree_To_Georef(B, L: Double): string;

  {UTM and MGRS convert function} //dng
  procedure ConvDegree_To_UTM_and_MGRS(const latitude, longitude : Double; var resultUTM, resultMGRS : string); // dng

  {Karvak}
  procedure ConvDegree_To_Karvak(x,y : Double; var horzPoint, vertPoint: string);

  // Tambahan
  function CalcPositionAhead(const ptOrg: t2DPoint; const aRange, aDirection: double ) : t2DPoint;
  {nautical mile, Cartesian}

  //convert string to array of char
  procedure StrToChar(Src : ansistring; var dest: array of AnsiChar);

  //convert array to string
  procedure CopyArrayToStr(const src: array of AnsiChar; var dest: AnsiString);

  //get win version
  function DSiGetWindowsVersion: TDSiWindowsVersion;
  function DSiGetTrueWindowsVersion: TDSiWindowsVersion;


  //GetElevation
  function GetElevation(Speed , Range : Double):Double;

//  //getSHACode
//  function SHA1FromString(const AString: string): string;

  //encrypt string with key
  function EncryptStr(const S :WideString; Key: Word): String;

  //decrypt string with key
  function DecryptStr(const S: String; Key: Word): String;

  function Compare(List: TStringList; Index1, Index2: Integer): Integer;

  function BubbleSort( list: TStringList ): TStringList;

  function TimeToSecond(const aTimeStr: string; var aSecond: Integer): Boolean;
  function SecondToTime(const aSecond: Integer; var aTimeStr: string): Boolean;
const

  C_Degree_To_NauticalMile = 60.0;
  C_NauticalMile_To_Degree = 1.0 /60.0;
  C_NauticalMile_To_Metre  = 1852.0;
  C_NauticalMile_To_Feet = 6076.11549;
  C_NauticalMile_To_Yards = 2025.37183;
  C_Feet_To_Meter = 0.3048;
  C_Meter_To_Feet = 3.281;
  C_Meter_To_NauticalMile = 1 / C_NauticalMile_To_Metre;
  C_Meter_To_Degree = C_Meter_To_NauticalMile * C_NauticalMile_To_Degree;
  C_Degree_To_Meter = 111319.49081869110446433493412896;
  C_Degree_To_Feet = C_Degree_To_NauticalMile * C_NauticalMile_To_Feet;
  C_MS_To_KNOTS = 1.9438449412;
  C_Gravitasi = 9.807;
  C_KNOTS_To_MS = 0.5144444;

  C_Personel_Weight = 0.08; //ton

  CKEY1 = 53761;
  CKEY2 = 32618;


implementation

uses
  Math, SysUtils , uStringFunc;

//==============================================================================
{ Horizon View Calculation }

(*
Distance to horizon

At a height h above the ground, the distance to the horizon d, is given by:
  d = sqrt(2*R*h/b)

b=0.8279 is a factor that accounts for atmospheric refraction and depends
  on the atmospheric temperature lapse rate, which is taken to be standard.

  R is the radius of the earth. Note that the earth is assumed smooth- likely only true over the oceans!

For h in feet and d in nm:
 d =1.17*sqrt(h)

i.e. from 10000 feet, the horizon is 117nm awa
*)

function CalcPositionAhead(const ptOrg: t2DPoint; const aRange, aDirection: double) : t2DPoint;
    {nautical mile, Cartesian degree}
begin
    result.X := ptOrg.X + C_NauticalMile_To_Degree * aRange * Cos(aDirection * C_DegToRad);
    result.Y := ptOrg.Y + C_NauticalMile_To_Degree * aRange * Sin(aDirection * C_DegToRad);
end;

function DistanceToHorizon(const h: double): double;
//const b = 0.8279;
//      R = 3438.147;
begin  //For h in feet and d in nm:
//  result := sqrt(2*R* (h /6076.11549) );
    result := sqrt(Abs(1.13169 * h));
end;

function IsVisibleByHorizon(const x1, y1, h1: double; const x2, y2, h2: double): boolean;
var s :double;
    d1, d2 : double;
begin
  s := trueDistance(x1, y1, x2, y2);
  d1 := DistanceToHorizon(h1);

  if s <  d1  then begin
    result := true;
  end
  else begin // behind the horizon
    d2 := DistanceToHorizon(h2);
    result := (d1 + d2) > s;
  end
end;

{
  ctrX, ctrY, X, Y : in degree
  radius in meter
}
function IsInsideCircle(ctrX, ctrY, X, Y, radius : double; ctrZ, Z : double
         ; mode : integer):boolean;
var
  deltaX, deltaY, deltaZ, deltaR : double;
begin
  result := false;

  if mode = 1 then
  begin
    deltaX := (X - ctrX) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaY := (Y - ctrY) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaZ := (Z - ctrZ) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaR := sqrt(Abs((deltaX*deltaX)+(deltaY*deltaY)+(deltaZ*deltaZ)));

    result := deltaR <= radius;
  end
  else
  if mode = 2 then
  begin
    deltaX := (X - ctrX) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaY := (Y - ctrY) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaR := sqrt(Abs((deltaX*deltaX)+(deltaY*deltaY)));

    result := deltaR <= radius;
  end;
end;

function IsInsideSector(centX, centY, ptX, ptY, startAngle, endAngle, radius : double):boolean;
var
  tempRange, tempBearing : Double;

begin
  result := false;

  tempRange := CalcRange(centX, centY, ptX, ptY);
  tempBearing := CalcBearing(centX, centY, ptX, ptY);

  if startAngle < 0 then
    startAngle := startAngle + 360;

  if endAngle < startAngle then
    endAngle := endAngle + 360;

  if (endAngle > 360) and ((tempBearing > 0) and (tempBearing < startAngle)) then
    tempBearing := tempBearing + 360;

  if (startAngle <= tempBearing) and (tempBearing  <= endAngle) then
  begin
    if tempRange <= radius then
      Result := True;
  end;

end;

// PointInPolygon() function
function IsPointInPolygon(const x, y: Integer; x1, y1, x2, y2, x3, y3, x4,
  y4 : Integer): Boolean;
var
  PolyHandle : HRGN;
  aPolygon : array[0..3] of TPoint;
begin
  aPolygon[0].X := x1;
  aPolygon[0].Y := y1;

  aPolygon[1].X := x2;
  aPolygon[1].Y := y2;

  aPolygon[2].X := x3;
  aPolygon[2].Y := y3;

  aPolygon[3].X := x4;
  aPolygon[3].Y := y4;

  PolyHandle := CreatePolygonRgn(aPolygon[0], Length(aPolygon), WINDING);
  Result := PtInRegion(PolyHandle, X, Y);
  DeleteObject(PolyHandle);
end;

//==============================================================================
{ Direction Conversion }

procedure RangeBearingToCoord(const r, b: double; var mx, my : double);
var dRad  : extended;
    sinx, cosx: extended;
    range : double;
begin
  range := r * C_NauticalMile_To_Degree;

  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  mx := range * cosx;
  my := range * sinx;
end;

function ConvCustomAngleStart(const degree,startAngle: Double):Double;
begin
  result := startAngle - degree;
  if result < 0.0 then result := result + 360.0;
end;
function ConvCartesian_To_Compass(const degree: double): double;
begin
  // input : derajat (0..360) dari sumbu X, CCW, cartesian
  // output: derajat (0..360) dari utara,   CW, kompas

  result := 90.0 - degree;
  if result < 0.0 then result := result + 360.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function ConvCompass_To_Cartesian(const degree: double): double;
begin
  // input : derajat (0..360) dari utara,   CW, kompas
  // output: derajat (0..360) dari sumbu X, CCW, cartesian

  result := 90.0 - degree;
  if result < 0.0 then result := result + 360.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function DegComp_IsBeetwen(const aDegTes: double;
  const aDeg1, aDeg2: double): boolean;
{compass direction}
var
  d1, d2: double;
begin
  d1 := (aDegTes - aDeg1);
  if d1 < 0.0 then d1 := d1 + 360.0;
//  while d1 < 0.0 do d1 := d1+ 360.0;

  d2 := (aDeg2 - aDeg1);
  if d2 < 0.0 then d2 := d2 + 360.0;
//  while d2 < 0.0 do d2 := d2+ 360.0;

  result := d1 < d2;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function IsDegreeDestAtLeft(const src, dest: double): boolean;
{ Cartesian }
{ return true jika dest dikiri (CCW) src, cartesian, east = 0 }
var
  back: double;
begin
  back := ValidateRange(dest - src, 360.0);
  result := (back - 180.0) < 0.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function trueDistance(const x1, y1, x2, y2: double): double;
const
  R = 3438.147;
begin
  result := ArcCos(sin(y1) * sin(y2) + cos(y1) * cos(y2) *
    cos(x2 - x1)) * R;
end;

function CalcRange3D(const x1, y1, x2, y2, z1, z2: double): Double;
var
  dx, dy, dz: Extended;
begin
   {input dec degree, output nautical mile, }
  dx := (x2 - x1) * C_Degree_To_NauticalMile;
  dy := (y2 - y1) * C_Degree_To_NauticalMile;
  dz := (z2 - z1) * C_Degree_To_NauticalMile;

  result := sqrt(Abs(sqr(dx) + sqr(dy) + sqr(dz)));
end;

function CalcRange(const x1, y1, x2, y2: double): Double;
var
  dx, dy: Extended;
begin
   {input dec degree, output nautical mile, }
  dx := (x2 - x1) * C_Degree_To_NauticalMile;
  dy := (y2 - y1) * C_Degree_To_NauticalMile;

  result := sqrt(Abs(sqr(dx) + sqr(dy)));
end;

function CalcMove(const x1, y1: double): Extended;
var
  d : Extended;
begin
  d := (x1 - y1) * C_Degree_To_NauticalMile;

  result := d;
end;

function CalcBearing(const x1, y1, x2, y2: double): Double;
var
  dx, dy, bearing: Extended;
begin
   {input dec degree, output Compass Coord }
  dx := (x2 - x1);
  dy := (y2 - y1);
  bearing := RadToDeg(ArcTan2(dy, dx));
  result := ConvCartesian_To_Compass(bearing);
end;

//==============================================================================
procedure CalcForward(const x1, y1, aDist, aCourse: double; var x2, y2: double);
{ x1, y1 : long lat degree
  aDist  : nautical Miles
  aDir   : Compas;
}
var dir : Double;
begin
  dir := DegToRad(90 - aCourse);

  X2 := X1 + C_NauticalMile_To_Degree * aDist * Cos(dir);
  Y2 := Y1 + C_NauticalMile_To_Degree * aDist * Sin(dir);

end;
//==============================================================================

function CalcRelativeHeading(OwnHeading, TargetHeading : Double): Integer;
var
  leftLmt, rightLmt, straightLmt  : Double;
begin
  Result := 0;

  {Batas Kiri}
  leftLmt := ValidateDegree(straightLmt - 90);

  {Batas Tengah}
  if OwnHeading < leftLmt then
    straightLmt := OwnHeading + 360
  else
    straightLmt := OwnHeading;

  {Batas Kanan}
  rightLmt := straightLmt + 90;

  {Target Heading}
  if (straightLmt >= 360) and ((TargetHeading + 360) < 600) then
    TargetHeading := TargetHeading + 360;

  {Cek Arah Target}
  if (TargetHeading >= leftLmt) and (TargetHeading < straightLmt)then
    Result := -1  {Kearah Kiri}
  else if (TargetHeading <= rightLmt) and (TargetHeading > straightLmt)then
    Result := 1;  {Kearah Kanan}
end;

procedure FindPoint(postCont: t2DPoint; var postValue : t2DPoint; vr, vb: Double);
var
  dx, dy : Double;
begin
  RangeBearingToCoord(vr, vb, dx, dy);
  postValue.X := postCont.X + dx;
  postValue.Y := postCont.Y + dy;
end;

procedure CalcKuadranPt(const ptS, ptF : t2DPoint; ShipHeading: double; var rToPt, bToPt: Double; var kuadPt : Integer);
var
  degree : Double;
begin
  bToPt := CalcBearing(ptS.X, ptS.Y, ptF.X, ptF.Y);
  rToPt := CalcRange(ptS.X, ptS.Y, ptF.X, ptF.Y);

  degree := abs(ShipHeading - bToPt);

  {Mencari titik Formasi ada di kuadran brapanya kapal}
  if (degree >= 0) and (degree < 20)then
    kuadPt := 1 {depan kanan}
  else if (degree >= 340) and (degree < 360) then
    kuadPt := 3 {depan kiri}
  else
    kuadPt := 2 {Belakang}
end;

procedure CalcKuadranCrash(ptShip, ptColl : t2DPoint; ShipHeading: double; var SudutHindar: Double; var KuadColl : Integer);
var
  BearingToCrash,
  leftLmt, rightLmt, straightLmt : Double;
begin
  BearingToCrash := CalcBearing(ptShip.X, ptShip.Y, ptColl.X, ptColl.Y);

  straightLmt := ShipHeading;
  rightLmt := ValidateDegree(straightLmt + 45);
  leftLmt := ValidateDegree(straightLmt - 45);

  if (BearingToCrash >= 315) and (BearingToCrash < 360)then
  begin

    if leftLmt < 0 then
    begin
      leftLmt := leftLmt + 360;
      straightLmt := straightLmt + 360;
    end;
  end

  else if (BearingToCrash >= 0) and (BearingToCrash <= 45)then

  begin

    if rightLmt >= 360 then
    begin
      rightLmt := rightLmt - 360;
      straightLmt := straightLmt - 360;
    end;
  end;

  if (BearingToCrash <= rightLmt) and (BearingToCrash >= straightLmt) then

  begin

//    degree := leftLmt;
//    section := 1 {hindar kiri}

  end

  else if (BearingToCrash >= leftLmt) and (BearingToCrash <= straightLmt) then

  begin
//    degree := rightLmt;
//    section := 2 {hindar kanan}
  end
  else
  begin
//    degree := ShipHeading;
//    section := 3 {jalan lurus}
  end;
end;
procedure CalcBearingToCollision(const x1, y1, x2, y2, ShipHeading: double; var degree: Double; var section : Integer);
var
  bearingFromShip,
  leftLmt, rightLmt, straightLmt : Double;
begin
  bearingFromShip := CalcBearing(x1, y1, x2, y2);

  straightLmt := ShipHeading;
  rightLmt := ValidateDegree(straightLmt + 45);
  leftLmt := ValidateDegree(straightLmt - 45);

  if (bearingFromShip >= 315) and (bearingFromShip < 360)then
  begin

    if leftLmt < 0 then
    begin
      leftLmt := leftLmt + 360;
      straightLmt := straightLmt + 360;
    end;
  end

  else if (bearingFromShip >= 0) and (bearingFromShip <= 45)then

  begin

    if rightLmt >= 360 then
    begin
      rightLmt := rightLmt - 360;
      straightLmt := straightLmt - 360;
    end;
  end;

  if (bearingFromShip <= rightLmt) and (bearingFromShip >= straightLmt) then

  begin

    degree := leftLmt;

    section := 1 {hindar kiri}

  end

  else if (bearingFromShip >= leftLmt) and (bearingFromShip <= straightLmt) then

  begin
    degree := rightLmt;
    section := 2 {hindar kanan}
  end
  else
  begin
    degree := ShipHeading;
    section := 3 {jalan lurus}
  end;
end;

procedure SplitDegreeMinuteSecond(const dd: double; var d, m, s: double);
var
  absLongLat: double;
  MinDet: double;
begin
  absLongLat := abs(dd);
  d := Trunc(absLongLat);
  MinDet := Frac(absLongLat) * 60.0;
  m := Trunc(MinDet);
  s := Frac(MinDet) * 60.0;
end;

procedure SplitDegreeMinute(const dd: double; var d, m: double);
var
  absLongLat: double;
  MinDet: double;
begin
  absLongLat := abs(dd);
  d := Trunc(absLongLat);
  MinDet := Frac(absLongLat) * 60.0;
  m := MinDet;
  {
  s := Frac(MinDet) * 60.0;
  }
end;

//==============================================================================

function formatDMS_long(const x: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(x);
  if absLongLat > 180.0 then absLongLat := 180.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('000', Degree) + '° ' +
    FormatFloat('00', Minute) + ''' ' +
    FormatFloat('00.0', second) + '" ';
  if x < 0 then
    Result := Result + 'W'
  else
    Result := Result + 'E'
end;

//==============================================================================

function formatDMS_latt(const y: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(y);
  if absLongLat > 90.0 then absLongLat := 90.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('00', Degree) + '° ' +
    FormatFloat('00', Minute) + ''' ' +
    FormatFloat('00.0', second) + '" ';

  if y < 0 then
    Result := Result + 'S'
  else
    Result := Result + 'N';
end;

function formatDM_longitude(const x: double): string;
var
  absLongLat: double;
  Degree, Minute: double;
begin
  absLongLat := abs(x);
  if absLongLat > 180.0 then absLongLat := 180.0;
  SplitDegreeMinute(absLongLat, Degree, Minute);

  Result := FormatFloat('000', Degree) + '° ' +
    FormatFloat('00.000', Minute) + ''' ' {+
    FormatFloat('00.0', second) + '" '};
  if x < 0 then
    Result := Result + 'W'
  else
    Result := Result + 'E'
end;

function formatDM_latitude(const y: double): string;
var
  absLongLat: double;
  Degree, Minute: double;
begin
  absLongLat := abs(y);
  if absLongLat > 90.0 then absLongLat := 90.0;
  SplitDegreeMinute(absLongLat, Degree, Minute);

  Result := FormatFloat('00', Degree) + '° ' +
    FormatFloat('00.000', Minute) + ''' ' {+
    FormatFloat('00.0', second) + '" '};

  if y < 0 then
    Result := Result + 'S'
  else
    Result := Result + 'N';
end;

function dmsToLong(const s: string): Double;
var
  d, m: Integer;
  sec: double;
  str: string;
begin
  Result := 0.0;
  if length(s) < 16 then exit;
    //    1234567890123456
    //    114° 57' 37.6" E

  str := Copy(s, 1, 3);
  d := ConvertStringToInt(str);

  str := Copy(s, 6, 2);
  M := ConvertStringToInt(str);

  str := Copy(s, 10, 4);
  sec := ConvertStringToFloat(str);

  result := d + (m / 60.0) + (sec / 3600.0);

  if s[16] = 'W' then
    result := -result;
end;

function dmsToLatt(const s: string): Double;
var
  d, m: Integer;
  sec: double;
  str: string;
begin
  Result := 0.0;

  if length(s) < 15 then exit;
    // 123456789012345
    // 07° 52' 34.2" S

  str := Copy(s, 1, 2);
  d := ConvertStringToInt(str);

  str := Copy(s, 5, 2);
  M := ConvertStringToInt(str);

  str := Copy(s, 9, 4);
  sec := ConvertStringToFloat(str);

  result := d + (m / 60.0) + (sec / 3600.0);

  if s[15] = 'S' then
    result := -result;

end;

function dmToLongitude(const s: string): Double;
var
  d: Integer;
  m : double;
  str: string;
begin
//  Result := 0.0;
  //if length(s) < 16 then exit;
    //    1234567890123456
    //    114° 57' 37.6" E
  //115° 03.229' E

  str := Copy(s, 1, 3);
  d := ConvertStringToInt(str);

  str := Copy(s, 6, 6);
  m := StrToFloat(str);
  {
  str := Copy(s, 10, 4);
  sec := ConvertStringToFloat(str);
  }
  result := d + (m / 60.0) {+ (sec / 3600.0)};

  if s[14] = 'W' then
    result := -result;
end;

function dmToLatitude(const s: string): Double;
var
  d: Integer;
  m : double;
  str: string;
begin
//  Result := 0.0;
  //if length(s) < 16 then exit;
    //    1234567890123456
    //    114° 57' 37.6" E
  //00° 08.093' S

  str := Copy(s, 1, 2);
  d := ConvertStringToInt(str);

  str := Copy(s, 5, 6);
  M := StrToFloat(str);
  {
  str := Copy(s, 10, 4);
  sec := ConvertStringToFloat(str);
  }
  result := d + (m / 60.0) {+ (sec / 3600.0)};

  if s[13] = 'S' then
    result := -result;
end;

//==============================================================================
function ValidateDegree(const degreeOrg: double): double;
begin
  result := degreeOrg - (Floor(degreeOrg / 360.0) * 360.0);
end;

//==============================================================================

// point dalam degree, ratDiff dalam meter
function ptBetween2Point(const ptC, ptFrom, ptTo : t2DPoint;ratDiff : double): boolean;
var
  ptLnDist, dist, dist1, dist2 : double;
begin
  result := false;

  ptLnDist := ptToLineDistance(ptFrom,ptTo,ptC);
  ptLnDist := ptLnDist * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;

  if ptLnDist <= ratDiff then begin
    dist  := CalcRange(ptFrom.X,ptFrom.Y,ptTo.X,ptTo.Y) * C_NauticalMile_To_Metre;
    dist1 := CalcRange(ptFrom.X,ptFrom.Y,ptC.X,ptC.Y)   * C_NauticalMile_To_Metre;
    dist2 := CalcRange(ptTo.X,ptto.Y,ptC.X,ptC.Y)       * C_NauticalMile_To_Metre;

    result := abs(dist - (dist1 + dist2)) <= 1;
  end;

end;

function ptToArc(const cent, pt: t2DPoint; r1, r2 : Double; sA, eA, id : Integer): Boolean;
var
  range, bearing,
  rin, rOut, SAngle, EAngle : Double;
begin
  Result := False;

  if r1 > r2 then
  begin
    rin := r2;  rOut := r1;
    r1 := rin;  r2 := rOut;
  end;

  {ditampung di variabel local dulu agar bisa diolah}
  SAngle := sA;
  EAngle := eA;

  range := CalcRange(cent.X, cent.Y, pt.X, pt.Y);
  bearing := CalcBearing(cent.X, cent.Y, pt.X, pt.Y);

  case id of
    0 : {dipake deteksi crash}
    begin
      if SAngle > EAngle then
      begin
        EAngle := EAngle + 360;

        if (bearing + 360) < 600 then
          bearing := bearing + 360;
      end;

      if (range <= r1) then
      begin
        if (SAngle <= bearing) and (bearing <= EAngle)  then
          Result := True;
      end;
    end;
    1 : {dipake select Arc overlay}
    begin
      if SAngle > EAngle then
      begin
        bearing := bearing + 360;
        EAngle := EAngle + 360;
      end;

      if range <= r1  then
      begin
        if (SAngle <= bearing) and (bearing <= EAngle)  then
          Result := True;
      end;
    end;
    2 : {dipake select Sector overlay}
    begin
      if SAngle > EAngle then
      begin
        bearing := bearing + 360;
        EAngle := EAngle + 360;
      end;

      if (range >= r1) and (range <= r2 ) then
      begin
        if (SAngle <= bearing) and (bearing <= EAngle)  then
          Result := True;
      end;
    end;
  end;
end;

function ptToCircle(const cent, pt: t2DPoint; r : Double): Boolean;
var
  range : Double;
begin
  Result := False;

  range := CalcRange(cent.X, cent.Y, pt.X, pt.Y);

  if range <= r then
    Result := True;

end;

function ptToArea(const rect : TRect ; pt: t2DPoint): Boolean;
begin
  Result := False;
  if ((pt.X >= rect.Left) AND (pt.X <= rect.Right)) then
  begin
    if ((pt.Y >= rect.Top) AND (pt.Y <= rect.Bottom)) then
    begin
      Result := True;
    end;
  end;
end;

function MapToArea(const rect : tOutSide ; pt: t2DPoint): Boolean;
begin
  Result := False;
  if ((pt.X >= rect.osL) or (pt.X <= rect.osR)) then
  begin
    if ((pt.Y >= rect.osB) or (pt.Y <= rect.osT)) then
    begin
      Result := True;
    end;
  end;
end;

function ptToLine(const ptFrom, ptTo, pt: t2DPoint): Boolean;
var
  dxGaris, dyGaris, dx, dy, dr : double;
  m, c: double;
begin
  Result := False;

  dxGaris := (ptTo.x - ptFrom.x);
  if dxGaris = 0 then //==||==> vertikal line
  begin
    if (abs(pt.x - ptFrom.x)) < 2 then
    begin
      if (ptTo.y - ptFrom.y) < 0 then
      begin
        if (ptTo.y < pt.y) and (pt.y < ptFrom.y) then
          Result := True;
      end
      else
      begin
        if (ptTo.y > pt.y) and (pt.y > ptFrom.y) then
          Result := True;
      end;
    end;
    exit;
  end;

  dyGaris := (ptTo.y - ptFrom.y);
  if dyGaris = 0 then //==__==> horizontal Line
  begin
    if (abs(pt.y - ptFrom.y)) < 2 then
    begin
      if (ptTo.x - ptFrom.x) < 0 then
      begin
        if (ptTo.x < pt.x) and (pt.x < ptFrom.x) then
          Result := True;
      end
      else
      begin
        if (ptTo.x > pt.x) and (pt.x > ptFrom.x) then
          Result := True;
      end;
    end;
    exit;
  end;

  {gradien oleh 2 titik}
  m := dyGaris / dxGaris;

  {constanta diketahui dari salah satu titik pd garis}
  c := ptFrom.y - (m * ptFrom.x);

  {pers garis lurus y = mx+c}
  dy := (m * pt.x + c) - pt.y;

  {pers garis lurus x = (y-c)/m}
  dx := ((pt.y - c) / m) - pt.x;

  dr := sqrt(dx * dx + dy * dy);

  if dr = 0 then
  begin
    Exit;
  end
  else
  begin
    if (abs(dx * dy / dr)) < 2 then
    begin
      if (ptTo.x - ptFrom.x) < 0 then
      begin
        if (ptTo.x < pt.x) and (pt.x < ptFrom.x) then
          Result := True;
      end
      else
      begin
        if (ptTo.x > pt.x) and (pt.x > ptFrom.x) then
          Result := True;
      end;
    end;
    exit;
  end;
end;

function ptToLineDistance(const ptFrom, ptTo, pt: t2DPoint): double;
var
  dxGaris, dyGaris, dx, dy, dr: double;
  m, c: double;
begin
  dxGaris := (ptTo.x - ptFrom.x);
  if dxGaris = 0 then begin //==||==> vertikal line
    result := abs(pt.x - ptFrom.x);
    exit;
  end;
  dyGaris := (ptTo.y - ptFrom.y);
  if dyGaris = 0 then begin //==__==> horizontal Line
    result := abs(pt.y - ptFrom.y);
    exit;
  end;
  try
    m := dyGaris / dxGaris;
    c := ptFrom.y - m * ptFrom.x;

      // pers garis lurus y = mx+c
    dy := (m * pt.x + c) - pt.y;

      // pers garis lurus   x = (y-c)/m
    if m <> 0 then
      dx := ((pt.y - c) / m) - pt.x   //mk
    else
      dx := ((pt.y - c) / 1) - pt.x;

    dr := sqrt(Abs(dx * dx + dy * dy));

    if dr <> 0 then                  //mk
      result := abs(dx * dy / dr)
    else
      result := abs(dx * dy / 1);
  except
    result := 1000;
  end;
end;

function FormatCourse(const d: double): string;
var
  i1, i2: Integer;
begin
  i1 := Trunc(Int(d)) mod 360;
  i2 := Trunc(Int(frac(d) * 10));
  result := Format('%3.3d.%1.1d', [i1, i2]);
end;

function FormatCourse(const d: single): string;
var
  i1, i2: Integer;
begin
  i1 := Floor(d) mod 360;
  i2 := Floor(frac(d) * 10);
  result := Format('%3.3d.%1.1d', [i1, i2]);
end;


function FormatSpeed(const d: double): string;
begin
  result := FormatFloat('00.0', abs(d));
end;

function FormatRange(const d: double): string;
begin
  result := FormatFloat('00.0', abs(d));
end;

function FormatTrackNumber(const i: integer): string;
begin
  result := format('%4d', [i]);
end;

function FormatAltitude(const s: single):string;
begin
  result := FormatFloat('0000',s);
end;

function FormatTurnRate(const d: double): string;             // added by mizuki
var
  degMin : double;
begin
  //degMin := d * 60;                   // (deg/s) -> (deg/min)
  degMin := 0;
  result := FormatFloat('0.00', degMin);
end;

function FormatAltitudeTrack(const s: single):string;
begin
  Result := FormatFloat('0000',s * C_Meter_To_Degree * C_Degree_To_Feet);
end;

procedure ConvDegree_To_UTM_and_MGRS(const latitude, longitude : Double; var resultUTM, resultMGRS : string);  // dng
var
  // =============== UTM ============= //
   a : Integer;
  lat, Long, longo, b, f, f1, rm, k0, e, e2, n, rho, nu, p  : Double;
  merA, merB, merC, merD, merE, merS : Double;
  K1, K2, K3, K4, K5 : Double;
  isNorting, isEasting : Boolean;
  AbsLatitude, AbsLongitude: Double;

  n1, n2, n3, n4, n5, T, C, A0 : Double ;
  Degree, Minute, Second: double;
  // ================ result ============== //
  Zona,EastingV,NortingV,ZonaLat : Double ;
  latzone,Hemisphere : string;

  //=============== MGRS ===============//
  aSet, blok, per100rblat, per1jtlongitude, blokdua, digitlong, jenisdigitlong : Integer;
  hasilHurufPertama, hasilhurufkedua : integer;
  PraHasilN,PraHasilE,HasilN,HasilE, Digraph1,Digraph2 : string;
begin

 // ======== UTM formula ======== //
//===step 1====
  if latitude < 0 then
    isNorting := false
  else
    isNorting := True;

  if longitude < 0 then
    isEasting := False
  else
    isEasting := True;

    AbsLongitude := Abs(longitude);
  if AbsLongitude > 180.0 then AbsLongitude := 180.0;
    SplitDegreeMinuteSecond(AbsLongitude, Degree, Minute, Second);

    Long := ((Degree) + (Minute) / 60 + (Second) / 3600) * 2 * PI / 360;


  AbsLatitude := Abs(latitude);
  if AbsLatitude > 90.0 then AbsLatitude := 90.0;
    SplitDegreeMinuteSecond(AbsLatitude, Degree, Minute, Second);

    lat := ((Degree) + (Minute) / 60 + (Second) / 3600) * 2 * PI / 360;

  If isNorting Then
    lat := lat
  Else
    lat := -1 * lat ;

  If isEasting Then
    long := long
  Else
    long := -1 * long ;



 //=====step 2====
  a := 6378137 ;
  b  := A - A / 298.2572 ;// 6356752.3142;
  f :=  1/298.257223563;
  f1 := 1/f;

  k0 := 0.9996;
  e := Sqrt(1-power(b,2)/ power(a,2));
  e2 := e * e / (1 - e * e);
  n := (a - b) / ( a + b);
  rho := (a * (1 - power(e,2))) / (power(( 1 - power((e * sin(lat)),2)),(3/2)));
  nu := a / (power(( 1 - power((e * sin(lat)),2)),(1/2)));

  //set hemisphere
  if isNorting = True then
  Hemisphere := 'N'
  else
  Hemisphere := 'S';

  //get zona
  if isEasting then
    Zona := Trunc((longitude / 6) + 31)
  else
    Zona := Trunc((180 + longitude) / 6) + 1;

  if isNorting then
    zonaLat := Trunc((latitude / 8) + 11)
  else
    ZonaLat := Trunc((80 + latitude) / 8) + 1;

  // get zona for utm and lat zone for mgrs
  if (ZonaLat > 6) and (ZonaLat <= 11)then
    latzone := Char(66 + Round(ZonaLat) + 1)
  else if (ZonaLat > 11) then
    latzone := Char(66 + Round(ZonaLat) + 2)
  else
    latzone := Char(66 + Round(ZonaLat));

  n1 := (A - b) / (A + b);
  n2 := n1 * n1;
  n3 := n2 * n1;
  n4 := n3 * n1;
  n5 := n4 * n1;

  longo := DegtoRad(((Zona - 1) * 6) - 180 + 3);

  p := long - longo;
  merA := A * (1 - n1 + (5 / 4) * (n2 - n3) + (81 / 64) * (n4 - n5));
  merB := (3 * A * n1 / 2) * (1 - n1 + (7 / 8) * (n2 - n3) + (55 / 64) * (n4 - n5));
  merC := (15 * A * n2 / 16) * (1 - n1 + (3 / 4) * (n2 - n3));
  merD := (35 * A * n3 / 48) * (1 - n1 + (11 / 16) * n2);
  merE := (315 * A * n4 / 512) * (1 - n1);

  merS := (merA * lat) - (merB * Sin(2 * lat)) + (merC * Sin(4 * lat)) - (merD * Sin(6 * lat)) + (merE * Sin(8 * lat));

  K1 := merS * k0;
  K2 := k0 * nu * sin(lat) * cos(lat)/2;
  K3 := (k0 * nu * sin(lat) * power(cos(lat),3) / 24) * (5 - power(tan(lat),2) + 9 * e2 * power(cos(lat),2) + 4 * power(e2,2)* power(cos(lat),4));
  k4 := k0 * nu * cos(lat);
  k5 := (k0 * nu * power(cos(lat),3) / 6) * (1 - power(tan(lat),2) + e2 * power(cos(lat),2));

   // get norting & easting

  EastingV :=  K1 + k2 * power(p,2) + K3 * power(p,4);    //
  NortingV := 500000 + (K4 * p + K5 * power(p,3));      //

  If lat < 0 Then
    EastingV := 10000000 + EastingV
  Else
    EastingV := EastingV ;

  // ========== MGRS ==========//
  // rubah ke string dulu
  PraHasilN := FloatToStr(Trunc(NortingV));
  PraHasilE := FloatToStr(Trunc(EastingV));
  // == ambil karakter tertentu untuk MGRS ==//
  // edt7.Text := FloatToStr(Zona);   // get long zone
  HasilN := Copy (PraHasilN,2,5); // get lat mgrs
  if (Length(PraHasilE) > 6) then // get long mgrs, but jika 7 digit(juta) / 6 digit(ratusan)
  begin
    HasilE := Copy (PraHasilE,3,5);
    digitlong := 7;  // panjang digit
  end
  else
  HasilE := Copy(PraHasilE,2,5);
  digitlong := 6;  // pannjang digit


  // == set div Digraph/huruf pertama ==//
  aSet := (Round(zona) mod 6);  //sisa pembagian yang dibagi 6
  if aSet = 0 then  // jika habis dibagi 6
  aSet := 6;  // maka termasuk zona 6

  blok := aSet mod 3;
  if blok = 0 then
  blok := 3;

  per100rblat := (Round(NortingV) div 100000) + (8*(blok-1));

  if ( per100rblat > 8) and ( per100rblat < 15 )then
    hasilHurufPertama := (per100rblat + 64 + 1)     // iki lek menyentuh huruf i
  else if ( per100rblat >= 15 ) then
    hasilHurufPertama := (per100rblat + 64 + 2)    // iki lek menyentuh huruf o
  else
    hasilHurufPertama := (per100rblat + 64); // iki asline

  Digraph1 := Char(hasilHurufPertama);        // === get digraph 1


// == set div Digraph/angka kedua == //

  if (aSet mod 2 = 0) then //jika blok 2 genap
    blokdua := 69
  else      // ganjil
    blokdua := 64;

  if digitlong = 6 then // deteksi jumlah digit
  jenisdigitlong := 100000   // 6 digit
  else
  jenisdigitlong := 1000000;  // 7 digit

  per1jtlongitude := ((Round(EastingV) mod 1000000) div 100000);//div jenisdigitlong);

  if EastingV > 1000000 then
  begin
    if (Round(EastingV) div 1000000) = 9 then
      per1jtlongitude := per1jtlongitude + 10;
  end;

  hasilhurufkedua := (per1jtlongitude + blokdua + 1);

  if blokdua = 69 then
  begin
    if ( per1jtlongitude > 2) and ( per1jtlongitude < 9 )then
      hasilhurufkedua := (hasilhurufkedua + 1)     // iki lek menyentuh huruf i
    else if ( per1jtlongitude >= 9 ) then
      hasilhurufkedua := (hasilhurufkedua + 2)    // iki lek menyentuh huruf o
    else
      hasilhurufkedua := hasilhurufkedua; // iki asline

  end
  else
  begin
    if ( per1jtlongitude > 7) and ( per1jtlongitude < 14 )then
      hasilhurufkedua := (hasilhurufkedua + 1)     // iki lek menyentuh huruf i
    else if ( per1jtlongitude >= 14 ) then
      hasilhurufkedua := (hasilhurufkedua + 2)    // iki lek menyentuh huruf o
    else
      hasilhurufkedua := hasilhurufkedua; // iki asline
  end;

  if hasilhurufkedua > 86 then
    hasilhurufkedua := hasilhurufkedua - 22;

    Digraph2 := char(hasilhurufkedua);       // get digraph 2


  //====  hasil konversi

  resultUTM  := FloatToStr(Round(Zona)) + Hemisphere +' '+ FormatFloat('0',NortingV) +' '+ FormatFloat('0',EastingV);//hasil UTM
  resultMGRS := FloatToStr(Round(Zona)) + latzone + Digraph1 + Digraph2 +  HasilN + HasilE ;
end;

function ConvDegree_To_Georef(B, L: Double): string;
var HrfSN: string[15];
  HrfWE: string[25];
  Bujur, Lintang, BM, LM: Integer;
  Hasil: string[9];
  //absLongLat, absLongLat1: double;
  //Degree, Minute, Second, Degree1, Minute1, Second1: double;
begin
  if (B < -180) or (B > 180) or (L > 90) or (L < -90) then
    hasil := 'N/A'
  else
  begin
    Hasil := '         ';
    HrfSN := 'ABCDEFGHJKLM';
    hrfWE := 'ABCDEFGHJKLMNPQRSTUVWXYZ';
    bujur := floor(B) + 180;
    BM := floor((B + 180 - bujur) * 60);
    hasil[1] := hrfWE[(bujur div 15) + 1];
    hasil[3] := HrfSN[(bujur mod 15) + 1];
    Hasil[5] := AnsiChar(inttostr(BM div 10)[1]);
    Hasil[6] := AnsiChar(inttostr(BM mod 10)[1]);
    Lintang := floor(L) + 90;
    LM := floor((L + 90 - Lintang) * 60);
    hasil[2] := hrfWE[(Lintang div 15) + 1];
    hasil[4] := HrfSN[(Lintang mod 15) + 1];
    Hasil[7] := AnsiChar(inttostr(LM div 10)[1]);
    Hasil[8] := AnsiChar(inttostr(LM mod 10)[1]);
    result := hasil;
  end;
end;

procedure ConvDegree_To_Karvak(x,y : Double; var horzPoint, vertPoint: string);
const
  horizontalPointDeft = '114° 04'''+' 55.3" E';
  verticalPointDeft = '07° 53'''+' 01.5" S';
var
  RangeHorz, RangeVert : Double;
  horz, vert : Double;
begin
  horz := dmsToLong(horizontalPointDeft);
  vert := dmsToLatt(verticalPointDeft);

  RangeHorz := CalcRange(horz, y, x, y);
  if horz > x then
    horzPoint := IntToStr(10 - Ceil(((Trunc(RangeHorz) mod 6) + Frac(RangeHorz)) / 0.6))
  else
    horzPoint := IntToStr(10 - Ceil(((Trunc(RangeHorz) mod 6) + Frac(RangeHorz)) / 0.6) - 1);

  RangeVert := CalcRange(x, vert, x, y);
  vertPoint := IntToStr(Ceil(((Trunc(RangeVert) mod 6) + Frac(RangeVert)) / 0.6) - 1);
end;

procedure StrToChar(Src : ansistring; var dest: array of AnsiChar);
begin
  FillChar(dest,sizeof(dest),0);
  copyMemory(@dest, @Src[1], Length(Src));
end;

procedure CopyArrayToStr(const src: array of AnsiChar; var dest: AnsiString);
var
  i:Integer;
begin
  dest := '';

  for i := 0 to Length(src) do
  begin
    if Ord(src[i]) <> 0 then
      dest := dest + src[i];

    if Ord(src[i]) = 0 then
      Break;
  end;
end;

function DSiGetWindowsVersion: TDSiWindowsVersion;
var
  versionInfo: TOSVersionInfo;
begin
  versionInfo.dwOSVersionInfoSize := SizeOf(versionInfo);
  GetVersionEx(versionInfo);
  Result := wvUnknown;
  case versionInfo.dwPlatformID of
    VER_PLATFORM_WIN32s: Result := wvWin31;
    VER_PLATFORM_WIN32_WINDOWS:
      case versionInfo.dwMinorVersion of
        0:
          if Trim(versionInfo.szCSDVersion[1]) = 'B' then
            Result := wvWin95OSR2
          else
            Result := wvWin95;
        10:
          if Trim(versionInfo.szCSDVersion[1]) = 'A' then
            Result := wvWin98SE
          else
            Result := wvWin98;
        90:
          if (versionInfo.dwBuildNumber = 73010104) then
             Result := wvWinME;
      else
        Result := wvWin9x;
      end; //case versionInfo.dwMinorVersion
    VER_PLATFORM_WIN32_NT:
      case versionInfo.dwMajorVersion of
        3: Result := wvWinNT3;
        4: Result := wvWinNT4;
        5:
          case versionInfo.dwMinorVersion of
            0: Result := wvWin2000;
            1: Result := wvWinXP;
            2: Result := wvWinServer2003;
          else
            Result := wvWinNT
          end; //case versionInfo.dwMinorVersion
        6: Result := wvWinVista;
      end; //case versionInfo.dwMajorVersion
  end; //versionInfo.dwPlatformID
end; { DSiGetWindowsVersion }

function DSiGetTrueWindowsVersion: TDSiWindowsVersion;

  function ExportsAPI(module: HMODULE; const apiName: string): boolean;
  begin
    Result := GetProcAddress(module, PChar(apiName)) <> nil;
  end; { ExportsAPI }

var
  hKernel32: HMODULE;

begin { DSiGetTrueWindowsVersion }
  hKernel32 := GetModuleHandle('kernel32');
  Win32Check(hKernel32 <> 0);
  if ExportsAPI(hKernel32, 'GetLocaleInfoEx') then
    Result := wvWinVista
  else if ExportsAPI(hKernel32, 'GetLargePageMinimum') then
    Result := wvWinServer2003
  else if ExportsAPI(hKernel32, 'GetNativeSystemInfo') then
    Result := wvWinXP
  else if ExportsAPI(hKernel32, 'ReplaceFile') then
    Result := wvWin2000
  else if ExportsAPI(hKernel32, 'OpenThread') then
    Result := wvWinME
  else if ExportsAPI(hKernel32, 'GetThreadPriorityBoost') then
    Result := wvWinNT4
  else if ExportsAPI(hKernel32, 'IsDebuggerPresent') then  //is also in NT4!
    Result := wvWin98
  else if ExportsAPI(hKernel32, 'GetDiskFreeSpaceEx') then  //is also in NT4!
    Result := wvWin95OSR2
  else if ExportsAPI(hKernel32, 'ConnectNamedPipe') then
    Result := wvWinNT3
  else if ExportsAPI(hKernel32, 'Beep') then
    Result := wvWin95
  else // we have no idea
    Result := DSiGetWindowsVersion;
end; { DSiGetTrueWindowsVersion }

function GetElevation(Speed , Range : Double):Double;
var
  alpha : Double;
  bagi : Double;
  arsin : Single;
  degree: Double;
begin
 bagi := (((range * C_NauticalMile_To_Metre)*C_Gravitasi)/(sqr(Speed * C_KNOTS_To_MS)));
 if bagi > 1 then Exit;

 arsin := ArcSin(bagi);
 alpha := (0.5 * arsin);
 degree := RadToDeg(alpha);
 Result := degree;
end;

//function SHA1FromString(const AString: string): string;
//var
//  SHA1: TIdHashSHA1;
//begin
//  SHA1 := TIdHashSHA1.Create;
//  try
//    Result := SHA1.HashStringAsHex(AString);
//  finally
//    SHA1.Free;
//  end;
//end;


function EncryptStr(const S :WideString; Key: Word): String;
var   i          :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
begin
  Result:= '';
  RStr:= UTF8Encode(S);
  for i := 0 to Length(RStr)-1 do begin
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;
  for i := 0 to Length(RStr)-1 do begin
    Result:= Result + IntToHex(RStrB[i], 2);
  end;
end;

function DecryptStr(const S: String; Key: Word): String;
var   i, tmpKey  :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
      tmpStr     :string;
begin
  tmpStr:= UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i:= 1;
  try
    while (i < Length(tmpStr)) do begin
      RStrB[i div 2]:= StrToInt('$' + tmpStr[i] + tmpStr[i+1]);
      Inc(i, 2);
    end;
  except
    Result:= '';
    Exit;
  end;
  for i := 0 to Length(RStr)-1 do begin
    tmpKey:= RStrB[i];
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;
  Result:= UTF8Decode(RStr);
end;

function Compare(List: TStringList; Index1, Index2: Integer): Integer;
begin
  if Length(List[Index1]) = Length(List[Index2]) then
    begin
      if List[Index1] = List[Index2] then
        result := 0
      else
        if List[Index1] > List[Index2] then
          result := -1
        else
          result := 1;
    end
  else
    if Length(List[Index1]) > Length(List[Index2]) then
      result := -1
    else
      result := 1;
end;

function BubbleSort( list: TStringList ): TStringList;
var
  i, j: Integer;
  temp: string;
  tempObj: TObject;
begin
  // bubble sort
  for i := 0 to list.Count - 1 do begin
    for j := 0 to ( list.Count - 1 ) - i do begin
      // Condition to handle i=0 & j = 9. j+1 tries to access x[10] which
      // is not there in zero based array
      if ( j + 1 = list.Count ) then
        continue;
      if ( StrToFloat(list.Strings[j]) < StrToFloat(list.Strings[j+1]) ) then begin
        temp              := list.Strings[j];
        tempObj           := list.Objects[j];

        list.Strings[j]   := list.Strings[j+1];
        list.Objects[j]   := list.Objects[j+1];

        list.Strings[j+1] := temp;
        list.Objects[j+1] := tempObj;
      end; // endif
    end; // endwhile
  end; // endwhile
  Result := list;
end;

function TimeToSecond(const aTimeStr: string; var aSecond: Integer): Boolean;
var
  hStr, mStr, sStr, hmSeparator, msSeparator : string;
  h, m, s, totalSecond : Integer;
begin
  Result := False;
  aSecond := 0;

  if Length(aTimeStr) <> 8 then
  begin
//    ShowMessage('Too Short / Too Long');
    Exit;
  end;

  hStr := Copy(aTimeStr, 1, 2);
  hmSeparator := Copy(aTimeStr, 3, 1);
  mStr := Copy(aTimeStr, 4, 2);
  msSeparator := Copy(aTimeStr, 6, 1);
  sStr := Copy(aTimeStr, 7, 2);

  if not (TryStrToInt(hStr, h) and (hmSeparator = ':') and
    TryStrToInt(mStr, m) and (msSeparator = ':') and TryStrToInt(sStr, s)) then
  begin
//    ShowMessage('Invalid format');
    Exit;
  end;

  if h > 23 then
  begin
//    ShowMessage('Invalid hour value');
    Exit;
  end;

  if m > 59 then
  begin
//    ShowMessage('Invalid minute value');
    Exit;
  end;

  if s > 59 then
  begin
//    ShowMessage('Invalid second value');
    Exit;
  end;

  Result := True;
  aSecond := (h * 3600) + (m * 60) + s;
end;

function SecondToTime(const aSecond: Integer; var aTimeStr: string): Boolean;
var
  h, m, s, totalSecond : Integer;
  hStr, mStr, sStr : string;
begin
  Result := False;
  aTimeStr := '00:00:00';

  totalSecond := aSecond;

  if (totalSecond > 86399) or (totalSecond < 0) then
  begin
    Exit;
  end;

  h := totalSecond div 3600;
  totalSecond := totalSecond mod 3600;
  m := totalSecond div 60;
  s := totalSecond mod 60;

  hStr := IntToStr(h);

  if Length(hStr) < 2 then
    hStr := '0' + hStr;

  mStr := IntToStr(m);

  if Length(mStr) < 2 then
    mStr := '0' + mStr;

  sStr := IntToStr(s);

  if Length(sStr) < 2 then
    sStr := '0' + sStr;

  Result := True;
  aTimeStr := hStr + ':' + mStr + ':' + sStr;
end;

end.

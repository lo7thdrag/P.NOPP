unit uCoordConvertor;

interface

uses
  Classes, MapXLib_TLB;

type

  TCoordConverter = class
  private
  public
    FMap: TMap;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertToScreen(dx, dy: double; var ix, iy: integer);
    procedure ConvertToMap(const ix, iy: integer; var dx, dy: double);

    function Distance_nmi(const x1, y1, x2, y2: double): double;
    function Distance_yard(const x1, y1, x2, y2: double): double;
    function Distance_meter(const x1, y1, x2, y2: double): double;
    function Distance_feet(const x1, y1, x2, y2: double): double;

    function ScreenDistance(x1, y1, r: double): integer;

  end;

  procedure degreeToRedGreen(const aDeg: double; var aDir: char; var aVal: double);

implementation

uses
  Math;
{ TConverter }

constructor TCoordConverter.Create;
begin

end;

destructor TCoordConverter.Destroy;
begin

  inherited;
end;

procedure TCoordConverter.ConvertToMap(const ix, iy: integer; var dx,
  dy: double);
var
  sx, sy: single;
begin
  sx := ix;
  sy := iy;
  FMap.ConvertCoord(sx, sy, dx, dy, miScreenToMap);
end;

procedure TCoordConverter.ConvertToScreen(dx, dy: double; var ix,
  iy: integer);
var
  sx, sy: single;
begin
  sx := 0;
  sy := 0;
  FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);
  ix := Round(sx);
  iy := Round(sy);
end;

{function TCoordConverter.Distance(const x1, y1, x2, y2: double): double;
begin
end;
}

function TCoordConverter.Distance_feet(const x1, y1, x2,
  y2: double): double;
var
  old: word;
begin
  old := FMap.MapUnit;
  FMap.MapUnit := miUnitFoot;
  result := Fmap.Distance(x1, y1, x2, y2);
  FMap.MapUnit := old;
end;

function TCoordConverter.Distance_meter(const x1, y1, x2,
  y2: double): double;
var
  old: word;
begin
  old := FMap.MapUnit;
  FMap.MapUnit := miUnitMeter;
  result := Fmap.Distance(x1, y1, x2, y2);
  FMap.MapUnit := old;
end;

function TCoordConverter.Distance_nmi(const x1, y1, x2,
  y2: double): double;
var
  old: word;
begin
  old := FMap.MapUnit;
  FMap.MapUnit := miUnitNauticalMile;
  result := Fmap.Distance(x1, y1, x2, y2);
  FMap.MapUnit := old;
end;

function TCoordConverter.Distance_yard(const x1, y1, x2,
  y2: double): double;
var
  old: word;
begin
  old := FMap.MapUnit;
  FMap.MapUnit := miUnitYard;
  result := Fmap.Distance(x1, y1, x2, y2);
  FMap.MapUnit := old;
end;

function TCoordConverter.ScreenDistance(x1, y1, r: double): integer;
var
  sx1, sy1, sx2, sy2: single;
  dx: double;
begin
  dx := x1 + r;
  FMap.ConvertCoord(sx1, sy1, x1, y1, miMapToScreen);
  FMap.ConvertCoord(sx2, sy2, dx, y1, miMapToScreen);
  Result := abs(Round(sx2 - sx1));

end;

procedure degreeToRedGreen(const aDeg: double; var aDir: char; var aVal: double);
var
  s, c: extended;
begin
  sinCos(DegToRad(aDeg), s, c);
  if s < 0 then
    aDir := 'R'
  else
    aDir := 'G';
  aVal := RadToDeg(ArcCos(abs(c)));
end;

end.

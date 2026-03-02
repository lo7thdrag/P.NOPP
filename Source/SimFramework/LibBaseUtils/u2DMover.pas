unit u2DMover;
{ simple n fast movement calculator
  by Andy Sucipto
  20 Agustus 2007

  catatan:
    speed = knots,
    X dan Y -> dalam degree longlat ;
}

interface

type

  T2DMover = class // 2 D mover
  private
    FEnabled: boolean;
    function GetDirection(): double;
    procedure SetDirection(const Value: double);

    function GetTurnRate: double;
    procedure SetTurnRate(const Value: double);

    function GetAcceleration: double;
    procedure SetAcceleration(const Value: double);

    function GetSpeed: double;
    procedure SetSpeed(const Value: double);

    function GetDeltaDir: double;
    procedure SetEnabled(const Value: boolean);

  protected
    FPosX, FPosY, FPosZ: double; // long lat;

    FAcceleration: double; // knots / second ??/
    FSpeed: double; // degree / ms

    FTurnRate: double; // Radians per second;

    FDirection: double; // 0 .. 2 Pi;
    FDeltaDir: double;

    FSinX, FCosX: extended;

  public
    constructor Create;

    procedure Calc_Speed(const aDt: double); // if accelerate
    procedure Calc_Direction(const aDt: double); // if turn
    procedure Calc_Movement(const aDt: double); //

    procedure Move(const aDt: double); // dt : millisecond;

  public
    property X: double read FPosX write FPosX; // asli longlat;
    property Y: double read FPosY write FPosY;
    property Z: double read FPosZ write FPosZ;

    property Acceleration: double
      read GetAcceleration write SetAcceleration;

    property Speed: double
      read GetSpeed write SetSpeed;

    property Direction: double // degree 0 .. 360 cartesian
      read GetDirection write SetDirection;

    property DeltaDirection: double // degree 0 .. 360 cartesian
      read GetDeltaDir;

    property TurnRate: double // degree per second;
      read GetTurnRate write SetTurnRate;

    property Enabled: boolean read FEnabled write SetEnabled;
  end;

implementation

uses Math;

const

  C_2_Pi: double = 2.0 * Pi;

  C_RadToDeg = 180.0 / Pi;
  C_DegToRad = Pi / 180.0;

  C_Degree_To_NauticalMile = 60.0;
  C_NauticalMile_To_Degree = 1.0 / 60.0;
  C_MilliSecondToHour: double = 0.001 / 3600.0;
  C_HourToMilliSecond: double = 3600000.0;

  C_MilliSecondToSecond: double = 0.001;
  C_SecondToMilliSecond: double = 1000.0;

function ValidateRange(const aVal, aMaxVal: double): double;
begin
  result := aVal - (Floor(aVal / aMaxVal) * aMaxVal);
end;

{ T2DMover }

constructor T2DMover.Create;
begin
  FEnabled := False;
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

function T2DMover.GetDirection(): double;
begin
  Result := C_RadToDeg * FDirection;

end;

procedure T2DMover.SetDirection(const Value: double);
begin
  FDirection := C_DegToRad * Value;
  SinCos(FDirection, FSinx, FCosX);
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

function T2DMover.GetTurnRate: double;
begin
  result := C_RadToDeg * C_SecondToMilliSecond * FTurnRate;
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

procedure T2DMover.SetTurnRate(const Value: double);
begin
  FTurnRate := C_DegToRad * C_MilliSecondToSecond * Value;
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

function T2DMover.GetAcceleration: double;
begin //knot per second ??.
  result := FAcceleration * C_Degree_To_NauticalMile
    * C_HourToMilliSecond * C_SecondToMilliSecond;

end;

procedure T2DMover.SetAcceleration(const Value: double);
begin
  FAcceleration := C_NauticalMile_To_Degree * Value /
    (C_HourToMilliSecond * C_SecondToMilliSecond)
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

function T2DMover.GetSpeed: double;
begin
  result := FSpeed * C_Degree_To_NauticalMile * C_HourToMilliSecond;

end;

procedure T2DMover.SetSpeed(const Value: double);
begin
  // value = knots, FSpeed = degree per millisecond;
  FSpeed := C_NauticalMile_To_Degree * Value * C_MilliSecondToHour;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure T2DMover.Calc_Speed(const aDt: double);
begin
  // speed : degree per millisecond;
  // aDt   : miilisecond;

  FSpeed := FSpeed + FAcceleration * aDt;
end;

procedure T2DMover.Calc_Direction(const aDt: double);
begin
  //Direction : cartesian degree, 0.. 2 Pi , 0 = east
  //FTurnRate : radian per milli second

  FDeltaDir := FTurnRate * aDt;
  FDirection := FDirection + FDeltaDir;
  FDirection := ValidateRange(FDirection, C_2_Pi);
  SinCos(FDirection, FSinX, FCosX);
end;

procedure T2DMover.Calc_Movement(const aDt: double);
var
  d, dx, dy: double;
begin
  // x := v . t;
  d := FSpeed * aDt;

  dx := d * FCosX;
  dy := d * FSinX;

  FPosX := FPosX + dx;
  FPosY := FPosY + dy;
end;

procedure T2DMover.Move(const aDt: double);
begin
  if not FEnabled then Exit;
  Calc_Speed(aDt);
  if ABS(FSpeed) > 0.00000001 then begin
    Calc_Direction(aDt);
    Calc_Movement(aDt);
  end;
end;

function T2DMover.GetDeltaDir: double;
begin
  result := C_RadToDeg * FDeltaDir;
end;

procedure T2DMover.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

end.

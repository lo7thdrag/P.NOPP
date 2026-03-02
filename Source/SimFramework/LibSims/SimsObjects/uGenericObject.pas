unit uGenericObject;

(*
  Base Class untuk object yg bergerak
*)

interface

uses
  uBaseSimObjects, u2DMover;

type

  TGenericObject = class(TBaseSimObject)
  private
    function getTurnRate: double;
  protected
    FMover  : T2DMover; // Engine mover
    FEnabled: boolean;

    procedure setEnabled(const Value: boolean); virtual;

    procedure SetHeading(const Value: double);
    function GetHeading: double;

    function GetSpeed: double; virtual;
    procedure SetSpeed(const Value: double); virtual;

    function GetPos(const Index: Integer): double;
    procedure SetPos(const Index: Integer; const Value: double);

    procedure SetTurnRate(const aTurnRate: double); virtual; // degree / second;
  public

    constructor Create;
    destructor Destroy; override;

    procedure Run(const aDeltaMs: double); virtual; abstract;
    procedure Update; virtual; abstract;

    property X: double index 0 // longlat degree
      read GetPos write SetPos;
    property Y: double index 1 // longlat degree
      read GetPos write SetPos;
    property Z: double index 2 // longlat degree NOT always zero
      read GetPos write SetPos;

    property Speed: double read GetSpeed write SetSpeed;
    property Heading: double read GetHeading write SetHeading;
    property TurnRate: double read getTurnRate write SetTurnRate;

    property Enabled: boolean read FEnabled write setEnabled;

  end;

implementation

uses
  uBaseCoordSystem;

{ TGenericObject }

constructor TGenericObject.Create;
begin

  FMover := T2DMover.Create;
  FMover.Direction := 90.0; // compas = 0.0
end;

destructor TGenericObject.Destroy;
begin

  FMover.Free;
  inherited;
end;

function TGenericObject.GetPos(const Index: Integer): double;
begin
  case Index of
    0: Result := FMover.X;
    1: Result := FMover.Y;
    2: Result := FMover.Z;
  else
    Result := 0;
  end
end;

procedure TGenericObject.SetPos(const Index: Integer; const Value: double);
begin
  case Index of
    0: FMover.X := Value;
    1: FMover.Y := Value;
    2: FMover.Z := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TGenericObject.SetHeading(const Value: double);
begin
  FMover.Direction := ConvCompass_To_Cartesian(Value);
end;

function TGenericObject.GetHeading: double;
begin
  result := ConvCartesian_To_Compass(FMover.Direction);
end;
//------------------------------------------------------------------------------

procedure TGenericObject.SetSpeed(const Value: double);
begin
  FMover.Speed := Value;
end;

function TGenericObject.GetSpeed: double;
begin
  result := FMover.Speed;
end;

procedure TGenericObject.SetTurnRate(const aTurnRate: double);
begin
//  FTurnRate   := abs(aTurnRate); // Degree per second;
  FMover.TurnRate := aTurnRate;
end;

function TGenericObject.getTurnRate: double;
begin
  result := FMover.TurnRate;
end;

procedure TGenericObject.setEnabled(const Value: boolean);
begin
  FEnabled := Value;
  FMover.Enabled := Value;
end;

end.

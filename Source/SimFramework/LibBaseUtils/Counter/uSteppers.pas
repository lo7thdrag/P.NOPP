unit uSteppers;

interface
uses
  Classes;

type

//==============================================================================
//  raise event setiap 'count' cycle
  TCycler = class
  private
    FOnCycle: TNotifyEvent;

  public
    index,
      Count: Word;
    Enabled: Boolean;

    constructor Create;

    procedure Run();
    property OnCycle: TNotifyEvent read FOnCycle write FOnCycle;
  end;

//==============================================================================
// raise event setiap
  TDelayer = class
  public
    DCounter : double;
    DInterval: double;
  private
    FOnTime: TNotifyEvent;
    FEnabled: Boolean;
    procedure setEnabled(const Value: Boolean);
  public

    constructor Create;
    destructor Destroy; override;

    procedure Run(const dt: double);
    property OnTime: TNotifyEvent read FOnTime write FOnTime;

    property Enabled: Boolean read FEnabled write setEnabled;

  end;

//==============================================================================
  TChangeState = (cstStable, cstIncreasing, cstDecreasing);

  TStepper = class
  private
    FChangeState: tChangeState;
    FValue: double;
    FIncRate: double;
    FDecRate: double;
    FChangeRate: double;

    FTargetValue: double;

    procedure setValue(const Value: double);
    procedure SetDecRate(const Value: double);
    procedure SetIncRate(const Value: double);
  public
    MinValue,
      MaxValue: double;

  public
    constructor Create;

    procedure Move(const aDT: double);
    procedure StepTo(const dTgt: double);

  public
    property Value: double read FValue write setValue;

    property IncRate: double read FIncRate write SetIncRate; // per second;
    property DecRate: double read FDecRate write SetDecRate; // per second;

    property TargetValue: double read FTargetValue;
    property ChangeState: tChangeState read FChangeState;
  end;

implementation

uses
  Math;

//==============================================================================
{ TCycler }

constructor TCycler.Create;
begin
  Index := 0;
  Count := 0;
  Enabled := TRUE;
end;

procedure TCycler.Run();
begin
  if not Enabled then exit;

  if (Count = 0) or (Index = 0) then begin
    if Assigned(FOnCycle) then FOnCycle(self);
  end;
  if Count > 0 then
    Index := (Index + 1) mod Count;
end;

//==============================================================================
{ TDelayer }

constructor TDelayer.Create;
begin
  Enabled := False;
  DCounter := 0.0;
  DInterval := 1000.0;
  FOnTime := nil;
end;

destructor TDelayer.Destroy;
begin
  FOnTime := nil;
  inherited;
end;

procedure TDelayer.Run(const dt: double);
begin
  if not Enabled then exit;
  DCounter := DCounter + dt;

  if DCounter > DInterval then begin
    DCounter := DCounter - DInterval;
    if Assigned(FOnTime) then FOnTime(self);
  end;

end;

procedure TDelayer.setEnabled(const Value: Boolean);
begin
  DCounter := 0.0;
  FEnabled := Value;
end;

//==============================================================================
{ TStepper }

constructor TStepper.Create;
begin
  MinValue := -20.0;
  MaxValue := 30.0;
  FValue := 0.0;
  FTargetValue := 0.0;

  FIncRate := 3.0;
  FDecRate := 2.0;

  FChangeState := cstStable;
end;

procedure TStepper.setValue(const Value: double);
begin
  FValue := EnsureRange(Value, MinValue, MaxValue);
end;

procedure TStepper.SetDecRate(const Value: double);
begin
  FDecRate := EnsureRange(Value, 0.0, MaxDouble);
end;

procedure TStepper.SetIncRate(const Value: double);
begin
  FIncRate := EnsureRange(Value, 0.0, MaxDouble);
end;

procedure TStepper.Move(const aDt: double);
begin
  if FChangeState <> cstStable then begin
    FValue := FValue + (0.001 * aDt * FChangeRate);

    if FChangeState = cstIncreasing then begin
      if (FValue > FTargetValue)
        or (FValue > MaxValue) then begin
        FChangeState := cstStable;
        FValue := FTargetValue;
        FChangeRate := 0.0;
      end;
    end
    else if FChangeState = cstDecreasing then begin
      if (FValue < FTargetValue)
        or (FValue < MinValue) then begin
        FChangeState := cstStable;
        FValue := FTargetValue;
        FChangeRate := 0.0;
      end;
    end;
  end;
end;

procedure TStepper.StepTo(const dTgt: double);
const
  CMin_Epsilon = 0.000001;
begin
  FTargetValue := EnsureRange(dTgt, MinValue, MaxValue);

  if abs(Value - FTargetValue) < CMin_Epsilon then begin
    FChangeState := cstStable;
    Value := FTargetValue;
    FChangeRate := 0;
  end
  else if FTargetValue > Value then begin
      FChangeState := cstIncreasing;
      FChangeRate := IncRate;
    end
    else begin
      FChangeState := cstDecreasing;
      FChangeRate := -DecRate;
    end;

end;

end.

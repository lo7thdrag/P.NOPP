unit uThreadTimer;

interface

uses
  Classes, Windows;

type

//==============================================================================
  TRunningEvent = procedure(const dt: double) of object;

  TMSTimer = class(TThread)
  private
    FLastPerfCount,
      FPerfFreq: Int64;

    function GetEnabled: boolean;
    procedure SetEnabled(const Value: boolean);

  protected
    FInterval: Word; // millisecond;
    FOnTimer: TNotifyEvent;
    FOnRunning: TRunningEvent;

    procedure SetInterval(const Value: Word);  // millisecond

    procedure Execute; override;
    procedure DoByMySelf; virtual;

  public
    constructor Create;
    destructor Destroy; override;

  public

    property OnRunning: TRunningEvent read FOnRunning write FOnRunning;
    property Interval: Word read FInterval write SetInterval; //millisecond

    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;

    property Enabled: boolean read GetEnabled write SetEnabled;

  end;

  TZTimer = class(TMSTimer)
  protected
    procedure Execute; override;
  end;


implementation



//==============================================================================
{ TMSTimer }

constructor TMSTimer.Create;
begin

//  timeBeginPeriod(10);
  FInterval := 20;

  QueryPerformanceFrequency(FPerfFreq);
  QueryPerformanceCounter(FLastPerfCount);

  inherited Create(TRUE);
end;

destructor TMSTimer.Destroy;
begin
  FOnTimer := nil;
  FOnRunning := nil;

//  timeEndPeriod(10);
  inherited;
end;

procedure TMSTimer.DoByMySelf;
var
  Count: Int64;
  Sec: double;
begin
  QueryPerformanceCounter(Count);
  Sec := (Count - FLastPerfCount) / FPerfFreq;
  FLastPerfCount := Count;
  if Assigned(FOnRunning) then begin
    FOnRunning(Sec); // detik.
  end;
end;

procedure TMSTimer.Execute;
begin
  while not Terminated do begin

    Synchronize(DoByMySelf);

    Sleep(FInterval);
  end;
end;

procedure TMSTimer.SetInterval(const Value: Word);
begin
  FInterval := Value;
end;

function TMSTimer.GetEnabled: boolean;
begin
  result := not Suspended;
end;

procedure TMSTimer.SetEnabled(const Value: boolean);
begin
  if Value <> Suspended then
    Exit;

  Suspended := not Value;

  if Value then
    QueryPerformanceCounter(FLastPerfCount);
end;

{ TZTimer }

procedure TZTimer.Execute;
begin
  while not Terminated do begin
    DoByMySelf;

    Sleep(FInterval);
  end;

end;

end.

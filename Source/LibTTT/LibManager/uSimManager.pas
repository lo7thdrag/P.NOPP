unit uSimManager;

interface

uses

  uThreadTimer, uVirtualTime, uSimContainers;

type

//==============================================================================
  TGamePlayState = (gsStop, gsPlaying, gsTerminated );

  TSimManager = class
  protected
    FGameThread   : TMSTimer;

    FMainVTime    : TVirtualTime;
    FGameSpeed    : double;
    FGameState    : TGamePlayState;

    FNetworkThread     : TMSTimer;
    FNetworkThreadTemp : TMSTimer;

  private

  protected
    function GetGameTime: TDateTime;
    function getGameSpeed: double;
    function getGameState: boolean;
    procedure setGameSpeed(const Value: double); virtual;

  public
    constructor Create;
    destructor Destroy; override;

    procedure GameStart; virtual;
    procedure GamePause; virtual;
    procedure GameTerminate; virtual;

    property GameTIME: TDateTime read GetGameTime;
    property GameIsRunning: boolean read getGameState;
    property GameState: TGamePlayState read FGameState;
    property MainVTime: TVirtualTime read FMainVTime;

  end;

implementation

uses
 SysUtils;
{ TSimManager }

constructor TSimManager.Create;
begin
  FGameState    := gsStop;

  FMainVTime    := TVirtualTime.Create;
  FGameSpeed    := 0.0;
  FGameThread   := TMSTimer.Create;

  FNetworkThread := TMSTimer.Create;
  FNetworkThread.Interval := 2;

  FNetworkThreadTemp := nil;
end;

destructor TSimManager.Destroy;
begin
  if Assigned(FNetworkThreadTemp) then
  begin
    FNetworkThreadTemp.Enabled := False;
    FNetworkThreadTemp.OnRunning := nil;
    FNetworkThreadTemp.Free;
  end;

  FNetworkThread.Enabled := False;
  FNetworkThread.OnRunning := nil;
  FNetworkThread.Free;

  FGameState    := gsStop;

  FGameThread.OnRunning := nil;
  FGameThread.Free;

  FMainVTime.Free;

  inherited;
end;

procedure TSimManager.GamePause;
begin
  FGameState    := gsStop;
end;

procedure TSimManager.GameStart;
begin
  FGameState    := gsPlaying;
end;

procedure TSimManager.GameTerminate;
begin
  FGameState    := gsTerminated;
end;

function TSimManager.GetGameTime: TDateTime;
begin
  inherited;
  result := FMainVTime.GetTime;
end;

function TSimManager.getGameSpeed: double;
begin
  result := FGameSpeed;
end;

function TSimManager.getGameState: boolean;
begin
  result := FGameState = gsPlaying;
end;

procedure TSimManager.setGameSpeed(const Value: double);
begin
  FGameSpeed := Value;
end;

end.

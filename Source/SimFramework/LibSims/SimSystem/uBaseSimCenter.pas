unit uBaseSimCenter;

(*  andySu, 2008 11 06
*)

interface

uses

  Classes,
  uThreadTimer, uVirtualTime,
  uSimContainers;

type

//==============================================================================

  TBaseSimCenter = class
  private
    function getVTime: TDateTime;

  protected
    MainThread: TMSTimer;
    MainList  : TSimContainer;
    MainVTime : TVirtualTime;
    StatusStarted: boolean;

    procedure EventOnMainTimer(const dt: double); virtual;
  public

    constructor Create;
    destructor Destroy; override;

    procedure PlayGame; virtual;
    procedure StopGame; virtual;
    procedure ResumeGame; virtual;

    function GetList: TList;
    procedure ReturnList;

  public
    property VirtualTime: TDateTime read getVTime;

  end;


var
  SimCenter: TBaseSimCenter;

implementation

uses SysUtils;


{ TBaseSimCenter }

constructor TBaseSimCenter.Create;
begin
  StatusStarted := false;

  MainThread := TMSTimer.Create;
  MainThread.OnRunning := EventOnMainTimer;

  MainList := TSimContainer.Create;
  MainVTime := TVirtualTime.Create;

end;

destructor TBaseSimCenter.Destroy;
begin
  MainVTime.Free;
  MainList.Free;

  MainThread.OnRunning := nil;
  MainThread.Free;

  inherited;
end;

procedure TBaseSimCenter.EventOnMainTimer(const dt: double);
begin
  MainVTime.IncreaseMillisecond(dt);

end;

procedure TBaseSimCenter.PlayGame;
begin
  if StatusStarted then
    ResumeGame
  else begin
    StatusStarted := true;
    MainThread.Enabled := True;
  end;

end;

procedure TBaseSimCenter.ResumeGame;
begin
  MainThread.Enabled := True;

end;

procedure TBaseSimCenter.StopGame;
begin
  MainThread.Enabled := False;

end;

function TBaseSimCenter.GetList: TList;
begin
  result := MainList.GetList;

end;

procedure TBaseSimCenter.ReturnList;
begin
  MainList.ReturnList;

end;

function TBaseSimCenter.getVTime: TDateTime;
begin
  Result := MainVTime.GetTime;

end;

end.

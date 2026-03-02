unit uVirtualTime;

interface

uses
  SysUtils, DateUtils;

type

//==============================================================================

  TVirtualTime = class
  protected
    FMsCounter: double;
    FMilliSecond: LongWord;
    FDateTimeOffset: TDateTime;

  public
    constructor Create;
    destructor Destroy; override;

    procedure IncreaseMillisecond(const aMs: double);

    procedure Reset(const aMs: double = 0.0);

    function GetTime: TDateTime;
    function GetMillisecond: LongWord;
    procedure SetMilliSecond(const aMs: LongWord);

    property DateTimeOffset: TDateTime read FDateTimeOffset write FDateTimeOffset;
  end;

  function MillisecToDateTime(const msAll): TDateTime;
  function MillisecToDateTime2(const msMS :LongWord ): TDateTime;

implementation

//==============================================================================
{ TVirtualTime }

constructor TVirtualTime.Create;
begin
  FDateTimeOffset := Now;
  FMilliSecond := 0;
  FMsCounter := 0.0;
end;

destructor TVirtualTime.Destroy;
begin

  inherited;
end;

function TVirtualTime.GetMillisecond: LongWord;
begin
  result := FMilliSecond;
end;

procedure TVirtualTime.SetMilliSecond(const aMs: LongWord);
begin
  FMscounter := aMs;
  FMilliSecond := aMs;
end;

function TVirtualTime.GetTime: TDateTime;
var
  detik: Cardinal;
begin
  detik := FMilliSecond div 1000;
  result := IncSecond(FDateTimeOffset,detik);
end;

procedure TVirtualTime.IncreaseMillisecond(const aMs: double);
begin
  FMscounter := FMscounter + aMs;
  FMilliSecond := Round(FMscounter);
end;

procedure TVirtualTime.Reset(const aMs: double = 0.0);
begin
  FMscounter := aMs;
  FMilliSecond := Round(FMscounter);
end;

function MillisecToDateTime(const msAll): TDateTime;
var
  //dt: TDateTime;
  ms, s, n, h: word;
  ns, detik: Cardinal;
begin
  //VirtualTick in millisecond;
  ms := 0; //sementara
  detik := ms div 1000;
  ms    := ms mod 1000;
  s     := detik mod 60;
  ns    := detik div 60;
  n     := ns mod 60;
  ns    := ns div 60;
  h     := ns mod 24;

  result := EncodeTime(h, n, s, ms);
end;

function MillisecToDateTime2(const msMS :LongWord ): TDateTime;
var
  dt: TDateTime;
  ms, s, n, h: word;
  ns, detik: Cardinal;
begin
  //VirtualTick in millisecond;
  detik := msMS div 1000;
  ms    := msMS mod 1000;
  s     := detik mod 60;
  ns    := detik div 60;
  n     := ns mod 60;
  ns    := ns div 60;
  h     := ns mod 24;

  dt := EncodeTime(h, n, s, ms);

  result := dt;
end;


end.

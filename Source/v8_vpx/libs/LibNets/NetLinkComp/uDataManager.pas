unit uDataManager;

interface

uses
  System.Classes,
  System.SysUtils,
  uDataType;

// -----------------------------------------------------------------------------

type

  TPacketHandlerProc = procedure(AHeader: TPacketInfo; AContent: TBytes) of object;

  TPacketRec = record
    recName: string;
    theProc: TPacketHandlerProc;
  end;

  TPacketArray = TArray<TPacketRec>;

  // -----------------------------------------------------------------------------
  TPacketManager = class
  private
    function GetHandler(index: integer): TPacketRec;
    function GetHandlerCount: integer;

  protected
    FRegProcs: TPacketArray;
    FRegProcSize: Word;

  public
    constructor Create;
    destructor Destroy; override;

    function IsRegistered(const id: Word): Boolean;
    function IsHandled(const id: Word): Boolean;

    procedure UnregisterAll;

    procedure Register(const aType: Word;
      aProcedure: TPacketHandlerProc; const aRecName: string = '');

    procedure UnRegister(const aType: Word);

    property Handler[index: integer]: TPacketRec
      read GetHandler; default;
    property HandlerCount: integer read GetHandlerCount;

  end;

implementation

// -----------------------------------------------------------------------------

{ TPacketManager }

constructor TPacketManager.Create;
begin
  FRegProcSize := 0;
  SetLength(FRegProcs, 0);
end;

destructor TPacketManager.Destroy;
begin
  UnregisterALL; //

  FRegProcSize := 0;
  SetLength(FRegProcs, 0);
end;

function TPacketManager.GetHandler(index: integer): TPacketRec;
begin
  if IsRegistered(index) then
    Result := FRegProcs[index];
end;

function TPacketManager.GetHandlerCount: integer;
begin
  Result := FRegProcSize;
end;

// -----------------------------------------------------------------------------

function TPacketManager.IsRegistered(const id: Word): Boolean;
begin
  Result := (id < FRegProcSize);
end;

function TPacketManager.IsHandled(const id: Word): Boolean;
begin
  Result := (id < FRegProcSize) and Assigned(FRegProcs[id].theProc);
end;

procedure TPacketManager.UnregisterALL;
var
  i: integer;
begin
  for i := FRegProcSize - 1 downto 0 do
  begin
    FRegProcs[i].theProc := nil;
    FRegProcs[i].recName := '';
  end;

  FRegProcSize := 0;
  SetLength(FRegProcs, 0);
end;

procedure TPacketManager.Register(const aType: Word;
  aProcedure: TPacketHandlerProc; const aRecName: string = '');
var
  i: integer;
begin
  if aType >= FRegProcSize then
  begin
    SetLength(FRegProcs, aType + 1);

    for i := FRegProcSize to aType - 1 do
    begin
      FRegProcs[i].theProc := nil;
      FRegProcs[i].recName := '';
    end;
    FRegProcSize := aType + 1;

  end;
  FRegProcs[aType].theProc := aProcedure;

  if aRecName = '' then
    FRegProcs[aType].recName := 'REC' + IntToStr(aType);
end;

procedure TPacketManager.UnRegister(const aType: Word);
begin
  FRegProcs[aType].theProc := nil;
  FRegProcs[aType].recName := '';
end;

end.

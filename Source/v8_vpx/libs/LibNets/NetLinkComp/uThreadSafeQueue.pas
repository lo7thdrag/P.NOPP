unit uThreadSafeQueue;

interface

uses
  System.SysUtils,
  System.SyncObjs,
  UDataType;

type
  PQueueNode = ^TQueueNode;

  TQueueNode = record
    Info: TPacketInfo;
    Data: TBytes;
    Next: PQueueNode;
    Prev: PQueueNode;
  end;

  TThreadSafeQueue = class
  private
    FCount: Integer;
    FHead: PQueueNode;
    FTail: PQueueNode;
    FCriticalSection: TCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Enqueue(AInfo: TPacketInfo; AData: TBytes);
    function Dequeue(var AInfo: TPacketInfo; var AData: TBytes): Boolean;
    function IsEmpty: Boolean;
    procedure Clear;

    property Count: Integer read FCount;
  end;

implementation

constructor TThreadSafeQueue.Create;
begin
  inherited;
  FCount:= 0;
  FCriticalSection:= TCriticalSection.Create;
end;

destructor TThreadSafeQueue.Destroy;
begin
  Clear;
  FCriticalSection.DisposeOf;
  inherited;
end;

procedure TThreadSafeQueue.Clear;
var
  AInfo: TPacketInfo;
  AValue: TBytes;
begin
  while not IsEmpty do
    Dequeue(AInfo, AValue);
end;

procedure TThreadSafeQueue.Enqueue(AInfo: TPacketInfo; AData: TBytes);
var
  NewTail: PQueueNode;
begin
  FCriticalSection.Enter;
  try
    New(NewTail);
    NewTail.Info:= AInfo;
    NewTail.Data:= AData;
    NewTail.Next:= nil;
    if FTail <> nil then
    begin
      FTail.Next:= NewTail;
      NewTail.Prev:= FTail;
    end
    else
      FHead:= NewTail;
    FTail:= NewTail;
    FCount:= FCount + 1;
  finally
    FCriticalSection.Leave;
  end;
end;

function TThreadSafeQueue.Dequeue(var AInfo: TPacketInfo; var AData: TBytes): Boolean;
var
  OldHead: PQueueNode;
begin
  Result:= False;
  if IsEmpty then
    Exit;
  FCriticalSection.Enter;
  try
    OldHead:= FHead;
    FHead:= OldHead.Next;
    if FHead <> nil then
      FHead.Prev:= nil
    else
      FTail:= nil;

    AInfo:= OldHead.Info;
    AData:= OldHead.Data;
    Dispose(OldHead);
    FCount:= FCount - 1;
    Result:= True;
  finally
    FCriticalSection.Leave;
  end;
end;

function TThreadSafeQueue.IsEmpty: Boolean;
begin
  FCriticalSection.Enter;
  try
    Result:= FHead = nil;
  finally
    FCriticalSection.Leave;
  end;
end;

end.

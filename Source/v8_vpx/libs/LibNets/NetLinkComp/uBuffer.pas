unit uBuffer;

interface

uses
  System.Classes,
  System.SysUtils,

  uDataType,
  uDataManager,
  uThreadSafeQueue,
  UPacketHelper;

type
  TDataQueue = class
  private
    //pLocBuff: PAnsiChar;
    FQueue: TThreadSafeQueue;
    FRegProcs: TPacketManager;
    FLogStat: TGetStrProc;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    // procedure PutPacket(aP: PAnsiChar; const aSize: integer;
    // const ipSender: string);
    //
    procedure PutPacket(AInfo: TPacketInfo; AData: TBytes);

    procedure PacketRecognizer(AInfo: TPacketInfo; AData: TBytes);

    // function GetPacket(): Boolean;
    function GetPacket: Boolean;

    property RegProcs: TPacketManager read FRegProcs write FRegProcs;
    property LogStat: TGetStrProc read FLogStat write FLogStat;
  end;

implementation

uses
// Windows;
  DateUtils;

{ TDataQueue }

constructor TDataQueue.Create;
begin
  FQueue := TThreadSafeQueue.Create;
end;

destructor TDataQueue.Destroy;
begin
  FQueue.DisposeOf;
  inherited;
end;

procedure TDataQueue.Clear;
begin
  FQueue.Clear
end;

function TDataQueue.GetPacket: Boolean;
var
  AInfo: TPacketInfo;
  AData: TBytes;
begin
  Result:= False;
  if FQueue.IsEmpty then
    Exit;

//  if Assigned(FLogStat) then
//    FLogStat(TimeToString + ' : Queue Size Before Dequeue = ' + IntToStr(FQueue.Count));

  //Data:= FQueue.Dequeue;
//  if Data<>nil then
  if FQueue.Dequeue(AInfo, AData) then
  begin
//    if Assigned(FLogStat) then
//      FLogStat(TimeToString + ' : Queue Size After Dequeue = ' + IntToStr(FQueue.Count));
    PacketRecognizer(AInfo, AData);
    Result:= True;
  end;
end;

procedure TDataQueue.PacketRecognizer(AInfo: TPacketInfo; AData: TBytes);
begin
  if FRegProcs.IsHandled(AInfo.DataID) then
  begin
    if Assigned(FLogStat) then
      FLogStat(TimeToString + ': Data ' + FRegProcs[AInfo.DataID].recName);
    FRegProcs[AInfo.DataID].theProc(AInfo, AData);
  end
  else
  begin
    if Assigned(FLogStat) then
      FLogStat(TimeToString + ': ' + 'UnRegistered ID ' + IntToStr(AInfo.DataID));
  end;
end;

procedure TDataQueue.PutPacket(AInfo: TPacketInfo; AData: TBytes);
begin
//  if Length(AData)<=0 then
//    Exit;

//  if Assigned(FLogStat) then
//      FLogStat(TimeToString + ' : Queue Size Before = ' + IntToStr(FQueue.Count));

  FQueue.Enqueue(AInfo, aData);

//  if FQueue.Count > 0 then
//  begin
//    if Assigned(FLogStat) then
//      FLogStat(TimeToString + ' : Queue Size After = ' + IntToStr(FQueue.Count));
//  end;

end;

end.

unit UPacketProtocol;

interface

uses
  System.SysUtils,
  System.Math;

type
  TBitConverter = class
  private
  public
    class function FromInt32(AValue: Integer): TBytes;
    class function ToInt32(Bytes: TBytes; Index: Integer): Integer;
  end;

  TMessageArrivedProc = procedure(const ABytes: TBytes) of object;

  TPacketProtocol = class
  private
    FLengthBuffer: TBytes;
    FDataBuffer: TBytes;
    FBytesReceived: Integer;
    FMaxMessageSize: Integer;
    FMessageArrived: TMessageArrivedProc;
    procedure ReadCompleted(Count: Integer);
  public
    constructor Create(MaxMessageSize: Integer);
    destructor Destroy; override;
    class function WrapMessage(AMessage: TBytes): TBytes;
    class function WrapKeepaliveMessage: TBytes;
    procedure DataReceived(const Data: TBytes);
    property MessageArrived: TMessageArrivedProc read FMessageArrived
      write FMessageArrived;
  end;

implementation

{ TBitConverter }

class function TBitConverter.FromInt32(AValue: Integer): TBytes;
begin
  SetLength(Result, SizeOf(AValue));
  Move(AValue, Result[0], SizeOf(AValue));
end;

class function TBitConverter.ToInt32(Bytes: TBytes; Index: Integer): Integer;
begin
  Move(Bytes[0], Result, Length(Bytes));
end;

{ TPacketProtocol }

class function TPacketProtocol.WrapMessage(AMessage: TBytes): TBytes;
var
  MessageLength: Integer;
  PrefixLengthBytes: TBytes;
var
  PrefixLength: Integer;
begin
  MessageLength := Length(AMessage);
  if MessageLength <= 0 then
  begin
    SetLength(Result, 0);
    Exit
  end;
  PrefixLengthBytes := TBitConverter.FromInt32(MessageLength);
  PrefixLength := Length(PrefixLengthBytes);
  SetLength(Result, PrefixLength + MessageLength);
  Move(PrefixLengthBytes[0], Result[0], PrefixLength);
  Move(AMessage[0], Result[PrefixLength], MessageLength);
end;

class function TPacketProtocol.WrapKeepaliveMessage: TBytes;
var
  MessageBytes: TBytes;
begin
  MessageBytes := TBitConverter.FromInt32(0);
  SetLength(Result, SizeOf(MessageBytes));
  Move(MessageBytes[0], Result[0], SizeOf(MessageBytes));
end;

constructor TPacketProtocol.Create(MaxMessageSize: Integer);
begin
  SetLength(FLengthBuffer, SizeOf(Integer));
  SetLength(FDataBuffer, 0);
  FMaxMessageSize := MaxMessageSize;
  FBytesReceived:= 0;
  FMessageArrived := nil;
end;

destructor TPacketProtocol.Destroy;
begin
  SetLength(FLengthBuffer, 0);
  SetLength(FDataBuffer, 0);
  inherited;
end;

procedure TPacketProtocol.DataReceived(const Data: TBytes);
var
  i: Integer;
  DataLength: Integer;
  bytesAvailable: Integer;
  bytesRequested: Integer;
  bytesTransferred: Integer;
begin
  i:= 0;
  DataLength:= Length(Data);
  while i <> DataLength do
  begin
    bytesAvailable:= DataLength - i;
    if Length(FDataBuffer) <> 0 then
    begin
      bytesRequested:= Length(FDataBuffer) - FBytesReceived;
      bytesTransferred:= Min(bytesRequested, bytesAvailable);
      Move(Data[i], FDataBuffer[FBytesReceived], bytesTransferred);
      i := i + bytesTransferred;

      ReadCompleted(bytesTransferred);
    end
    else
    begin
      bytesRequested:= Length(FLengthBuffer) - FBytesReceived;
      bytesTransferred:= Min(bytesRequested, bytesAvailable);
      Move(Data[i], FLengthBuffer[FBytesReceived], bytesTransferred);
      i := i + bytesTransferred;

      ReadCompleted(bytesTransferred);
    end;
  end;
end;

procedure TPacketProtocol.ReadCompleted(Count: Integer);
var
  len: Integer;
  m: TBytes;
begin
  FBytesReceived := FBytesReceived + Count;
  if Length(FDataBuffer) = 0 then
  begin
    if FBytesReceived <> SizeOf(Integer) then
    begin

    end
    else
    begin
      len:= TBitConverter.ToInt32(FLengthBuffer, 0);

      if len < 0 then
        raise Exception.Create('Message length is less than zero');

      if (FMaxMessageSize > 0) and (len > FMaxMessageSize) then
        raise Exception.Create('Message length ' + len.ToString +
          ' is larger than maximum message size ' + FMaxMessageSize.ToString);

      if len = 0 then
      begin
        FBytesReceived := 0;
        if Assigned(FMessageArrived) then
        begin
          SetLength(m, 0);
          MessageArrived(m);
        end;
      end
      else
      begin
        SetLength(FDataBuffer, len);
        FBytesReceived := 0;
      end
    end;
  end
  else
  begin
    if FBytesReceived <> Length(FDataBuffer) then
    begin

    end
    else
    begin
      if Assigned(FMessageArrived) then
        FMessageArrived(FDataBuffer);

      SetLength(FDataBuffer, 0);
      FBytesReceived := 0;
    end
  end;
end;

end.

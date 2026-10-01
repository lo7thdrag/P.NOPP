unit uPacketHelper;

interface

uses
  System.SysUtils,
  System.Classes,
  uDataType;

type
  TPacket = class
    class function Compose(var PacketHeader: TPacketHeader;
      const Data: TBytes): TBytes;
    class procedure Decompose(const Packet: TBytes;
      var PacketHeader: TPacketHeader; var Data: TBytes);
  end;

  TDataComposer = class
    class function ComposeRecord<T>(var PacketHeader: TPacketHeader;
      Data: T): TBytes;
    class function ComposeString(var PacketHeader: TPacketHeader;
      Data: string): TBytes;
    class function ComposeStream(var PacketHeader: TPacketHeader;
      Data: TStream): TBytes;

    class procedure DecomposeRecord<T>(const Packet: TBytes;
      var PacketHeader: TPacketHeader; var Data: T);
    class procedure DecomposeString(const Packet: TBytes;
      var PacketHeader: TPacketHeader; var Data: string);
    class procedure DecomposeStream(const Packet: TBytes;
      var PacketHeader: TPacketHeader; const Data: TStream);
  end;

implementation

// TPacket

class function TPacket.Compose(var PacketHeader: TPacketHeader;
  const Data: TBytes): TBytes;
var
  HeaderSize: Integer;
  DataSize: Integer;
begin
  HeaderSize := SizeOf(TPacketHeader);
  DataSize := Length(Data);
  PacketHeader.DataSize := DataSize;
  SetLength(Result, HeaderSize + DataSize);
  Move(PacketHeader, Result[0], SizeOf(TPacketHeader));
  Move(Data[0], Result[HeaderSize], DataSize);
end;

class procedure TPacket.Decompose(const Packet: TBytes;
  var PacketHeader: TPacketHeader; var Data: TBytes);
var
  HeaderSize: Integer;
begin
  HeaderSize := SizeOf(TPacketHeader);
  Move(Packet[0], PacketHeader, HeaderSize);
  SetLength(Data, PacketHeader.DataSize);
  Move(Packet[HeaderSize], Data[0], PacketHeader.DataSize);
end;

// TDataComposer

class function TDataComposer.ComposeRecord<T>(var PacketHeader: TPacketHeader;
  Data: T): TBytes;
var
  ABytes: TBytes;
begin
  SetLength(ABytes, SizeOf(T));
  Move(Data, ABytes[0], SizeOf(T));
  Result := TPacket.Compose(PacketHeader, ABytes);
end;

class function TDataComposer.ComposeStream(var PacketHeader: TPacketHeader;
  Data: TStream): TBytes;
var
  ABytes: TBytes;
begin
  Data.Position := 0;
  SetLength(ABytes, Data.Size);
  Data.ReadBuffer(ABytes[0], Data.Size);
  Result := TPacket.Compose(PacketHeader, ABytes);
end;

class function TDataComposer.ComposeString(var PacketHeader: TPacketHeader;
  Data: string): TBytes;
var
  ABytes: TBytes;
begin
  ABytes := TEncoding.UTF8.GetBytes(Data);
  Result := TPacket.Compose(PacketHeader, ABytes);
end;

class procedure TDataComposer.DecomposeRecord<T>(const Packet: TBytes;
  var PacketHeader: TPacketHeader; var Data: T);
var
  ABytes: TBytes;
begin
  TPacket.Decompose(Packet, PacketHeader, ABytes);
  Move(ABytes[0], Data, Length(ABytes));
end;

class procedure TDataComposer.DecomposeString(const Packet: TBytes;
  var PacketHeader: TPacketHeader; var Data: string);
var
  ABytes: TBytes;
begin
  TPacket.Decompose(Packet, PacketHeader, ABytes);
  Data := TEncoding.UTF8.GetString(ABytes);
end;

class procedure TDataComposer.DecomposeStream(const Packet: TBytes;
  var PacketHeader: TPacketHeader; const Data: TStream);
var
  ABytes: TBytes;
begin
  TPacket.Decompose(Packet, PacketHeader, ABytes);
  Data.Size := Length(ABytes);
  Data.Position := 0;
  Data.WriteBuffer(ABytes[0], Length(ABytes));
end;

end.

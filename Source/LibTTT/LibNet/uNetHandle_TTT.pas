unit uNetHandle_TTT;

interface

uses
   Classes, SysUtils,
   OverbyteIcsWSocket,
   uNetBaseSocket, uNetUDPnode, uPacketRegister, uBaseNetHandler;

type

//------------------------------------------------------------------------------
// kelas abstract
// network connection manager.
//------------------------------------------------------------------------------

  TNetHandle_TTT = class(TBaseNetHandler)
  protected
    FNetUDPNode: TNetUDPNode;
    FNetTCPSock: TNetBaseSocket;
    FNetTCPSockVBS : TNetBaseSocket;
    FLongIpBC: Longword;

    function GetBCAddress: string;
    procedure setBCAddress(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
  public
    GamePort   : integer;
    CommandPort: integer;
    VBSPort : Integer;
    StubPort   : integer;
    StubAddr   : string;

    property BroadCastAddress: string read GetBCAddress write setBCAddress;
  public
    procedure StartNetworking; override;
    procedure StopNetworking; override;
    procedure RegisterUDPPacket(const aType, aRecSize: word;
      aProcedure: TRegPacketHandlerProc);
    procedure RegisterTCPPacket(const aType, aRecSize: word;
      aProcedure: TRegPacketHandlerProc);
    procedure UnRegisterUDP;
    procedure UnRegisterTCP;
  end;

implementation

//===============================================================================
{ TNetHandler }

//==============================================================================
constructor TNetHandle_TTT.Create;
begin
  inherited;

end;

destructor TNetHandle_TTT.Destroy;
begin
  inherited;
end;

function TNetHandle_TTT.GetBCAddress: string;
begin
  result := LongIp_To_StrIp(FLongIpBC);
end;

procedure TNetHandle_TTT.setBCAddress(const Value: string);
begin
  FLongIpBC := StrIp_To_LongIp(Value);
end;

procedure TNetHandle_TTT.RegisterUDPPacket(const aType, aRecSize: word;
  aProcedure: TRegPacketHandlerProc);
begin
  FNetUDPNode.RegisterProcedure(aType, aProcedure, aRecSize);

end;

procedure TNetHandle_TTT.RegisterTCPPacket(const aType, aRecSize: word;
      aProcedure: TRegPacketHandlerProc);
begin
  FNetTCPSock.RegisterProcedure(aType, aProcedure, aRecSize);

//  if Assigned(FNetTCPSockVBS) then
//    FNetTCPSockVBS.RegisterProcedure(aType, aProcedure, aRecSize);
end;

procedure TNetHandle_TTT.StartNetworking;
begin
  inherited;

//  FNetUDPNode       := TNetUDPNode.Create;
//  FNetUDPNode.Port  := GamePort;

  // TCPSock harus di create di turunan.

end;

procedure TNetHandle_TTT.StopNetworking;
begin
//  FNetUDPNode.Close;
//  FNetUDPNode.Free;

end;

procedure TNetHandle_TTT.UnRegisterTCP;
begin
  FNetTCPSock.UnregisterAllProcedure;
  FNetTCPSockVBS.UnregisterAllProcedure;
end;

procedure TNetHandle_TTT.UnRegisterUDP;
begin
  FNetUDPNode.UnregisterAllProcedure;

end;

//==============================================================================



end.

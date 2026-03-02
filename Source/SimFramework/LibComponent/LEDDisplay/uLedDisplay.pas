unit ULedDisplay;

interface
uses
  Windows, SysUtils, Classes, Comdrv32, ExtCtrls;

type

  TStatusEvent = procedure(Sender: TObject; Status: string) of object;

  TLedDisplay = class
  private
    Scom: TCommPortDriver;
    FOnStatusEvent: TStatusEvent;
    FOpened: boolean;
    FLastString: string;
    procedure ComRecvData(Sender: TObject; DataPtr: pointer; DataSize: integer);

  public
    constructor Create(aOwner: tcomponent);
    destructor Destroy; override;

    function OpenPort(PortNum: byte): boolean;
    procedure SendString(Data: string);
    procedure ResetData;
    procedure Disconnect;

    procedure SendDisplayString(Mode, speed: Byte; Data: string);

  published
    property OnSatusEvent: TStatusEvent read FOnStatusEvent write FOnStatusEvent;
    property Opened: boolean read FOpened;

  end;

implementation

constructor TLedDisplay.Create(aOwner: tcomponent);
begin
  //inherited Create();
  scom := TCommPortDriver.Create(aOwner);
  scom.ComPortSpeed     := br9600;
  scom.ComPortParity    := ptNONE;
  scom.ComPortStopBits  := sb1BITS;
  scom.OnReceiveData    := ComRecvData;

  FLastString := '';
end;

destructor TLedDisplay.Destroy;
begin
  if scom.Connected then
    scom.Disconnect;
  inherited Destroy;

end;

function TLedDisplay.OpenPort(PortNum: byte): boolean;
begin
  scom.ComPort := TComPortNumber(PortNum - 1);
  FOpened := scom.Connect;
  result := FOpened;

end;

procedure TLedDisplay.SendString(Data: string);
var
  i, m: byte;
  S, Ts: string;
begin
  if CompareStr(Data, FLastString) = 0 then Exit;
  ts := '                ';
  s := data;
  m := Length(Data);
  if m > 16 then
    m := 16;
  for i := 1 to m do
    ts[i] := s[i];
  ts := '[D00' + ts + ']';
  scom.SendString(ts);
  FLastString := data;
end;

procedure TLedDisplay.ResetData;
begin
  scom.SendString('[C0000]');
end;

procedure TLedDisplay.Disconnect;
begin
  scom.Disconnect;
end;

procedure TLedDisplay.ComRecvData(Sender: TObject; DataPtr: pointer; DataSize: integer);
var
  pc: PCHAR;

  tpc: string;
begin
  pc := DataPtr;
  tpc := Copy(pc, 0, DataSize);
  if Assigned(FOnStatusEvent) then
    FOnStatusEvent(self, tpc);

end;

procedure TLedDisplay.SendDisplayString(Mode, speed: Byte; Data: string);
var i, m: byte;
    S, Ts: string;
    md, sp: string;
begin
  if CompareStr(Data, FLastString) = 0 then Exit;
  ts := '                ';
  s := data;
  m := Length(Data);
  if m > 16 then
    m := 16;
  for i := 1 to m do
    ts[i] := s[i];

  if Mode > 15 then Mode := 0;
  md := IntToHex(Mode, 1);

  if speed > 15 then Speed := 0;
  sp := IntToHex(Speed, 1);

  ts := '[D'+ md + '5' + ts + #13;
  scom.SendString(ts);
  FLastString := data;
end;

end.

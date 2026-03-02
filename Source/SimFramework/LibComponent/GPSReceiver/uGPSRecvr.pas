unit uGPSRecvr;
{ GPS RECEIVER
  BY ANDYSCTS
  2009 06 18
}
interface

uses
  Classes, Comdrv32, uGPSTranslate;

type

  //==============================================================================
  TGPSRecvMode = (gmNMEA, gmGarminText);
  //==============================================================================

  TGPSGenericData = record
    X, Y, z: Double;
    Course, Speed: Double;
    gpsTime: TDateTime;
    ErrStatus: string
  end;
  //==============================================================================

  TStringEvent = procedure(const s: string) of object;
  TGPSDataEvent = procedure(const gData: TGPSGenericData) of object;
  TNMEADataEvent = procedure(const nData: TNMEAData) of object;

  //==============================================================================
  TGPSReceiver = class
  private
    FCom: TCommPortDriver;
    FBuff: string;

    FGPSRecvMode: TGPSRecvMode;

    FLineDelimit: array[TGPSRecvMode] of Char;
    FParseHandler: array[TGPSRecvMode] of TStringEvent;

    FNMEAData: TNMEAData;
    FGarminData: TModeTextData;
    FGPSData: TGPSGenericData;

    FOnRecvData: TGPSDataEvent;
    FGetSentences: TStringEvent;

    FOnNMEAData: TNMEADataEvent;

    procedure SetGPSRecvMode(const Value: TGPSRecvMode);

    procedure ComRecvData(Sender: TObject; DataPtr: pointer; DataSize: integer);

    procedure parseNMEA(const s: string);
    procedure parseGarminText(const s: string);

    procedure SetComBaudRate(const Value: TComPortBaudRate);
    procedure SetComPortNumber(const Value: TComPortNumber);

    function getComBaudRate: TComPortBaudRate;
    function getComPortNumber: TComPortNumber;

  public
    constructor Create;
    destructor Destroy; override;

    function OpenGPS(): boolean;
    procedure CloseGPS;

  published

    property GPSRecvMode: TGPSRecvMode read FGPSRecvMode write SetGPSRecvMode;
    property ComBaudRate: TComPortBaudRate read getComBaudRate write SetComBaudRate;
    property ComPortNumber: TComPortNumber read getComPortNumber write SetComPortNumber;

    property OnGPSRecvData: TGPSDataEvent read FOnRecvData write FOnRecvData;
    property OnGetSentences: TStringEvent read FGetSentences write FGetSentences;

    property OnGPSNMEAData: TNMEADataEvent read  FOnNMEAData write FOnNMEAData; 

  end;
procedure Split(const delimiter, S: string; var chunks: TStrings);

implementation

uses
  Windows, SysUtils, StrUtils;

procedure LogFile_def(const fName: string;
  const msg: string; const spcCount: byte= 0);
var i:  Integer;
    f: TextFile;
    s,  spc : string;
begin
  AssignFile(f, fName);
  if not FileExists(fName) then begin
    Rewrite(f);
    s := FormatDateTime('dd-mm-yyyy hh:nn:ss', now);
    Writeln(f, 'atnp application version 1.1');
    Writeln(f, s);
    Writeln(f);
  end
  else
    Append(f);
  i := spcCount * 2;
  SetLength(spc, i);
  FillChar(spc, i, ' ');

//  s := FormatDateTime('hh:nn:ss.zzz- ', Time);
//  Writeln(f, s +  spc + msg);
  Writeln(f, spc + msg);

  Flush(f);
  CloseFile(f);
end;


procedure Split(const delimiter, S: string; var chunks: TStrings);
var
  i, l: integer;
  sub: string;
begin
  chunks.Clear;
  l := Length(S);
  i := 1;
  while (i <= l) do begin
    sub := '';
    while (i <= l) and not IsDelimiter(delimiter, S, i) do begin //Warning! isDelimiter ngetes salah satu karakter(OR)..
      if (s[i] <> char(10)) and (s[i] <> char(13)) then
        sub := sub + s[i]; //^&^
      inc(i);
    end;
    sub := trim(sub);
    if sub <> '' then
      chunks.Append(sub)
    else
      chunks.Append(' ');

    inc(i);
  end;
end;

//-----------------------------------------------------------

constructor TGPSReceiver.Create;
begin
  inherited;

  FCom := TCommPortDriver.Create(nil);
  with FCom do begin
    ComPort := pnCOM1;
    ComPortSpeed := br4800;
    ComPortDataBits := db8BITS;
    ComPortStopBits := sb1BITS;
    ComPortParity := ptNONE;
    ComPortHwHandshaking := hhNONE;
    ComPortSwHandshaking := shNone;
    ComPortPollingDelay := 50;
  end;
  //  scom.FlushBuffers(TRUE, TRUE);

  FCom.OnReceiveData := ComRecvData;

  FLineDelimit[gmNMEA] := '$';
  FLineDelimit[gmGarminText] := '@';

  FParseHandler[gmNMEA] := parseNMEA;
  FParseHandler[gmGarminText] := parseGarminText;
  FBuff := '';

  FGPSRecvMode := gmNMEA;

end;

destructor TGPSReceiver.Destroy;
begin
  FCom.Free;
  inherited;
end;

procedure TGPSReceiver.ComRecvData(Sender: TObject;
  DataPtr: pointer; DataSize: integer);

var
  c: Char;
  i, j, count: integer;
  str, pas: string;
begin
  SetLength(str, DataSize);
  CopyMemory(@str[1], DataPtr, DataSize);

  FBuff := FBuff + str;

  c := FLineDelimit[FGPSRecvMode];

  i := Pos(c, FBuff);
  if i >= 0 then begin
    j := PosEx(c, FBuff, i + 1);
    if j > i then begin
      count := j - i;
      SetLength(pas, Count);
      pas := Copy(FBuff, i, Count); // get one sentence :D
      Delete(FBuff, 1, j - 1); //  Delete(FBuff, 1, j);

      pas := trim(pas);
      if Assigned(FGetSentences) then FGetSentences(pas);

      FParseHandler[FGPSRecvMode](pas);

      SetLength(pas, 0);

    end
  end;
  //else uncomplete sentence

  SetLength(str, 0);
end;

function TGPSReceiver.OpenGPS(): boolean;
begin
  FBuff := '';
  Result := FCom.Connect;
end;

procedure TGPSReceiver.CloseGPS;
begin
  FCom.Disconnect;
  FBuff := '';
end;

procedure TGPSReceiver.parseNMEA(const s: string);
begin
  if TranslateNMEA(s, FNMEAData) then begin
//    LogFile_def('atnp_gps.log', s, 0);
    if Assigned(FOnNMEAData) then begin
      FOnNMEAData(FNMEAData);
    end;

    if Assigned(FOnRecvData) then begin
      with FGPSData do begin
        X := FNMEAData.Longitude;
        Y := FNMEAData.Latitude;
        z := FNMEAData.Altitude;

        Course := FNMEAData.Heading;
        Speed := FNMEAData.Speed;

        ERRStatus := FNMEAData.ERRStatus;
        gpsTime := Int(FNMEAData.UTCDate) + Frac(FNMEAData.UTCTime);
      end;
      FOnRecvData(FGPSData);
    end
  end;

  {  if ss[0]='$GPGGA' then begin

    end;
    if ss[0]='$GPGLL' then begin

    end;
    if ss[0]='$GPGSA' then begin

    end;
    if ss[0]='$GPGSV' then begin

    end;
    if ss[0]='$GPRMC' then begin

    end;
    if ss[0]='$GPVTG' then begin

    end;

  }
end;

procedure TGPSReceiver.parseGarminText(const s: string);
begin
  TranslateModeText(s, FGarminData);

  if Assigned(FOnRecvData) then begin
    with FGPSData do begin
      X := FGarminData.Longitude;
      Y := FGarminData.Latitude;

      Course := FGarminData.Heading;
      Speed := FGarminData.Speed;

      ERRStatus := FGarminData.Status;

      gpsTime := FGarminData.DateTime;

    end;
    FOnRecvData(FGPSData);
  end
end;

procedure TGPSReceiver.SetGPSRecvMode(const Value: TGPSRecvMode);
begin
  FGPSRecvMode := Value;
end;

procedure TGPSReceiver.SetComBaudRate(const Value: TComPortBaudRate);
begin

  FCom.ComPortSpeed := Value;

  //  ComPortPollingDelay  :=  FCom.ComPortInBufSize := / Speed

end;

procedure TGPSReceiver.SetComPortNumber(const Value: TComPortNumber);
begin
  if Value <> FCom.ComPort then begin
    //    if FCom.Connected then FCom.Disconnect; ? exit
    FCom.ComPort := Value;
  end
end;

function TGPSReceiver.getComBaudRate: TComPortBaudRate;
begin
  Result := FCom.ComPortSpeed;

end;

function TGPSReceiver.getComPortNumber: TComPortNumber;
begin
  Result := FCom.ComPort;
end;

end.

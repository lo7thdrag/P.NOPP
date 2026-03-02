unit uGPSTranslate;

interface
uses
  Windows, Classes, SysUtils, DateUtils;

type

  TNMEAData = record
    Sentences: string;
    UTCTime: TDateTime;
    UTCDate: TDateTime;
    Latitude: double; //decimal degree
    Longitude: double; //decimal degree
    ERRStatus: string; // Valid OR Invalid
    Altitude: double;
    AltitudeUnit: string;

    Speed: double; // m/s;
    Heading: double; //
  end;

  TModeTextData = record
    DateTime: TDateTime;
    Latitude: double; //decimal degree
    Longitude: double; //decimal degree

    // ++diubah disini
    LattString: string;
    LongString: string;

    FormatLattString: string;
    FormatLongString: string;

    Status: string;
    Error: Integer;
    Altitude: Integer;
    EWSpd: double;
    NSSpd: double;
    VSpd: double;

    Speed: double;
    Heading: double;

  end;

function EastToNorth(const degree: double): double;

procedure Split(const delimiter, S: string; var chunks: TStrings);

function DMSX(const cLLDMS: Double; cType: Char): string;

function TranslateNMEA(const s: string;
  var nDat: TNMEAData): boolean;

function TranslateModeText(const s: string;
  var gmData: TModeTextData): boolean;

implementation

uses
  math;


function ValidateDegree(const degreeOrg: double): double;
begin
  result := degreeOrg - (Floor(degreeOrg / 360.0) * 360.0);
end;

function EastToNorth(const degree: double): double;
begin
  {input: derajat (0..360) dari sumbu X, CCW, cartesian }
  {ouput: derajat (0..360) dari utara, CW, kompas}
  result := ValidateDegree(90.0 - degree);

  {  frac := degree - Floor(degree);
    degInt :=  ((359 - Round(degree) )+90) mod 360;
    result := degInt + (1-frac);}
end;

// === GPS routine ==

function ConvertStringToInt(const s: string): integer;
var
  numChar, SignChar: set of Char;
  i, max: integer;
  str: string;
  valid: boolean;
begin
  result := 0;
  str := trim(s);
  max := Length(str);
  if max < 1 then exit;

  numChar := ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  SignChar := ['-', '+'];

  if str[1] in SignChar then begin
    valid := max > 1;
    i := 2;
  end
  else begin
    valid := TRUE;
    i := 1;
  end;

  while valid and (i <= max) do begin
    valid := valid and (str[i] in numChar);
    inc(i);
  end;

  if valid then
    result := StrToInt(str);
end;

function ConvertStringToFloat(const s: string): double;
var
  numChar, SignChar: set of Char;
  numPoint: integer;
  i, max: integer;
  str: string;
  valid: boolean;
  fs: TFormatSettings;
begin
  result := 0.0;
  str := trim(s);
  max := Length(str);
  if max < 1 then exit;

  numChar := ['.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  SignChar := ['-', '+'];

  if str[1] in SignChar then begin
    valid := max > 1;
    i := 2;
  end
  else begin
    valid := TRUE;
    i := 1;
  end;
  numPoint := 0;
  while valid and (i <= max) do begin
    valid := valid and (str[i] in numChar);
    if str[i] = '.' then inc(numPoint);
    inc(i);
  end;
  if valid and (numPoint < 2) then begin
    fs.DecimalSeparator := '.';
    result := StrToFloat(str, fs);
  end;
end;

//==============================================================================

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

//==============================================================================

function DMSX(const cLLDMS: Double; cType: Char): string;
var
  MinDet, DetDec: Extended;
  Degree, Minute: Integer;
  absLongLat: Extended;
  S: string;
begin
  absLongLat := abs(cLLDMS);
  Degree := Trunc(absLongLat);
  MinDet := Frac(absLongLat) * 60 + 0.00000001;
  Minute := Trunc(MinDet);
  DetDec := Frac(MinDet) * 60 + 0.000001;
  if DetDec >= 60 then begin
    Minute := Minute + 1;
    DetDec := DetDec - 60;
  end;
  if minute >= 60 then begin
    minute := minute - 60;
    Degree := Degree + 1;
  end;
  case cType of
    '0': if cLLDMS < 0 then
        S := 'W'
      else
        S := 'E';
    '1': if cLLDMS < 0 then
        S := 'S'
      else
        S := 'N';
  end;
  Result := IntToStr(Abs(Degree)) + '° ' + FormatFloat('00', Minute) + ''' ' + FormatFloat('00.00', DetDec) + '" ' + S;
end;

//==============================================================================

//==============================================================================

//TNMEAData

function TranslateNMEA(const s: string;
  var nDat: TNMEAData): boolean;
// local function
  function UTCTimeToTime(const s: string): TDateTime;
    { input: hhmmss.sss}
  var
    whh, wnn, wss, wsss: word;
  begin
    result := 0.0; //
    if (Length(s) < 6) then exit;
    whh := ConvertStringToInt(Copy(s, 1, 2));
    wnn := ConvertStringToInt(Copy(s, 3, 2));
    wss := ConvertStringToInt(Copy(s, 5, 2));
    //    wsss := ConvertStringToInt(Copy(s, 8, 3));
    wsss := 0;
    result := EncodeTime(wHh, wNn, wSs, wSss);
  end;

  function UTCDateToDate(const s: string): TDateTime;
    { input: DDMMYY}//131005
  var
    wyy, wmm, wdd: word;
  begin
    result := 0.0;
    if (Length(s) < 6) then exit;
    wdd := ConvertStringToInt(Copy(s, 1, 2));
    wmm := ConvertStringToInt(Copy(s, 3, 2));
    wyy := ConvertStringToInt(Copy(s, 5, 2)) + 2000;
    result := EncodeDate(wYy, wMm, wDd);
  end;

  function NMEADegreeToDecDegree(const st, sign: string): double;
    (* input  : ddmm.mmmm N/S or dddmm.mmmm E/W
       output : dd.ddddd OR -dd.ddddd
    *)
  var
    d, dg, dc, m: double;
  begin
    result := 0;
    if st = ' ' then exit;

    d := ConvertStringToFloat(st);

    dg := Int(d / 100);
    m := Frac(d / 100);
    dc := dg + 100 * m / 60;
    result := dc;
    if (sign[1] = 'S') or (sign[1] = 'W') then
      result := -Result;
  end;

const
  C_KnotsToMPerS = 1852.0 / 3600.0;
  C_KmPerhToMPerS = 1000.0 / 3600.0;

var
  ss: TStrings;
  vi: Integer;
begin

  ss := tStringList.Create;

  Split(',', s, ss);
  nDat.Sentences := ss[0];

  if ss[0] = '$GPGGA' then begin
    if ss.Count >= 10 then begin
      {  Example (signal not acquired): $GPGGA,235947.000,0000.0000,N,00000.0000,E,0,00,0.0,0.0,M,,,,0000*00
       Example (signal acquired):
       $GPGGA,  092204.999, 4250.5589,   S,14718.5084, E, 1, 04,24.4,19.7,M,,,,0000*1F
      //$ GPGGA,051144,0735.2225,S,11246.6551,E,8,10,2.0,711.9,M,17.0

       0 Sentence ID      $GPGGA
       1 UTC Time          092204.999    hhmmss.sss
       2 Latitude          4250.5589     ddmm.mmmm
       3 N/S Indicator     S             N = North, S = South
       4 Longitude         14718.5084    dddmm.mmmm
       5 E/W Indicator     E             E = East, W = West
       6 Position Fix      1             0 = Invalid, 1 = Valid SPS, 2 = Valid DGPS, 3 = Valid PPS
       7 Satellites Used   04            Satellites being used (0-12)
       8 HDOP              24.4          Horizontal dilution of precision
       9 Altitude          19.7          Altitude in meters according to WGS-84 ellipsoid
      10 Altitude Units    M             M = Meters
      11 Geoid Seperation                Geoid seperation in meters according to WGS-84 ellipsoid
      12 Seperation Units                M = Meters
      13 DGPS Age                        Age of DGPS data in seconds
      14 DGPS Station ID   0000
      15 Checksum          *1F
      16 Terminator        CR/LF  }

{ GGA - essential fix data which provide 3D location and accuracy data.

 $GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47

Where:
    0     GGA          Global Positioning System Fix Data
    1     123519       Fix taken at 12:35:19 UTC
    2,3   4807.038,N   Latitude 48 deg 07.038' N
    4,5   01131.000,E  Longitude 11 deg 31.000' E
    6              Fix quality: 0 = invalid
                                1 = GPS fix (SPS)
                                2 = DGPS fix
                                3 = PPS fix
			                          4 = Real Time Kinematic
			                          5 = Float RTK
                                6 = estimated (dead reckoning) (2.3 feature)
			                          7 = Manual input mode
			                          8 = Simulation mode
    7      08           Number of satellites being tracked
    8      0.9          Horizontal dilution of position
    9,10   545.4,M      Altitude, Meters, above mean sea level
    11,12  46.9,M       Height of geoid (mean sea level) above WGS84
                      ellipsoid
     (empty field) time in seconds since last DGPS update
     (empty field) DGPS station ID number
     *47          the checksum data, always begins with *

}
      nDat.Sentences := ss[0];
      nDat.UTCTime    := UTCTimeToTime(ss[1]);
      nDat.Latitude   := NMEADegreeToDecDegree(ss[2], ss[3]);
      nDat.Longitude  := NMEADegreeToDecDegree(ss[4], ss[5]);

      vi := ConvertStringToInt(ss[6]);
      case vi of
        0 : nDat.ERRStatus := 'Invalid';
        1 : nDat.ERRStatus := 'GPS Fix';  //gos fix
        2 : nDat.ERRStatus := 'DGPS Fix';
        3 : nDat.ERRStatus := 'PPS Fix';
        4 : nDat.ERRStatus := 'Real Time Kinematic';
        5 : nDat.ERRStatus := 'Float RTK';
        6 : nDat.ERRStatus := 'estimated';
        7 : nDat.ERRStatus := 'Manual';
        8 : nDat.ERRStatus := 'Simulation';
      end;

      if ss[9] <> ' ' then begin
        nDat.Altitude := ConvertStringToFloat(ss[9]);
        nDat.AltitudeUnit :=  ss[10];
      end;
    end;
  end;

  (*  if ss[0]='$GPGLL' then begin
    { Example (signal not acquired): $GPGLL,0000.0000,N,00000.0000,E,235947.000,V*2D
      Example (signal acquired): $GPGLL,4250.5589,S,14718.5084,E,092204.999,A*2D
      0  Sentence ID     $GPGLL
      1  Latitude        4250.5589   ddmm.mmmm
      2  N/S Indicator   S           N = North, S = South
      3  Longitude       14718.5084  dddmm.mmmm
      4  E/W Indicator   E           E = East, W = West
      5  UTC Time        092204.999  hhmmss.sss
      6  Status          A           A = Valid, V = Invalid
      7  Checksum        *2D      
      8  Terminator      CR/LF }

      nDat.Sentences := ss[0];
      nDat.UTCTime  := UTCTimeToTime(ss[5]);
      nDat.Latitude  := NMEADegreeToDecDegree(ss[1], ss[2]);
      nDat.Longitude := NMEADegreeToDecDegree(ss[3], ss[4]);

      if (ss[6] = 'A') then
        nDat.ERRStatus := 'Invalid'
      else if (ss[6] = 'V') then
        nDat.ERRStatus := 'Valid';

      nDat.Speed   := 0.0;
      nDat.Heading := 0.0;
    end;
   *)
  if ss[0] = '$GPRMC' then begin
    // $GPRMC,   060913,   V,   0549.9275,S,11224.7088,E,330.0,296.0,121005,1.3,E,S*04
 //   $GPRMC,045854,V,0718.6230,S,11246.6551,E,70.0,180.0,131005,1.4,

   { Example (signal not acquired): $GPRMC,235947.000,V,0000.0000,N,00000.0000,E,,,041299,,*1D
     Example (signal acquired): $GPRMC,092204.999,A,4250.5589,S,14718.5084,E,0.00,89.68,211200,,*25

      0 Sentence ID   $GPRMC
      1  UTC Time            092204.999  hhmmss.sss
      2  Status              A           A = InValid, V = valid
      3  Latitude            4250.5589   ddmm.mmmm
      4  N/S Indicator       S           N = North, S = South
      5  Longitude           14718.5084  dddmm.mmmm
      6  E/W Indicator       E           E = East, W = West
      7  Speed over ground   0.00        Knots
      8  Course over ground  0.00        Degrees
      9  UTC Date            211200      DDMMYY
     10  Magnetic variation              Degrees
     11  Magnetic variation              E = East, W = West
     12  Checksum            *25
     13  Terminator          CR/LF        }
{ $GPRMC,123519,A,4807.038,N,01131.000,E,022.4,084.4,230394,003.1,W*6A

Where:
     RMC          Recommended Minimum sentence C
     123519       Fix taken at 12:35:19 UTC
     A            Status A=active or V=Void.
     4807.038,N   Latitude 48 deg 07.038' N
     01131.000,E  Longitude 11 deg 31.000' E
     022.4        Speed over the ground in knots
     084.4        Track angle in degrees True
     230394       Date - 23rd of March 1994
     003.1,W      Magnetic Variation
     *6A          The checksum data, always begins with *

}
    if ss.Count >= 10 then begin
      nDat.Sentences := ss[0];
      nDat.UTCTime := UTCTimeToTime(ss[1]);
      nDat.UTCDate := UTCDateToDate(ss[9]);
      nDat.Latitude := NMEADegreeToDecDegree(ss[3], ss[4]);
      nDat.Longitude := NMEADegreeToDecDegree(ss[5], ss[6]);

      if (ss[2] = 'A') then
        nDat.ERRStatus := 'Active'
      else if (ss[2] = 'V') then
        nDat.ERRStatus := 'Void';

      if (ss[7] <> ' ') then
        nDat.Speed := ConvertStringToFloat(ss[7]);

      if (ss[8] <> ' ') then
        nDat.Heading := ConvertStringToFloat(ss[8]);
    end;
  end;

  if ss[0] = '$GPVTG' then begin
    { $GPVTG Sentence (Course over ground)
       Example (signal not acquired): $GPVTG,,T,,M,,N,,K*4E
       Example (signal acquired): $GPVTG,89.68,T,,M,0.00,N,0.0,K*5F

       0 Sentence ID   $GPVTG
       1 Course        89.68       Course in degrees
       2 Reference     T           = True heading
       3 Course        89.68       Course in degrees
       4 Reference     M           = Magnetic heading
       5 Speed         0.00        Horizontal speed
       6 Units         N           N = Knots
       7 Speed         0.00        Horizontal speed
       8 Units         K           K = KM/h
       9 Checksum      *5F
      10 Terminator  CR/LF  }

    if ss.Count >= 5 then begin
      nDat.Sentences := ss[0];

      //     nDat.Heading := StrToFloat(ss[1]);
      //     nDat.Speed   := StrToFloat(ss[5]) * C_KnotsToMPerS;
      nDat.Heading := ConvertStringToFloat(ss[1]);
      nDat.Speed := ConvertStringToFloat(ss[5]);

    end;
  end;

  ss.Free;
  Result := TRUE;
end;

// -- ModeText text routine
//==============================================================================

function ModeTextTimeToDateTime(const str: string): TDateTime;
var
  wyy, wmm, wdd, whh, wnn, wss: word;
begin
  result := 0.0;
  if (Length(str) < 12) then exit;
  wyy := ConvertStringToInt(Copy(Str, 1, 2)) + 2000;
  wmm := ConvertStringToInt(Copy(Str, 3, 2));
  wdd := ConvertStringToInt(Copy(Str, 5, 2));
  whh := ConvertStringToInt(Copy(Str, 7, 2));
  wnn := ConvertStringToInt(Copy(Str, 9, 2));
  wss := ConvertStringToInt(Copy(Str, 11, 2));

  result := EncodeDateTime(wyy, wmm, wdd, whh, wnn, wss, 000);
end;

function ModeTextTextLongLatToDecDegree(const str: string): double;
var
  stDeg: string;
  iDeg, iMn: integer;
  m: double;
begin
  result := 0.00;
  if Length(Str) >= 8 then begin
    if Length(Str) = 8 then
      stDeg := Copy(Str, 2, 7)
    else
      stDeg := Copy(Str, 2, 8);

    iDeg := ConvertStringToInt(stDeg);
    iMn := iDeg mod 100000; //mmmmm
    iDeg := iDeg div 100000; //ddd OR dd

    m := 10 * (iMn * 0.00001) / 6;
    result := iDeg + m;

    if (str[1] = 'S') or (str[1] = 'W') then
      result := -Result;
  end;
end;

function ModeTextSpeedToMeterPerSecond(const str: string): double;
begin
  result := 0.00;
  if Length(Str) < 5 then exit;

  result := ConvertStringToInt(Copy(Str, 2, 4)) * 0.1;

  if (str[1] = 'S') or (str[1] = 'W') or (str[1] = 'D') then
    result := -Result;
end;

function TranslateModeText(const s: string; var gmData: TModeTextData): boolean;
//@051012064723S0500540E11041582S015+00710W0232N0094U0000

//@051012064724S0500535E11041569S015+00710W0232N0094U0000

(* 0         1         2         3         4         5         6
   0123456789012345678901234567890123456789012345678901234567890123456789
    @000607204655N6012249E01107556S015+00130E0021N0018U0000
  //@051012060304S0611800E11234763S015+00709W0278N1203U0000
    @yymmddhhmmss        Longitude    Altitude   NSSpd
                 Latitude          error    EWSpd     VSpd

  Tabel 3.1 Data keluaran GPS receiver ModeText III+ dengan mode text
  DESKRIPSI.	LEBARDIGIT	KETERANGAN
    Tanda Awal 	1	Selalu '@'
  WAKTU
    Tahun	2	Dua digit terakhir dari tahun  UTC
    Bulan	2	Bulan  UTC , "01".."12"
    Hari	2	Hari dari bulan UTC, "01".."31"
    Jam	  2	Jam UTC, "00".."23"
    Menit	2	Menit UTC, "00".."59"
    Detik	2	Detik UTC, "00".."59"

  POSISI
    Arah Lintang	    1	'N' or 'S'
    Koordinat Lintang	7	WGS84 ddmmmmm, with an implied decimal after the 4th digit
    Arah Bujur	      1	'E' or 'W'
    Koordinat Bujur	  8	WGS84 dddmmmmm with an implied decimal after the 5th digit
    Status posisi	    1	'd' jika memakai 2D differential GPS position
      'D' jika memakai 3D differential GPS position
      'g' jika memakai 2D GPS position
      'G' jika memakai 3D GPS position
      'S' Jika menggunakan simulasi posisi
      '_' Jika posisinya salah
    Posisi Kesalahan Horizontal 	3	EPH in meters
    Tanda Ketinggian	            1	'+' atau  '-'
    Ketinggian	                  5	Ketinggian rata-rata diatas permukaan laut (meter)

  KECEPATAN
    Timur atau Barat, arah kecepatan	1	'E' atau 'W'
    Magnitude Barat atau Timur	      4	Meter per detik dalam tenths,   ("1234" = 123.4 m/s)
    Arah Kecepatan Utara/Selatan	    1	'N' or 'S'
    Magnitude Utara atau Selatan	    4	Meter per detik dalam  tenths, ("1234" = 123.4 m/s)
    Arah kecepatan  Vertical 	        1	'U' (atas) or 'D' (bawah)
    Magnitude kecepatan Vertical	    4	Meter per detik dalam hundredths, ("1234" = 12.34 m/s)
  Akhir tanda	2	Carriage return, '0x0D', dan line feed,0x0A'
*)
var
  Stat: Char;
  CoordDir: double;
  lat, lon: string;
begin
  // check string
  result := FALSE;
  ///    Tanda Awal 	1	Selalu '@'
  if (Length(s) < 55) or (s[1] <> '@') then exit;
  //  WAKTU
  gmData.DateTime := ModeTextTimeToDateTime(Copy(s, 2, 12));

  //  POSISI
  gmData.Latitude := ModeTextTextLongLatToDecDegree(Copy(S, 14, 8));
  gmData.Longitude := ModeTextTextLongLatToDecDegree(Copy(S, 22, 9));

  // ++diubah disini
  lat := Copy(S, 14, 8);
  lon := Copy(S, 22, 9);
  gmData.LattString := lat;
  gmData.LongString := lon;

  gmData.FormatLattString := //Sddmmmmm
  Copy(lat, 1, 1) + ' ' + // S / N
  Copy(lat, 2, 2) + ' ' + // degree
  Copy(lat, 4, 2) + '.' + // menit
  Copy(lat, 6, 3); //decimal menit

  gmData.FormatLongString :=
    Copy(lon, 1, 1) + ' ' + // E / W
  Copy(lon, 2, 3) + ' ' + // degree
  Copy(lon, 5, 2) + '.' + // menit
  Copy(lon, 7, 3); //decimal menit

  // ++

  //status
  Stat := S[31];
  case Stat of
    'D': gmData.Status := '3D differential GPS position';
    'g': gmData.Status := '2D GPS position';
    'G': gmData.Status := '3D GPS position';
    'S': gmData.Status := 'Simulated';
    '_': gmData.Status := 'I N V A L I D';
  end;

  gmData.Error := ConvertStringToInt(Copy(S, 32, 3));
  gmData.Altitude := ConvertStringToInt(Copy(S, 35, 6));

  //  KECEPATAN
  gmData.EWSpd := ModeTextSpeedToMeterPerSecond(Copy(S, 41, 5));
  gmData.NSSpd := ModeTextSpeedToMeterPerSecond(Copy(S, 46, 5));
  gmData.VSpd := ModeTextSpeedToMeterPerSecond(Copy(S, 51, 5));

  gmData.Speed := sqrt(sqr(gmData.EWSpd) + sqr(gmData.NSSpd));

  if Abs(gmData.EWSpd) > 0.0001 then begin
    CoordDir := RadToDeg(ArcTan2(gmData.NSSpd, gmData.EWSpd));
    gmData.Heading := EastToNorth(CoordDir);
  end;

  result := TRUE;
end;

//$GPRMC,,V,,,,,,,131005,1.4,E,N*3B
//$GPGGA,,,,,,0,00,,,M,,M,,*66

end.

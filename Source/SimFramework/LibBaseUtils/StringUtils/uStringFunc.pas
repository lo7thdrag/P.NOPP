unit uStringFunc;

interface

uses
  Classes;

  function SeparateString(const s: string; del: char; var s1, s2: string): boolean;
  function ConvertStringToFloat(const s: string): double;
  function ConvertStringToInt(const s: string): integer;
  function LimitStr(const sNew: string; const sz: Byte=16): string;
  function MakeValidIdent(var Ident: string): Boolean;

  procedure StringListCompare(const aStrs1, aStrs2 :TStrings;
        var aStrsEqual, aStrsIn_1_Only, aStrsIn_2_Only: TStrings;
        const aSort: boolean= false);


implementation

uses
  SysUtils;

function SeparateString(const s: string; del: char; var s1, s2: string): boolean;
  // left and right part must exist.
var
  i, l: integer;
begin
  result := false;
  l := Length(s);
  i := Pos(del, s);
  if (l < 2) or (i < 1) then exit;

  s1 := Copy(s, 1, i - 1);
  s2 := Copy(s, i + 1, l - i);

  s1 := Trim(s1);
  s2 := Trim(s2);
  result := (s1 <> '') and (s2 <> '');

end;

{
function SaferStrToFloat(const s: string): Double;
var
  fs: TFormatSettings;
begin
  Result := 0.0;
  fs.DecimalSeparator := '.';
  try
    result := StrToFloat(s, fs);
  except
    on EConvertError do begin
      fs.DecimalSeparator := ',';
      try
        result := StrToFloat(s, fs);
      except
        on EConvertError do
          Result := 0.0;
      end;
    end;
  end;
end;
}

{function IsValidFloat(const s: string): boolean;
const CNum = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      CSign = ['+', '-'];
var l, dotCount: Integer;

begin
  result := false;
  l := Length(s);

  if l = 0 then Exit;

  if l = 1 then begin
     Result := s[1] in CNum;
  end
  else
  if l = 2 then begin
     Result := ( s[2] in CNum) and ((s[1] in CSign) or (s[2] in CNum))
  end;
  if l > 2 then begin

  end;
end;

function IsValidInteger(const s: string): boolean;
begin
  result := false;

end;
}

function ConvertStringToFloat(const s: string): double;
var
  numChar, SignChar: set of AnsiChar;//Char;
  numPoint: integer;
  i, max: integer;
  str: string;
  valid: boolean;
  fs: TFormatSettings;
begin
  result := 0.0;
  str := trim(s);

  max := Length(str);
  if max < 1 then
    exit;

  numChar := ['.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  SignChar := ['-', '+'];

  //if str[1] in SignChar then begin
  if CharInSet(str[1], SignChar) then begin
    valid := max > 1;
    i := 2;
  end
  else begin
    valid := TRUE;
    i := 1;
  end;

  numPoint := 0;
  while valid and (i <= max) do begin
    valid := valid and CharInSet(str[i], numChar);
    //valid := valid and (str[i] in numChar);
    if str[i] = '.' then inc(numPoint);
    inc(i);
  end;

  if valid and (numPoint < 2) then begin
    fs.DecimalSeparator := '.';
    result := StrToFloat(str, fs);
  end;
end;

function ConvertStringToInt(const s: string): integer;
var
  numChar, SignChar: set of AnsiChar; //Char;
  i, max: integer;
  str: string;
  valid: boolean;
begin
  result := 0;
  str := trim(s);

  max := Length(str);
  if max < 1 then
    exit;

  numChar := ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  SignChar := ['-', '+'];

  //if str[1] in SignChar then begin
  if CharInSet(str[1], SignChar) then begin
    valid := max > 1;
    i := 2;
  end
  else begin
    valid := TRUE;
    i := 1;
  end;

  while valid and (i <= max) do begin
    //valid := valid and (str[i] in numChar);
    valid := valid and CharInSet(str[i], numChar);
    inc(i);
  end;

  if valid then
    result := StrToInt(str);
end;

function LimitStr(const sNew: string; const sz: Byte=16): string;
begin
  if Length(sNew) >= sz then
    result  := Copy(sNew, 1, sz)
  else
    Result  := sNew;
end;

function MakeValidIdent(var Ident: string): Boolean;
//const
//  Alpha = ['A'..'Z', 'a'..'z', '_'];
//  AlphaNumeric = Alpha + ['0'..'9'];
var
  Alpha, AlphaNumeric: set of AnsiChar; //Char;
  I: Integer;
begin
  Result := False;

  Alpha := ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric := Alpha + ['0'..'9'];

  if (Length(Ident) = 0) or not CharInSet(Ident[1], Alpha) then//(Ident[1] in Alpha) then
    Exit;

  for I := 2 to Length(Ident) do
  begin
   if not CharInSet(Ident[I], AlphaNumeric) then //(Ident[I] in AlphaNumeric) then
    Ident[I] := '_';
  end;

  Result := True;
end;

  procedure StringListCompare(const aStrs1, aStrs2 :TStrings;
        var aStrsEqual, aStrsIn_1_Only, aStrsIn_2_Only: TStrings;
        const aSort: boolean= false);

  var i, j : integer;
      strI, strJ : string;
      same : boolean;

  begin
    aStrsIn_1_Only.Clear;
    aStrsIn_1_Only.AddStrings(aStrs1);
    (aStrsIn_1_Only as TStringList).Sorted := aSort;

    aStrsIn_2_Only.Clear;
    aStrsIn_2_Only.AddStrings(aStrs2);
    (aStrsIn_2_Only as TStringList).Sorted := aSort;

    for i := aStrsIn_1_Only.Count-1 downto 0 do begin
      strI := aStrsIn_1_Only[i];

      j := 0;
      same := false;
      while not same and (j < aStrsIn_2_Only.Count) do begin
        strJ := aStrsIn_2_Only[j];
        same :=  CompareStr(strI,  strJ) = 0;
        inc(j);
      end;

      if same then begin
        aStrsEqual.Insert(0,strI);
        aStrsIn_1_Only.Delete(i);
        aStrsIn_2_Only.Delete(j-1);
      end;
    end;
  end;

end.

unit xmlInterface;

interface

uses
  GmXml;

type

  TXMLObjInterface = class
  protected
    XmlNode: TGmXmlNode;

    function getAttribValueByName(const aName: string): string;
    procedure setAttribValueByName(const aName, aValue: string);

    function getChildValueByName(const aName: string): string;
    procedure setChildValueByName(const aName, aValue: string);

    function GetAttribValueByte(const aName: string): Byte;
    procedure setAttribValueByte(const aName: string;  aValue: byte);

    function GetAttribValueInteger(const aName: string): integer;
    procedure setAttribValueInteger(const aName: string;  aValue: integer);

    function GetAttribValueDouble(const aName: string): double;
    procedure setAttribValueDouble(const aName: string;  aValue: double);

  public

    constructor Create;
    procedure Assign(xNode: TGmXmlNode); virtual;
  public

    property ChildVal[const aName: string]: string read getChildValueByName write setChildValueByName;
    property AttribVal[const aName: string]: string read getAttribValueByName write setAttribValueByName;

  end;

implementation

uses
  uStringFunc, SysUtils;

{ TXMLObjInterface }

constructor TXMLObjInterface.Create;
begin
  XmlNode := nil;
end;

function TXMLObjInterface.getAttribValueByName(const aName: string): string;
var
  a: TGmXmlNodeAttribute;
begin
  if XmlNode = nil then Exit;
  a := makeAttribNodeExist(aName, '', XMLNode);
  Result := a.Value;
end;


procedure TXMLObjInterface.setAttribValueByName(const aName, aValue: string);
var
  a: TGmXmlNodeAttribute;
begin
  if XmlNode = nil then Exit;
  a := makeAttribNodeExist(aName, aValue, XMLNode);
  a.Value := aValue;
end;

function TXMLObjInterface.getChildValueByName(const aName: string): string;
var
  n: TGmXmlNode;
begin
  if XmlNode = nil then Exit;
  n := makeChildNodeExist(aName, XMLNode);
  result := n.AsDisplayString;
end;

procedure TXMLObjInterface.setChildValueByName(const aName, aValue: string);
var
  n: TGmXmlNode;
begin
  if XmlNode = nil then Exit;
  n := makeChildNodeExist(aName, XMLNode);
  n.AsString := aValue;
end;

procedure TXMLObjInterface.Assign(xNode: TGmXmlNode);
begin
  XmlNode := xNode;
end;

function TXMLObjInterface.GetAttribValueByte(const aName: string): Byte;
begin
  try
    Result := ConvertStringToInt(AttribVal[aName]);
  except
    on EConvertError do begin
      Result := 0;
      AttribVal[aName] := '0';
    end;
  end;
end;
procedure TXMLObjInterface.setAttribValueByte(const aName: string;  aValue: byte);
begin
  AttribVal[aName] := IntToStr(aValue) ;
end;

function TXMLObjInterface.GetAttribValueInteger(const aName: string): integer;
begin
  try
    Result := ConvertStringToInt(AttribVal[aName]);
  except
    on EConvertError do begin
      Result := 0;
      AttribVal[aName] := '0';
    end;
  end;
end;
procedure TXMLObjInterface.setAttribValueInteger(const aName: string;  aValue: integer);
begin
  AttribVal[aName] := IntToStr(aValue);
end;


function TXMLObjInterface.GetAttribValueDouble(const aName: string): double;
begin
  Result := 0.0;
  try
    Result := ConvertStringToFloat(AttribVal[aName]);
  except
    on EConvertError do begin
      Result := 0.0;
    end;
  end;
end;

procedure TXMLObjInterface.setAttribValueDouble(const aName: string;  aValue: double);
var f: string;
begin
  f := FloatToStr(aValue);
  AttribVal[aName]     := f;

end;
end.

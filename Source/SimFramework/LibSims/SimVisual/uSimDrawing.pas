unit uSimDrawing;

interface

uses
  Classes, Windows, Graphics,
  uCoordConvertor;

type

  // ==============================================================================
  TDrawElement = class
  public
    Size: byte;
    Color: TColor;
    Center: TPoint;
    Offset: TPoint;
    FontName: TFontName;
    Visible: boolean;

    constructor Create;
    procedure Draw(aCnv: TCanvas); virtual;
    procedure ConvertCoord(cvt: TCoordConverter); virtual;

  end;

  // ==============================================================================
  TDrawContainers = class
  protected
    FList: TList;
    FDrw: TDrawElement;

  public
    constructor Create;
    destructor Destroy; override;

    procedure ClearItems;

    procedure addItem(const obj: TDrawElement);
    function GetItem(const i: integer): TDrawElement;
    function ItemCount: integer;

    procedure DrawAll(aCnv: TCanvas);
    procedure ConvertAll(cvt: TCoordConverter);

    function SearchByPos(const x, y: integer): integer;
    // return index of list.

  end;
  // ==============================================================================

implementation

uses
  uSimContainers;

{ TDrawElement }
// ==============================================================================

constructor TDrawElement.Create;
begin
  Size := 12;
  FontName := 'Arial';
  Color := RGB(12, 255, 12);
  Center.x := 0;
  Center.y := 0;
  Offset := Center;
  Visible := true;
end;

procedure TDrawElement.ConvertCoord(cvt: TCoordConverter);
begin
  //
end;

procedure TDrawElement.Draw(aCnv: TCanvas);
begin
  if not Visible then
    exit;

  with aCnv do
  begin
    Font.Name := FontName;
    Font.Size := Size;
    Font.Color := Color;
  end;

end;

// ============================================================================
{ TDrawContainers }

constructor TDrawContainers.Create;
begin
  FList := TList.Create;

end;

destructor TDrawContainers.Destroy;
begin

  ClearAndFreeItems(FList);
  inherited;
end;

procedure TDrawContainers.ClearItems;
var
  i: integer;
  FDrw: TDrawElement;
begin
  for i := 0 to FList.Count - 1 do
  begin
    FDrw := FList[i];
    FDrw.Free;
  end;
  FList.Clear;

end;

procedure TDrawContainers.addItem(const obj: TDrawElement);
begin
  FList.Add(obj);
end;

procedure TDrawContainers.ConvertAll(cvt: TCoordConverter);
var
  i: integer;
  FDrw: TDrawElement;
begin
  for i := 0 to FList.Count - 1 do
  begin
    FDrw := FList[i];
    FDrw.ConvertCoord(cvt);
  end;
end;

procedure TDrawContainers.DrawAll(aCnv: TCanvas);
var
  i: integer;
  FDrw: TDrawElement;
begin
  for i := 0 to FList.Count - 1 do
  begin
    FDrw := FList[i];
    FDrw.Draw(aCnv);
  end;
end;

function ptToRect(const pt: TPoint; const r: integer): TRect;
begin
  result := Rect(pt.x - r, pt.y - r, pt.x + r, pt.y + r)
end;

function TDrawContainers.SearchByPos(const x, y: integer): integer;
const
  C_HIT_SIZE = 6;
var
  i: integer;
  de: TDrawElement;
  r: TRect;
  found: boolean;
begin
  result := -1;
  found := false;
  r := ptToRect(Point(x, y), C_HIT_SIZE);

  i := FList.Count - 1;
  while not found and (i >= 0) do
  begin
    de := FList.Items[i];
    found := PtInRect(r, de.Center);
    dec(i);
  end;
  if found then
    result := i + 1;

end;

function TDrawContainers.GetItem(const i: integer): TDrawElement;
begin
  result := nil;
  if (i >= 0) and (i < FList.Count) then
    result := FList[i];
end;

function TDrawContainers.ItemCount: integer;
begin
  result := FList.Count;
end;

end.

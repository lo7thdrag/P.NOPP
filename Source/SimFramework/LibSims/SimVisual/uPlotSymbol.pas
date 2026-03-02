unit uPlotSymbol;

interface

uses
  Classes, Graphics, uDrawItems, uCoordConvertor,
  uSimDrawing, uDataTypes;

type

  TPlotItem = class(TDrawElement)
  private
    FSymIndex: Integer;
    function getTextVisible: boolean;
    procedure setTextVisible(const Value: boolean);
    function getCapt: string;
    procedure setCapt(const Value: string);
    function getSymIndex: Integer;
    procedure setSymIndex(const Value: Integer);

  protected
    FSymbol: TBitmapSymbol;
    FText: TInfoLabel;
  public
    Pos: t2DPoint;
    PlotID: Integer;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCnv: TCanvas); override;

    procedure SetBitmap(bmp: TBitmap);
    procedure GetBitmap(bmp: TBitmap);

  published
    property TextVisible: boolean read getTextVisible write setTextVisible;
    property Caption: string read getCapt write setCapt;
    property SymIndex: Integer read getSymIndex write setSymIndex;

  end;

  //============================================================================

  TPlotSymbol = class(TDrawContainers)
  private

  protected
    FPlot: TPlotItem;
    FLastID: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function AddPlot(const x, y: Double; const t: Integer; const capt: string): integer;
    procedure DelPoint(const ix, iy: integer); // screnn coord

    procedure AddPlotWithID(const x, y: Double; const t: Integer;
      const capt: string; const id: integer);

    function FindByID(const plotid: integer): integer;
    procedure DelByID(const plotId: integer);

  published

  end;

implementation

uses
  SysUtils, uBaseCoordSystem;

{ TPlotItem }

constructor TPlotItem.Create;
begin
  inherited;

  FSymbol := TBitmapSymbol.Create;
  FSymbol.Offset.X := 0;
  FSymbol.Offset.Y := 0;

  FText := TInfoLabel.Create;
  FText.Color := clPurple;

  PlotID := 0;
end;

destructor TPlotItem.Destroy;
begin
  FSymbol.Free;
  FText.Free;

  inherited;
end;

procedure TPlotItem.ConvertCoord(cvt: TCoordConverter);
begin
  cvt.ConvertToScreen(Pos.X, pos.Y, center.x, center.y);
  FSymbol.Center := Center;
  FText.Center := Center;

end;

procedure TPlotItem.Draw(aCnv: TCanvas);
begin
  inherited;
  FSymbol.Draw(aCnv);
  if FText.Visible then
    FText.Draw(aCnv);

end;

function TPlotItem.getTextVisible: boolean;
begin
  Result := FText.Visible;
end;

procedure TPlotItem.setTextVisible(const Value: boolean);
begin
  FText.Visible := Value;
end;

function TPlotItem.getCapt: string;
begin
  Result := FText.Line1;
end;

procedure TPlotItem.setCapt(const Value: string);
begin
  FText.Line1 := VAlue;
end;

function TPlotItem.getSymIndex: Integer;
begin
  Result := FSymIndex;
end;

procedure TPlotItem.setSymIndex(const Value: Integer);
begin
  FSymIndex := Value;
end;

procedure TPlotItem.SetBitmap(bmp: TBitmap);
begin

  FSymbol.BitmapDraw(bmp);
end;

procedure TPlotItem.GetBitmap(bmp: TBitmap);
begin
  //
  FSymbol.getBitmap(bmp);
end;

{ TPlotSymbol }

function TPlotSymbol.AddPlot(const x, y: Double; const t: Integer;
  const capt: string): Integer;
var
  fPath, fName: string;
begin
  Result := -1;
  if t < 0 then Exit;

  FPlot := TPlotItem.Create;
  FPlot.Pos.X := x;
  FPlot.Pos.Y := y;
  FPlot.SymIndex := t;
  Result := FLastID;
  FPlot.PlotID := FLastID;
  Inc(FLastID);

  fPath := ExtractFilePath(ParamStr(0)) + 'data\symbols\plot\';

  FPlot.FText.Line1 := capt;

  FPlot.FText.Line2 := formatDMS_long(x);
  FPlot.FText.Line3 := formatDMS_lat(y);

  case t of
    0: begin
        fName := fPath + 'bouy.bmp';
        FPlot.FSymbol.LoadBitmap(fName); /// jangan load terus.
      end;
    1: begin
        fName := fPath + 'danger.bmp';
        FPlot.FSymbol.LoadBitmap(fName);
      end;
    2: begin
        fName := fPath + 'suar.bmp';
        FPlot.FSymbol.LoadBitmap(fName);
      end;
  end;
  FList.Add(FPLot);
end;

procedure TPlotSymbol.AddPlotWithID(const x, y: Double; const t: Integer;
  const capt: string; const id: integer);
var
  fPath, fName: string;
begin
  if t < 0 then Exit;

  FPlot := TPlotItem.Create;
  FPlot.Pos.X := x;
  FPlot.Pos.Y := y;
  FPlot.SymIndex := t;
  FLastID := id;
  FPlot.PlotID := FLastID;
  Inc(FLastID);

  fPath := ExtractFilePath(ParamStr(0)) + 'data\symbols\plot\';

  FPlot.FText.Line1 := capt;
  FPlot.FText.Line2 := formatDMS_long(x);
  FPlot.FText.Line3 := formatDMS_lat(y);
  case t of
    0: begin
        fName := fPath + 'bouy.bmp';
        FPlot.FSymbol.LoadBitmap(fName);
      end;
    1: begin
        fName := fPath + 'danger.bmp';
        FPlot.FSymbol.LoadBitmap(fName);
      end;
    2: begin
        fName := fPath + 'suar.bmp';
        FPlot.FSymbol.LoadBitmap(fName);
      end;
  end;
  FList.Add(FPLot);
end;

constructor TPlotSymbol.Create;
begin
  inherited;

end;

procedure TPlotSymbol.DelByID(const plotId: integer);
var
  i: Integer;
begin
  i := FindByID(plotId);
  if i >= 0 then FList.Delete(i);

end;

procedure TPlotSymbol.DelPoint(const ix, iy: integer);
var
  i: integer;
begin
  i := SearchByPos(ix, iy);
  if i >= 0 then begin
    FList.Delete(i);
  end;

end;

destructor TPlotSymbol.Destroy;
begin
  ClearItems;

  inherited;
end;

function TPlotSymbol.FindByID(const plotid: integer): integer;
var
  i: integer;
  de: TPlotItem;
  found: boolean;
begin
  result := -1;
  found := false;

  i := FList.Count - 1;
  while not found and (i >= 0) do begin
    de := FList.Items[i];
    found := de.PlotID = plotId;
    dec(i);
  end;
  if found then result := i + 1;

end;

end.

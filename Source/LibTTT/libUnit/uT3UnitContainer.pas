unit uT3UnitContainer;

interface

uses uSimContainers, uSimObjects, Windows, Graphics, Classes,uCoordConvertor;
type
  { container }
  TT3UnitContainer = class
  private
    FUnits : TSimContainer;
    FConverter: TCoordConverter;

    procedure   SetConverter(const Value: TCoordConverter);
  public
    constructor Create;
    destructor  Destroy; override;
    property    Converter : TCoordConverter read FConverter write SetConverter;

    procedure addObject(Val : TSimObject);
    procedure deleteObject(Val : TSimObject);
    procedure removeChilds(parent : TSimObject);
    function  getObject(index : integer) : TSimObject;
    function  getObjectByInstanceIndex(Instanceindex : Integer): TSimObject;
    function  itemCount : integer;
    procedure ClearAndRemove;

    procedure Draws(aCnv: tCanvas);
    procedure Moves(const aDeltaMs: double);
    procedure GameTime(const aGameTime: TDateTime);
    procedure UpdateVisuals;
    procedure UpdateAndDrawVisuals(aCnv: tCanvas;aRect : TRect);

    procedure Validate;

    procedure CleanUpObject;
    procedure ReturnList;
	  procedure ClearObjectEvent; //pak andik
    procedure ClearObjectAfterSnapshot; //add for clean object yang tidak dipakai setelah snapshot;
  end;

implementation

uses SysUtils;

{ TUnitContainer }

procedure TT3UnitContainer.addObject(Val: TSimObject);
begin
  val.Converter := Converter;
  FUnits.AddObject(Val);
end;

procedure TT3UnitContainer.CleanUpObject;
begin
  FUnits.CleanUpObject;
end;

procedure TT3UnitContainer.ClearAndRemove;
begin
  FUnits.ClearAndFreeObject;
end;

procedure TT3UnitContainer.ClearObjectAfterSnapshot;
var i : Integer;
    l : TList;
    sco : TSimObject;
    //p : double;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    try
      // test pointer
      if Assigned(sco) then
      begin
        sco.getPositionX;
        if sco.DeleteFromSnapshot then begin
//          FreeAndNil(sco);
          sco.FreeChilds;
          sco.Free;
          sco := nil;
          l.Delete(i);
        end;
      end;
    except
//      FreeAndNil(sco);
      sco.Free;
      //sco := nil;
      l.Delete(i);

      //FUnits.remove(i);
    end;
  end;

  l.Pack;
  FUnits.ReturnList;
end;

procedure TT3UnitContainer.ClearObjectEvent;
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    sco.OnDestroy := nil;
    //sco.OnHancur  := nil;
  end;

  FUnits.ReturnList;
end;

constructor TT3UnitContainer.Create;
begin
  FUnits := TSimContainer.Create;
end;

procedure TT3UnitContainer.deleteObject(Val: TSimObject);
begin
  FUnits.RemoveObject(Val);
end;

destructor TT3UnitContainer.Destroy;
begin
  FUnits.CleanUpObject;
  FUnits.ClearAndFreeObject;
  FUnits.Free;
  inherited;
end;

procedure TT3UnitContainer.Draws(aCnv: tCanvas);
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    if Assigned(sco) then
       sco.Draw(aCnv);
  end;

  FUnits.ReturnList;
end;

procedure TT3UnitContainer.GameTime(const aGameTime: TDateTime);
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    if Assigned(sco)  then
      sco.GameTime := aGameTime;
  end;

  FUnits.ReturnList;
end;

function TT3UnitContainer.getObject(index: integer): TSimObject;
var
    //tx : double;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;

  if (index < 0) or (index >= l.Count) then
    sco := nil
  else
    sco :=  l[index];

  result := sco;

  FUnits.ReturnList;
end;

function TT3UnitContainer.getObjectByInstanceIndex(
  Instanceindex: Integer): TSimObject;
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;
  sco := nil;
  Result := nil;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];

    if Assigned(sco)  then
    begin
      if sco.getInstanceIndex = Instanceindex then
      begin
        Result := sco;
        Break;
      end;
    end;
  end;

  FUnits.ReturnList;
end;

function TT3UnitContainer.itemCount: integer;
var
    l : TList;
begin
  l :=  FUnits.GetList;
  result := l.Count;
  FUnits.ReturnList;
end;

procedure TT3UnitContainer.Moves(const aDeltaMs: double);
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    if Assigned(sco)  then
      sco.Move(aDeltaMs);
  end;

  FUnits.ReturnList;
end;

procedure TT3UnitContainer.RemoveChilds(parent: TSimObject);
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    if Assigned(sco) and (sco.Parent = parent) then begin
      l.Delete(i);
      FreeAndNil(sco);
    end;
  end;

  FUnits.ReturnList;
end;

procedure TT3UnitContainer.ReturnList;
begin
  FUnits.ReturnList;
end;

procedure TT3UnitContainer.SetConverter(const Value: TCoordConverter);
begin
  FConverter := Value;
end;

procedure TT3UnitContainer.UpdateAndDrawVisuals(aCnv: tCanvas;aRect : TRect);
var i : Integer;
    l : TList;
    sco : TSimObject;
    PtObj : TPoint;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do
  begin
    sco := l[i];

    if Assigned(sco) then begin
      sco.UpdateVisual;

      Converter.ConvertToScreen(sco.getPositionX,sco.getPositionY,PtObj.X,PtObj.Y);

      //if PtInRect(aRect,PtObj) then
        sco.Draw(aCnv);
    end;
  end;

  FUnits.ReturnList;
end;

procedure TT3UnitContainer.UpdateVisuals;
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    if Assigned(sco)  then
      sco.UpdateVisual;
  end;

  FUnits.ReturnList;
end;

procedure TT3UnitContainer.Validate;
var i : Integer;
    l : TList;
    sco : TSimObject;
    //p : double;
begin
  l :=  FUnits.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    try
      // test pointer
      if Assigned(sco) then
      begin
        sco.getPositionX;
        if sco.AbsoluteFree and sco.FreeMe then begin
//          FreeAndNil(sco);
          sco.Free;
          sco := nil;
          l.Delete(i);
        end;
      end;
    except
//      FreeAndNil(sco);
      sco.Free;
      //sco := nil;
      l.Delete(i);

      //FUnits.remove(i);
    end;
  end;

  l.Pack;
  FUnits.ReturnList;
end;


end.

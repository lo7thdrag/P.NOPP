unit uGenericShip;

(*
  andySu, 2008 11 08
*)

interface

uses
  Windows, Classes, Graphics,
  uDataTypes, u2DMover, uGenericObject, uSimGlobalData,
  uDrawItems, uCoordConvertor, uSteppers, uWaypoints, uShipView;

type

  TOriginStatus = (osLocalTrack, osRemoteTrack);
  TMovementCheck = procedure (const x, y: Double; var allowMove: boolean) of object;


  //==============================================================================
  TGenericShip = class(TGenericObject)
  private
    FRightEngine,
      FLeftEngine,
      FRudder: TStepper;

    FEngine: array[0..2] of TStepper;
    FEnableMoveMent: Boolean;
    FCalcFuel: Boolean;
    FOnWpAlarm: TWayPointNotify;

    FOnMovementCheck: TMovementCheck;

    procedure UpdateShipTurnRate;
    procedure UpdateShipSize;

    //property methods
    function getEngineSpeed(const Index: Integer): double;
    procedure SetEngineSpeed(const Index: Integer; const Value: double);

    function getEngine(const Index: Integer): TStepper;
    function getShipCourse: double;
    procedure setShipCourse(const Value: double);
    procedure SetCalcMoveMent(const Value: Boolean);

    //    procedure ev_wpAlarmChange(sender: TObject);
    function getShowTote: boolean;
    procedure setShowTote(const Value: boolean);
    function getSelected: boolean;
    procedure setSelected(const Value: boolean);
    function getShipSize(const Index: Integer): Double;
    procedure setShipSize(const Index: Integer; const Value: Double);
    function getboundShape: TRecShipShape;

  protected

    FEngineDistanceFactor: double;
    FRudderFactor: double;

    FShipMaxSpeed,
      FShipMinSpeed: double;

    FShipSpeed    : double;
    FShipTurnRate : double;
    //drawing
    FSymbol       : TRotateCharSymbol;
    FLabel        : TInfoLabel;
    FHistory      : THistory;
    FViewCenter   : TPoint;
    FViewRect     : TRect;
    FSelectRect   : TSelectionMarker;

    FLineDbg      : TLineDebugView;

    FShipSize : TRecShipSize;

    orgShape,
    rotShape  : TRecShipShape;
    FTopView  : TShipTopView;

    procedure setEnabled(const Value: boolean); override;
  public
    ShipIndex: byte;
    TrackID: integer;
    ShipName: string;
    ShortName: string;
    Origin: TOriginStatus;
    Fuel: double;
    SavedPos,
      LastPos: t2DPoint;

    Callsign: string;

    LastEnabled: boolean;
    IpAddress: string;

    WayPoint: TWayPoints;
    FCTote: TCanvasTote;

    constructor Create;
    destructor Destroy; override;

    procedure Run(const aDeltaMs: double); override;
    procedure Update; override;

    procedure ConvertCoord(cvrt: TCoordConverter);
    procedure Draw(cnv: TCanvas);

    // command interface
    procedure Cmd_ChangeLeftEngineSpeed(const spdDest: double);
    procedure Cmd_ChangeRightEngineSpeed(const spdDest: double);
    procedure Cmd_ChangeRuderPosition(const rdPos: double);

    procedure AddHistory;
    function TestHit(const x, y: integer): boolean;

    procedure InitSpeed(const d: double);
    procedure InitCourse(const d: double);

    procedure SavePosition;
    procedure LoadPosition;

    procedure UpdateTote;
    procedure setDebugLabel(const s: string);
    procedure setDebugPoint(const dbgX, dbgY: double; const vis: boolean);

  public

    property LeftEngineSpeed: double index 0 read getEngineSpeed write SetEngineSpeed;
    property RightEngineSpeed: double index 1 read getEngineSpeed write SetEngineSpeed;

    property RuderPosition: double index 2 read getEngineSpeed write SetEngineSpeed;
    property ShipSpeed: double read FShipSpeed;
    property ShipCourse: double read getShipCourse write setShipCourse;

    property LeftEngine: TStepper index 0 read getEngine;
    property RightEngine: TStepper index 1 read getEngine;
    property Rudder: TStepper index 2 read getEngine;
    property History: THistory read FHistory write FHistory;

    property EnableMoveMent: Boolean read FEnableMoveMent write SetCalcMoveMent;
    property CalcFuel: Boolean read FCalcFuel write FCalcFuel;

    property OnWayPoint_Alarm: TWayPointNotify read FOnWpAlarm write FOnWpAlarm;

    property ShowTote: boolean read getShowTote write setShowTote;

    property Selected: boolean read getSelected write setSelected;

    property SizeLength: Double index 1 read getShipSize write setShipSize;
    property SizeBeam: Double   index 2 read getShipSize write setShipSize;
    property SizeDraft: Double  index 3 read getShipSize write setShipSize;

    property BoundShape : TRecShipShape read getboundShape;
    property OnMovementCheck: TMovementCheck read FOnMovementCheck write FOnMovementCheck;

  end;

  TGenericShipFactory = class
  protected

  public
    ShipFontName: string;
    ShipSymbolSize: byte;
    ShipSymbolColor: TColor;
    shipLabelColor: TColor;

    constructor Create;

    function GenerateShipByShipIndex(shipIx: byte): TGenericShip;

    //load
  end;

procedure InitShipState(const st: TRecShipStateData;
  var gShip: TGenericShip);
procedure ExtractShipStateData(const gShip: TGenericShip;
  var rsState: TRecShipStateData);

var
  ShipFactory: TGenericShipFactory;
  gship : TGenericShip; // global temp.

implementation

uses
  Math, SysUtils, uBaseCoordSystem, uShipDBase, uSimFunction, uSimDrawing;

const

  C_HitSize = 6;
  { TGenericShip }

constructor TGenericShip.Create;
begin
  inherited;

  FEngineDistanceFactor := 12000;
  FRudderFactor := 0.15;

  FShipMinSpeed := -10.0;
  FShipMaxSpeed := 40.0;

  FRightEngine := TStepper.Create;
  FLeftEngine := TStepper.Create;
  FRudder := TStepper.Create;

  FEngine[0] := FLeftEngine;
  FEngine[1] := FRightEngine;
  FEngine[2] := FRudder;

  FRudder.MinValue := -35.0;
  FRudder.MaxValue :=  35.0;

  FRudder.IncRate :=  0.5;
  FRudder.DecRate := -0.5;

  FSymbol := TRotateCharSymbol.Create;

  FLabel := TInfoLabel.Create;
  FHistory := THistory.Create;

  Fuel := 100.0;

  WayPoint := TWayPoints.Create;
  WayPoint.Visible := false;
  WayPoint.AllInfoVisible := False;

  WayPoint.OnWP_Alarm := nil;

  Enabled := False;
  FEnableMoveMent := False;
  FCalcFuel := True;

  FCTote := TCanvasTote.Create;
  FCTote.Visible := false;

  FSelectRect := TSelectionMarker.Create;
  FSelectRect.Visible := False;

  FTopView  := TShipTopView.Create;
  FTopView.Visible := True;

  FLineDbg      := TLineDebugView.Create;
  FLineDbg.Visible := True;

end;
// map view Change!

destructor TGenericShip.Destroy;
begin
  FTopView.Free;

  FSelectRect.Free;

  FCTote.Free;
  WayPoint.Free;

  FHistory.Free;
  FLabel.Free;
  FSymbol.Free;

  FEngine[2] := nil;
  FEngine[1] := nil;
  FEngine[0] := nil;

  FRudder.Free;
  FLeftEngine.Free;
  FRightEngine.Free;

  inherited;
end;

function TGenericShip.getEngineSpeed(const Index: Integer): double;
begin
  result := FEngine[Index].Value;
end;

procedure TGenericShip.SetEngineSpeed(const Index: Integer;
  const Value: double);
begin
  FEngine[Index].Value := Value;
  FEngine[Index].StepTo(Value);

  UpdateShipTurnRate;
end;

procedure TGenericShip.UpdateShipTurnRate;
var
  vR, vL: double;
begin
  FShipSpeed := FLeftEngine.Value + FRightEngine.Value;
  EnsureRange(FShipSpeed, FShipMinSpeed, FShipMaxSpeed);

  vR := C_RadToDeg * ArcTan2(FRightEngine.Value, FEngineDistanceFactor);
  vL := C_RadToDeg * ArcTan2(FLeftEngine.Value, FEngineDistanceFactor);
  FShipTurnRate := -FRudder.Value * FRudderFactor + (vR - vL);

end;

procedure TGenericShip.UpdateShipSize;
var t : TRecShipShape;
   sFact : double;
begin
  orgShape := CreateShipShape(FShipSize);
  sFact := 1.0 / (1852.0 * 60.0);
  orgShape := ScaleShipShape(orgShape, sFact);

  rotShape := RotateShipShape(orgShape, FMover.Direction);
  FTopView.FShape := TranslateShipShape(rotShape, FMover.X, FMover.Y);
end;


procedure TGenericShip.Run(const aDeltaMs: double);
var
  h, rate: double;
  allowMove : Boolean;
begin
  if not FEnabled then Exit;

  if FEnableMoveMent then begin

    FRightEngine.Move(aDeltaMs);
    FLeftEngine.Move(aDeltaMs);
    FRudder.Move(aDeltaMs);

    UpdateShipTurnRate;

    FMover.TurnRate := FShipTurnRate;
    FMover.Acceleration := 0.0; // calc by engine
    FMover.Speed := FShipSpeed;

    LastPos.X := FMover.X;
    LastPos.Y := FMover.Y;

    FMover.Move(aDeltaMs);

    rotShape        := RotateShipShape(orgShape,  FMover.Direction);
    FTopView.FShape := TranslateShipShape(rotShape, FMover.X, FMover.Y);

    if Assigned(FOnMovementCheck) then begin
      FOnMovementCheck(FMover.X, FMover.Y, allowMove);
      if not allowMove then begin
        FMover.X := LastPos.X;
        FMover.Y := LastPos.Y;
        LeftEngineSpeed   := 0;
        RightEngineSpeed  := 0;

      end;
    end;

    if FCalcFuel then begin

      h := (0.001 * aDeltaMs) / 3600.0;
      //rate := 1.0; 1 persen per jam
      rate := FMover.Speed / 15;

      Fuel := fuel - h * rate;
      if Fuel < 0 then Fuel := 0;
    end;
  end;
end;

procedure TGenericShip.Update;
begin
//  inherited;

end;

// kendali kapal.
procedure TGenericShip.Cmd_ChangeLeftEngineSpeed(const spdDest: double);
begin
  FLeftEngine.StepTo(spdDest);
end;

procedure TGenericShip.Cmd_ChangeRightEngineSpeed(const spdDest: double);
begin
  FRightEngine.StepTo(spdDest);
end;

procedure TGenericShip.Cmd_ChangeRuderPosition(const rdPos: double);
begin
  FRudder.StepTo(rdPos);
end;

function ptToRect(const pt: TPoint; const r: integer): TRect;
begin
  result := Rect(pt.X - r, pt.Y - r, pt.X + r, pt.Y + r)
end;

procedure TGenericShip.ConvertCoord(cvrt: TCoordConverter);
var ct: TPoint;
    sc: Double;
begin
  cvrt.ConvertToScreen(X, Y, ct.x, ct.y);
  FViewCenter := ct;
  FViewRect := ptToRect(ct, C_HitSize);

  FSymbol.Center := ct;
  FSymbol.Rotation := FMover.Direction;
  //  FSymbol.Rotation := ShipCourse;
  FSelectRect.Center := ct;

  FLabel.Center := ct;
  FLabel.Line1 := ShortName;
  sc := ShipCourse;
  if (sc >= 359.9) then
    if sc < 360.1 then
      sc := 0.0
    else
      sc := sc - 360.0;

  FLabel.Line2 := Format('%3.1f', [sc]);

  FLabel.Line3 := Format('%2.1f', [ShipSpeed]);
  FHistory.ConvertCoord(cvrt);

  WayPoint.ConvertCoord(cvrt);
  WayPoint.ShipInf.Speed  := ShipSpeed;
  WayPoint.ShipInf.Course := ShipCourse;
  WayPoint.ShipInf.Pos.X  := X;
  WayPoint.ShipInf.Pos.Y  := Y;
  WayPoint.ShipInf.Fuel   := Fuel;

  WayPoint.ShipMoved;
  //  WayPoint.OnWP_Alarm := ev_wpAlarmChange;
  WayPoint.OnWP_Alarm := nil;

  FCTote.Center := ct;
  FCTote.ConvertCoord(cvrt);

  FTopView.ConvertCoord(cvrt);

  FLineDbg.mStart.X := X;
  FLineDbg.mStart.Y := Y;

  FLineDbg.ConvertCoord(cvrt);

end;

procedure TGenericShip.Draw(cnv: TCanvas);
begin
  FCTote.Draw(cnv);
  WayPoint.Draw(cnv);
  FHistory.Draw(cnv);
  FLabel.Draw(cnv);
  FSymbol.Draw(cnv);
  FTopView.Draw(cnv);
  FSelectRect.Draw(cnv);

  FLineDbg.Draw(cnv);
end;

function TGenericShip.getShipCourse: double;
begin
  result := ValidateDegree(ConvCartesian_To_Compass(FMover.Direction));

end;

procedure TGenericShip.setShipCourse(const Value: double);
begin
  FMover.Direction := ConvCompass_To_Cartesian(Value);
end;

function TGenericShip.getEngine(const Index: Integer): TStepper;
begin
  result := FEngine[Index];
end;

//------------------------------------------------------------------------------

procedure TGenericShip.AddHistory;
begin
  FHistory.AddPoint(FMover.X, FMover.Y, now);
end;

function TGenericShip.TestHit(const x, y: integer): boolean;
begin
  result := PtInRect(FViewRect, Point(x, y));
end;

procedure TGenericShip.SetCalcMoveMent(const Value: Boolean);
begin
  FEnableMoveMent := Value;
  FMover.Enabled := Value;

end;

//==============================================================================

procedure TGenericShip.setEnabled(const Value: boolean);
begin
  inherited;

end;

procedure TGenericShip.InitSpeed(const d: double);
begin
  FRightEngine.Value := 0.5 * d;
  FLeftEngine.Value := 0.5 * d;
  FShipSpeed := d;
  UpdateShipTurnRate;

end;

procedure TGenericShip.InitCourse(const d: double);
begin
  FMover.Direction := ConvCompass_To_Cartesian(d);
end;

procedure TGenericShip.LoadPosition;
begin
  FMover.X := SavedPos.X;
  FMover.Y := SavedPos.Y;

end;

procedure TGenericShip.SavePosition;
begin
  SavedPos.X := FMover.X;
  SavedPos.Y := FMover.Y;
end;

function TGenericShip.getShowTote: boolean;
begin
  Result := FCTote.Visible;
end;

procedure TGenericShip.setShowTote(const Value: boolean);
begin
  FCTote.Visible := Value;
end;

procedure TGenericShip.UpdateTote;
begin
  if not FCTote.Visible then Exit;
  FCTote.IShipName := ShipName;
  FCTote.ICallSign := Callsign;
  FCTote.ICourse := FormatFloat('000', ShipCourse);
  FCTote.ISpeed := FormatFloat('000', ShipSpeed);
  FCTote.IShipX := formatDMS_long(X);
  FCTote.IShipY := formatDMS_lat(Y);

end;

function TGenericShip.getSelected: boolean;
begin
  Result := FSelectRect.Visible;
end;

procedure TGenericShip.setSelected(const Value: boolean);
begin
  FSelectRect.Visible := Value;
end;

function TGenericShip.getShipSize(const Index: Integer): Double;
begin
  Result := 0;
  case index of
    1 : Result := FShipSize.Length;
    2 : Result := FShipSize.Beam;
    3 : Result := FShipSize.Draft;
  end;
end;

procedure TGenericShip.setShipSize(const Index: Integer;
  const Value: Double);
begin
  case index of
    1 : FShipSize.Length  := Value;
    2 : FShipSize.Beam    := Value;
    3 : FShipSize.Draft   := Value;
  end;
end;

procedure TGenericShip.setDebugLabel(const s: string);
begin
//  FLabel.LineDebug := s;
end;

procedure TGenericShip.setDebugPoint(const dbgX, dbgY: double; const vis: boolean);
begin
  if Vis then begin
    FLineDbg.mStart.X := Self.x;
    FLineDbg.mStart.Y := Self.y;

    FLineDbg.mEnd.X := dbgX;
    FLineDbg.mEnd.Y := dbgY;
    FLineDbg.Visible := True;
  end
  else begin
    FLineDbg.Visible := False;

  end;
end;


function TGenericShip.getboundShape: TRecShipShape;
begin
  Result := FTopView.FShape;
end;

{ TGenericShipFactory }

constructor TGenericShipFactory.Create;
begin
  inherited;
  ShipFontName    := 'ShipSymbol';
  ShipSymbolSize  := 20;
  ShipSymbolColor := clBlue;
  shipLabelColor  := clBlue;
end;

function TGenericShipFactory.GenerateShipByShipIndex(shipIx: byte): TGenericShip;
var
  sClassDB: TShipClassDB;
  sFixDB: TShipFixDB;
begin

  sFixDB := ShipDataBase.GetShipFix(shipIx);
  sClassDB := ShipDataBase.GetShipClass(sFixDB.classID);

  Result := TGenericShip.Create;

  with result do begin
    ShipIndex := shipIx;

    FRightEngine.IncRate := sClassDB.acellerate * 0.5;
    FRightEngine.DecRate := sClassDB.decellerate * 0.5;
    FRightEngine.MinValue := -Abs(sClassDB.minspeed * 0.5);
    FRightEngine.MaxValue := Abs(sClassDB.maxspeed * 0.5);

    FLeftEngine.IncRate := sClassDB.acellerate * 0.5;
    FLeftEngine.DecRate := sClassDB.decellerate * 0.5;
    FLeftEngine.MinValue := -Abs(sClassDB.minspeed * 0.5);
    FLeftEngine.MaxValue := Abs(sClassDB.maxspeed * 0.5);

    FRudder.IncRate := sClassDB.ruderrate;
    FRudder.DecRate := sClassDB.ruderrate;
    FRudder.MinValue := -Abs(sClassDB.ruder);
    FRudder.MaxValue := sClassDB.ruder;
    FRudder.Value := 0.0;
    FRudderFactor := 0.15;

    FShipMinSpeed := -Abs(sClassDB.minspeed);
    FShipMaxSpeed := Abs(sClassDB.maxspeed);

    FEngineDistanceFactor := sClassDB.enginefactor;

    FSymbol.CharSymbol:= sClassDB.ClassSymbol;
    FShipSize.Length  := sClassDB.Length;
    FShipSize.Beam    := sClassDB.Beam;
    FShipSize.Draft   := sClassDB.Draft;

    UpdateShipSize;


    FSymbol.FontName  := ShipFontName; // constan
    FSymbol.Size      := ShipSymbolSize;
    FSymbol.Color     := ShipSymbolColor;
    FLabel.Color      := shipLabelColor;

    ShipName  := sFixDB.ShipName;
    ShortName := sFixDB.ShortName;
    UniqueID  := sFixDB.ShipNumber;
    Callsign  := sFixDB.ShortName;
  end;

end;

procedure InitShipState(const st: TRecShipStateData;
  var gShip: TGenericShip);
begin
  with st do begin
    gShip.X := X;
    gShip.Y := Y;
    gShip.Z := 0;
    gShip.SetHeading(Course);
    gShip.FLeftEngine.Value := LSpeed;
    gShip.FLeftEngine.StepTo(LSpeedTo);

    gShip.FRightEngine.Value := RSpeed;
    gShip.FRightEngine.StepTo(RSpeedTo);

    gShip.FRudder.Value := Rudder;
    gShip.FRudder.StepTo(Rudderto);

    gShip.UpdateShipTurnRate;
  end;

end;

procedure ExtractShipStateData(
  const gShip: TGenericShip;
  var rsState: TRecShipStateData);
begin
  rsState.ixShip := gShip.ShipIndex;
  rsState.X := gShip.X;
  rsState.Y := gShip.Y;
  //  rsState.Z         := gShip.Z;
  rsState.Course    := gShip.Heading;
  rsState.LSpeed    := gShip.FLeftEngine.Value;
  rsState.LSpeedTo  := gShip.FLeftEngine.TargetValue;
  rsState.RSpeed    := gShip.FRightEngine.Value;
  rsState.RSpeedTo  := gShip.FRightEngine.TargetValue;
  rsState.Rudder    := gShip.FRudder.Value;
  rsState.Rudderto  := gShip.FRudder.TargetValue
end;

end.

unit uWayPoints;

interface

uses
  Classes, Windows, Graphics, uDataTypes, uCoordConvertor,
  uSimContainers, uSimDrawing, uGameDataType;

type

  TWayPointNotify = procedure(const sUID: string; const state: byte) of object;

  //============================================================================
  TShipInfo = record
    Speed: double; // always knots
    Course: double; // compass
    Pos: t2DPoint;
    iX, iY: integer; // convert frompos
    Fuel: double; // persen
  end;

  //============================================================================
  TCheckPointInfo = record
    // inputs:
    //    Speed: double; // ship speed starting at this point

    //output:
    // to next checkPoint;
    Distance,
      Direction: double; //

    EstHour: double; //
    EstTime: TDateTime;
    //lastDist, deltaDist: double;
  end;

  //============================================================================
  TCheckPoint = class
  private
    FPos: t2DPoint; // position in long latt
    FSpeed: single; // ship speed starting at this point
    FBmp: TBitmap;
    FDRect: TRect;

    procedure setSpeed(const Value: integer);
    function getSpeed: integer;
  public
    Center: TPoint; // screen coord
    Color: TColor;
    passed: boolean;
    ShowInfo: boolean;
    info: TCheckPointInfo;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter);
    procedure Draw(cvs: TCanvas);

    property Pos: t2DPoint read FPos write FPos;
    property X: double read FPos.X write FPos.X;
    property Y: double read FPos.Y write FPos.Y;

    property Speed: integer read getSpeed write setSpeed;

  end;

  //============================================================================
  TWayPoints = class(TDrawElement)
  private
    FList: TList;
    FCP: TCheckPoint; // tmp
    FBmp: TBitmap;
    FDRect: TRect;

    FCIndex: integer; // index to next checkPoint;

    FOnWP_Alarm: TNotifyEvent;
    FBlink, FBlinkStat: boolean;
    FWpWidth: integer;
    FAllInfoVisible: boolean;
    fWarningStatus: TWarningStatus;
    function getCount: Integer;
    procedure setAllInfoVisible(const Value: boolean);

  public
    ShipInf: TShipInfo;

    EstimatedTime,
      totalDistance: double;
    nextDist,
      nextTime: double;
    lastDist: double; //from cp

    InfoVisible,
      LineVisible: boolean;

    nextCourse,
      rCourse: Double;

    wpDistance,
      wpDistAlarm: double;
    wpAlarmEnabled: boolean;

    constructor Create;
    destructor Destroy; override;

    function SearchByPos(const x, y: integer): integer; // return index of list.

    function AddPoint(const x, y, speed: double): TCheckPoint; // map coord

    procedure DeletePoint(const i: integer);
    procedure ToggleInfo(const i: integer); // screen coord

    function GetPoint(const i: integer): TCheckPoint;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCnv: TCanvas); override;

    procedure Calculation;
    procedure ShipMoved;

    procedure ClearPoint;

  public
    property PointCount: Integer read getCount;

    property OnWP_Alarm: TNotifyEvent read FOnWP_Alarm write FOnWP_Alarm;
    property WarningStatus: TWarningStatus read FWarningStatus;

    property AllInfoVisible: boolean read FAllInfoVisible write setAllInfoVisible;

  end;
const
  // param FOnWayPointInfo
  C_WPInfo_None = 0; // no waypoint
  C_WPInfo_exist = 1; // waypoint,no alarm
  C_WPInfo_alarm_1 = 2;
  C_WPInfo_alarm_2 = 3;

implementation

uses
  SysUtils, uBaseCoordSystem, uSimFUnction;
//  uSimContainers;
 //============================================================================

{ TCheckPoint }

constructor TCheckPoint.Create;
begin
  ShowInfo := true;

  FDRect := Rect(0, 0, 108, 56);

  FBmp := TBitmap.Create;
  FBmp.PixelFormat := pf24bit;

  FBmp.Width := FDRect.Right;
  FBmp.Height := FDRect.Bottom;

  FBmp.Canvas.Brush.Color := clBlack;
  FBmp.Canvas.FillRect(FDRect);

end;

destructor TCheckPoint.Destroy;
begin
  FBmp.Dormant;
  FBmp.FreeImage;
  FBmp.ReleaseHandle;

  FBmp.Free;

  inherited;
end;

procedure TCheckPoint.setSpeed(const Value: integer);
begin
  FSpeed := Value;
end;

procedure TCheckPoint.ConvertCoord(cvt: TCoordConverter);
begin
  cvt.ConvertToScreen(FPos.X, FPos.Y, center.x, center.y);
end;

{
procedure DrawCheckInfo(aCnv: TCanvas; ct: tPoint; cl: tColor; cp: TCheckPointInfo);
var s: string;
    x: integer;
begin
  x := ct.X + 16;

  aCnv.Font.Color := cl;
  with aCnv do begin
    s := 'Speed: ' + Format('%2.2f knots', [cp.Speed ]);
    aCnv.TextOut(x , ct.Y + 12,  s);

    s := 'Direction: ' + Format('%2.1f', [cp.Direction ]);
    aCnv.TextOut(x , ct.Y + 24,  s);

    s := 'Distance: ' + Format('%2.2f nm', [cp.Distance ]);
    aCnv.TextOut(x , ct.Y + 36,  s);

    s := 'est: ' + FormatDateTime('hh:nn:ss', cp.EstTime) ;
    aCnv.TextOut(x , ct.Y + 48,  s);

  end;
end;
}

procedure TCheckPoint.Draw(cvs: TCanvas);
var
  s: string;
  x: integer;
  b: TBlendFunction;
  r: TRect;
begin
  if not ShowInfo then Exit;

  with b do begin
    BlendOp := AC_SRC_OVER;
    BlendFlags := 0;
    AlphaFormat := 0;
    SourceConstantAlpha := 160;
  end;
  r := Rect(Center.x + 12, Center.y + 12, Center.x + 108, Center.Y + 64);

  AlphaBlend(cvs.Handle, r.Left - 2, r.Top, FDRect.Right - 2, FDRect.Bottom,
    Fbmp.Canvas.Handle, 0, 0, FDRect.Right, FDRect.Bottom, b);

  x := center.X + 16;
  cvs.Font.Color := RGB(255, 192, 63);

  with cvs do begin
    s := 'Speed: ' + Format('%2.1f knots', [FSpeed]);
    TextOut(x, Center.Y + 16, s);

//    s := 'Direction: ' + Format('%2.1f', [info.Direction ]);
    s := 'Direction: ' + FormatCourse(info.Direction);
    TextOut(x, Center.Y + 28, s);

    s := 'Distance: ' + Format('%2.2f nm', [info.Distance]);
    TextOut(x, Center.Y + 40, s);

    s := 'est: ' + FormatDateTime('hh:nn:ss', info.EstTime);
    TextOut(x, Center.Y + 52, s);
  end;

end;

//============================================================================

function TCheckPoint.getSpeed: integer;
begin
  result := Round(FSpeed)
end;

{ TWayPoints }

constructor TWayPoints.Create;
begin
  FList := TList.Create;

  FCIndex := -1;
  ;

  lastDist := 99999;

  wpDistance := 0.0;
  wpDistAlarm := 0.5; // naut
  wpAlarmEnabled := true;
  FBlink := false;
  FBlinkStat := false;
  FWpWidth := 0;
  InfoVisible := false;
  LineVisible := false;

  Visible := TRUE;

  FAllInfoVisible := False;

  fWarningStatus := wsNoWarning;

  FDRect := Rect(0, 0, 182, 100);

  FBmp := TBitmap.Create;
  FBmp.PixelFormat := pf24bit;

  FBmp.Width := FDRect.Right;
  FBmp.Height := FDRect.Bottom;

  FBmp.Canvas.Brush.Color := clBlack;
  FBmp.Canvas.FillRect(FDRect);

end;

destructor TWayPoints.Destroy;
begin
  ClearAndFreeItems(FList);
  FList.Free;

  FBmp.Dormant;
  FBmp.FreeImage;
  FBmp.ReleaseHandle;

  FBmp.Free;

  inherited;
end;

function ptToRect(const pt: TPoint; const r: integer): TRect;
begin
  result := Rect(pt.X - r, pt.Y - r, pt.X + r, pt.Y + r)
end;

function TWayPoints.SearchByPos(const x, y: integer): integer; // return index of list.
const
  C_HIT_SIZE = 6;
var
  i: integer;
  cp: TCheckPoint;
  r: TREct;
  found: boolean;
begin
  result := -1;
  found := false;
  r := ptToRect(Point(x, y), C_HIT_SIZE);

  i := FList.Count - 1;
  while not found and (i >= 0) do begin
    cp := FList.Items[i];
    found := PtInRect(r, cp.Center);
    dec(i);
  end;
  if found then result := i + 1;

end;

procedure TWayPoints.ClearPoint;
begin
  ClearAndFreeItems(FList);

  InfoVisible := false;
  LineVisible := False;
  Visible := False;
end;

function TWayPoints.AddPoint(const x, y, speed: double): TCheckPoint; // map coord
begin
  FCP := TCheckPoint.Create;

  FCP.X := x;
  FCP.Y := y;

  FCP.passed := false;
  FCP.ShowInfo := false;

  FList.Add(FCP);

  if FList.Count = 1 then begin
    FCIndex := 0;
    fWarningStatus := wsGreen;
    if Assigned(FOnWP_Alarm) then FOnWP_Alarm(Self);

  end;

  result := FCP;
  FCP.Speed := Round(speed);

  Calculation;
end;

procedure TWayPoints.DeletePoint(const i: integer); // index di list
begin
  if (i < 0) or (i >= FList.Count) then Exit;
  FList.Delete(i);

  if FList.Count = 0 then begin
    FCIndex := -1;
    InfoVisible := false;
    fWarningStatus := wsNoWarning;
    if Assigned(FOnWP_Alarm) then FOnWP_Alarm(Self);

  end;
  Calculation;

end;

function TWayPoints.GetPoint(const i: integer): TCheckPoint; //
begin
  if (i < 0) or (i >= FList.Count) then
    Result := nil
  else
    Result := FList.Items[i];
end;

procedure TWayPoints.ToggleInfo(const i: integer); // screen coord
var
  cp: TCheckPoint;
begin
  if (i < 0) or (i >= FList.Count) then Exit;
  cp := FList.Items[i];
  cp.ShowInfo := not cp.ShowInfo;
end;

procedure TWayPoints.ConvertCoord(cvt: TCoordConverter);
var
  i: integer;
  cp: TCheckPoint;
begin

  if FList.Count < 1 then Exit;
  for i := 0 to FList.Count - 1 do begin
    cp := FList.Items[i];
    cp.ConvertCoord(cvt);
  end;
  cvt.ConvertToScreen(ShipInf.Pos.X, ShipInf.Pos.Y, ShipInf.iX, ShipInf.iY);

  FWpWidth := cvt.ScreenDistance(ShipInf.Pos.X, ShipInf.Pos.Y, wpDistAlarm / C_Degree_To_NauticalMile);
end;

procedure TWayPoints.Draw(aCnv: TCanvas);
var
  i: integer;
  cp: TCheckPoint;
  r: TRect;
  lPt: TPoint;
  s: string;
  b: TBlendFunction;
begin
  if not Visible then exit;

  aCnv.Brush.Color := clRed;
  aCnv.Brush.Style := bsSolid;
  aCnv.Pen.Mode := pmCopy;

  SetBkMode(aCnv.Handle, TRANSPARENT);

  if LineVisible then begin

    if (FCIndex >= 0) and (FCIndex < FList.Count) then begin
      aCnv.Pen.Color := clFuchsia;
      aCnv.Pen.Style := psSolid;

      cp := FList.Items[FCIndex];
      lPt := cp.Center;

      if FBlink and FBlinkStat then
        aCnv.Pen.Width := 2
      else
        aCnv.Pen.Width := 1;
      aCnv.MoveTo(ShipInf.iX, ShipInf.iY);
      aCnv.LineTo(lpt.X, lpt.Y);
    end;

    aCnv.Pen.Color := clBlue;
    aCnv.Pen.Style := psSolid;

    aCnv.Font.Color := clNavy;
    aCnv.Font.Size := 8;

    if FList.Count > 0 then begin
      cp := FList.Items[0];
      lPt := cp.Center;
      r := ptToRect(lPt, 5);
      aCnv.Ellipse(r);
    end;

    if FList.Count > 1 then begin
      for i := 1 to FList.Count - 1 do begin
        cp := FList.Items[i];

        aCnv.MoveTo(lpt.X, lpt.Y);
        aCnv.LineTo(cp.Center.X, cp.Center.Y);
        lPt := cp.Center;

        r := ptToRect(cp.Center, FWpWidth);

        aCnv.Arc(r.Left, r.Top, r.Right, r.Bottom, 0, 0, 0, 0);

        r := ptToRect(cp.Center, 5);

        aCnv.Brush.Style := bsSolid;
        aCnv.Ellipse(r);
        aCnv.TextOut(cp.Center.X + 2, cp.Center.Y - 8, IntToStr(i));
      end;

    end;
  end;

  if InfoVisible then begin
    for i := 0 to FList.Count - 2 do begin
      cp := FList.Items[i];
      if cp.ShowInfo then
        cp.Draw(aCnv);
    end;

    r := Rect(ShipInf.iX - 22, ShipInf.iY + 28, ShipInf.iX - 22 + 200, ShipInf.iY + 28 + 120);

    with b do begin
      BlendOp := AC_SRC_OVER;
      BlendFlags := 0;
      AlphaFormat := 0;
      SourceConstantAlpha := 160;
    end;

    AlphaBlend(aCnv.Handle, r.Left - 7, r.Top, FDRect.Right - 7, FDRect.Bottom,
      Fbmp.Canvas.Handle, 0, 0, FDRect.Right, FDRect.Bottom, b);

    aCnv.Font.Color := RGB(255, 160, 63);

    with aCnv do begin
      s := 'Next Distance';
      aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 35, s);

      s := Format(': %2.2f nm', [nextDist]);
      aCnv.TextOut(ShipInf.iX + 58, ShipInf.iY + 35, s);

      s := 'Next ETA';
      aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 47, s);
      s := ': ' + FormatDateTime('hh:nn:ss', nextTime);
      aCnv.TextOut(ShipInf.iX + 58, ShipInf.iY + 47, s);

      s := 'Course (rel)';
      aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 59, s);

      s := ': ' + FormatCourse(Abs(rCourse));
      if rCourse < 0.0 then
        s := s + ' port'
      else
        s := s + ' stbd';
      aCnv.TextOut(ShipInf.iX + 58, ShipInf.iY + 59, s);

      aCnv.Font.Color := RGB(255, 127, 31);

      s := 'End Distance';
      aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 75, s);
      s := ': ' + Format('%2.2f nm', [totalDistance]);
      aCnv.TextOut(ShipInf.iX + 58, ShipInf.iY + 75, s);

      s := 'ETA';
      aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 87, s);
      s := ': ' + FormatDateTime('hh:nn:ss', EstimatedTime);
      aCnv.TextOut(ShipInf.iX + 58, ShipInf.iY + 87, s);

      aCnv.Font.Color := RGB(255, 127, 15);
      s := 'Fuel';
      aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 103, s);
      s := ': ' + Format('%2.2f ', [ShipInf.Fuel]) + '%';
      aCnv.TextOut(ShipInf.iX + 58, ShipInf.iY + 103, s);

//dist form line
//      s := 'wpdist: ' + Format('%2.2f ', [ wpDistance]) + 'nm';
//      aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 120,  s);

  //    s := 'INDEX: ' + IntToStr(FCIndex);
  //    aCnv.TextOut(ShipInf.iX - 20, ShipInf.iY + 100,  s);
    end;
  end;

end;

procedure TWayPoints.Calculation;
// dihitung sesudah add / remove checkpoint
var
  i: integer;
  cp1, cp2: TCheckPoint;
  totdist: double;
  tottime: double;

begin
  totdist := 0.0;
  tottime := 0.0;

  if FList.Count > 1 then begin
    for i := 0 to FList.Count - 2 do begin
      cp1 := FList.Items[i];
      cp2 := FList.Items[i + 1];
      with cp1.info do begin
        Distance := CalcRange(cp1.X, cp1.Y, cp2.X, cp2.Y);
        Direction := CalcBearing(cp1.X, cp1.Y, cp2.X, cp2.Y);
        if abs(cp1.Speed) > 0.0000001 then begin
          EstHour := Distance / cp1.Speed;
        end
        else
          EstHour := -1.0;
        EstTime := EstHour / 24.0;

      end;
      totdist := totdist + cp1.info.Distance;
      tottime := tottime + cp1.info.EstTime;
    end;

  end;

end;

procedure TWayPoints.ShipMoved;
var
  cpTo: TCheckPoint;
  dist, dirs, est: double;
  xDist: double;
  xEst: double;
  i: integer;
  cp1, cp2: TCheckPoint;
  c: Char;
  prevStat: TWarningStatus;
begin

  if FCIndex >= FList.Count then FCIndex := -1; // last
  if (FCIndex < 0) then exit; // belum ada check point

  cpTo := FList.Items[FCIndex];
  dist := CalcRange(ShipInf.Pos.X, ShipInf.Pos.Y, cpTo.X, cpTo.Y);
  dirs := CalcBearing(ShipInf.Pos.X, ShipInf.Pos.Y, cpTo.X, cpTo.Y);

  // calc distance net control point from ship;

  if abs(ShipInf.Speed) > 0.0000001 then begin
    est := (dist / ShipInf.Speed) / 24.0;
  end
  else
    est := -1.0;

  xDist := 0;
  xEst := 0;

  for i := FCIndex to FList.Count - 2 do begin
    cp1 := FList.Items[i];
    xDist := xDist + cp1.info.Distance;
    xEst := xEst + cp1.info.EstTime;
  end;

  totalDistance := dist + xDist;
  EstimatedTime := est + xEst;

  nextDist := dist;
  nextTime := est;

  if dist < wpDistAlarm then begin //
    if lastDist < dist then begin
      inc(FCIndex);
      lastDist := 999999.99;
      if FCIndex >= FList.Count then FCIndex := -1;
    end
    else
      lastDist := dist;
  end;

  // calc distance from wayPoint line;
  if (FCIndex > 0) then begin
    cp2 := FList.Items[FCIndex];
    cp1 := FList.Items[FCIndex - 1];

    wpDistance := ptToLineDistance(cp1.Pos, cp2.Pos, ShipInf.Pos) * C_Degree_To_NauticalMile;
    xDist := 0.5 * wpDistAlarm;

    if wpAlarmEnabled then begin
      prevStat := fWarningStatus;

      if (wpDistance > wpDistAlarm) then begin
        fWarningStatus := wsRed;
        FBlink := true;
        FBlinkStat := not FBlinkStat;
      end
      else begin
        if (wpDistance > xDist) then
          fWarningStatus := wsYellow
        else
          fWarningStatus := wsGreen;

        FBlink := false;
        FBlinkStat := false;
      end;

      if prevStat <> fWarningStatus then
        if Assigned(FOnWP_Alarm) then FOnWP_Alarm(self);

    end;
{
    if wpAlarmEnabled and (wpDistance > wpDistAlarm) then begin
      if not FBlink then
         // muncul klo ada perubahan status
         if Assigned(FOnWP_Alarm) then  FOnWP_Alarm(self);
      FBlink := true;
      FBlinkStat := not FBlinkStat;
    end
    else begin
      if FBlink then
         if Assigned(FOnWP_Alarm) then  FOnWP_Alarm(self);
         // muncul klo ada perubahan status
      FBlink := false;
      FBlinkStat := false;
    end;
}
  end;

  nextCourse := dirs;
  degreeToRedGreen(ShipInf.Course - dirs, c, rCourse);
  if c = 'R' then
    rCourse := Abs(rCourse)
  else
    rCourse := -Abs(rCourse);
end;

function TWayPoints.getCount: Integer;
begin
  result := FList.Count;
end;

procedure TWayPoints.setAllInfoVisible(const Value: boolean);
var
  i: Integer;
  cp1: TCheckPoint;
begin
  FAllInfoVisible := Value;
  for i := FCIndex to FList.Count - 2 do begin
    cp1 := FList.Items[i];
    cp1.ShowInfo := Value;
  end;
  InfoVisible := Value;
end;

end.

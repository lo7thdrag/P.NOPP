unit uTMapTouch2;

interface

uses
  MapXLib_TLB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GestureMgr, ImgList, jpeg,
  pngimage, StdCtrls, Keyboard, Manipulations,
  uBaseCoordSystem, tttData;

type
  WinIsWow64 = function( Handle: THandle; var Iret: BOOL ): Windows.BOOL; stdcall;

type
  TTouchedPoints = array of TPoint;
  TOnTouchedPoints = procedure (Points : TTouchedPoints) of object;
  TMapXTouch = class (TMap, _IManipulationEvents)
  private
    FLyrDraw: CMapXLayer;
    FInertia: IInertiaProcessor;
    FManipulator: IManipulationProcessor;
    FInertiaCookie, FManipulatorCookie: LongInt;
    FCompleted: BOOL;
    FPlatformSelected : Boolean;
    FOnTouchedPoints: TOnTouchedPoints;
    FOnLog: TGetStrProc;
    FTouchedPoints : TTouchedPoints;
    FTimer: TTimer;
    procedure SetOnLog(const Value: TGetStrProc);
    procedure SetOnTouchedPoints(const Value: TOnTouchedPoints);
  protected
    procedure DoTouch(const TouchInput: TTouchInput; const Point: TPoint);

    { _IManipulationEvents }
    function ManipulationStarted(X: Single; Y: Single): HRESULT; stdcall;
    function ManipulationDelta(X: Single; Y: Single; translationDeltaX: Single;
      translationDeltaY: Single; scaleDelta: Single; expansionDelta: Single;
      rotationDelta: Single; cumulativeTranslationX: Single;
      cumulativeTranslationY: Single; cumulativeScale: Single;
      cumulativeExpansion: Single; cumulativeRotation: Single): HRESULT;
      stdcall;
    function ManipulationCompleted(X: Single; Y: Single;
      cumulativeTranslationX: Single; cumulativeTranslationY: Single;
      cumulativeScale: Single; cumulativeExpansion: Single;
      cumulativeRotation: Single): HRESULT; stdcall;
  protected
    procedure WMTouch( var Msg: TMessage); message WM_TOUCH;
  public
    X, Y: Integer;

    FWinXP : Boolean;
    IsPan : Boolean;
    MiniCanvas : TCanvas;

    constructor Create(AParent: TWinControl);

    procedure LoadMap(aGeoset: String);
    procedure Disconnect;
    procedure ProcessInertia(Sender : TObject);
    property OnTouchedPoints : TOnTouchedPoints read FOnTouchedPoints write SetOnTouchedPoints;
    property OnLog : TGetStrProc read FOnLog write SetOnLog;
    property OnPlatformSelected : Boolean read FPlatformSelected write FPlatformSelected;
    property WinXP : Boolean read FWinXP write FWinXP;
  end;

implementation

uses
  D2D1, GraphUtil, Math, Types, MMSystem, ComObj;


{ TMapXTouch }
procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;

procedure TMapXTouch.LoadMap(aGeoset: String);
var
  i: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin

  InitOleVariant(z);
  Layers.RemoveAll;

  Geoset := aGeoset;

  if aGeoset <> '' then
  begin
    for i := 1 to Layers.Count do
    begin
      Layers.Item(i).Selectable := False;
      Layers.Item(i).Editable := False;
      Layers.Item(i).AutoLabel := False;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw;
    mInfo.AddParameter('Name', 'LYR_DRAW');
    FLyrDraw := Layers.Add(mInfo, 1);

    Layers.AnimationLayer := FLyrDraw;

    MapUnit := miUnitNauticalMile;
    Title.Visible := False;
  end;
  BackColor := RGB(192, 224, 255);
end;

constructor TMapXTouch.Create(AParent: TWinControl);
var
  WinVer : TDSiWindowsVersion;
  byteWinVer : Word;
begin
  inherited Create(AParent);

  MiniCanvas := TCanvas.Create;

  WinVer := DSiGetWindowsVersion;
  byteWinVer := Byte(WinVer);

  case byteWinVer of
    0..13 : WinXP := True;
    14    : WinXP := False;
  end;

  if not WinXP then
  begin
    FInertia := CreateComObject(CLSID_IInertiaProcessor) as IInertiaProcessor;
    FManipulator := CreateComObject(CLSID_IManipulationProcessor) as IManipulationProcessor;
    InterfaceConnect(FInertia, _IManipulationEvents, Self, FInertiaCookie);
    InterfaceConnect(FManipulator, _IManipulationEvents, Self, FManipulatorCookie);

    FInertia.put_DesiredDeceleration(0.001);

    FInertia.put_BoundaryLeft(200);
    FInertia.put_BoundaryTop(200);
    FInertia.put_BoundaryRight(AParent.Width - 200);
    FInertia.put_BoundaryBottom(AParent.Height - 200);

    FInertia.put_ElasticMarginLeft(200);
    FInertia.put_ElasticMarginTop(200);
    FInertia.put_ElasticMarginRight(200);
    FInertia.put_ElasticMarginBottom(200);

    FTimer := TTimer.Create(Self);
    FTimer.Enabled := False;
    FTimer.Interval := 10;
    FTimer.OnTimer := ProcessInertia;
  end;
  IsPan := True;
end;

procedure TMapXTouch.Disconnect;
begin
  if not WinXP then
  begin
    InterfaceDisconnect(FInertia, _IManipulationEvents, FInertiaCookie);
    InterfaceDisconnect(FManipulator, _IManipulationEvents, FManipulatorCookie);
  end;
end;

procedure TMapXTouch.DoTouch(const TouchInput: TTouchInput;
  const Point: TPoint);
var
  Vx, Vy: Single;
begin
  if (TouchInput.dwFlags and TOUCHEVENTF_DOWN) <> 0 then
  begin
    X := Point.X;
    Y := Point.Y;

    if not WinXP then
      FManipulator.ProcessDown(TouchInput.dwID, Point.X, Point.Y);
  end
  else if (TouchInput.dwFlags and TOUCHEVENTF_UP) <> 0 then
  begin
    if not WinXP then
    begin
      FManipulator.ProcessUp(TouchInput.dwID, Point.X, Point.Y);

      FManipulator.GetVelocityX(Vx);
      FManipulator.GetVelocityY(Vy);
      FInertia.put_InitialVelocityX(Vx);
      FInertia.put_InitialVelocityY(Vy);

      FInertia.put_InitialOriginX(X);
      FInertia.put_InitialOriginY(Y);

      FCompleted := False;
    end;
  end
  else if (TouchInput.dwFlags and TOUCHEVENTF_MOVE) <> 0 then
  begin
              {agar aktif hanya bila btnPan ditekan}
    if not IsPan then
      Exit;

    X := Point.X;
    Y := Point.Y;

    if not WinXP then
    begin
      if not IsPan then
        Exit;                     {agar aktif hanya bila btnPan ditekan}

      FManipulator.ProcessMove(TouchInput.dwID, Point.X, Point.Y);
    end;
  end;
  FTimer.Enabled := True;
end;

function TMapXTouch.ManipulationCompleted(X, Y, cumulativeTranslationX,
  cumulativeTranslationY, cumulativeScale, cumulativeExpansion,
  cumulativeRotation: Single): HRESULT;
begin
  result := 0
end;

function TMapXTouch.ManipulationDelta(X, Y, translationDeltaX,
  translationDeltaY, scaleDelta, expansionDelta, rotationDelta,
  cumulativeTranslationX, cumulativeTranslationY, cumulativeScale,
  cumulativeExpansion, cumulativeRotation: Single): HRESULT;
var
  px, py : single;
  mx, my : double;
  s : String;
begin
  // translate
  mx := CenterX;
  my := CenterY;
  ConvertCoord(px,py,mx,my,miMapToScreen);

  px := px - translationDeltaX;
  py := py - translationDeltaY;

  ConvertCoord(px,py,mx,my,miScreenToMap);

  CenterX := mx;
  CenterY := my;
  //============

  // scale
  if scaleDelta > 0 then
    Zoom := Zoom * (1 / scaleDelta);
  if Zoom >= 2048 then       {filter max scale}
     Zoom := 4096;
  if Zoom <= 0.125 then      {filter min scale}
    Zoom := 0.250;

  // rotate ??
//  Rotation := Rotation + (10 * rotationDelta);

  s := FormatFLoat('#.000',translationDeltaX);
  s := 'Tdx : ' + s;

  s := s + #9;
  s := s + 'Tdy : ' + FormatFLoat('#.000',translationDeltaY);
  s := s + #9;

  s := s + 'ScaleDelta : ' + FormatFLoat('#.000',scaleDelta);
  s := s + #9;

  s := s + 'RotationDelta : ' + FormatFLoat('#.000',rotationDelta);
  s := s + #9;

  Invalidate;

  if Assigned(FOnlog) then
    FOnlog(s);

  result := 0;

end;

function TMapXTouch.ManipulationStarted(X, Y: Single): HRESULT;
begin
  result := 0;
end;

procedure TMapXTouch.ProcessInertia;
begin
//  if not FCompleted then
//    FInertia.Process(FCompleted);
//
//  if FCompleted then
//    FTimer.Enabled := False;

end;

procedure TMapXTouch.SetOnLog(const Value: TGetStrProc);
begin
  FOnLog := Value;
end;

procedure TMapXTouch.SetOnTouchedPoints(const Value: TOnTouchedPoints);
begin
  FOnTouchedPoints := Value;
end;

procedure TMapXTouch.WMTouch(var Msg: TMessage);
  function TouchPointToPoint(const TouchPoint: TTouchInput): TPoint;
  begin
    Result := Point(TouchPoint.X div 100, TouchPoint.Y div 100);
    PhysicalToLogicalPoint(Self.Handle, Result);
    Result := ScreenToClient(Result);
  end;
var
  TouchInputs: array of TTouchInput;
  TouchInput: TTouchInput;
  Handled: Boolean;
  Point: TPoint;
  I :Integer;
begin
  Handled := False;

  SetLength(TouchInputs, Msg.WParam);
  SetLength(FTouchedPoints,Length(TouchInputs));

  GetTouchInputInfo(Msg.LParam, Msg.WParam, @TouchInputs[0],
    SizeOf(TTouchInput));
  try
    I := 0;
    for TouchInput in TouchInputs do
    begin
      Point := TouchPointToPoint(TouchInput);
      FTouchedPoints[I].X := Point.X;
      FTouchedPoints[I].Y := Point.Y;

      if FPlatformSelected then
        Exit;

      DoTouch(TouchInput,Point);

      Inc(I);

    end;


    //if Assigned(FOnTouchedPoints) then
    //  FOnTouchedPoints(FTouchedPoints);

    Handled := True;
  finally
    if Handled then
      CloseTouchInputHandle(Msg.LParam)
    else
      inherited;
  end;
end;

end.

unit uRemoteScreen;

interface

uses
  Windows, Classes, SysUtils, Graphics, Math, Forms, OverbyteIcsWSocket,
  uRemoteData, ZLibEx , MultiMon ;

type
  EMonitorCaptureException = class(Exception);
  MonIndex = record
    Idx : Integer;
    Cnt : Integer;
    MonInfo : MONITORINFO;
  end;
  PMonIndex = ^MonIndex;

  TCaptureRegion = record
    X, Y,
    Width, Height: integer;
  end;

  TRemoteScreen = class(TThread)
  private
    FSocket: TWSocket;
    Fms1, Fms2: TMemoryStream;
    FBmp1, FBmp2, FBmp3: TBitmap;
    FWidth, FHeight, FLine, FInc: Integer;
    FRects: array[0..8] of TRect;
    FDC: HDC;
    FCmd: TRemoteCmd;
    FCursor: HCURSOR;
    FCurPos: TPoint;
    FFormat: TPixelFormat;
    FRegion : TCaptureRegion ;
    //
    procedure CaptureScreen( destBitmap : TBitmap;aMonitorNum : Integer);
    function ValidScreen: Boolean;
    procedure SendRemoteData(nCmd: Byte);
    procedure InitData;
    procedure UpdateData;
    procedure SaveRect(rt: TRect);
    procedure SendRect;
    procedure SetPixelFormat(Value: TPixelFormat);
    function RegionByWindowHandle(AHandle: HWND): TCaptureRegion;
  protected
    MonitorCount : integer ;
    procedure Execute; override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    //
    property Region : TCaptureRegion read FRegion write FRegion;
    property Socket: TWSocket read FSocket write FSocket;
    property PixelFormat: TPixelFormat read FFormat write SetPixelFormat;
  end;

const BitBltRopMode_WinNT=$40000000 or SRCCOPY;
const BitBltRopMode_Win9x=SRCCOPY;

implementation

uses uRemoteServer;

constructor TRemoteScreen.Create;
begin
  FreeOnTerminate := True;
  Fms1  := TMemoryStream.Create;
  Fms2  := TMemoryStream.Create;
  FBmp1 := TBitmap.Create;
  FBmp2 := TBitmap.Create;
  FBmp3 := TBitmap.Create;
  FWidth  := 0;
  FHeight := 0;
  FInc    := 4;
  FFormat := pf8bit;
  FCursor := LoadCursor(0, IDC_ARROW);
  inherited Create(True);
end;

destructor TRemoteScreen.Destroy;
begin
  Fms1.Free;
  Fms2.Free;
  FBmp3.Free;
  FBmp1.Free;
  FBmp2.Free;
  inherited;
end;

procedure TRemoteScreen.Execute;
begin
  try
    while (not Terminated) and (FSocket.State = wsConnected) do
    begin
      if ValidScreen then InitData else UpdateData;
      Sleep(30);
    end;
  except
  end;
end;

procedure TRemoteScreen.SetPixelFormat(Value: TPixelFormat);
begin
  FFormat := Value;
  case FFormat of
    pf1bit:  FInc := 32;
    pf4bit:  FInc := 8;
    pf8bit:  FInc := 4;
    pf16bit: FInc := 2;
    pf32bit: FInc := 1;
  else
    FFormat := pf8bit;
    FInc := 4;
  end;
end;

function TRemoteScreen.ValidScreen: Boolean;
var
  nW, nH: Integer;
begin
  Result := False;
  nW := GetSystemMetrics(SM_CXSCREEN);
  nH := GetSystemMetrics(SM_CYSCREEN);
  if (nW <> FWidth) or (nH <> FHeight) then
  begin
    FLine   := 0;
    FWidth  := nW;
    FHeight := nH;
    FBmp1.Width  := FWidth;
    FBmp1.Height := FHeight;
    FBmp2.Width  := FWidth;
    FBmp2.Height := 1;
    FBmp1.PixelFormat := FFormat;
    FBmp2.PixelFormat := FFormat;
    FBmp3.PixelFormat := FFormat;
    Result := True;
  end;
end;

function MonInfoCB(hm: HMONITOR; dc: HDC; r: PRect; l: LPARAM): Boolean; stdcall;
var
 MI : PMonIndex;
begin
  MI := PMonIndex(pointer(l));
  Inc(MI.Cnt);
  if MI.Cnt = MI.Idx then
     GetMonitorInfo(hm,@(MI.MonInfo));
  result := true;
end;

function GetMonInfoByIdx(MonIdx : Integer) : MONITORINFO;
var
 MI : MonIndex;
begin
  MI.MonInfo.cbSize := SizeOf(MI.MonInfo);
  MI.Idx := MonIdx;
  MI.Cnt := 0;
  EnumDisplayMonitors(0,nil,MonInfoCB, Integer(@MI));
  result := MI.MonInfo;
end;

procedure CaptureDeviceContext(SrcDC: HDC;aCaptureRect : TRect;destBitMap : TBitmap);
begin
// This is just in case you want to capture from a Device Context
// that is not the screen, or you already have the Device Context Handle
    destBitmap.Width := aCaptureRect.Right - aCaptureRect.Left;
    destBitmap.Height := aCaptureRect.Bottom - aCaptureRect.Top;
    BitBlt(destBitmap.Canvas.Handle,
           0,
           0,
           destBitmap.Width,
           destBitmap.Height,
           SrcDC,
           aCaptureRect.Left,
           aCaptureRect.Top,
           SRCCOPY) ;
end;

function TRemoteScreen.RegionByWindowHandle(AHandle: HWND): TCaptureRegion;
var
  VRect: TRect;
begin
  if GetWindowRect(AHandle, VRect) then
  begin
    Result.X:= VRect.Left;
    Result.Y:= VRect.Top;
    Result.Width:= VRect.Right-VRect.Left;
    Result.Height:= VRect.Bottom-VRect.Top;
  end
  else
    raise Exception.Create('Unable to get window position for window handle '+IntToStr(AHandle));
end;

procedure TRemoteScreen.CaptureScreen( destBitmap : TBitmap; aMonitorNum : Integer);
var
   h  : HWND;
   MonInfo : MONITORINFO;
   lCapRect : TRect;
begin
  Assert(Assigned(destBitMap));
  h := 0;
  FillMemory(@lCapRect,SizeOf(TRect),0);
  //FDC := CreateDC('DISPLAY',nil,nil,nil);
  try
      begin
        if (  MonitorCount < aMonitorNum) or (aMonitorNum < 1) then
           raise EMonitorCaptureException.CreateFmt('Monitor Index out of Bounds [%d]',[aMonitorNum]);
        MonInfo := GetMonInfoByIdx(aMonitorNum);
        lCapRect := MonInfo.rcMonitor;
    end;
    CaptureDeviceContext(FDC,lCapRect,destBitmap);
  finally
    //ReleaseDC(h, FDC) ;
   end;
end;

function GetBitBlt_RopMode() : Integer;
begin
  GetVersion();
  if (Win32Platform=VER_PLATFORM_WIN32_NT) then Result := BitBltRopMode_WinNT
  else Result := BitBltRopMode_Win9x;
end;

procedure TRemoteScreen.InitData;
var
  MonInfo : MONITORINFO;
  lCapRect : TRect;

  lpPal: PLogPalette;
  P: TPoint; // Where is the mouse now?

begin
  GetCursorPos(FCurPos);

  FDC := CreateDC('DISPLAY',nil,nil,nil);
  //FDC := FRDC;
  FBmp1.Canvas.Lock;

  FBmp1.Width := Screen.Monitors[2].Width;
  FBmp1.Height := Screen.Monitors[2].Height;

  FWidth := FBmp1.Width ;
  FHeight := FBmp1.Height ;

  if ( GetDeviceCaps ( FDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
  begin
     // allocate memory for a logical palette
    GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
     // zero it out to be neat
    FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ), #0 );
     // fill in the palette version
    lpPal^.palVersion := $300;
     // grab the system palette entries
    lpPal^.palNumEntries :=
      GetSystemPaletteEntries ( FDC, 0, 256, lpPal^.palPalEntry );
    if ( lpPal^.PalNumEntries <> 0 ) then
     // create the palette
      FBmp1.Palette := CreatePalette ( lpPal^ );
    FreeMem ( lpPal, Sizeof ( TLOGPALETTE ) + ( 255 * Sizeof ( TPALETTEENTRY ) ) );
  end;

  BitBlt(FBmp1.Canvas.Handle, 0, 0, FWidth, FHeight, FDC, Screen.Monitors[0].Left, Screen.Monitors[0].Top, GetBitBlt_RopMode());

  DrawIcon(FBmp1.Canvas.Handle, FCurPos.X - 10, FCurPos.Y - 10, FCursor);
  FBmp1.Canvas.Unlock;
  ReleaseDC(0, FDC);
  Fms1.Clear;
  FBmp1.SaveToStream(Fms1);
  SendRemoteData(1);
end;

procedure TRemoteScreen.UpdateData;
var
  p1, p2: PDWORD;
  i, j: Integer;
  rt: TRect;
  MonInfo : MONITORINFO;
  lCapRect : TRect;

  lpPal: PLogPalette;
  P: TPoint; // Where is the mouse now?

begin
  for i := 0 to 8 do SetRectEmpty(FRects[i]);

  //FDC := GetDC(0);
  FDC := CreateDC('DISPLAY',nil,nil,nil);

  i := FLine;
  while (i < FHeight) do
  begin
    FBmp2.Canvas.Lock;

    FBmp2.Width := Screen.Monitors[2].Width;
    FBmp2.Height := Screen.Monitors[2].Height;
    FWidth := FBmp2.Width ;
    FHeight := FBmp2.Height ;

    if ( GetDeviceCaps ( FDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
    begin
     // allocate memory for a logical palette
    GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
     // zero it out to be neat
    FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ), #0 );
     // fill in the palette version
    lpPal^.palVersion := $300;
     // grab the system palette entries
    lpPal^.palNumEntries :=
      GetSystemPaletteEntries ( FDC, 0, 256, lpPal^.palPalEntry );
    if ( lpPal^.PalNumEntries <> 0 ) then
     // create the palette
      FBmp1.Palette := CreatePalette ( lpPal^ );
    FreeMem ( lpPal, Sizeof ( TLOGPALETTE ) + ( 255 * Sizeof ( TPALETTEENTRY ) ) );
    end;

    //BitBlt(FBmp2.Canvas.Handle, 0, 0, FWidth, 1, FDC, 0, i, SRCCOPY);

    BitBlt(FBmp1.Canvas.Handle, 0, 0, FWidth, FHeight, FDC, Screen.Monitors[0].Left, i, GetBitBlt_RopMode());


    FBmp2.Canvas.Unlock;
    p1 := FBmp1.ScanLine[i];
    p2 := FBmp2.ScanLine[0];
    rt.Right := 0;
    j := 0;
    while (j < FWidth) do
    begin
      if (p1^ = p2^) then
      begin
        Inc(p1);
        Inc(p2);
        Inc(j, FInc);
        Continue;
      end;
      with rt do
      begin
        Left   := Max(j - 32, 0);
        Top    := Max(i - 19, 0);
        Right  := Min(j + 32, FWidth);
        Bottom := Min(i + 19, FHeight);
      end;
      SaveRect(rt);
      Inc(p1, 32 div FInc);
      Inc(p2, 32 div FInc);
      Inc(j, 32);
    end;
    Inc(i, 19);
  end;
  FLine := (FLine + 3) mod 19;
  SendRect;
  ReleaseDC(0, FDC);
end;


procedure TRemoteScreen.SendRect;
var
  i: Integer;
  pt: TPoint;
  rt: TRect;
begin
  Fms2.Clear;
  for i := 0 to 8 do
  begin
    if (FRects[i].Right = 0) then Continue;
    with FRects[i] do
    begin
      Left   := Max(Left, 0);
      Top    := Max(Top,  0);
      Right  := Min(Right,  FWidth);
      Bottom := Min(Bottom, FHeight);
    end;
    FBmp1.Canvas.Lock;
    FBmp3.Canvas.Lock;
    try
      FBmp3.Width  := FRects[i].Right  - FRects[i].Left;
      FBmp3.Height := FRects[i].Bottom - FRects[i].Top;
      BitBlt(FBmp3.Canvas.Handle, 0, 0, FBmp3.Width, FBmp3.Height, FDC, FRects[i].Left, FRects[i].Top, SRCCOPY);
      BitBlt(FBmp1.Canvas.Handle, FRects[i].Left, FRects[i].Top, FBmp3.Width, FBmp3.Height, FBmp3.Canvas.Handle, 0, 0, SRCCOPY);
      Fms1.WriteBuffer(FRects[i], SizeOf(TRect));
      FBmp3.SaveToStream(Fms1);
    finally
      FBmp1.Canvas.Unlock;
      FBmp3.Canvas.Unlock;
    end;
  end;
  GetCursorPos(pt);
  if (not PointsEqual(pt, FCurPos)) or (Fms1.Size > 0) then
  begin
    FBmp3.Width  := 32;
    FBmp3.Height := 32;
    SetRect(rt, FCurPos.X - 10, FCurPos.Y - 10, FCurPos.X + 22 , FCurPos.Y + 22);
    BitBlt(FBmp3.Canvas.Handle, 0, 0, FBmp3.Width, FBmp3.Height, FBmp1.Canvas.Handle, rt.Left, rt.Top, SRCCOPY);
    Fms1.WriteBuffer(rt, SizeOf(rt));
    FBmp3.SaveToStream(Fms1);
    FCurPos := pt;
    SetRect(rt, FCurPos.X - 10, FCurPos.Y - 10, FCurPos.X + 22 , FCurPos.Y + 22);
    BitBlt(FBmp3.Canvas.Handle, 0, 0, FBmp3.Width, FBmp3.Height, FBmp1.Canvas.Handle, rt.Left, rt.Top, SRCCOPY);
    DrawIcon(FBmp3.Canvas.Handle, 0, 0, FCursor);
    Fms1.WriteBuffer(rt, SizeOf(rt));
    FBmp3.SaveToStream(Fms1);
  end;
  if (Fms1.Size > 0) then SendRemoteData(2);
end;

procedure TRemoteScreen.SaveRect(rt: TRect);
var
  i, j: Integer;
  rt3: TRect;
  nt: array[0..8] of Integer;
begin
  for i := 0 to 8 do
  begin
    if (FRects[i].Right <> 0) then
    begin
      if (FRects[i].Left - rt.Right > 32) or (rt.Left - FRects[i].Right > 32) or (FRects[i].Top - rt.Bottom > 38) or (rt.Top - FRects[i].Bottom > 38) then
        Continue
      else
      begin
        SetRect(FRects[i], Min(FRects[i].Left, rt.Left), Min(FRects[i].Top, rt.Top), Max(FRects[i].Right, rt.Right), Max(FRects[i].Bottom, rt.Bottom));
        Exit;
      end;
    end;
  end;
  for i := 0 to 8 do
  begin
    if (FRects[i].Right <> 0) then
    begin
      SetRect(rt3, Min(FRects[i].Left, rt.Left), Min(FRects[i].Top, rt.Top), Max(FRects[i].Right, rt.Right), Max(FRects[i].Bottom, rt.Bottom));
      j := ((rt3.Right - rt3.Left) * (rt3.Bottom - rt3.Top) - (FRects[i].Right - FRects[i].Left) * (FRects[i].Bottom - FRects[i].Top) - (rt.Right - rt.Left) * (rt.Bottom - rt.Top)) * 4 div FInc;
      if (j < 8000) then
      begin
        FRects[i] := rt;
        Exit;
      end;
      nt[i] := j;
    end;
  end;
  for i := 0 to 8 do
  begin
    if (FRects[i].Right = 0) then
    begin
      FRects[i] := rt;
      Exit;
    end;
  end;
  i := 0;
  for j := 1 to 8 do
  begin
    if (nt[j] < nt[i]) then i := j;
  end;
  SetRect(FRects[i], Min(FRects[i].Left, rt.Left), Min(FRects[i].Top, rt.Top), Max(FRects[i].Right, rt.Right), Max(FRects[i].Bottom, rt.Bottom));
end;

procedure TRemoteScreen.SendRemoteData(nCmd: Byte);
begin
  try
    Fms2.Clear;
    Fms1.Position := 0;
    ZCompressStream(Fms1, Fms2);
    Fms2.Position := 0;
    FCmd.Cmd  := nCmd;
    FCmd.Size := Fms2.Size;
    FSocket.Send(@FCmd, SizeOf(TRemoteCmd));
    FSocket.Send(Fms2.Memory, Fms2.Size);
  except
  end;
  Fms1.Clear;
end;

end.
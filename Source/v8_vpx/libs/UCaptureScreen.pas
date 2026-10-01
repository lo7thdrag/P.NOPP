unit UCaptureScreen;

interface

uses
  System.Classes,
  Winapi.Windows,
  Vcl.Graphics,
  Vcl.Dialogs;

type
  TCaptureScreen = class
    class function GetScreenDimension: TRect;
    class procedure RegionScreenshot(ABitmap: TBitmap; ARegion: TRect);
    class procedure RegionResizeScreenshot(ABitmap: TBitmap; SrcRegion, DestRegion: TRect);

    class procedure FullScreenshot(ABitmap: TBitmap);
    class procedure FullScreenshotAndResize(ABitmap: TBitmap;
      NewWidth, NewHeight: Integer);
    class procedure ResizeBitmap(ASource: TBitmap; ADest: TBitmap;
      NewWidth, NewHeight: Integer);

    class procedure DrawScreenCursor(var ABitmap: TBitmap);
  end;

implementation

class function TCaptureScreen.GetScreenDimension: TRect;
var
  Wnd: HWND;
  DC: HDC;
begin
  Result := Rect(0, 0, 0, 0);
  Wnd := GetDesktopWindow;
  DC := GetDC(Wnd);
  try
    Result.Width := GetDeviceCaps(DC, HORZRES);
    Result.Height := GetDeviceCaps(DC, VERTRES);
  finally
    ReleaseDC(Wnd, DC)
  end;
end;

class procedure TCaptureScreen.FullScreenshot(ABitmap: TBitmap);
var
  Wnd: HWND;
  DC: HDC;
begin
  Wnd := GetDesktopWindow;
  DC := GetDC(Wnd);
  try
    BitBlt(ABitmap.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height,
      DC, 0, 0, SRCCOPY);
  finally
    ReleaseDC(Wnd, DC);
  end;
end;

class procedure TCaptureScreen.FullScreenshotAndResize(ABitmap: TBitmap;
  NewWidth, NewHeight: Integer);
var
  Wnd: HWND;
  DC: HDC;
  ScreenWidth: Integer;
  ScreenHeight: Integer;
begin
  Wnd := GetDesktopWindow;
  DC := GetDC(Wnd);
  try
    ScreenWidth := GetDeviceCaps(DC, HORZRES);
    ScreenHeight := GetDeviceCaps(DC, VERTRES);
    SetStretchBltMode(ABitmap.Canvas.Handle, HALFTONE);
    SetBrushOrgEx(ABitmap.Canvas.Handle, 0, 0, NIL);
    StretchBlt(ABitmap.Canvas.Handle, 0, 0, NewWidth, NewHeight,
      DC, 0, 0, ScreenWidth, ScreenHeight, SRCCOPY);
  finally
    ReleaseDC(Wnd, DC);
  end;
end;

class procedure TCaptureScreen.RegionResizeScreenshot(ABitmap: TBitmap;
  SrcRegion, DestRegion: TRect);
var
  Wnd: HWND;
  DC: HDC;
begin
  Wnd := GetDesktopWindow;
  DC := GetDC(Wnd);
  try
    SetStretchBltMode(ABitmap.Canvas.Handle, HALFTONE);
    SetBrushOrgEx(ABitmap.Canvas.Handle, 0, 0, NIL);
    StretchBlt(ABitmap.Canvas.Handle, DestRegion.Left, DestRegion.Top, DestRegion.Width, DestRegion.Height,
      DC, SrcRegion.Left, SrcRegion.Top, SrcRegion.Width, SrcRegion.Height, SRCCOPY);
  finally
    ReleaseDC(Wnd, DC);
  end;
end;

class procedure TCaptureScreen.RegionScreenshot(ABitmap: TBitmap;
  ARegion: TRect);
var
  Wnd: HWND;
  DC: HDC;
begin
  Wnd := GetDesktopWindow;
  DC := GetDC(Wnd);
  try
    BitBlt(ABitmap.Canvas.Handle, 0, 0, ARegion.Width, ARegion.Height,
      DC, ARegion.Left, ARegion.Top, SRCCOPY);
  finally
    ReleaseDC(Wnd, DC);
  end;
end;

class procedure TCaptureScreen.ResizeBitmap(ASource: TBitmap; ADest: TBitmap;
  NewWidth, NewHeight: Integer);
begin
  if (ASource.Width < 12) OR (ASource.Height < 12) then
  begin
    ShowMessage('Cannot stretch images under 12 pixels!');
    { 'WinStretchBltF' will crash if the image size is too small (below 10 pixels) }
    Exit;
  end;

  ADest.PixelFormat := ASource.PixelFormat;
  { Make sure we use the same pixel format as the original image }
  // SetLargeSize(Result, OutWidth, OutHeight);
  ADest.Width := NewWidth;
  ADest.Height := NewHeight;
  SetStretchBltMode(ADest.Canvas.Handle, HALFTONE);
  SetBrushOrgEx(ADest.Canvas.Handle, 0, 0, NIL);
  StretchBlt(ADest.Canvas.Handle, 0, 0, NewWidth, NewHeight,
    ASource.Canvas.Handle, 0, 0, ASource.Width, ASource.Height, SRCCOPY);
  // bmpDest.Canvas.CopyRect(Rect(0,0,NewWidth,NewHeight),
  // bmp.Canvas,
  // Rect(0,0,bmp.Width,bmp.Height));
end;

class procedure TCaptureScreen.DrawScreenCursor(var ABitmap: TBitmap);
var
  R: TRect;
  CursorInfo: TCursorInfo;
  Icon: TIcon;
  IconInfo: TIconInfo;
begin
  R:= ABitmap.Canvas.ClipRect;
  Icon:= TIcon.Create;
  try
    //MonitorID: 0=ALL screens, 1=MAIN screen, 2=ADDITIONAL screen, etc....
    CursorInfo.cbSize:= SizeOf(CursorInfo);
    if GetCursorInfo(CursorInfo) then
    if CursorInfo.Flags = CURSOR_SHOWING then
    begin
      Icon.Handle:= CopyIcon(CursorInfo.hCursor);
      if GetIconInfo(Icon.Handle, IconInfo) then
      begin
        //Draw cursor image on screenshot image
        ABitmap.Canvas.Draw(
          CursorInfo.ptScreenPos.x - Integer(IconInfo.xHotspot) - R.Left,
          CursorInfo.ptScreenPos.y - Integer(IconInfo.yHotspot) - R.Top,
          Icon
        );
      end;
    end;
  finally
    Icon.Free;
  end;
end;

end.

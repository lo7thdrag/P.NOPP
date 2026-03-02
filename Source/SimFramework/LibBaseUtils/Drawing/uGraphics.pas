unit uGraphics;

interface
uses
  Windows, Graphics, ExtCtrls, Forms;

type

  TVerticalAlign = (vaNone, vaTop, vaCenter, vaBottom);
  THorizontalAlign = (haNone, haLeft, haCenter, haRight);

  rRGBPixel = packed record
    b, g, r: byte;
  end;

  aRGBPixels = array[0..4095] of rRGBPixel;
  paRGBPixels = ^aRGBPixels;

  procedure DefPaintBox1Paint(pbx: TPaintBox; stColr: tColor);

  procedure DrawShading(cnv: TCanvas; r: TRect; stColor: TColor);

  procedure bmp24_Rotate(bmpSrc, bmpDest: TBitmap;
    const aDeg: single);

  procedure bmp24_Fill(bmp: TBitmap);

implementation
uses
  Math, SysUtils;

const

  CRGBBlack: rRGBPixel = (b: 0; g: 0; r: 0);

//------------------------------------------------------------------------------

procedure DarkColor(var acl: TColor; const amt: byte);
asm
  movd mm0, dword ptr[eax];
  push ebx;
  mov dh, dl;
  mov bx, dx;
  shl edx, 16;
  and edx, $00FFFFFF;
  mov dx, bx;
  movd mm1, edx;
  psubusb mm0,mm1;
  pop ebx;
  movd dword ptr[eax], mm0;
  emms;
end;

//------------------------------------------------------------------------------

procedure DefPaintBox1Paint(pbx: TPaintBox; stColr: tColor);
var i: integer;
  h, w: integer;
  dt: integer;
  cl: tColor;
begin
  h := pbx.Height - 1;
  w := pbx.Width - 1;

  for i := 0 to h do begin
    dt := Round(i * 64 / h);
    cl := stColr;
    DarkColor(cl, dt);
    pbx.Canvas.Pen.Color := cl;
    pbx.Canvas.MoveTo(0, i);
    pbx.Canvas.LineTo(w, i);
  end;
end;

//------------------------------------------------------------------------------

procedure DrawShading(cnv: TCanvas; r: TRect; stColor: TColor);
var i: integer;
  h: integer;
  dt: integer;
  cl: tColor;
begin
  h := r.Bottom - r.Top - 1;
//  w := r.Right - r.Left -1;

  for i := 0 to h do begin
    dt := Round(i * 64 / h);
    cl := stColor;
    DarkColor(cl, dt);
    cnv.Pen.Color := cl;
    cnv.MoveTo(r.Left, r.Top + i);
    cnv.LineTo(r.Right, r.Top + i);
  end;
end;

//------------------------------------------------------------------------------

procedure PlaceFormToMonitor(const monNum: byte;
  const hAlign: THorizontalAlign;
  const vAlign: TVerticalAlign;
  const offX, offY: integer; var frm: Tform);
var
  setNum: byte;
begin
  if frm = nil then exit;
  frm.DefaultMonitor := dmPrimary;

  setNum := monNum;
  if monNum >= Screen.MonitorCount
    then setNum := Screen.MonitorCount - 1;

  with Screen.Monitors[setNum].WorkareaRect do
    case hAlign of
      haLeft:
        frm.Left := offX + Left;
      haRight:
        frm.Left := offX + Right - frm.Width;
      haCenter:
        frm.Left := offX + Left + ((Right - Left) div 2) - (frm.Width div 2);
    end;

  with Screen.Monitors[setNum].WorkareaRect do
    case vAlign of
      vaTop:
        frm.Top := offY + Top;
      vaCenter:
        frm.Top := offY + Top + ((Bottom - Top) div 2) - (frm.Height div 2);
      vaBottom:
        frm.Top := offY + Bottom - frm.Height;
    end;
end;
//------------------------------------------------------------------------------

procedure bmp24_Rotate(bmpSrc, bmpDest: TBitmap;
  const aDeg: single);
var i, j, fcx, fcy: integer;
  w, h: integer;
  pA: paRGBPixels;
  ySinA, yCosA: integer;
  xCos, xSin: array of integer;
  x, y, x2, y2: integer;
  sinA, cosA: extended;
  aPB: array of paRGBPixels;
//    bps: integer;
begin

  bmpDest.PixelFormat := pf24bit;
  bmpSrc.PixelFormat := pf24bit;
  bmpDest.Width := bmpSrc.Width;
  bmpDest.Height := bmpSrc.Height;

  h := bmpDest.Height;
  w := bmpDest.Width;
  fcx := w shr 1;
  fcy := h shr 1;

  SetLength(xCos, w);
  SetLength(xSin, w);

  SinCos(DegToRad(aDeg), sinA, cosA);
  for i := 0 to w - 1 do begin
    x := (i - fcx);
    xCos[i] := Round(x * cosA) + fcx;
    xSin[i] := Round(x * sinA) + fcy;
  end;

  SetLength(aPB, h);
  for j := 0 to h - 1 do
    aPB[j] := bmpSrc.ScanLine[j];

  for j := 0 to h - 1 do begin
    y := (j - fcy);
    ySinA := Round(y * sinA);
    yCosA := Round(y * cosA);
    pA := bmpDest.ScanLine[j];

    for i := 0 to w - 1 do begin
      x2 := (xCos[i] - ySinA);
      y2 := (xSin[i] + yCosA);
      if (x2 >= 0) and (x2 < w) and
        (y2 >= 0) and (y2 < h) then begin

        pA[i] := apB[y2, x2];
      end
      else
        pA[i] := CRGBBlack;
    end;
  end;
  SetLength(aPB, 0);

  SetLength(xCos, 0);
  SetLength(xSin, 0);
end;

procedure bmp24_Fill(bmp: TBitmap);
var j, maxI: integer;
  pA: pByteArray;
begin
  maxI := (bmp.Width) * 3;
  for j := 0 to bmp.height - 1 do begin
    pA := bmp.ScanLine[j];
    FillChar(pA[0], maxI, 0);
  end;
end;

end.

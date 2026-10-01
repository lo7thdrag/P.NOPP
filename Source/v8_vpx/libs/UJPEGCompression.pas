unit UJPEGCompression;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  libTurboJPEG;

type
  TJPEGOption = (jpgoOptimize, // optimize Huffman tables
    jpgoNoJFIFHeader, // don't write JFIF header
    jpgoProgressive // progressive JPEG
    );
  TJPEGOptions = set of TJPEGOption;

  TLibTurboJPEG = class
  public
    class procedure CompressJPEG(const ABitmap: TBitmap; var jpegData: TBytes;
      quality: Integer; const options: TJPEGOptions = []); overload;
    class procedure CompressJPEG(const ABitmap: TBitmap; const AStream: TStream;
      quality: Integer; const options: TJPEGOptions = []); overload;
    class procedure DecompressJPEG(const jpegData: TBytes; jpegDataLength: Integer;
      const ABitmap: TBitmap); overload;
    class procedure DecompressJPEG(const AStream: TStream;
      const ABitmap: TBitmap); overload;
  end;

implementation

class procedure TLibTurboJPEG.CompressJPEG(const ABitmap: TBitmap; var jpegData: TBytes; quality: Integer;
  const options: TJPEGOptions = []);
var
  outBuf: Pointer;
  outSize: Cardinal;
  jpeg: TJHandle;
  flags: Integer;
begin
  jpeg := TJ.InitCompress;
  try
    outBuf := nil;
    outSize := 0;
    flags := 0;
    flags := flags + TJFLAG_BOTTOMUP;
    if quality >= 90 then
      flags := flags + TJFLAG_ACCURATEDCT;
    if jpgoProgressive in options then
      flags := flags + TJFLAG_PROGRESSIVE;
    if TJ.Compress2(jpeg, ABitmap.ScanLine[ABitmap.Height - 1], ABitmap.Width,
      0, ABitmap.Height, TJPF_RGB, @outBuf, @outSize, TJSAMP_420, quality,
      flags) <> 0 then
      RaiseLastTurboJPEGError(jpeg);
    if outSize > 0 then
      try
        SetLength(jpegData, outSize);
        System.Move(outBuf^, Pointer(jpegData)^, outSize);
      finally
        TJ.Free(outBuf);
      end;
  finally
    TJ.Destroy(jpeg);
  end;
end;

class procedure TLibTurboJPEG.CompressJPEG(const ABitmap: TBitmap; const AStream: TStream;
      quality: Integer; const options: TJPEGOptions = []);
var
  outBuf: Pointer;
  outSize: Cardinal;
  jpeg: TJHandle;
  flags: Integer;
begin
  jpeg := TJ.InitCompress;
  try
    outBuf := nil;
    outSize := 0;
    flags := 0;
    flags := flags + TJFLAG_BOTTOMUP;
    if quality >= 90 then
      flags := flags + TJFLAG_ACCURATEDCT;
    if jpgoProgressive in options then
      flags := flags + TJFLAG_PROGRESSIVE;
    if TJ.Compress2(jpeg, ABitmap.ScanLine[ABitmap.Height - 1], ABitmap.Width,
      0, ABitmap.Height, TJPF_RGB, @outBuf, @outSize, TJSAMP_420, quality,
      flags) <> 0 then
      RaiseLastTurboJPEGError(jpeg);
    if outSize > 0 then
      try
//        SetLength(jpegData, outSize);
//        System.Move(outBuf^, Pointer(jpegData)^, outSize);
        AStream.Size:= outSize;
        AStream.Position:= 0;
        AStream.WriteBuffer(outBuf^, outSize);
      finally
        TJ.Free(outBuf);
      end;
  finally
    TJ.Destroy(jpeg);
  end;
end;

class procedure TLibTurboJPEG.DecompressJPEG(const jpegData: TBytes; jpegDataLength: Integer;
  const ABitmap: TBitmap);
var
  jpeg: TJHandle;
  jpegSubSamp: Integer;
  flags: Integer;
  w, h: Integer;
begin
  jpeg := TJ.InitDecompress;
  try
    jpegSubSamp := 0;
    if TJ.DecompressHeader2(jpeg, PByte(jpegData), jpegDataLength, @w, @h,
      @jpegSubSamp) <> 0 then
      RaiseLastTurboJPEGError(jpeg);

    flags := 0;
    flags := flags + TJFLAG_BOTTOMUP;
    ABitmap.PixelFormat := pf24bit;
    ABitmap.SetSize(w, h);
    if TJ.Decompress2(jpeg, PByte(jpegData), jpegDataLength,
      ABitmap.ScanLine[ABitmap.Height - 1], w, 0, h, TJPF_RGB, flags) <> 0 then
      RaiseLastTurboJPEGError(jpeg);
  finally
    TJ.Destroy(jpeg);
  end;
end;

class procedure TLibTurboJPEG.DecompressJPEG(const AStream: TStream;
      const ABitmap: TBitmap);
var
  jpegData: TBytes;
  jpegDataLength: Integer;
  jpeg: TJHandle;
  jpegSubSamp: Integer;
  flags: Integer;
  w, h: Integer;
begin
  AStream.Position:= 0;
  SetLength(jpegData, AStream.Size);
  AStream.ReadBuffer(jpegData[0], AStream.Size);
  jpegDataLength:= Length(jpegData);

  jpeg := TJ.InitDecompress;
  try
    jpegSubSamp := 0;
    if TJ.DecompressHeader2(jpeg, PByte(jpegData), jpegDataLength, @w, @h,
      @jpegSubSamp) <> 0 then
      RaiseLastTurboJPEGError(jpeg);

    flags := 0;
    flags := flags + TJFLAG_BOTTOMUP;
    ABitmap.PixelFormat := pf24bit;
    ABitmap.SetSize(w, h);
    if TJ.Decompress2(jpeg, PByte(jpegData), jpegDataLength,
      ABitmap.ScanLine[ABitmap.Height - 1], w, 0, h, TJPF_RGB, flags) <> 0 then
      RaiseLastTurboJPEGError(jpeg);
  finally
    TJ.Destroy(jpeg);
  end;
end;

end.

program caster;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FrmMain},
  UCommands in '..\commons\UCommands.pas',
  USettings in '..\commons\USettings.pas',
  UJPEGCompression in '..\libs\UJPEGCompression.pas',
  UCaptureScreen in '..\libs\UCaptureScreen.pas',
  UData in '..\commons\UData.pas',
  libyuv in '..\libs\codec\libyuv.pas',
  video_encoder_vpx in '..\libs\codec\video_encoder_vpx.pas',
  vp8cx in '..\libs\codec\vp8cx.pas',
  vpx_codec in '..\libs\codec\vpx_codec.pas',
  vpx_encoder in '..\libs\codec\vpx_encoder.pas',
  vpx_image in '..\libs\codec\vpx_image.pas',
  VPXRegionEncoder in '..\libs\codec\VPXRegionEncoder.pas',
  video_decoder_vpx in '..\libs\codec\video_decoder_vpx.pas',
  vp8dx in '..\libs\codec\vp8dx.pas',
  vpx_decoder in '..\libs\codec\vpx_decoder.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:= True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

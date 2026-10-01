program viewer;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FrmMain},
  UCommands in '..\commons\UCommands.pas',
  USettings in '..\commons\USettings.pas',
  UFrmCommand in 'UFrmCommand.pas' {FrmCommand},
  UData in '..\commons\UData.pas',
  UJPEGCompression in '..\libs\UJPEGCompression.pas',
  video_decoder_vpx in '..\libs\codec\video_decoder_vpx.pas',
  libyuv in '..\libs\codec\libyuv.pas',
  vp8dx in '..\libs\codec\vp8dx.pas',
  vpx_codec in '..\libs\codec\vpx_codec.pas',
  vpx_decoder in '..\libs\codec\vpx_decoder.pas',
  vpx_image in '..\libs\codec\vpx_image.pas',
  uProcessManager in '..\libs\uProcessManager.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:= True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

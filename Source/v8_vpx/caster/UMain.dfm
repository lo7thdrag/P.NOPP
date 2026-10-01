object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'caster'
  ClientHeight = 340
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlTop: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 14
      Width = 28
      Height = 13
      Caption = 'FPS : '
    end
    object edtFPS: TEdit
      Left = 48
      Top = 11
      Width = 89
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
  end
  object MmoLog: TMemo
    Left = 0
    Top = 41
    Width = 672
    Height = 299
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object tmrClientGetPacket: TTimer
    Enabled = False
    Interval = 16
    OnTimer = tmrClientGetPacketTimer
    Left = 160
    Top = 208
  end
  object tmrClientCheckConnection: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrClientCheckConnectionTimer
    Left = 160
    Top = 120
  end
  object tmrFPS: TTimer
    Enabled = False
    OnTimer = tmrFPSTimer
    Left = 496
    Top = 216
  end
  object tmrCasting: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrCastingTimer
    Left = 408
    Top = 152
  end
  object tmrCastGetPacket: TTimer
    Enabled = False
    OnTimer = tmrCastGetPacketTimer
    Left = 408
    Top = 208
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 240
    Top = 8
  end
  object TrayIcon1: TTrayIcon
    OnDblClick = TrayIcon1DblClick
    Left = 312
  end
end

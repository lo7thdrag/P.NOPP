object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Monitor'
  ClientHeight = 309
  ClientWidth = 645
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  DesignSize = (
    645
    309)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDraw: TPanel
    Left = 0
    Top = 0
    Width = 645
    Height = 309
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 651
    ExplicitHeight = 338
    object pbDraw: TPaintBox
      Left = 0
      Top = 0
      Width = 645
      Height = 309
      Align = alClient
      OnDblClick = pbDrawDblClick
      OnPaint = pbDrawPaint
      ExplicitLeft = 184
      ExplicitTop = 64
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
  end
  object pnlOfficial: TPanel
    Left = 8
    Top = 268
    Width = 113
    Height = 33
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    Caption = '---'
    Color = clAqua
    ParentBackground = False
    TabOrder = 1
  end
  object tmrClientGetPacket: TTimer
    Enabled = False
    OnTimer = tmrClientGetPacketTimer
    Left = 216
    Top = 96
  end
  object tmrClientCheckConnection: TTimer
    Enabled = False
    OnTimer = tmrClientCheckConnectionTimer
    Left = 248
    Top = 152
  end
  object tmrCastGetPacket: TTimer
    Enabled = False
    OnTimer = tmrCastGetPacketTimer
    Left = 328
    Top = 104
  end
  object tmrFPS: TTimer
    Enabled = False
    OnTimer = tmrFPSTimer
    Left = 392
    Top = 152
  end
end

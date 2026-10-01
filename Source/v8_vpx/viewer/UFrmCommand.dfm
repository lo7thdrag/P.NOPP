object FrmCommand: TFrmCommand
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Command'
  ClientHeight = 299
  ClientWidth = 635
  Color = cl3DDkShadow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MmoLog: TMemo
    Left = 0
    Top = 41
    Width = 635
    Height = 258
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentColor = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    BevelInner = bvSpace
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object lblFPS: TLabel
      Left = 10
      Top = 14
      Width = 34
      Height = 13
      Caption = 'FPS : '
    end
    object edtFPS: TEdit
      Left = 44
      Top = 11
      Width = 44
      Height = 21
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object btnClose: TButton
      Left = 98
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
end

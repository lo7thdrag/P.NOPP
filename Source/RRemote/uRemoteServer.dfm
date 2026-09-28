object frmMain: TfrmMain
  Left = 346
  Top = 281
  Caption = 'Remote Server'
  ClientHeight = 231
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 20
    Width = 403
    Height = 211
    Align = alClient
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 75
      Height = 20
      Align = alLeft
      AutoSize = False
      Layout = tlCenter
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 192
    Top = 56
  end
end

object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Restart'
  ClientHeight = 251
  ClientWidth = 848
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblRestart: TLabel
    Left = 47
    Top = 88
    Width = 753
    Height = 75
    Caption = 'Restarting Application ...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
end

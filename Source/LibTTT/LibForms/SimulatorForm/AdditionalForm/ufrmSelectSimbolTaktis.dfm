object frmSelectSimbolTaktis: TfrmSelectSimbolTaktis
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Tactical Symbol'
  ClientHeight = 554
  ClientWidth = 412
  Color = 3091499
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 21
    Top = 523
    Width = 49
    Height = 16
    Caption = 'Search :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object drwgrdFontTaktis: TDrawGrid
    Left = 0
    Top = 0
    Width = 412
    Height = 513
    Align = alTop
    ColCount = 1
    DefaultColWidth = 2000
    DefaultRowHeight = 40
    FixedColor = clWhite
    FixedCols = 0
    RowCount = 530
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnDrawCell = drwgrdFontTaktisDrawCell
  end
  object btnOK: TButton
    Left = 248
    Top = 519
    Width = 75
    Height = 25
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 329
    Top = 519
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edt_searchsimbol: TEdit
    Left = 76
    Top = 519
    Width = 121
    Height = 21
    TabOrder = 3
    OnKeyPress = edt_searchsimbolKeyPress
  end
end

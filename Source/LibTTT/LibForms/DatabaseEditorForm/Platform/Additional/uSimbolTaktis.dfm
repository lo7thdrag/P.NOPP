object SimbolTaktis: TSimbolTaktis
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Tactical symbol'
  ClientHeight = 719
  ClientWidth = 510
  Color = clBtnFace
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
    Top = 690
    Width = 40
    Height = 13
    Caption = 'Search :'
  end
  object drwgrdFontTaktis: TDrawGrid
    Left = 0
    Top = 0
    Width = 510
    Height = 673
    Align = alTop
    ColCount = 1
    DefaultColWidth = 2000
    DefaultRowHeight = 40
    FixedColor = clWhite
    FixedCols = 0
    RowCount = 530
    FixedRows = 0
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
    OnDrawCell = drwgrdFontTaktisDrawCell
  end
  object btnOK: TButton
    Left = 327
    Top = 686
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 408
    Top = 686
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object edt_searchsimbol: TEdit
    Left = 67
    Top = 690
    Width = 121
    Height = 21
    TabOrder = 3
    OnKeyPress = edt_searchsimbolKeyPress
  end
end

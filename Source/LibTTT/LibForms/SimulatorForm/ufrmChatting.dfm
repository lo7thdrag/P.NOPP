object frmChatting: TfrmChatting
  Left = 0
  Top = 0
  ClientHeight = 440
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = -8
    Top = -32
    Width = 301
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object btnClose: TButton
    Left = 248
    Top = 16
    Width = 33
    Height = 33
    Caption = 'X'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft JhengHei'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnOption: TButton
    Left = 209
    Top = 16
    Width = 33
    Height = 33
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object TButton
    Left = 8
    Top = 16
    Width = 33
    Height = 33
    BiDiMode = bdRightToLeft
    Caption = 'v'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 16
    Top = 88
    Width = 129
    Height = 49
    Lines.Strings = (
      'Memo2')
    TabOrder = 4
  end
  object Memo3: TMemo
    Left = 136
    Top = 152
    Width = 137
    Height = 49
    Lines.Strings = (
      'Memo2')
    TabOrder = 5
  end
  object Memo4: TMemo
    Left = 16
    Top = 216
    Width = 161
    Height = 65
    Lines.Strings = (
      'Memo2')
    TabOrder = 6
  end
  object Memo5: TMemo
    Left = 112
    Top = 296
    Width = 161
    Height = 49
    Lines.Strings = (
      'Memo2')
    TabOrder = 7
  end
  object ListBox1: TListBox
    Left = -8
    Top = 384
    Width = 317
    Height = 106
    ItemHeight = 13
    TabOrder = 8
  end
  object Edit1: TEdit
    Left = 8
    Top = 400
    Width = 274
    Height = 25
    TabOrder = 9
    Text = 'Edit1'
  end
end

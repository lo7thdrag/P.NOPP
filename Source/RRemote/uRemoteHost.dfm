object frmRemoteHost: TfrmRemoteHost
  Left = 300
  Top = 146
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = ' Monitor Student'
  ClientHeight = 90
  ClientWidth = 281
  Color = 2695445
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 14
    Top = 9
    Width = 45
    Height = 13
    Caption = 'Console :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object rg1: TRadioGroup
    Left = 24
    Top = 124
    Width = 255
    Height = 57
    Caption = 'Color'
    Columns = 3
    ItemIndex = 3
    Items.Strings = (
      '1 bit'
      '4 bit'
      '8 bit'
      '16 bit'
      '24 bit'
      '32 bit')
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 113
    Top = 55
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 194
    Top = 55
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 12
    Top = 28
    Width = 257
    Height = 21
    AutoDropDown = True
    Ctl3D = True
    DropDownCount = 25
    ParentCtl3D = False
    TabOrder = 3
  end
end

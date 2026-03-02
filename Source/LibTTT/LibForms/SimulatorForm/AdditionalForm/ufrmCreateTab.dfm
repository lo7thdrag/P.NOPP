object frmCreateTab: TfrmCreateTab
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 127
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 24
    Width = 47
    Height = 13
    Caption = 'Caption : '
  end
  object Label1: TLabel
    Left = 8
    Top = 51
    Width = 31
    Height = 13
    Caption = 'Type :'
  end
  object edtCaption: TEdit
    Left = 61
    Top = 20
    Width = 145
    Height = 21
    TabOrder = 0
  end
  object cbbType: TComboBox
    Left = 61
    Top = 47
    Width = 71
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'Map'
    OnChange = cbbTypeChange
    Items.Strings = (
      'Map'
      'Image')
  end
  object btnOK: TButton
    Left = 21
    Top = 90
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 120
    Top = 90
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end

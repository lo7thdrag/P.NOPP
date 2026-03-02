object frmImageInsert: TfrmImageInsert
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmImageInsert'
  ClientHeight = 114
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 22
    Top = 17
    Width = 69
    Height = 13
    Caption = 'Insert Image :'
  end
  object edtAddress: TEdit
    Left = 22
    Top = 36
    Width = 367
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 395
    Top = 34
    Width = 41
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object btnOK: TButton
    Left = 280
    Top = 81
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 361
    Top = 81
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 331
  end
end

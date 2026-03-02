object frmUsage: TfrmUsage
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Usage Report'
  ClientHeight = 402
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 732
    Height = 304
    Align = alClient
    TabOrder = 0
    object ListView1: TListView
      Left = 16
      Top = 14
      Width = 697
      Height = 283
      Columns = <
        item
          Caption = 'Usage'
          Width = 150
        end
        item
          Width = 250
        end
        item
          Width = 293
        end>
      ColumnClick = False
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 732
    Height = 57
    Align = alTop
    TabOrder = 1
    object lbl1: TLabel
      Left = 16
      Top = 16
      Width = 341
      Height = 13
      Caption = 
        'Below is a list of the database entries that reference the selec' +
        'ted item:'
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 361
    Width = 732
    Height = 41
    Align = alBottom
    TabOrder = 2
    object btnOk: TButton
      Left = 638
      Top = 6
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnPrint: TButton
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Print'
      TabOrder = 1
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 176
    Top = 24
  end
end

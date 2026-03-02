object frmDebug: TfrmDebug
  Left = 503
  Top = 350
  Caption = 'frmDebug'
  ClientHeight = 360
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 335
    Height = 301
    ActivePage = TabSheet5
    Align = alClient
    TabOrder = 0
    object TabSheet5: TTabSheet
      Caption = 'Application'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object mmApp: TMemo
        Left = 0
        Top = 0
        Width = 327
        Height = 273
        Align = alClient
        BevelKind = bkSoft
        BorderStyle = bsNone
        Lines.Strings = (
          'Application Log')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsNetLog: TTabSheet
      Caption = 'tsNetLog'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 327
        Height = 273
        ActivePage = TabSheet8
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 335
        ExplicitHeight = 284
        object TabSheet8: TTabSheet
          Caption = 'Net Log'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object mmNet: TMemo
            Left = 0
            Top = 0
            Width = 319
            Height = 245
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
            ExplicitWidth = 327
            ExplicitHeight = 256
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'Send Log'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object mmSend: TMemo
            Left = 0
            Top = 0
            Width = 319
            Height = 245
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
            ExplicitWidth = 327
            ExplicitHeight = 256
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'Recv Log'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object mmRecv: TMemo
            Left = 0
            Top = 0
            Width = 319
            Height = 245
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
            ExplicitWidth = 327
            ExplicitHeight = 256
          end
        end
        object tsError: TTabSheet
          Caption = 'Net Error'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object mmNetErr: TMemo
            Left = 0
            Top = 0
            Width = 319
            Height = 245
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
            ExplicitWidth = 327
            ExplicitHeight = 256
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 301
    Width = 335
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 312
    ExplicitWidth = 343
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 59
      Height = 13
      Caption = 'Buffer Count'
    end
    object lblBuffCount: TLabel
      Left = 80
      Top = 8
      Width = 57
      Height = 13
      Caption = 'lblBuffCount'
    end
  end
  object Timer1: TTimer
    Enabled = False
    Left = 204
    Top = 72
  end
end

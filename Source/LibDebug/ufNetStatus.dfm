object frmNetStatus: TfrmNetStatus
  Left = 813
  Top = 538
  Caption = 'frmNetStatus'
  ClientHeight = 182
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 460
    Height = 182
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel2'
    TabOrder = 0
    ExplicitWidth = 468
    ExplicitHeight = 193
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 458
      Height = 180
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      ExplicitWidth = 466
      ExplicitHeight = 191
      object Splitter2: TSplitter
        Left = 348
        Top = 49
        Height = 112
        Align = alRight
        ExplicitLeft = 356
        ExplicitHeight = 123
      end
      object StatusBar1: TStatusBar
        Left = 0
        Top = 161
        Width = 458
        Height = 19
        Panels = <
          item
            Width = 50
          end
          item
            Width = 50
          end
          item
            Width = 50
          end>
        ExplicitTop = 172
        ExplicitWidth = 466
      end
      object lvNetState: TListView
        Left = 0
        Top = 49
        Width = 348
        Height = 112
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'IP Address'
            Width = 100
          end
          item
            Caption = 'Send'
            Width = 80
          end
          item
            Caption = 'Receive'
            Width = 80
          end
          item
            Caption = 'Callsign'
            Width = 80
          end>
        TabOrder = 1
        ViewStyle = vsReport
        ExplicitLeft = -3
        ExplicitTop = 47
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 458
        Height = 49
        Align = alTop
        TabOrder = 2
        ExplicitWidth = 466
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 68
          Height = 13
          Caption = 'Server Socket'
        end
        object SpeedButton1: TSpeedButton
          Left = 352
          Top = 8
          Width = 73
          Height = 33
          GroupIndex = 1
        end
        object Label2: TLabel
          Left = 152
          Top = 8
          Width = 43
          Height = 13
          Caption = 'Incoming'
        end
        object Label3: TLabel
          Left = 152
          Top = 24
          Width = 43
          Height = 13
          Caption = 'Outgoing'
        end
        object lblIncoming: TLabel
          Left = 200
          Top = 8
          Width = 58
          Height = 13
          Caption = 'SendChanel'
        end
        object lblOutGoing: TLabel
          Left = 200
          Top = 24
          Width = 45
          Height = 13
          Caption = 'OutGoing'
        end
        object lblServerState: TLabel
          Left = 8
          Top = 24
          Width = 68
          Height = 13
          Caption = 'Server Socket'
        end
      end
      object RichEdit2: TRichEdit
        Left = 351
        Top = 49
        Width = 107
        Height = 112
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'RichEdit1')
        ParentFont = False
        TabOrder = 3
        ExplicitLeft = 354
        ExplicitTop = 47
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 289
    Top = 121
  end
end

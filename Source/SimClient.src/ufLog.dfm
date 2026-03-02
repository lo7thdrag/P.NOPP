object frmLog: TfrmLog
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'LOG WINDOW'
  ClientHeight = 254
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 525
    Height = 254
    ActivePage = tsStatusPlatform
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'LOGS'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 517
        Height = 226
        Align = alClient
        BorderStyle = bsNone
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'PLATFORMS'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbPlatform: TListBox
        Left = 0
        Top = 25
        Width = 517
        Height = 201
        Align = alClient
        BorderStyle = bsNone
        ItemHeight = 13
        TabOrder = 0
      end
      object Button1: TButton
        Left = 0
        Top = 0
        Width = 517
        Height = 25
        Align = alTop
        Caption = 'GetPlatforms'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'NETWORKS EVENT'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 517
        Height = 193
        Align = alTop
        BorderStyle = bsNone
        DoubleBuffered = True
        ParentDoubleBuffered = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
      object Button4: TButton
        Left = 0
        Top = 199
        Width = 75
        Height = 25
        Caption = 'Network Log'
        TabOrder = 1
        OnClick = Button4Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'WATCHER'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 517
        Height = 33
        Align = alTop
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        object Button2: TButton
          Left = 376
          Top = 5
          Width = 64
          Height = 25
          Caption = 'Start'
          TabOrder = 0
        end
        object Button3: TButton
          Left = 446
          Top = 5
          Width = 64
          Height = 25
          Caption = 'Stop'
          TabOrder = 1
        end
      end
      object lvPlatform: TListView
        Left = 0
        Top = 33
        Width = 517
        Height = 193
        Align = alClient
        Columns = <
          item
            Caption = 'ID'
          end
          item
            Caption = 'Name'
            Width = 80
          end
          item
            Caption = 'Pos X'
            Width = 90
          end
          item
            Caption = 'Pos Y'
            Width = 90
          end
          item
            Caption = 'Actual Speed'
          end
          item
            Caption = 'Ordered Speed'
          end
          item
            Caption = 'Actual Heading'
          end
          item
            Caption = 'Ordered Heading'
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object tsDatalink: TTabSheet
      Caption = 'DATALINK'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblNCS: TLabel
        Left = 3
        Top = 3
        Width = 106
        Height = 13
        Caption = 'Datalink NCS Entities :'
      end
      object lblDL1: TLabel
        Left = 3
        Top = 22
        Width = 47
        Height = 13
        Caption = 'Datalink 1'
      end
      object lblDL2: TLabel
        Left = 143
        Top = 22
        Width = 47
        Height = 13
        Caption = 'Datalink 2'
      end
      object lblDL3: TLabel
        Left = 283
        Top = 22
        Width = 47
        Height = 13
        Caption = 'Datalink 3'
      end
      object mmoDL1: TMemo
        Left = 3
        Top = 41
        Width = 134
        Height = 182
        ReadOnly = True
        TabOrder = 0
      end
      object mmoDL2: TMemo
        Left = 143
        Top = 41
        Width = 134
        Height = 182
        Lines.Strings = (
          '')
        ReadOnly = True
        TabOrder = 1
      end
      object mmoDL3: TMemo
        Left = 283
        Top = 41
        Width = 134
        Height = 182
        ReadOnly = True
        TabOrder = 2
      end
    end
    object tsDataBuffer: TTabSheet
      Caption = 'DATABUFFER'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object vrblnkld1: TVrBlinkLed
        Left = 0
        Top = 206
        Width = 517
        Height = 20
        Palette1.Low = clLime
        Palette1.High = clRed
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        BlinkLedType = ltLargeRect
        Margin = 2
        Spacing = 3
        Align = alBottom
        Color = clMaroon
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
        ExplicitLeft = 72
        ExplicitTop = 64
        ExplicitWidth = 50
      end
      object mmo1: TMemo
        Left = 0
        Top = 25
        Width = 517
        Height = 181
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object btn1: TButton
        Left = 0
        Top = 0
        Width = 517
        Height = 25
        Align = alTop
        Caption = 'GetDataBuffer'
        TabOrder = 1
        OnClick = btn1Click
      end
    end
    object tsStatusPlatform: TTabSheet
      Caption = 'Status Platform'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lvStatusPlatform: TListView
        Left = 0
        Top = 35
        Width = 517
        Height = 191
        Align = alClient
        Columns = <
          item
            Caption = 'ID'
          end
          item
            Caption = 'Nama Platform'
            Width = 150
          end
          item
            Caption = 'Status'
            Width = 200
          end
          item
            Caption = 'Controlled By'
            Width = 110
          end
          item
          end>
        RowSelect = True
        ParentShowHint = False
        ShowWorkAreas = True
        ShowHint = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 517
        Height = 35
        Align = alTop
        TabOrder = 1
        object btnStart: TButton
          Left = 352
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Start'
          TabOrder = 0
        end
        object btnStop: TButton
          Left = 433
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Stop'
          TabOrder = 1
          OnClick = btnStopClick
        end
      end
    end
  end
  object Timer1: TTimer
    Interval = 500
    Left = 392
    Top = 232
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 352
    Top = 232
  end
  object tmrStatePlatform: TTimer
    Enabled = False
    Interval = 500
    Left = 424
    Top = 232
  end
end

object frmDebugReplay: TfrmDebugReplay
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Replay'
  ClientHeight = 32
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object rgReplayGameSpeed: TRadioGroup
    Left = 8
    Top = 200
    Width = 96
    Height = 81
    Caption = 'Speed'
    ItemIndex = 0
    Items.Strings = (
      'satu'
      'dua'
      'empat'
      'delapan')
    TabOrder = 0
    OnClick = rgReplayGameSpeedClick
  end
  object Panel2: TPanel
    Left = 110
    Top = 53
    Width = 177
    Height = 0
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitTop = 59
    ExplicitWidth = 268
    object sGrid: TStringGrid
      Left = 5
      Top = 5
      Width = 167
      Height = 2
      Align = alClient
      ColCount = 6
      Ctl3D = False
      DefaultRowHeight = 16
      FixedCols = 0
      RowCount = 48
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentCtl3D = False
      TabOrder = 0
      OnClick = sGridClick
      OnDrawCell = sGridDrawCell
      ExplicitWidth = 258
      ExplicitHeight = 330
      ColWidths = (
        41
        71
        68
        69
        42
        64)
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 53
    Width = 110
    Height = 0
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 59
    object btnClose: TButton
      Left = 8
      Top = 33
      Width = 97
      Height = 25
      Caption = 'CloseFile'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnOpenFile: TButton
      Left = 8
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Open File'
      TabOrder = 1
      OnClick = btnOpenFileClick
    end
    object btnPause: TButton
      Left = 8
      Top = 129
      Width = 96
      Height = 25
      Caption = 'Pause'
      TabOrder = 2
      OnClick = btnPauseClick
    end
    object btnResume: TButton
      Left = 8
      Top = 154
      Width = 96
      Height = 25
      Caption = 'Resume'
      TabOrder = 3
      OnClick = btnResumeClick
    end
    object btnStartReplay: TButton
      Left = 8
      Top = 73
      Width = 96
      Height = 25
      Caption = 'StartReplay'
      TabOrder = 4
      OnClick = btnStartReplayClick
    end
    object btnStopReplay: TButton
      Left = 8
      Top = 98
      Width = 96
      Height = 25
      Caption = 'StopReplay'
      TabOrder = 5
      OnClick = btnStopReplayClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 287
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 10
    TabOrder = 3
    ExplicitWidth = 584
    object lblFrameInfo: TLabel
      Left = 10
      Top = 10
      Width = 267
      Height = 16
      Align = alClient
      Layout = tlBottom
      ExplicitWidth = 606
      ExplicitHeight = 38
    end
  end
  object ScrollBar1: TScrollBar
    Left = 0
    Top = 36
    Width = 287
    Height = 17
    Align = alTop
    PageSize = 0
    TabOrder = 4
    OnChange = ScrollBar1Change
    ExplicitLeft = 10
    ExplicitTop = 10
    ExplicitWidth = 564
  end
  object OpenDlg: TOpenDialog
    InitialDir = '.'
    Left = 64
    Top = 352
  end
end

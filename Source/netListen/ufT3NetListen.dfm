object frmNetListen: TfrmNetListen
  Left = 0
  Top = 0
  Caption = 'frmNetListen'
  ClientHeight = 540
  ClientWidth = 799
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sgDistance: TStringGrid
    Left = 0
    Top = 73
    Width = 404
    Height = 467
    Align = alClient
    DefaultRowHeight = 18
    TabOrder = 0
    ExplicitWidth = 799
    RowHeights = (
      18
      18
      18
      18
      18)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 799
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 25
      Width = 56
      Height = 13
      Caption = 'Game State'
    end
    object Label2: TLabel
      Left = 16
      Top = 54
      Width = 41
      Height = 13
      Caption = 'Selected'
    end
    object lblGameState: TLabel
      Left = 90
      Top = 25
      Width = 40
      Height = 13
      Caption = 'Stopped'
    end
    object lblSelectedPID: TLabel
      Left = 90
      Top = 54
      Width = 6
      Height = 13
      Caption = '0'
    end
    object network: TLabel
      Left = 16
      Top = 11
      Width = 59
      Height = 13
      Caption = 'GameServer'
    end
    object lblSockState: TLabel
      Left = 90
      Top = 11
      Width = 64
      Height = 13
      Caption = 'Disconnected'
    end
    object lblConsole: TLabel
      Left = 90
      Top = 44
      Width = 64
      Height = 13
      Caption = 'Disconnected'
    end
    object Label4: TLabel
      Left = 16
      Top = 44
      Width = 38
      Height = 13
      Caption = 'Console'
    end
    object btnGetDistance: TButton
      Left = 392
      Top = 20
      Width = 75
      Height = 25
      Caption = 'GetDistance'
      TabOrder = 0
      OnClick = btnGetDistanceClick
    end
  end
  object Memo1: TMemo
    Left = 404
    Top = 73
    Width = 395
    Height = 467
    Align = alRight
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
    WordWrap = False
  end
end

object frmDebug: TfrmDebug
  Left = 503
  Top = 477
  Caption = 'frmDebug'
  ClientHeight = 233
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
    Height = 201
    ActivePage = tsNetLog
    Align = alClient
    TabOrder = 0
    object tsNetConnect: TTabSheet
      Caption = 'NetConnect'
      ImageIndex = 2
      object lvNetState: TListView
        Left = 0
        Top = 0
        Width = 327
        Height = 173
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'IPAddress'
          end
          item
            Caption = 'Status'
          end>
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object tsNetLog: TTabSheet
      Caption = 'sNetLog'
      ImageIndex = 6
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 327
        Height = 173
        ActivePage = TabSheet10
        Align = alClient
        TabOrder = 0
        object TabSheet8: TTabSheet
          Caption = 'Net Log'
          object mmNet: TMemo
            Left = 0
            Top = 0
            Width = 319
            Height = 145
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'Send Log'
          ImageIndex = 2
          object mmSend: TMemo
            Left = 0
            Top = 0
            Width = 319
            Height = 145
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'Recv Log'
          ImageIndex = 3
          object mmRecv: TMemo
            Left = 0
            Top = 0
            Width = 319
            Height = 145
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 201
    Width = 335
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
  end
end

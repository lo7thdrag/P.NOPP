object frmSummaryPlatform: TfrmSummaryPlatform
  Left = 91
  Top = 0
  Caption = 'frmSummaryPlatform'
  ClientHeight = 577
  ClientWidth = 981
  Color = 4989446
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object lblClass: TLabel
    Left = 25
    Top = 35
    Width = 49
    Height = 17
    Caption = 'Class :'
    Color = clBackground
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial Rounded MT Bold'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object PgcSummaryPlatform: TPageControl
    Left = 25
    Top = 94
    Width = 936
    Height = 427
    HelpType = htKeyword
    ActivePage = TbsPhysical
    TabHeight = 40
    TabOrder = 1
    TabWidth = 105
    object TbsGeneral: TTabSheet
      Caption = 'General'
      object btnAdd: TImage
        Left = 278
        Top = 18
        Width = 19
        Height = 21
        Cursor = crHandPoint
        Hint = 'Add Data'
        ParentShowHint = False
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D494844520000001D0000
          001D08060000005693670F000000097048597300002E2300002E230178A53F76
          000000664944415478DA639C78F3C77F063A0346A8A58C1498E100C40D406C4F
          4F4B49B69C9A96126D392D2C2568392D2DC569393D2CC5B09C124B61598D54BD
          FF472D1DB574F85A4A690D84CDDCC16929DE60C263305E7DA3968E5A3A322D25
          178C5A3A8C2DA52B0000BA8D8D1B420588510000000049454E44AE426082}
        Proportional = True
        ShowHint = True
        Stretch = True
        Transparent = True
      end
      object Label1: TLabel
        Left = 19
        Top = 24
        Width = 93
        Height = 15
        Caption = 'Member Of Class :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object btnDelete: TImage
        Left = 326
        Top = 18
        Width = 19
        Height = 21
        Cursor = crHandPoint
        Hint = 'Delete Data'
        ParentShowHint = False
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D494844520000001D0000
          001D08060000005693670F000000097048597300002E2300002E230178A53F76
          000002584944415478DABD965D888C611480CF6824960B5ACACF0D6A93FCFF84
          08118A42E42FAE08456DB8D80B4512C20576293F25171B4552A4144512B217F2
          736308E566E5A7D4A2DDD078CE9E33E33556E69BEFB56F3DCD37DFCC7CCF7BDE
          73DEF34EA63ED79A974E1E1995D6D674CB54FA8086E76D3379D90533D24B33C9
          E6D1906B2D5B5E8E542FF48183E1313C84424A7AC2E7A4F27F49B3700E96059F
          BC814B300EA6C166389124F272239D042B6139F42FF9E62D9807DFFE78463EDF
          61CE93E6B48BFF78152C853E7EFF1D9C8553F02C9416230FE4690AA92BCC8515
          B0187AC10F5FEE93A5D2409E8F55BDDD6181AFC01C180DAF2B950E80E149EC8C
          1EF0169A2A954E87DB09A53AB4DA2F562AD57DF809BEC33D18017DE10B3C8051
          500D1FE0094CF64887412E4D4E9FC21DD824B62FF57A1B1C16DB42E78B9189EC
          832D5228AA14D2D31ECD22B1AEF4CA27705CAC78AE8AEDE3263803236142FB2F
          534837C2565F32ADD2AF1D4887FA64EEB62FABC8DAB4D2F1701FAAC4BA4E0BD4
          9548AB7C321F6137D4A795665D3456ACDBBC804381F4824BB5C0B433CD869B69
          A5E291EE87CB6255DC18488FC210F95564FDE07D0CE9116886036227CC8D40BA
          53AC90D6C11E090F8494D235304BAC40B4AF3E0AA45A680BE1208C11EBC751A4
          3562DB61AA58A13407D2251EE515CF795D2CA9BE79E9B9AB15ABE2825427B2DD
          857B3DDF51A43AAEC36AB1BF2ED5815457E198D89699E84B1F4DAA51685F1D28
          76786B6EB50DF6166B0A1AADF6EAB698D229FEF0BF1DB4D760FE6F77221DE21B
          60070C0AEE6964BA85D68B9DA3D1A5C94662E97F1A456967090BE327FF026B2A
          FAE8FCBF0000000049454E44AE426082}
        Proportional = True
        ShowHint = True
        Stretch = True
        Transparent = True
      end
      object Label11: TLabel
        Left = 27
        Top = 235
        Width = 42
        Height = 15
        Caption = 'Domain'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 27
        Top = 262
        Width = 49
        Height = 15
        Caption = 'Category'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 27
        Top = 289
        Width = 26
        Height = 15
        Caption = 'Type'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 27
        Top = 316
        Width = 88
        Height = 15
        Caption = 'detectability type'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 120
        Top = 316
        Width = 6
        Height = 15
        Caption = ' :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 121
        Top = 289
        Width = 6
        Height = 15
        Caption = ' :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 121
        Top = 262
        Width = 6
        Height = 15
        Caption = ' :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 121
        Top = 235
        Width = 6
        Height = 15
        Caption = ' :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object btnEdit: TImage
        Left = 302
        Top = 18
        Width = 19
        Height = 21
        Cursor = crHandPoint
        Hint = 'Edit Data'
        ParentShowHint = False
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D494844520000001D0000
          001D08060000005693670F000000097048597300002E2300002E230178A53F76
          0000019C4944415478DAE5D4CF2B04611CC7F167AE94F5EBA80D719572418983
          DF925CC4969348FE08F12738919C2807C96F22CE42580E086751A29C08599FA7
          E7BB358DE779E6997D76E6E2A977EDCC3C3BAF9D6776C699BAFD48B1888743A8
          63718E2634811AA34403E3D9448DF130505F3C4C54894781FEC1B38136A06954
          89B6D0307AD5CC4FD9A2CD681DE5B8F625510B7A09036D45AB1ED004CE18E5E0
          1AFA41B98A39FC786FB6D036BAC20334843650AD64DEBB621502A3ED04EEA13E
          F489626857025FA26A5BB483C01DD44F607AC4687F3D6DBFD18A1CDBA01CE4F7
          685B02A6471CDDD3B2F21539529CCB08ED422B68132514603EDA67E259D58146
          68375A66E2CFC2C12FC99C02022B98F8579FF8AC9A16ED414B040EA06FC99C42
          02CB99782E4F99FF50A279E89989B74D4203F2C7A68C8937D39901A8456BE857
          CFA0313ED173BC88AEB094AED014D4A27C3917E9F32C1A75C1C504C6093C0F00
          6AD17134E9DA9E43232EB084C06440508BCEA341CFBE05544520BF871719805A
          F410D549BEF0883A2D402D7A879ED015BA4637D48305E68B8639FE211AE9F805
          6634CC1BA5DBBF090000000049454E44AE426082}
        Proportional = True
        ShowHint = True
        Stretch = True
        Transparent = True
      end
      object lstSummaryPlatformGeneral: TListBox
        Left = 19
        Top = 45
        Width = 326
        Height = 164
        BevelInner = bvLowered
        BevelKind = bkSoft
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object GrpCommunications: TGroupBox
        Left = 376
        Top = 87
        Width = 537
        Height = 202
        Caption = 'Communications'
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        object Label2: TLabel
          Left = 11
          Top = 26
          Width = 29
          Height = 15
          Caption = 'Link :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 11
          Top = 51
          Width = 34
          Height = 15
          Caption = 'Voice :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 11
          Top = 74
          Width = 100
          Height = 15
          Caption = 'Message Handling :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 11
          Top = 116
          Width = 93
          Height = 15
          Caption = 'Antenna Height  :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 11
          Top = 141
          Width = 262
          Height = 15
          Caption = 'Antenna Height Above Water When Submerged :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 11
          Top = 166
          Width = 237
          Height = 15
          Caption = 'Maximum Communication Operating Depth :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 367
          Top = 116
          Width = 20
          Height = 15
          Caption = 'feet'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 367
          Top = 141
          Width = 20
          Height = 15
          Caption = 'feet'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 367
          Top = 166
          Width = 20
          Height = 15
          Caption = 'feet'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object ChkHfLink: TCheckBox
          Left = 120
          Top = 25
          Width = 81
          Height = 17
          Caption = 'HF Link'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
        object ChkHfVoice: TCheckBox
          Left = 120
          Top = 50
          Width = 81
          Height = 17
          Caption = 'HF Voice'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 1
        end
        object ChkHfMessage: TCheckBox
          Left = 120
          Top = 73
          Width = 81
          Height = 17
          Caption = 'HF Message'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 2
        end
        object ChkUhfLink: TCheckBox
          Left = 207
          Top = 25
          Width = 97
          Height = 17
          Caption = 'UHF Link'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 3
        end
        object ChkUhfVhfVoice: TCheckBox
          Left = 207
          Top = 50
          Width = 97
          Height = 17
          Caption = 'UHF/VHF Voice'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 4
        end
        object ChkUhfMessage: TCheckBox
          Left = 207
          Top = 73
          Width = 97
          Height = 17
          Caption = 'UHF Message'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 5
        end
        object ChkSatcomMessage: TCheckBox
          Left = 310
          Top = 73
          Width = 115
          Height = 17
          Caption = 'SATCOM Message'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 6
        end
        object ChkSatcomVoice: TCheckBox
          Left = 310
          Top = 50
          Width = 97
          Height = 17
          Caption = 'SATCOM Voice'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 7
        end
        object ChkUwt: TCheckBox
          Left = 413
          Top = 50
          Width = 76
          Height = 17
          Caption = 'UWT'
          Color = clCream
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 8
        end
        object EdtAntennaHeigthAboveWater: TEdit
          Left = 294
          Top = 138
          Width = 67
          Height = 21
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 9
        end
        object EdtMaximumCommunication: TEdit
          Left = 294
          Top = 163
          Width = 67
          Height = 21
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 10
        end
        object EdtAntennaHeight: TEdit
          Left = 294
          Top = 113
          Width = 67
          Height = 21
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 11
        end
      end
      object AdvCategoryGeneral: TAdvComboBox
        Left = 136
        Top = 259
        Width = 209
        Height = 21
        Color = clWindow
        Version = '1.9.4.0'
        Visible = True
        BevelKind = bkSoft
        BevelInner = bvLowered
        ButtonWidth = 17
        EmptyTextStyle = []
        DropWidth = 0
        Enabled = True
        ItemIndex = -1
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        TabOrder = 2
      end
      object AdvTypeGeneral: TAdvComboBox
        Left = 136
        Top = 286
        Width = 209
        Height = 21
        Color = clWindow
        Version = '1.9.4.0'
        Visible = True
        BevelKind = bkSoft
        BevelInner = bvLowered
        ButtonWidth = 17
        EmptyTextStyle = []
        DropWidth = 0
        Enabled = True
        ItemIndex = -1
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        TabOrder = 3
      end
      object AdvDetectabilityTypeGeneral: TAdvComboBox
        Left = 136
        Top = 313
        Width = 209
        Height = 21
        Color = clWindow
        Version = '1.9.4.0'
        Visible = True
        BevelKind = bkSoft
        BevelInner = bvLowered
        ButtonWidth = 17
        EmptyTextStyle = []
        DropWidth = 0
        Enabled = True
        ItemIndex = -1
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        TabOrder = 4
      end
      object GrpDamageSustainability: TGroupBox
        Left = 376
        Top = 295
        Width = 537
        Height = 66
        Caption = 'Damage Sustainability'
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 5
        object TbDamageSustainability: TTrackBar
          Left = 11
          Top = 21
          Width = 437
          Height = 28
          TabOrder = 0
        end
        object EdtDamageSustainability: TEdit
          Left = 454
          Top = 25
          Width = 67
          Height = 21
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 1
        end
      end
      object GrpCapabilities: TGroupBox
        Left = 376
        Top = 37
        Width = 537
        Height = 44
        Caption = 'Capabilities'
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 6
        object chkNavigationLight: TCheckBox
          Left = 240
          Top = 19
          Width = 97
          Height = 17
          Caption = 'Navigation Lights'
          Color = clCream
          ParentColor = False
          TabOrder = 0
        end
        object ChkBarrierChaff: TCheckBox
          Left = 97
          Top = 19
          Width = 97
          Height = 17
          Caption = 'Barrier Chaff'
          Color = clCream
          ParentColor = False
          TabOrder = 1
        end
      end
      object AdvDomainGeneral: TAdvComboBox
        Left = 136
        Top = 232
        Width = 209
        Height = 21
        Color = clWindow
        Version = '1.9.4.0'
        Visible = True
        BevelKind = bkSoft
        BevelInner = bvLowered
        BiDiMode = bdLeftToRight
        ButtonWidth = 17
        EmptyTextStyle = []
        DropWidth = 0
        Enabled = True
        ItemIndex = -1
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        ParentBiDiMode = False
        TabOrder = 7
      end
    end
    object TbsModel: TTabSheet
      Caption = 'Model'
      ImageIndex = 1
      object ImgDefaultModel: TImage
        Left = 19
        Top = 45
        Width = 558
        Height = 316
      end
      object Label19: TLabel
        Left = 19
        Top = 24
        Width = 83
        Height = 15
        Caption = 'Default Model  :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object GroupBox2: TGroupBox
        Left = 608
        Top = 45
        Width = 297
        Height = 316
        Caption = 'Tactical Syimbol'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        object Label20: TLabel
          Left = 19
          Top = 37
          Width = 57
          Height = 15
          Caption = 'Font Type '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 19
          Top = 72
          Width = 45
          Height = 15
          Caption = 'Font ID  '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 19
          Top = 107
          Width = 52
          Height = 15
          Caption = 'Model ID  '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 82
          Top = 37
          Width = 6
          Height = 15
          Caption = ': '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 83
          Top = 107
          Width = 6
          Height = 15
          Caption = ': '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label25: TLabel
          Left = 83
          Top = 72
          Width = 6
          Height = 15
          Caption = ': '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label26: TLabel
          Left = 70
          Top = 280
          Width = 157
          Height = 15
          Caption = 'skadron heli anti kapal selam. '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object AdvTacticalSymbol: TAdvComboBox
          Left = 103
          Top = 33
          Width = 154
          Height = 23
          Color = clWindow
          Version = '1.9.4.0'
          Visible = True
          BevelKind = bkSoft
          BevelInner = bvLowered
          BiDiMode = bdLeftToRight
          ButtonWidth = 17
          EmptyTextStyle = []
          DropWidth = 0
          Enabled = True
          ItemIndex = -1
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          ParentBiDiMode = False
          TabOrder = 0
        end
        object edtFontIDTacticalSymbol: TEdit
          Left = 103
          Top = 65
          Width = 110
          Height = 30
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 1
        end
        object edtModelIDTacticalSyimbol: TEdit
          Left = 103
          Top = 100
          Width = 110
          Height = 30
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 2
        end
        object btnTacticalSyimbolModel: TButton
          Left = 219
          Top = 99
          Width = 38
          Height = 32
          Caption = '...'
          TabOrder = 3
        end
        object btnTacticalSyimbolFont: TButton
          Left = 219
          Top = 63
          Width = 38
          Height = 32
          Caption = '...'
          TabOrder = 4
        end
      end
    end
    object TbsPhysical: TTabSheet
      Caption = 'Physical'
      ImageIndex = 2
      ExplicitLeft = 0
      object Label27: TLabel
        Left = 27
        Top = 24
        Width = 122
        Height = 15
        Caption = 'Motion Characteristics  :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 496
        Top = 87
        Width = 72
        Height = 15
        Caption = 'Cross-Section:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentFont = False
      end
      object GroupBox1: TGroupBox
        Left = 27
        Top = 87
        Width = 454
        Height = 163
        Caption = 'Capabilities'
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 27
        Top = 45
        Width = 824
        Height = 21
        TabOrder = 1
      end
      object GroupBox3: TGroupBox
        Left = 27
        Top = 256
        Width = 454
        Height = 105
        Caption = 'Capabilities'
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
      end
      object GroupBox4: TGroupBox
        Left = 496
        Top = 108
        Width = 201
        Height = 86
        Caption = 'Radar'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 3
        object Label29: TLabel
          Left = 16
          Top = 23
          Width = 35
          Height = 15
          Caption = 'Front :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label30: TLabel
          Left = 16
          Top = 52
          Width = 27
          Height = 15
          Caption = 'Side :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object edtRadarFront: TEdit
          Left = 64
          Top = 18
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 0
        end
        object edtRadarSide: TEdit
          Left = 64
          Top = 47
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 1
        end
        object advRadarFront: TAdvComboBox
          Left = 127
          Top = 18
          Width = 57
          Height = 24
          Color = clWindow
          Version = '1.9.4.0'
          Visible = True
          BevelKind = bkSoft
          BevelInner = bvLowered
          BiDiMode = bdLeftToRight
          ButtonWidth = 17
          EmptyTextStyle = []
          DropWidth = 0
          Enabled = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = -1
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 2
          Text = 'dBm'
        end
        object advRadarSide: TAdvComboBox
          Left = 127
          Top = 47
          Width = 57
          Height = 24
          Color = clWindow
          Version = '1.9.4.0'
          Visible = True
          BevelKind = bkSoft
          BevelInner = bvLowered
          BiDiMode = bdLeftToRight
          ButtonWidth = 17
          EmptyTextStyle = []
          DropWidth = 0
          Enabled = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = -1
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 3
          Text = 'dBm'
        end
      end
      object GroupBox5: TGroupBox
        Left = 714
        Top = 108
        Width = 192
        Height = 86
        Caption = 'Acoustic'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 4
        object Label31: TLabel
          Left = 24
          Top = 23
          Width = 35
          Height = 15
          Caption = 'Front :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label32: TLabel
          Left = 24
          Top = 52
          Width = 27
          Height = 15
          Caption = 'Side :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label33: TLabel
          Left = 135
          Top = 23
          Width = 28
          Height = 15
          Caption = 'dB m'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 135
          Top = 52
          Width = 28
          Height = 15
          Caption = 'dB m'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object EdtAcousticFront: TEdit
          Left = 72
          Top = 18
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 0
        end
        object EdtAcousticSide: TEdit
          Left = 72
          Top = 47
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 1
        end
      end
      object GroupBox6: TGroupBox
        Left = 496
        Top = 215
        Width = 201
        Height = 86
        Caption = 'Visual/ Electro-Optical'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 5
        object Label35: TLabel
          Left = 24
          Top = 23
          Width = 35
          Height = 15
          Caption = 'Front :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label36: TLabel
          Left = 24
          Top = 52
          Width = 27
          Height = 15
          Caption = 'Side :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label37: TLabel
          Left = 135
          Top = 23
          Width = 34
          Height = 15
          Caption = 'metres'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 135
          Top = 52
          Width = 34
          Height = 15
          Caption = 'metres'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object EdtVisualFront: TEdit
          Left = 72
          Top = 18
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 0
        end
        object EdtVisualSide: TEdit
          Left = 72
          Top = 47
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 1
        end
      end
      object GroupBox7: TGroupBox
        Left = 714
        Top = 215
        Width = 192
        Height = 86
        Caption = 'Infrared'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 6
        object Label39: TLabel
          Left = 24
          Top = 23
          Width = 35
          Height = 15
          Caption = 'Front :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label40: TLabel
          Left = 24
          Top = 52
          Width = 27
          Height = 15
          Caption = 'Side :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label41: TLabel
          Left = 135
          Top = 23
          Width = 34
          Height = 15
          Caption = 'metres'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 135
          Top = 52
          Width = 34
          Height = 15
          Caption = 'metres'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Berlin Sans FB'
          Font.Style = []
          ParentFont = False
        end
        object EdtInfraredFront: TEdit
          Left = 72
          Top = 18
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 0
        end
        object EdtInfraredSide: TEdit
          Left = 72
          Top = 47
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 1
        end
      end
      object GroupBox8: TGroupBox
        Left = 496
        Top = 307
        Width = 201
        Height = 54
        Caption = 'Magnetic'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Berlin Sans FB'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 7
        object EdtMagnetic: TEdit
          Left = 72
          Top = 18
          Width = 57
          Height = 25
          BevelInner = bvLowered
          BevelKind = bkSoft
          BorderStyle = bsNone
          TabOrder = 0
        end
      end
    end
    object TbsCharacteristic: TTabSheet
      Caption = 'Characteristic'
      ImageIndex = 3
    end
    object TbsModifier: TTabSheet
      Caption = 'POH Modifier'
      ImageIndex = 4
    end
    object TbsAssets: TTabSheet
      Caption = 'Assets'
      ImageIndex = 5
    end
    object TbsPeriscope: TTabSheet
      Caption = 'Periscope'
      ImageIndex = 6
    end
    object TbsNotes: TTabSheet
      Caption = 'Notes'
      ImageIndex = 7
    end
  end
  object btnOk: TButton
    Left = 724
    Top = 535
    Width = 75
    Height = 25
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object BtnApply: TButton
    Left = 805
    Top = 535
    Width = 75
    Height = 25
    Caption = 'Apply'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object BtnCancel: TButton
    Left = 886
    Top = 535
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object EdtClass: TEdit
    Left = 25
    Top = 57
    Width = 936
    Height = 21
    TabOrder = 0
  end
end

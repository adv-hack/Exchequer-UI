object CuStkT2: TCuStkT2
  Left = 391
  Top = 286
  HelpContext = 500
  ActiveControl = T2LTotF
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'TeleSales Item Entry'
  ClientHeight = 228
  ClientWidth = 577
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Scaled = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 14
  object Id3Panel: TSBSPanel
    Left = 1
    Top = 3
    Width = 261
    Height = 133
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    AllowReSize = False
    IsGroupBox = False
    TextId = 0
    object Id3SCodeLab: Label8
      Left = 18
      Top = 14
      Width = 55
      Height = 14
      Caption = 'Stock Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
  end
  object SBSPanel4: TSBSPanel
    Left = 264
    Top = 3
    Width = 312
    Height = 133
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    AllowReSize = False
    IsGroupBox = False
    TextId = 0
    object VATCCLab3: Label8
      Left = 39
      Top = 106
      Width = 61
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CC/Dep'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Label826: Label8
      Left = 19
      Top = 75
      Width = 82
      Height = 14
      Caption = 'G/L Code / Desc.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object id3LocLab: Label8
      Left = 74
      Top = 44
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = 'Locn '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Label83: Label8
      Left = 212
      Top = 105
      Width = 44
      Height = 14
      Caption = 'Line type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Label846: Label8
      Left = 5
      Top = 14
      Width = 95
      Height = 14
      Caption = 'Job Code / Analysis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
  end
  object SBSPanel1: TSBSPanel
    Left = 1
    Top = 138
    Width = 575
    Height = 89
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    AllowReSize = False
    IsGroupBox = False
    TextId = 0
    object Id3QtyLab: Label8
      Left = 60
      Top = 6
      Width = 17
      Height = 14
      Caption = 'Qty'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Id3UPLab: Label8
      Left = 139
      Top = 6
      Width = 34
      Height = 14
      Caption = 'U/Price'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Id3DiscLab: Label8
      Left = 229
      Top = 6
      Width = 42
      Height = 14
      Caption = 'Discount'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Id3LTotLab: Label8
      Left = 353
      Top = 6
      Width = 22
      Height = 14
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Label81: Label8
      Left = 395
      Top = 6
      Width = 20
      Height = 14
      Caption = 'VAT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Label82: Label8
      Left = 474
      Top = 6
      Width = 22
      Height = 14
      Caption = 'Cost'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Label84: Label8
      Left = 532
      Top = 6
      Width = 32
      Height = 14
      Caption = 'Margin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TextId = 0
    end
    object Bevel1: TBevel
      Left = 0
      Top = 53
      Width = 575
      Height = 2
    end
    object OkCP1Btn: TButton
      Tag = 1
      Left = 207
      Top = 61
      Width = 80
      Height = 21
      HelpContext = 257
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = CanCP1BtnClick
    end
    object CanCP1Btn: TButton
      Tag = 1
      Left = 297
      Top = 61
      Width = 80
      Height = 21
      HelpContext = 258
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = CanCP1BtnClick
    end
  end
  object T2SCodeF: Text8Pt
    Tag = 1
    Left = 81
    Top = 13
    Width = 168
    Height = 22
    Hint = 
      'Double click to drill down|Double clicking or using the down but' +
      'ton will drill down to the record for this field. The up button ' +
      'will search for the nearest match.'
    HelpContext = 781
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnExit = T2SCodeFExit
    TextId = 0
    ViaSBtn = False
    ShowHilight = True
  end
  object Id3SBox: TScrollBox
    Left = 13
    Top = 41
    Width = 238
    Height = 88
    HelpContext = 692
    HorzScrollBar.Visible = False
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    object T2Desc1F: Text8Pt
      Tag = 1
      Left = 1
      Top = 1
      Width = 218
      Height = 20
      HelpContext = 235
      BorderStyle = bsNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyPress = T2Desc1FKeyPress
      TextId = 0
      ViaSBtn = False
    end
    object T2Desc2F: Text8Pt
      Tag = 1
      Left = 1
      Top = 22
      Width = 218
      Height = 20
      HelpContext = 235
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TextId = 0
      ViaSBtn = False
    end
    object T2Desc3F: Text8Pt
      Tag = 1
      Left = 1
      Top = 43
      Width = 218
      Height = 20
      HelpContext = 235
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TextId = 0
      ViaSBtn = False
    end
    object T2Desc4F: Text8Pt
      Tag = 1
      Left = 1
      Top = 64
      Width = 218
      Height = 20
      HelpContext = 235
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TextId = 0
      ViaSBtn = False
    end
    object T2Desc5F: Text8Pt
      Tag = 1
      Left = 1
      Top = 85
      Width = 218
      Height = 20
      HelpContext = 235
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TextId = 0
      ViaSBtn = False
    end
    object T2Desc6F: Text8Pt
      Tag = 1
      Left = 1
      Top = 106
      Width = 218
      Height = 20
      HelpContext = 235
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TextId = 0
      ViaSBtn = False
    end
  end
  object T2JCodeF: Text8Pt
    Tag = 1
    Left = 370
    Top = 14
    Width = 94
    Height = 22
    Hint = 
      'Double click to drill down|Double clicking or using the down but' +
      'ton will drill down to the record for this field. The up button ' +
      'will search for the nearest match.'
    HelpContext = 778
    CharCase = ecUpperCase
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnExit = T2JCodeFExit
    TextId = 0
    ViaSBtn = False
    Link_to_Job = True
    ShowHilight = True
  end
  object T2JAnalF: Text8Pt
    Tag = 1
    Left = 467
    Top = 14
    Width = 97
    Height = 22
    HelpContext = 778
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnExit = T2JAnalFExit
    TextId = 0
    ViaSBtn = False
  end
  object T2LocF: Text8Pt
    Tag = 1
    Left = 370
    Top = 44
    Width = 53
    Height = 22
    HelpContext = 777
    CharCase = ecUpperCase
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnExit = T2LocFExit
    TextId = 0
    ViaSBtn = False
  end
  object T2NomF: Text8Pt
    Tag = 1
    Left = 370
    Top = 75
    Width = 53
    Height = 22
    HelpContext = 779
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnExit = T2NomFExit
    TextId = 0
    ViaSBtn = False
  end
  object T2NDesc: Text8Pt
    Left = 426
    Top = 75
    Width = 139
    Height = 22
    HelpContext = 779
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 9
    TextId = 0
    ViaSBtn = False
  end
  object T2DepF: Text8Pt
    Tag = 1
    Left = 426
    Top = 105
    Width = 46
    Height = 22
    HelpContext = 776
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnExit = T2CCFExit
    TextId = 0
    ViaSBtn = False
  end
  object T2CCF: Text8Pt
    Tag = 1
    Left = 370
    Top = 105
    Width = 53
    Height = 22
    HelpContext = 776
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnExit = T2CCFExit
    TextId = 0
    ViaSBtn = False
  end
  object T2LTF: TSBSComboBox
    Tag = 1
    Left = 523
    Top = 105
    Width = 43
    Height = 22
    HelpContext = 276
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 14
    MaxLength = 40
    ParentFont = False
    TabOrder = 12
    ExtendedList = True
    MaxListWidth = 75
    Validate = True
  end
  object T2Qty: TCurrencyEdit
    Tag = 1
    Left = 11
    Top = 163
    Width = 82
    Height = 22
    HelpContext = 783
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '0.67-')
    MaxLength = 9
    ParentFont = False
    TabOrder = 13
    WantReturns = False
    WordWrap = False
    OnEnter = T2QtyEnter
    OnExit = T2QtyExit
    OnKeyPress = T2QtyKeyPress
    AutoSize = False
    BlockNegative = False
    BlankOnZero = False
    DisplayFormat = '###,###,##0.00 ;###,###,##0.00-'
    ShowCurrency = False
    TextId = 0
    Value = -0.666666
  end
  object T2UPriceF: TCurrencyEdit
    Tag = 1
    Left = 97
    Top = 163
    Width = 94
    Height = 22
    HelpContext = 785
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '0.67-')
    ParentFont = False
    TabOrder = 14
    WantReturns = False
    WordWrap = False
    OnExit = T2UPriceFExit
    AutoSize = False
    BlockNegative = False
    BlankOnZero = False
    DisplayFormat = '###,###,##0.00 ;###,###,##0.00-'
    ShowCurrency = False
    TextId = 0
    Value = -0.666666
  end
  object T2DiscF: Text8Pt
    Tag = 1
    Left = 194
    Top = 163
    Width = 87
    Height = 22
    HelpContext = 269
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnExit = T2UPriceFExit
    TextId = 0
    ViaSBtn = False
  end
  object T2LTotF: TCurrencyEdit
    Tag = 2
    Left = 284
    Top = 163
    Width = 99
    Height = 22
    HelpContext = 784
    TabStop = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '0.67-')
    ParentFont = False
    TabOrder = 16
    WantReturns = False
    WordWrap = False
    AutoSize = False
    BlockNegative = False
    BlankOnZero = False
    DisplayFormat = '###,###,##0.00 ;###,###,##0.00-'
    ShowCurrency = False
    TextId = 0
    Value = -0.666666
  end
  object T2VATF: TSBSComboBox
    Tag = 1
    Left = 387
    Top = 163
    Width = 40
    Height = 22
    HelpContext = 803
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 14
    MaxLength = 1
    ParentFont = False
    TabOrder = 17
    OnDropDown = T2VATFDropDown
    OnExit = T2VATFExit
    AllowChangeInExit = True
    ExtendedList = True
    MaxListWidth = 75
    Validate = True
  end
  object T2CostF: TCurrencyEdit
    Tag = 1
    Left = 430
    Top = 163
    Width = 82
    Height = 22
    HelpContext = 277
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '0.67-')
    ParentFont = False
    TabOrder = 18
    WantReturns = False
    WordWrap = False
    OnEnter = T2CostFEnter
    OnExit = T2CostFExit
    AutoSize = False
    BlockNegative = False
    BlankOnZero = False
    DisplayFormat = '###,###,##0.00 ;###,###,##0.00-'
    ShowCurrency = False
    TextId = 0
    Value = -0.666666
  end
  object T2Marg: TCurrencyEdit
    Tag = 1
    Left = 516
    Top = 163
    Width = 53
    Height = 22
    HelpContext = 752
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '-0.67')
    ParentFont = False
    TabOrder = 19
    WantReturns = False
    WordWrap = False
    AutoSize = False
    BlockNegative = False
    BlankOnZero = False
    DisplayFormat = ' 0.00%;-0.00'
    ShowCurrency = False
    TextId = 0
    Value = -0.666666
  end
end

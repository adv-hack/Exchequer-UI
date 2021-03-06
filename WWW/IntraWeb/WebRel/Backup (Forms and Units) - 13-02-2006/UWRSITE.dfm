object frmSite: TfrmSite
  Left = 0
  Top = 0
  Width = 621
  Height = 589
  Background.Fixed = False
  HandleTabs = False
  SupportedBrowsers = [brIE, brNetscape6]
  TemplateProcessor = TemplateProcessor
  OnCreate = IWAppFormCreate
  DesignLeft = 265
  DesignTop = 111
  object cbDealership: TIWComboBox
    Left = 136
    Top = 40
    Width = 240
    Height = 21
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ItemsHaveValues = False
    NoSelectionText = ' '
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cbDealershipChange
    UseSize = True
    DoSubmitValidation = True
    Editable = True
    TabOrder = 0
    ItemIndex = -1
    Sorted = True
  end
  object cbCustomer: TIWComboBox
    Left = 136
    Top = 64
    Width = 240
    Height = 21
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ItemsHaveValues = False
    NoSelectionText = ' '
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cbCustomerChange
    UseSize = True
    DoSubmitValidation = True
    Editable = True
    TabOrder = 1
    ItemIndex = -1
    Sorted = True
  end
  object cbESN: TIWComboBox
    Left = 136
    Top = 88
    Width = 240
    Height = 21
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ItemsHaveValues = False
    NoSelectionText = ' '
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cbESNChange
    UseSize = True
    DoSubmitValidation = True
    Editable = True
    TabOrder = 2
    ItemIndex = -1
    Sorted = True
  end
  object lblDealership: TIWLabel
    Left = 24
    Top = 40
    Width = 75
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'Dealership:'
  end
  object lblCustomer: TIWLabel
    Left = 24
    Top = 64
    Width = 66
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'Customer:'
  end
  object lblESN: TIWLabel
    Left = 24
    Top = 88
    Width = 34
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'ESN:'
  end
  object lblVersion: TIWLabel
    Left = 24
    Top = 112
    Width = 53
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'Version:'
  end
  object cbVersion: TIWComboBox
    Left = 136
    Top = 112
    Width = 240
    Height = 21
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ItemsHaveValues = False
    NoSelectionText = ' '
    RequireSelection = True
    ScriptEvents = <>
    UseSize = True
    DoSubmitValidation = True
    Editable = True
    TabOrder = 3
    ItemIndex = -1
    Sorted = True
  end
  object bnContinue: TIWButton
    Left = 279
    Top = 152
    Width = 120
    Height = 25
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Continue'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 6
    OnClick = bnContinueClick
  end
  object bnAdmin: TIWButton
    Left = 150
    Top = 152
    Width = 120
    Height = 25
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Admin'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 5
    OnClick = bnAdminClick
  end
  object memoDealer: TIWMemo
    Left = 24
    Top = 228
    Width = 300
    Height = 150
    ZIndex = 0
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    RawText = False
    ReadOnly = True
    Required = False
    TabOrder = 7
    WantReturns = False
    FriendlyName = 'memoDealer'
  end
  object memoCustomer: TIWMemo
    Left = 24
    Top = 412
    Width = 300
    Height = 150
    ZIndex = 0
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    RawText = False
    ReadOnly = True
    Required = False
    TabOrder = 8
    WantReturns = False
    FriendlyName = 'IWMemo1'
  end
  object lblCustNotes: TIWLabel
    Left = 28
    Top = 392
    Width = 113
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'Customer Notes:-'
  end
  object lblDealerNotes: TIWLabel
    Left = 28
    Top = 208
    Width = 91
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'Dealer Notes:'
  end
  object bnDummy: TIWButton
    Left = 22
    Top = 152
    Width = 120
    Height = 25
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Use Dummy'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 4
    OnClick = bnDummyClick
  end
  object bnLogout: TIWButton
    Left = 279
    Top = 182
    Width = 120
    Height = 25
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Logout'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 9
    OnClick = bnLogoutClick
  end
  object edFilterDealer: TIWEdit
    Left = 390
    Top = 40
    Width = 56
    Height = 21
    ZIndex = 0
    BGColor = clNone
    DoSubmitValidation = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edFilterDealer'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    TabOrder = 10
    PasswordPrompt = False
  end
  object edFilterCust: TIWEdit
    Left = 390
    Top = 64
    Width = 56
    Height = 21
    ZIndex = 0
    BGColor = clNone
    DoSubmitValidation = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edFilterCust'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    TabOrder = 11
    PasswordPrompt = False
  end
  object bnFilterDealer: TIWButton
    Left = 455
    Top = 40
    Width = 75
    Height = 22
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Filter'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 12
    OnClick = bnFilterDealerClick
  end
  object bnFilterCust: TIWButton
    Left = 455
    Top = 64
    Width = 75
    Height = 22
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Filter'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 13
    OnClick = bnFilterCustomerClick
  end
  object cbContainsDealer: TIWCheckBox
    Left = 540
    Top = 40
    Width = 75
    Height = 21
    ZIndex = 0
    Caption = 'Contains'
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    DoSubmitValidation = True
    Style = stNormal
    TabOrder = 14
    Checked = False
  end
  object cbContainsCust: TIWCheckBox
    Left = 540
    Top = 64
    Width = 75
    Height = 21
    ZIndex = 0
    Caption = 'Contains'
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    DoSubmitValidation = True
    Style = stNormal
    TabOrder = 15
    Checked = False
  end
  object lbDemoHint: TIWLabel
    Left = 390
    Top = 90
    Width = 78
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'UNKNOWN'
  end
  object TemplateProcessor: TIWTemplateProcessorHTML
    Enabled = True
    MasterFormTag = True
    TagType = ttIntraWeb
    Left = 363
    Top = 253
  end
end

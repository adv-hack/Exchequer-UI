object frmHome: TfrmHome
  Left = 0
  Top = 0
  Width = 270
  Height = 164
  Background.Fixed = False
  HandleTabs = False
  SupportedBrowsers = [brIE, brNetscape6]
  TemplateProcessor = TemplateProcessor
  DesignLeft = 303
  DesignTop = 153
  object lblUserID: TIWLabel
    Left = 24
    Top = 40
    Width = 52
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'User ID:'
  end
  object lblPassword: TIWLabel
    Left = 24
    Top = 64
    Width = 69
    Height = 16
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    Caption = 'Password:'
  end
  object edUserID: TIWEdit
    Left = 104
    Top = 40
    Width = 120
    Height = 21
    ZIndex = 0
    BGColor = clNone
    DoSubmitValidation = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edUserID'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    TabOrder = 0
    OnSubmit = edUserIDSubmit
    PasswordPrompt = False
  end
  object edPassword: TIWEdit
    Left = 104
    Top = 64
    Width = 120
    Height = 21
    ZIndex = 0
    BGColor = clNone
    DoSubmitValidation = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edPassword'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    TabOrder = 1
    OnSubmit = bnLoginClick
    PasswordPrompt = True
  end
  object bnLogin: TIWButton
    Left = 104
    Top = 104
    Width = 123
    Height = 25
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Login'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 2
    OnClick = bnLoginClick
  end
  object TemplateProcessor: TIWTemplateProcessorHTML
    Enabled = True
    MasterFormTag = True
    TagType = ttIntraWeb
    Left = 24
    Top = 104
  end
end

object PassWRec2: TPassWRec2
  Left = 265
  Top = 257
  ActiveControl = DescF
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'User Name & Password'
  ClientHeight = 152
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 14
  object SBSBackGroup1: TSBSBackGroup
    Left = 7
    Top = 6
    Width = 268
    Height = 102
    TextId = 0
  end
  object Label81: Label8
    Left = 45
    Top = 36
    Width = 53
    Height = 14
    Caption = 'User &Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object Label82: Label8
    Left = 47
    Top = 67
    Width = 50
    Height = 14
    Caption = '&Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object OkCP1Btn: TButton
    Tag = 1
    Left = 61
    Top = 119
    Width = 80
    Height = 22
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 2
    OnClick = CanCP1BtnClick
  end
  object CanCP1Btn: TButton
    Tag = 1
    Left = 146
    Top = 119
    Width = 80
    Height = 22
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = CanCP1BtnClick
  end
  object SCodeF: Text8Pt
    Tag = 1
    Left = 110
    Top = 32
    Width = 121
    Height = 22
    TabStop = False
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 0
    TextId = 0
    ViaSBtn = False
  end
  object DescF: Text8Pt
    Tag = 1
    Left = 110
    Top = 63
    Width = 121
    Height = 22
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    ParentShowHint = False
    PasswordChar = 'x'
    ShowHint = True
    TabOrder = 1
    OnEnter = DescFEnter
    OnExit = DescFExit
    TextId = 0
    ViaSBtn = False
  end
end

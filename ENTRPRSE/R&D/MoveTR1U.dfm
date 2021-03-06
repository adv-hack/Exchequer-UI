object MoveLineType: TMoveLineType
  Left = 689
  Top = 274
  ActiveControl = NNumF
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Move Control Record'
  ClientHeight = 191
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Scaled = False
  Visible = True
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
    Top = 8
    Width = 284
    Height = 149
    TextId = 0
  end
  object Label81: Label8
    Left = 17
    Top = 23
    Width = 98
    Height = 14
    AutoSize = False
    Caption = 'Move Code '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object Label82: Label8
    Left = 17
    Top = 65
    Width = 99
    Height = 14
    AutoSize = False
    Caption = 'To'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object Label83: Label8
    Left = 17
    Top = 109
    Width = 32
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Type '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object Label84: Label8
    Left = 127
    Top = 23
    Width = 154
    Height = 14
    AutoSize = False
    Caption = 'Description '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object Label85: Label8
    Left = 127
    Top = 65
    Width = 154
    Height = 14
    AutoSize = False
    Caption = 'Description '
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
    Left = 66
    Top = 165
    Width = 80
    Height = 22
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 5
    OnClick = CanCP1BtnClick
  end
  object CanCP1Btn: TButton
    Tag = 1
    Left = 151
    Top = 165
    Width = 80
    Height = 22
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 6
    OnClick = CanCP1BtnClick
  end
  object SCDescF: Text8Pt
    Left = 125
    Top = 40
    Width = 157
    Height = 22
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 35
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
    OnExit = SCDescFExit
    TextId = 0
    ViaSBtn = False
  end
  object NNumF: Text8Pt
    Tag = 1
    Left = 15
    Top = 40
    Width = 102
    Height = 22
    HelpContext = 201
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
    TabOrder = 0
    OnExit = NNumFExit
    TextId = 0
    ViaSBtn = False
  end
  object ToF: Text8Pt
    Tag = 1
    Left = 15
    Top = 81
    Width = 102
    Height = 22
    HelpContext = 201
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
    TabOrder = 2
    OnExit = NNumFExit
    TextId = 0
    ViaSBtn = False
  end
  object MDescF: Text8Pt
    Left = 125
    Top = 81
    Width = 157
    Height = 22
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 35
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 3
    OnExit = NNumFExit
    TextId = 0
    ViaSBtn = False
  end
  object NITF: TSBSComboBox
    Tag = 1
    Left = 15
    Top = 125
    Width = 120
    Height = 22
    HelpContext = 229
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 4
    MaxListWidth = 95
    Validate = True
  end
end

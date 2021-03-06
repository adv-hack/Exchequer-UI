object CompanyDialog: TCompanyDialog
  Left = 303
  Top = 140
  HelpContext = 3
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Find Company'
  ClientHeight = 256
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object SBSBackGroup1: TSBSBackGroup
    Left = 4
    Top = 183
    Width = 269
    Height = 69
    Caption = 'Directory Contents'
    TextId = 0
  end
  object SysLbl: Label8
    Left = 63
    Top = 216
    Width = 202
    Height = 14
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object Label1: TLabel
    Left = 21
    Top = 216
    Width = 36
    Height = 14
    Caption = 'System'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 25
    Top = 233
    Width = 31
    Height = 14
    Caption = 'Status'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object StatLbl: Label8
    Left = 63
    Top = 233
    Width = 202
    Height = 14
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TextId = 0
  end
  object Label3: TLabel
    Left = 11
    Top = 199
    Width = 45
    Height = 14
    Caption = 'Company'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object CompLbl: Label8
    Left = 63
    Top = 199
    Width = 202
    Height = 14
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowAccelChar = False
    TextId = 0
  end
  object OKBtn: TButton
    Left = 282
    Top = 6
    Width = 80
    Height = 21
    Caption = '&OK'
    TabOrder = 2
    OnClick = OKBtnClick
  end
  object DriveComboBox1: TDriveComboBox
    Left = 4
    Top = 4
    Width = 269
    Height = 20
    Color = clWhite
    DirList = DirectoryListBox1
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 4
    Top = 27
    Width = 269
    Height = 153
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 1
    OnChange = DirectoryListBox1Change
  end
  object CancelBtn: TButton
    Left = 282
    Top = 31
    Width = 80
    Height = 21
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelBtnClick
  end
end

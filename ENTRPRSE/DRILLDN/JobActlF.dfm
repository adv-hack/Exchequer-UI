object frmJobActual: TfrmJobActual
  Left = 386
  Top = 310
  Width = 779
  Height = 371
  Caption = 'Actual Job Costing'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 14
  object PageControl: TPageControl
    Left = 4
    Top = 4
    Width = 757
    Height = 325
    ActivePage = LedgerPage
    TabIndex = 0
    TabOrder = 1
    object LedgerPage: TTabSheet
      Caption = 'Ledger'
      object BtListBox: TScrollBox
        Left = 3
        Top = 3
        Width = 626
        Height = 291
        VertScrollBar.Tracking = True
        VertScrollBar.Visible = False
        TabOrder = 0
        object BtListHeaderPanel: TSBSPanel
          Left = 2
          Top = 3
          Width = 616
          Height = 19
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 0
          AllowReSize = False
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumnHeader
          object CLORefLab: TSBSPanel
            Left = 2
            Top = 2
            Width = 45
            Height = 14
            BevelOuter = bvNone
            Caption = 'Our Ref'
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
          object CLDateLab: TSBSPanel
            Left = 81
            Top = 2
            Width = 60
            Height = 14
            BevelOuter = bvNone
            Caption = 'Date'
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
          object CLOOLab: TSBSPanel
            Left = 360
            Top = 2
            Width = 82
            Height = 14
            Alignment = taRightJustify
            BevelOuter = bvNone
            Caption = 'Charge  '
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 2
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
          object CLQOLab: TSBSPanel
            Left = 231
            Top = 2
            Width = 43
            Height = 14
            Alignment = taRightJustify
            BevelOuter = bvNone
            Caption = 'Hrs/Qty'
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 3
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
          object CLALLab: TSBSPanel
            Left = 275
            Top = 2
            Width = 82
            Height = 14
            Alignment = taRightJustify
            BevelOuter = bvNone
            Caption = 'Cost  '
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 4
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
          object CLACLab: TSBSPanel
            Left = 142
            Top = 2
            Width = 88
            Height = 14
            BevelOuter = bvNone
            Caption = 'Analysis'
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 5
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
          object CLUPLab: TSBSPanel
            Left = 445
            Top = 2
            Width = 82
            Height = 14
            Alignment = taRightJustify
            BevelOuter = bvNone
            Caption = 'Uplift  '
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 6
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
          object CLACCLab: TSBSPanel
            Left = 533
            Top = 2
            Width = 82
            Height = 14
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = 'A/C Code'
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 7
            OnMouseDown = BtListLabMouseDown
            OnMouseMove = BtListLabMouseMove
            AllowReSize = False
            IsGroupBox = False
            TextId = 0
            Purpose = puBtrListColumnHeader
          end
        end
        object CLORefPanel: TSBSPanel
          Left = 3
          Top = 25
          Width = 78
          Height = 248
          HelpContext = 142
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
        object CLDatePanel: TSBSPanel
          Left = 83
          Top = 25
          Width = 60
          Height = 248
          HelpContext = 143
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
        object CLOOPanel: TSBSPanel
          Left = 362
          Top = 25
          Width = 84
          Height = 248
          HelpContext = 979
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
        object CLQOPanel: TSBSPanel
          Left = 234
          Top = 25
          Width = 43
          Height = 248
          HelpContext = 977
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
        object CLALPanel: TSBSPanel
          Left = 279
          Top = 25
          Width = 81
          Height = 248
          HelpContext = 978
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
        object CLAcPanel: TSBSPanel
          Left = 145
          Top = 25
          Width = 87
          Height = 248
          HelpContext = 976
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
        object CLUPPanel: TSBSPanel
          Left = 448
          Top = 25
          Width = 84
          Height = 248
          HelpContext = 979
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
        object CLACCPanel: TSBSPanel
          Left = 534
          Top = 25
          Width = 84
          Height = 248
          HelpContext = 979
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnMouseUp = BtListPanelMouseUp
          AllowReSize = True
          IsGroupBox = False
          TextId = 0
          Purpose = puBtrListColumn
        end
      end
      object BtListBtnPanel: TSBSPanel
        Left = 633
        Top = 30
        Width = 18
        Height = 248
        BevelOuter = bvLowered
        TabOrder = 1
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
      end
    end
  end
  object BtnPanel: TSBSPanel
    Left = 664
    Top = 31
    Width = 91
    Height = 291
    BevelOuter = bvLowered
    TabOrder = 0
    AllowReSize = False
    IsGroupBox = False
    TextId = 0
    object I1BSBox: TScrollBox
      Left = 1
      Top = 3
      Width = 88
      Height = 187
      HorzScrollBar.Visible = False
      BorderStyle = bsNone
      TabOrder = 0
      object btnViewLine: TButton
        Left = 4
        Top = 32
        Width = 80
        Height = 21
        Hint = 
          'Find Stock Code|Choosing this option allows you to move to the n' +
          'ext line containing a specified Stock Code.'
        HelpContext = 264
        Caption = '&View'
        TabOrder = 1
        OnClick = btnViewLineClick
      end
      object btnClose: TButton
        Left = 4
        Top = 1
        Width = 80
        Height = 21
        HelpContext = 259
        Cancel = True
        Caption = 'C&lose'
        ModalResult = 2
        TabOrder = 0
        OnClick = btnCloseClick
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 19
    Top = 62
    object ViewTransaction: TMenuItem
      Caption = '&View Transaction'
      OnClick = ViewTransactionClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object PropFlg: TMenuItem
      Caption = '&Properties'
      Hint = 'Access Colour & Font settings'
      Visible = False
    end
    object N1: TMenuItem
      Caption = '-'
      Visible = False
    end
    object StoreCoordFlg: TMenuItem
      AutoCheck = True
      Caption = '&Save Coordinates'
      Hint = 'Make the current window settings permanent'
      OnClick = StoreCoordFlgClick
    end
    object ResetCoordinates1: TMenuItem
      AutoCheck = True
      Caption = '&Reset Coordinates'
      OnClick = ResetCoordinates1Click
    end
  end
end

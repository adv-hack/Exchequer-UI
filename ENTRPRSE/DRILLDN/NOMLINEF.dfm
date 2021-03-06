object frmGLLineDrill: TfrmGLLineDrill
  Left = 667
  Top = 381
  Width = 495
  Height = 239
  Caption = 'Exchequer GL History Drill-Down'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDefaultPosOnly
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object D1SBox: TScrollBox
    Left = 3
    Top = 4
    Width = 450
    Height = 193
    VertScrollBar.Visible = False
    TabOrder = 0
    object D1HedPanel: TSBSPanel
      Left = 3
      Top = 4
      Width = 556
      Height = 17
      BevelInner = bvLowered
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      AllowReSize = False
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumnHeader
      object D1ORefLab: TSBSPanel
        Left = 4
        Top = 2
        Width = 68
        Height = 13
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Doc'
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        OnMouseDown = D1ORefLabMouseDown
        OnMouseMove = D1ORefLabMouseMove
        OnMouseUp = D1ORefPanelMouseUp
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
        Purpose = puBtrListColumnHeader
      end
      object D1DateLab: TSBSPanel
        Left = 80
        Top = 2
        Width = 61
        Height = 13
        BevelOuter = bvNone
        Caption = 'Period'
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        OnMouseDown = D1ORefLabMouseDown
        OnMouseMove = D1ORefLabMouseMove
        OnMouseUp = D1ORefPanelMouseUp
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
        Purpose = puBtrListColumnHeader
      end
      object D1AccLab: TSBSPanel
        Left = 148
        Top = 2
        Width = 61
        Height = 13
        BevelOuter = bvNone
        Caption = 'A/C'
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        OnMouseDown = D1ORefLabMouseDown
        OnMouseMove = D1ORefLabMouseMove
        OnMouseUp = D1ORefPanelMouseUp
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
        Purpose = puBtrListColumnHeader
      end
      object D1AmtLab: TSBSPanel
        Left = 325
        Top = 2
        Width = 101
        Height = 13
        Alignment = taRightJustify
        BevelOuter = bvNone
        Caption = 'Amount'
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnMouseDown = D1ORefLabMouseDown
        OnMouseMove = D1ORefLabMouseMove
        OnMouseUp = D1ORefPanelMouseUp
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
        Purpose = puBtrListColumnHeader
      end
      object D1StatLab: TSBSPanel
        Left = 435
        Top = 2
        Width = 50
        Height = 13
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Status'
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        OnMouseDown = D1ORefLabMouseDown
        OnMouseMove = D1ORefLabMouseMove
        OnMouseUp = D1ORefPanelMouseUp
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
        Purpose = puBtrListColumnHeader
      end
      object D1DesLab: TSBSPanel
        Left = 216
        Top = 3
        Width = 102
        Height = 13
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Description'
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
        OnMouseDown = D1ORefLabMouseDown
        OnMouseMove = D1ORefLabMouseMove
        OnMouseUp = D1ORefPanelMouseUp
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
        Purpose = puBtrListColumnHeader
      end
      object D1DatLab: TSBSPanel
        Left = 492
        Top = 2
        Width = 60
        Height = 13
        BevelOuter = bvNone
        Caption = 'Date'
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 6
        OnMouseDown = D1ORefLabMouseDown
        OnMouseMove = D1ORefLabMouseMove
        OnMouseUp = D1ORefPanelMouseUp
        AllowReSize = False
        IsGroupBox = False
        TextId = 0
        Purpose = puBtrListColumnHeader
      end
    end
    object D1ORefPanel: TSBSPanel
      Left = 4
      Top = 24
      Width = 74
      Height = 149
      HelpContext = 565
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
      OnMouseUp = D1ORefPanelMouseUp
      AllowReSize = True
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumn
    end
    object D1DatePanel: TSBSPanel
      Left = 81
      Top = 24
      Width = 65
      Height = 149
      HelpContext = 253
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
      OnMouseUp = D1ORefPanelMouseUp
      AllowReSize = True
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumn
    end
    object D1AccPanel: TSBSPanel
      Left = 149
      Top = 24
      Width = 65
      Height = 149
      HelpContext = 91
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
      OnMouseUp = D1ORefPanelMouseUp
      AllowReSize = True
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumn
    end
    object D1DesPanel: TSBSPanel
      Left = 217
      Top = 24
      Width = 106
      Height = 149
      HelpContext = 566
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
      OnMouseUp = D1ORefPanelMouseUp
      AllowReSize = True
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumn
    end
    object D1AmtPanel: TSBSPanel
      Left = 326
      Top = 24
      Width = 106
      Height = 149
      HelpContext = 567
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
      OnMouseUp = D1ORefPanelMouseUp
      AllowReSize = True
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumn
    end
    object D1StatPanel: TSBSPanel
      Left = 435
      Top = 24
      Width = 56
      Height = 149
      HelpContext = 568
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
      OnMouseUp = D1ORefPanelMouseUp
      AllowReSize = True
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumn
    end
    object D1DatPanel: TSBSPanel
      Left = 494
      Top = 25
      Width = 65
      Height = 149
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
      OnMouseUp = D1ORefPanelMouseUp
      AllowReSize = True
      IsGroupBox = False
      TextId = 0
      Purpose = puBtrListColumn
    end
  end
  object D1ListBtnPanel: TSBSPanel
    Left = 456
    Top = 30
    Width = 18
    Height = 148
    BevelOuter = bvLowered
    TabOrder = 1
    AllowReSize = False
    IsGroupBox = False
    TextId = 0
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 34
    Top = 30
    object ViewTransaction1: TMenuItem
      Caption = '&View Transaction'
      OnClick = ViewTransaction1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object PropFlg: TMenuItem
      Caption = '&Properties'
      Hint = 'Access Colour & Font settings'
      OnClick = PropFlgClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object StoreCoordFlg: TMenuItem
      Caption = '&Save Coordinates'
      Hint = 'Make the current window settings permanent'
      OnClick = StoreCoordFlgClick
    end
  end
end

object MainForm: TMainForm
  Left = 194
  Top = 110
  Width = 435
  Height = 300
  Caption = 'MDI Application'
  Color = clAppWorkSpace
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  Position = poDefault
  WindowMenu = Window1
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedPanel: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 30
    Align = alTop
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object OpenBtn: TSpeedButton
      Left = 7
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Open|'
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        333FFFFFFFFFFFFFF3333380000000000000333333888888888888883F333300
        7B7B7B7B7B7B033333883F33333333338F33330F07B7B7B7B7B70333338F8F33
        3333333383F3330B0B7B7B7B7B7B7033338F83F33333333338F3330FB0B7B7B7
        B7B7B033338F38F333333333383F330BF07B7B7B7B7B7B03338F383FFFFF3333
        338F330FBF000007B7B7B703338F33888883FFFFFF83330BFBFBFBF000000033
        338F3333333888888833330FBFBFBFBFBFB03333338F333333333338F333330B
        FBFBFBFBFBF03333338F33333FFFFFF83333330FBFBF0000000333333387FFFF
        8888888333333330000033333333333333388888333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333333333333333333}
      NumGlyphs = 2
      OnClick = FileOpenItemClick
    end
    object SaveBtn: TSpeedButton
      Left = 31
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Save|'
      Enabled = False
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333FFFFFFFFFFFFFF3333380000000000008333
        333888F8FF888F888F333330CC08CCF770CC0333333888F8FF888F888F333330
        CC08CCF770CC0333333888F888888F888F333330CC07887770CC03333338888F
        FFFFF8888F333330CC60000006CC033333388888888888888F333330CCCCCCCC
        CCCC033333388888888888888F333330C6000000006C03333338888888888888
        8F333330C0FFFFFFFF0C0333333888FFFFFFFF888F333330C0FFFFFFFF0C0333
        333888FFFFFFFF888F333330C0FFFFFFFF0C0333333888FFFFFFFF888F333330
        C0FFFFFFFF0C0333333888FFFFFFFF888F33333000FFFFFFFF000333333888FF
        FFFFFF888F333330C0FFFFFFFF0C0333333888FFFFFFFF888F33333800000000
        0000833333388888888888888333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333333333333333333}
      NumGlyphs = 2
      OnClick = FileSaveItemClick
    end
    object CutBtn: TSpeedButton
      Left = 64
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Cut|'
      Enabled = False
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333FFFF333333FF
        FF33333844833333384483333338888FF33338888FF333843348333384334833
        3388F388F333883388F3338433343333433348333388F338F3338F3388F33384
        33343333433348333388FF38FF338F3388333338433483384334833333388FF8
        8FF88FF883333333844448844448333333338888888888883333333333444444
        4433333333333388888888333333333333346FF6433333333333333883F88F33
        333333333330F00F0333333333333338388383F333333333330FFFF0F0333333
        3333338333F8383F3333333330FFF00FFF033333333338333883F383F3333333
        0FFF0330FFF033333333833383383F383F333330FFF033330FFF033333383338
        333383F383F3330FFF03333330FFF033338F33833333383F38F3330FF0333333
        330FF033338F383333333383F8F3330F033333333330F033338F833333333338
        38F3330033333333333300333388333333333333883333333333333333333333
        33333333333333333333}
      NumGlyphs = 2
    end
    object CopyBtn: TSpeedButton
      Left = 88
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Copy|'
      Enabled = False
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333FFFFFFFFFF33333333300000000003333333333888888888
        8F3333333330FFFFFFFF033333333338F33333338F3333333330BFBFBFBF0333
        33333338F3FFFFFF8F3333333330F888888F033333333338F88888838F333333
        3330BFBFBFBF0333333FFFF8F3FFFFFF8F3333000000F888888F033333888888
        F88888838F33330FFFF0BFBFBFBF0333338F3338F3FFFFFF8F33330FFFF0F888
        888F0333338F3338F88888838F33330F7770BFBFBFBF0333338F3338F333333F
        8F33330FFFF0FFFFFF000333338F3338F33333888333330F7770BFBFBF003333
        338F3338FFFFFF883333330FFFF0000000033333338F3338888888833333330F
        777777F033333333338F33333338F3333333330FFFFFFFF033333333338F3333
        33F8F3333333330FFFFFF00033333333338F3333388833333333330FFFFFF003
        33333333338FFFFFF88333333333330000000033333333333388888888333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333333333333333333}
      NumGlyphs = 2
    end
    object PasteBtn: TSpeedButton
      Left = 112
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Paste|'
      Enabled = False
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333FFFFFFFFF333333333300000000033333333333888888
        888F33333333330BFBFBFB03333FFFFFFF8F3FFFFF8F33000000000F88888F03
        33888888888F8888838F307F7F7F7F0BFBFBFB0338F33333338F333FFF8F30F7
        F7F7F70F77888F0338F33333338FFF88838F307F7F7F74444BFBFB0338F33333
        38888F3FFF8F30F7F7F7F7C447888F0338F3333333888F88838F307F7F7F744C
        4BFBFB0338F3333338888F333F8F30F7F7F7444F4FFF880338F33333888F8333
        8883307F7F74440BFBFB803338F33338888FFFFF883330F7F744470000000333
        38F33388838888888333307F7F747F7F0333333338F3333833338F33333330F7
        F7F7F7F70333333338F3333333338F333333307F7F7F7F7F0333333338F33FFF
        FFF38F33333330F7444444F703333333383F888888FF833333333300ECCCC400
        33333333338838888888333333333333ECCCC433333333333333388888333333
        333333333EEEE333333333333333333333333333333333333333333333333333
        33333333333333333333}
      NumGlyphs = 2
    end
    object ExitBtn: TSpeedButton
      Left = 144
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Exit|'
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00377777777777
        777777773FFFFFFFFFFFF333333F888888888888F7F7F7888888888888883333
        33888888888888877F7F788888888888888F333FF88844444400888FFF444444
        88888888888333888883333334D5007FFF433333333338F888F3338F33333333
        345D50FFFF4333333333388788F3338F3333333334D5D0FFFF433333333338F8
        78F3338F33333333345D50FEFE4333333333388788F3338F3333333334D5D0FF
        FF433333333338F878F3338F33333333345D50FEFE4333333333388788F3338F
        3333333334D5D0FFFF433333333338F878F3338F33333333345D50FEFE433333
        3333388788F3338F3333333334D5D0EFEF433333333338F878F3338F33333333
        345D50FEFE4333333333388788F3338F3333333334D5D0EFEF433333333338F8
        F8FFFF8F33333333344444444443333333333888888888833333333333333333
        3333333333333333FFFFFF333333333333300000033333333333333888888F33
        333333333330AAAA0333333333333338FFFF8F33333333333330000003333333
        33333338888883333333}
      NumGlyphs = 2
      OnClick = FileExitItemClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 235
    Width = 427
    Height = 19
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Panels = <>
    ParentFont = False
    SimplePanel = True
  end
  object MainMenu1: TMainMenu
    Left = 36
    Top = 196
    object File1: TMenuItem
      Caption = '&File'
      Hint = 'File related commands'
      ShortCut = 0
      object FileNewItem: TMenuItem
        Caption = '&New'
        Hint = 'Create a new file'
        ShortCut = 0
        OnClick = FileNewItemClick
      end
      object FileOpenItem: TMenuItem
        Caption = '&Open'
        Hint = 'Open an existing file'
        ShortCut = 0
        OnClick = FileOpenItemClick
      end
      object FileCloseItem: TMenuItem
        Caption = '&Close'
        Hint = 'Close current file'
        ShortCut = 0
        OnClick = FileCloseItemClick
      end
      object FileSaveItem: TMenuItem
        Caption = '&Save'
        Enabled = False
        Hint = 'Save current file'
        ShortCut = 0
        OnClick = FileSaveItemClick
      end
      object FileSaveAsItem: TMenuItem
        Caption = 'Save &As...'
        Enabled = False
        Hint = 'Save current file as...'
        ShortCut = 0
        OnClick = FileSaveAsItemClick
      end
      object N1: TMenuItem
        Caption = '-'
        ShortCut = 0
      end
      object FileExitItem: TMenuItem
        Caption = 'E&xit'
        Hint = 'Exit the application'
        ShortCut = 0
        OnClick = FileExitItemClick
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      ShortCut = 0
      object CutItem: TMenuItem
        Caption = 'Cu&t'
        Enabled = False
        Hint = 'Cut to clipboard'
        ShortCut = 0
        OnClick = CutItemClick
      end
      object CopyItem: TMenuItem
        Caption = '&Copy'
        Enabled = False
        Hint = 'Copy to clipboard'
        ShortCut = 0
        OnClick = CopyItemClick
      end
      object PasteItem: TMenuItem
        Caption = '&Paste'
        Enabled = False
        Hint = 'Paste from clipboard'
        ShortCut = 0
        OnClick = PasteItemClick
      end
    end
    object Window1: TMenuItem
      Caption = '&Window'
      Hint = 'Window related commands such as Tile and Cascade'
      ShortCut = 0
      object WindowCascadeItem: TMenuItem
        Caption = '&Cascade'
        Hint = 'Arrange windows to overlap'
        ShortCut = 0
        OnClick = WindowCascadeItemClick
      end
      object WindowTileItem: TMenuItem
        Caption = '&Tile'
        Hint = 'Arrange windows without overlap'
        ShortCut = 0
        OnClick = WindowTileItemClick
      end
      object WindowArrangeItem: TMenuItem
        Caption = '&Arrange Icons'
        Hint = 'Arrange window icons at bottom of main window'
        ShortCut = 0
        OnClick = WindowArrangeItemClick
      end
      object WindowMinimizeItem: TMenuItem
        Caption = '&Minimize All'
        Hint = 'Minimize all windows'
        ShortCut = 0
        OnClick = WindowMinimizeItemClick
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      Hint = 'Help topics'
      ShortCut = 0
      object HelpAboutItem: TMenuItem
        Caption = '&About'
        ShortCut = 0
      end
    end
  end
  object OpenDialog: TOpenDialog
    FileEditStyle = fsEdit
    Filter = 'All files (*.*)|*.*'
    Left = 4
    Top = 196
  end
end

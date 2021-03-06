object Form2: TForm2
  Left = 78
  Top = 95
  Width = 590
  Height = 433
  Caption = 'Exchequer Printing Test Utility - Preview Window'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PopupMenu = Popup_Preview
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Toolbar: TSBSPanel
    Left = 0
    Top = 0
    Width = 582
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    AllowReSize = False
    IsGroupBox = False
    TextId = 0
    object Panel1: TPanel
      Left = 342
      Top = 0
      Width = 240
      Height = 36
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 6
      object Button_Close: TButton
        Left = 153
        Top = 4
        Width = 80
        Height = 28
        Cancel = True
        Caption = '&Close'
        TabOrder = 0
        OnClick = Button_CloseClick
      end
      object Panel_Pages: TPanel
        Left = 20
        Top = 7
        Width = 124
        Height = 22
        BevelOuter = bvLowered
        Caption = 'Page 99999 of 99999'
        TabOrder = 1
      end
    end
    object BitBtn_Print: TBitBtn
      Left = 168
      Top = 4
      Width = 28
      Height = 28
      Hint = 'Print Report|Print the report to a printer'
      TabOrder = 5
      OnClick = BitBtn_PrintClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555FFFFFFFFFFF5555000000000005555588888888888F55507777777770
        705558FFFFFFFFF8F8F500000000000007058888888888888F8F0777777BBB77
        00058F5555555555888F07777778887707058FFFFFFFFFFF8F8F000000000000
        07708888888888888F5807777777777070708FFFFFFFFFF8F8F8500000000007
        070058888888888F8F88550FFFFFFFF07070558F55FFFFF8F8F85550F00000F0
        00055558F888885888855550FFFFFFFF05555558F55FFFFF8F5555550F00000F
        055555558F8888858F5555550FFFFFFFF05555558FFFFFFFF855555550000000
        0055555558888888885555555555555555555555555555555555}
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object BitBtn_ZoomIn: TBitBtn
      Left = 7
      Top = 4
      Width = 28
      Height = 28
      Hint = 'Zoom In|Zoom in closer to the report'
      TabOrder = 0
      OnClick = BitBtn_ZoomInClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000CE0E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500555555555
        5555588FF5555555555500005555555555558888FF5555555555071005555555
        555585588FF5555555550F71005555555555855588FFFFFFF55550F710000000
        5555585558888888FF55550F7107777005555585558555588FF55550F0777777
        005555585855555588FF555507777977700555558F5558F5588F555507777977
        770555558F5FF8FF558F555507799999770555558F588888558F555507FF7977
        770555558F5558F5558F555507FF7977770555558FF558F5558F555500777777
        7055555588FF555558F555555007777700555555588FF55588F5555555007770
        055555555588FFF88F555555555000005555555555588888F555}
      NumGlyphs = 2
    end
    object BitBtn_ZoomOut: TBitBtn
      Left = 35
      Top = 4
      Width = 28
      Height = 28
      Hint = 'Zoom Out|Zoom out from the report'
      TabOrder = 1
      OnClick = BitBtn_ZoomOutClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000CE0E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500555555555
        5555588FF5555555555500005555555555558888FF5555555555071005555555
        555585588FF5555555550F71005555555555855588FFFFFFF55550F710000000
        5555585558888888FF55550F7107777005555585558555588FF55550F0777777
        005555585855555588FF555507777777700555558F555555588F555507777777
        770555558F5FFFFF558F555507799999770555558F588888558F555507FF7777
        770555558F555555558F555507FF7777770555558FF55555558F555500777777
        7055555588FF555558F555555007777700555555588FF55588F5555555007770
        055555555588FFF88F555555555000005555555555588888F555}
      NumGlyphs = 2
    end
    object BitBtn_ZoomPage: TBitBtn
      Left = 63
      Top = 4
      Width = 28
      Height = 28
      Hint = 'Show Page|Set the zoom so the entire page can be seen'
      TabOrder = 2
      OnClick = BitBtn_ZoomPageClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000CE0E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFFFFF5555550000000000555558888888888F5555550FFFFFFFF05
        55558555555558F5555550F777F77F0555558588858858F5555550FFFFFFFF05
        55558555555558F5555550F77F777F0555558588588858F5555550FFFFFFFF05
        55558555555558F5555550F7F7777F0555558585888858F5555550FFFFFFFF05
        55558555555558F5555550F777F77F0555558588858858F5555550FFFFFFFF05
        55558555555558F5555550F777777F0555558588888858F5555550FFFFFFFF05
        55558555555558F5555550FFFFFFFF0555558555555558F55555500000000005
        5555888888888855555555555555555555555555555555555555}
      NumGlyphs = 2
    end
    object BitBtn_NextPage: TBitBtn
      Left = 129
      Top = 4
      Width = 28
      Height = 28
      Hint = 'Next Page|View the next page of the report'
      Enabled = False
      TabOrder = 3
      OnClick = BitBtn_NextPageClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFFFFF5555500000000005055558888888888F8F5550FFFFFFFF050
        55558555555558F8F5550F777F77F05505558588858858F58F550FFFFFFFF055
        05558555555558F58F550F77F777F05550558588588858F558F50FFFFFFFF055
        50558555555558F558F50F7F7777F05555058585888858F5558F0FFFFFFFF055
        55058555555558F5558F0F777F77F05550558588858858F558F50FFFFFFFF055
        50558555555558F558F50F777777F05505558588888858F58F550FFFFFFFF055
        05558555555558F58F550FFFFFFFF05055558555555558F8F555000000000050
        5555888888888858F55555555555555555555555555555555555}
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object BitBtn_PrevPage: TBitBtn
      Left = 101
      Top = 4
      Width = 28
      Height = 28
      Hint = 'Previous Page|View the previous page of the report'
      Enabled = False
      TabOrder = 4
      OnClick = BitBtn_PrevPageClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555FFFFFFFFFF55505000000000055558F8888888888F555050FFFFFF
        FF055558F8555555558F550550F777F77F05558F58588858858F550550FFFFFF
        FF05558F58555555558F505550F77F777F0558F558588588858F505550FFFFFF
        FF0558F558555555558F055550F7F7777F058F5558585888858F055550FFFFFF
        FF058F5558555555558F505550F777F77F0558F558588858858F505550FFFFFF
        FF0558F558555555558F550550F777777F05558F58588888858F550550FFFFFF
        FF05558F58555555558F555050FFFFFFFF055558F8555555558F555050000000
        00055558F8888888888555555555555555555555555555555555}
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
  end
  object Panel_ScrollBar: TSBSPanel
    Left = 559
    Top = 36
    Width = 23
    Height = 370
    Align = alRight
    BevelOuter = bvNone
    BorderWidth = 2
    TabOrder = 1
    Visible = False
    AllowReSize = False
    IsGroupBox = False
    TextId = 0
    object ScrollBar_Pages: TScrollBar
      Left = 5
      Top = 2
      Width = 16
      Height = 263
      Hint = 'Scroll to change the page number'
      Enabled = False
      Kind = sbVertical
      PageSize = 0
      TabOrder = 0
      OnChange = ScrollBar_PagesChange
      OnScroll = ScrollBar_PagesScroll
    end
  end
  object ScrollBox_Preview: TScrollBox
    Left = 0
    Top = 36
    Width = 559
    Height = 370
    Align = alClient
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
  end
  object FilePrinter1: TFilePrinter
    FileName = 'c:\floppy.rep'
    StreamMode = smFile
    Left = 18
    Top = 46
  end
  object FilePreview1: TFilePreview
    FileName = 'c:\floppy.rep'
    StreamMode = smFile
    ScrollBox = ScrollBox_Preview
    ZoomInc = 25
    ZoomFactor = 115
    ShadowDepth = 0
    Left = 49
    Top = 46
  end
  object Popup_Preview: TPopupMenu
    Left = 30
    Top = 75
    object Popup_Preview_ZoomIn: TMenuItem
      Caption = 'Zoom &In'
      OnClick = BitBtn_ZoomInClick
    end
    object Popup_Preview_ZoomOut: TMenuItem
      Caption = 'Zoom &Out'
      OnClick = BitBtn_ZoomOutClick
    end
    object Popup_Preview_ZoomToPage: TMenuItem
      Caption = 'Zoom To P&age'
      OnClick = BitBtn_ZoomPageClick
    end
    object Popup_Preview_ZoomToNormal: TMenuItem
      Caption = 'Zoom to Nor&mal'
      OnClick = Popup_Preview_ZoomToNormalClick
    end
    object Popup_Preview_SepBar1: TMenuItem
      Caption = '-'
    end
    object Popup_Preview_PrevPage: TMenuItem
      Caption = 'P&revious Page'
      OnClick = BitBtn_PrevPageClick
    end
    object Popup_Preview_NextPage: TMenuItem
      Caption = '&Next Page'
      OnClick = BitBtn_NextPageClick
    end
    object Popup_Preview_SepBar2: TMenuItem
      Caption = '-'
    end
    object Popup_Preview_Print: TMenuItem
      Caption = '&Print'
      OnClick = BitBtn_PrintClick
    end
  end
end

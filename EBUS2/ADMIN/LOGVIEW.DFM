�
 TFRMLOGFILEVIEWER 0�	  TPF0TfrmLogFileViewerfrmLogFileViewerLeftTop� Width,HeightmHelpContext]CaptionLog File ViewerColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 	FormStyle
fsMDIChildOldCreateOrder	PositionpoDefaultPosOnlyScaledVisible	OnClose	FormCloseOnCreate
FormCreate	OnDestroyFormDestroyOnResize
FormResizePixelsPerInch`
TextHeight TPanel
pnlButtonsLeft�TopWidthqHeight3
BevelOuterbvNoneBorderStylebsSingleCtl3D	ParentCtl3DTabOrder  TButtonbtnCloseTagLeftTopWidthPHeightHintClose the Log Viewer window.HelpContextCancel	Caption&CloseModalResultTabOrder OnClickbtnCloseClick  
TScrollBox
sbxButtonsLeft Top WidthiHeightBorderStylebsNoneTabOrder TButton	btnDeleteTagLeftTop� WidthPHeightHintDelete the current log.HelpContextcCaption&DeleteTabOrder OnClickbtnDeleteClick  TButton	btnOldestLeftTopWidthPHeightHintView the oldest log.HelpContext_Caption&OldestTabOrderOnClickbtnFindLogClick  TButtonbtnNextLeftTop"WidthPHeightHint"View the next log on from current.HelpContext`Caption&NextTabOrderOnClickbtnFindLogClick  TButtonbtnPreviousLeftTop=WidthPHeightHintView previous log from current.HelpContextdCaption	&PreviousTabOrderOnClickbtnFindLogClick  TButton	btnLatestLeftTopXWidthPHeightHintView the most recent log.HelpContextaCaption&LatestTabOrderOnClickbtnFindLogClick  TButtonbtnPrintLeftTopsWidthPHeightHintPrint the current log.HelpContextbCaptionP&rintTabOrderOnClickbtnPrintClick    TEditedtFileNameLeftTopWidth�HeightFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontReadOnly	TabOrder  	TRichEditedtLogDisplayLeftTopWidth�Height3Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	
ScrollBarsssBothTabOrderWordWrap  TReportPrinterRepPrintStatusFormatPrinting page %pUnitsFactor       ��?TitleReportPrinter ReportOrientation
poPortraitScaleX       �@ScaleY       �@OnPrintRepPrintPrintLeft Top�   
TPopupMenu	mnuDeleteLeftTop�  	TMenuItemmniCurrentLogCaption&Current LogOnClickmniCurrentLogClick  	TMenuItemmniMultipleLogsCaption&Multiple LogsOnClickmniMultipleLogsClick    
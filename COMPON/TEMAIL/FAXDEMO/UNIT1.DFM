�
 TFORM1 0�  TPF0TForm1Form1Left� TopWidth�Height�CaptionFax Letters
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style Menu	MainMenu1OnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TPanelPanel1Left Top Width�Height)AlignalTop
BevelOuterbvNoneTabOrder  TBevelBevel1Left Top Width�HeightAlignalTop  TBevelBevel2Left� TopWidth	HeightShape
bsLeftLine  TLabelLabel2Left0TopWidthHeightCaptionDelay:  TBevelBevel3Left(TopWidth	HeightShape
bsLeftLine  TLabelLabel3Left�TopWidthHeightCaptionSecs.
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TBevelBevel4Left�TopWidth	HeightShape
bsLeftLine  TBitBtnSendfaxButtonLeftXTop	WidthAHeightCaptionSend FaxTabOrderOnClickSendfaxButtonClick  TBitBtn	Mergedat1LeftTop	WidthIHeightCaption
Merge DataTabOrder OnClickMergedat1Click  TBitBtnMergeSendBt1Left� Top	WidthyHeightCaptionMerge/Send SelectedTabOrderOnClickMergeSendBt1Click  	TSpinEdit	SpinEdit1LeftPTopWidth9Height	Increment
MaxValuexMinValue TabOrderValue<OnChangeSpinEdit1Change   
TScrollBox
ScrollBox1Left Top)Width�Height|AlignalClientTabOrder TPageControlPageControl1Left Top Width�Heightx
ActivePage	TabSheet2AlignalClientTabOrder  	TTabSheet	TabSheet2CaptionOverdue - Data TDBNavigatorDBNavigator1Left TopCWidthzHeight
DataSourceDataSource1AlignalBottomParentShowHintShowHint	TabOrder   TDBGridDBGrid1Left Top WidthzHeightCAlignalClient
DataSourceDataSource1TabOrderTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style    	TTabSheet	TabSheet1Caption
letter.rp1 TMemoRP1Left Top WidthzHeight\AlignalClient
Font.ColorclBlackFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder      
TStatusBar
StatusBar1Left Top�Width�HeightPanels	AlignmenttaCenterBevelpbNoneTextStatus:Width2 WidthX  SimplePanel  TEmailEmail1Attachment.Stringsc:\faxdemo\letter.rp1 ProfileLettersSubjectOverdue AccountLefthTop  	TMainMenu	MainMenu1LeftHTop 	TMenuItemFile1Caption&FileShortCut  	TMenuItemExit1CaptionE&xitShortCut OnClick
Exit1Click   	TMenuItemHelp1Caption&HelpShortCut  	TMenuItemAbout1Caption	&About...ShortCut OnClickAbout1Click    TTimerTimer1EnabledInterval`�  OnTimerTimer1TimerLeft�Top  TTableTable1Active		TableNameletters.DBFLeft(Top TStringFieldTable1FAXNUMBER	FieldName	FAXNUMBERSize  TStringField
Table1NAME	FieldNameNAMESize#  TStringField
Table1ADD1	FieldNameADD1Size#  TStringField
Table1ADD2	FieldNameADD2Size#  TStringField
Table1ADD3	FieldNameADD3Size#  TStringField
Table1ADD4	FieldNameADD4Size#  TStringField
Table1ADD5	FieldNameADD5Size#  TStringField
Table1ADD6	FieldNameADD6Size#  TStringField
Table1ADD7	FieldNameADD7Size#  TStringField
Table1ADD8	FieldNameADD8Size#   TDataSourceDataSource1DataSetTable1LeftTop   
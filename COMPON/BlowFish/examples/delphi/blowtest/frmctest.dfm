�
 TFRMCIPHERTEST 0�  TPF0TfrmCipherTestfrmCipherTestLeftTopDBorderIconsbiSystemMenu BorderStylebsDialogCaptionBlowfish TestClientHeight�ClientWidthColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnCreate
FormCreatePixelsPerInch`
TextHeight 	TGroupBoxgrpTextLeftTopWidthHeightUCaptionText EncryptionTabOrder  TBevelBevel1LeftTop,Width� Height  TLabellblTestTextLeftTopWidthJHeightCaptionText to encrypt:  TLabel
lblVersionLeftTop4Width#HeightCaptionVersion  TButton
btnDecryptLeft� Top0WidthKHeightCaptionDecryptTabOrder OnClickbtnDecryptClick  TButton
btnEncryptLeftXTop0WidthKHeightCaptionEncryptTabOrderOnClickbtnEncryptClick  TEditedtTestTextLeftXTopWidth�HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrderText.this is test text which is longer than 1 block  TEdit
edtVersionLeftDTop0Width� HeightReadOnly	TabOrder   	TGroupBoxgrpFileLeftTop`WidthHeightACaptionFile EncryptionTabOrder TButtonbtnFileEncryptLeftXTopWidthKHeightCaptionEncrypt FileTabOrder OnClickbtnFileEncryptClick  TButtonbtnFileDecryptLeft� TopWidthKHeightCaptionDecrypt FileTabOrderOnClickbtnFileDecryptClick   	TGroupBox	grpStreamLeftTop� WidthHeightYCaption0String Encryption (encryption using stream mode)TabOrder TLabellblStreamTestLeftTopWidthJHeightCaptionText to encrypt:  TEditedtStreamTestLeftXTopWidth�HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder Text.this is test text which is longer than 1 block  TButtonbtnStreamEncryptLeftXTop0WidthKHeightCaptionEncryptTabOrderOnClickbtnStreamEncryptClick  TButtonbtnStreamDecryptLeft� Top0WidthKHeightCaptionDecryptTabOrderOnClickbtnStreamDecryptClick   	TGroupBoxgrpCipherModeLeftTop�WidthHeight5CaptionCipher ModeTabOrder TRadioButtonrdbECBLeftTopWidthaHeightCaptionECB ModeChecked	TabOrder TabStop	OnClickrdbECBClick  TRadioButtonrdbCBCLeft� TopWidthaHeightCaptionCBC ModeTabOrderOnClickrdbCBCClick  TRadioButtonrdbCFBLeftTopWidthYHeightCaptionCFB ModeTabOrderOnClickrdbCFBClick  TRadioButtonrdbOFBLeft|TopWidthYHeightCaptionOFB ModeTabOrderOnClickrdbOFBClick   	TGroupBox	grpCBCMACLeftTop WidthHeight9CaptionCBC-MAC (CBC mode only)TabOrder TLabel	lblCBCMACLeft� TopWidth2HeightCaptionCBC-MAC:  TButton
btmMakeMACLeftXTopWidthKHeightCaptionMake MACTabOrder OnClickbtmMakeMACClick  TEdit	edtCBCMACLeftTopWidth� HeightTabOrder   	TGroupBoxgrpBlockLeftTop<WidthHeighteCaption%Block Mode encryption (ECB mode only)TabOrder TLabellblBlockKeyLeftTopWidth2HeightCaption
Key Bytes:  TLabellblPlainTextLeftTop0Width6HeightCaptionPlain bytes:  TLabellblCipherTextLeftTopHWidth=HeightCaptionCipher bytes:  TEditedtKeyBytes1LeftXTopWidthEHeightFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder Text00000000  TEditedtKeyBytes2Left� TopWidthEHeightFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrderText00000000  TEditedtKeyBytes3Left� TopWidthEHeightEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrderText00000000  TEditedtKeyBytes4Left0TopWidthEHeightEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrderText00000000  TRadioButtonrdb64Left�TopWidth5HeightCaption64 bitChecked	TabOrderTabStop	OnClick
rdb64Click  TRadioButtonrdb128Left�TopWidth5HeightCaption128 bitTabOrderOnClickrdb128Click  TEditedtPlainBytes1LeftXTop,WidthEHeightFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrderText00000000  TEditedtPlainBytes2Left� Top,WidthEHeightFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrderText00000000  TEditedtCipherBytes1LeftXTopDWidthEHeightFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrderText00000000  TEditedtCipherBytes2Left� TopDWidthEHeightFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder	Text00000000  TButtonbtnBlockEncLeft� Top8WidthKHeightCaptionEncryptTabOrder
OnClickbtnBlockEncClick  TButtonbtnBlockDecLeftLTop8WidthKHeightCaptionDecryptTabOrderOnClickbtnBlockDecClick   	TGroupBoxgrpTimeTrialLeftTop`Width� HeightACaption"Perform Time Trial (Takes a while)TabOrder TLabellblSpeedDispLeftpTopWidth"HeightCaptionSpeed:  TLabellblSpeedLeft� TopWidthHeight	AlignmenttaRightJustifyCaptionN/AFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabellblKBsLeft� TopWidthHeightCaptionKB/s  TButtonbtnTestSpeedLeftTopWidthKHeightCaption
Test SpeedTabOrder OnClickbtnTestSpeedClick   TOpenDialog
odlFileEncFilterAll Files|*.*TitleSelect file to encryptLeftTop�   TSaveDialog
sdlFileEnc
DefaultExtcryFilterAll Files|*.*TitleSelect file to save toLeft8Top�   TOpenDialog
odlFileDecFilterAll files|*.*TitleSelect file to decryptLeftXTop�   TSaveDialog
sdlFileDecFilterAll files|*.*Title$Select file to dave decypted data toLefttTop�   	TBlowfish	Blowfish1
CipherModeECB
StringModesmEncodeLeftTop:   
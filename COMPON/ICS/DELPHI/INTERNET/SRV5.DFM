�
 TSERVERFORM 0l  TPF0TServerForm
ServerFormLeft� Top�Width�Height� Caption
ServerForm
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PixelsPerInch`OnShowFormShow
TextHeight TLabel	InfoLabelLeftHTopWidth,HeightCaption	InfoLabel  TButtonDisconnectButtonLeftHTop(WidthKHeightCaption&DisconnectDefault	EnabledTabOrder OnClickDisconnectButtonClick  TWSocket	SrvSocketLineMode	LineLimit   LineEnd
LineEchoLineEditPorttelnetPrototcp	LocalAddr0.0.0.0	LocalPort0MultiThreadedComponentOptions OnSessionAvailableSrvSocketSessionAvailableFlushTimeout<	SendFlagswsSendNormalLingerOnOff
wsLingerOnLingerTimeout 
SocksLevel5SocksAuthenticationsocksNoAuthenticationLeftTop  TWSocket	CliSocketLineMode	LineLimit   LineEnd
LineEchoLineEditPorttelnetPrototcp	LocalAddr0.0.0.0	LocalPort0MultiThreadedComponentOptions OnSessionClosedCliSocketSessionClosedFlushTimeout<	SendFlagswsSendNormalLingerOnOff
wsLingerOnLingerTimeout 
SocksLevel5SocksAuthenticationsocksNoAuthenticationLeftTop8   
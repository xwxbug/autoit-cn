#include <WinAPIShPath.au3>

Local $Url[3] = ['http://www.microsoft.com', 'htps:\\www.microsoft.com', 'http:www.microsoft.com']

For $i = 0 To 2
	ConsoleWrite(StringFormat('%-27s' & _WinAPI_UrlFixup($Url[$i]), $Url[$i]) & @CRLF)
Next

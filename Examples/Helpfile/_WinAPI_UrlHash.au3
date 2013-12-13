#include <WinAPIShPath.au3>

Local $Url = 'http://www.microsoft.com'

ConsoleWrite(_WinAPI_UrlHash($Url) & @CRLF)

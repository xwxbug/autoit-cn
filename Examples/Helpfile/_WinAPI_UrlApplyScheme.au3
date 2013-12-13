#include <WinAPIShPath.au3>

Local $Url = 'www.microsoft.com'

ConsoleWrite(_WinAPI_UrlApplyScheme($Url) & @CRLF)

ConsoleWrite(_WinAPI_UrlApplyScheme('') & @CRLF)

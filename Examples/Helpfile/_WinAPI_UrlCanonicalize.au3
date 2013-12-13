#include <WinAPIShPath.au3>
#include <APIShPathConstants.au3>

Local $Url = 'http://msdn.microsoft.com/en-us/library/ee663300%28VS.85%29.aspx'

ConsoleWrite(_WinAPI_UrlCanonicalize($Url, $URL_UNESCAPE) & @CRLF)

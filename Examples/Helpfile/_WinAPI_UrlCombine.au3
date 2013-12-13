#include <WinAPIShPath.au3>

Local $Url1 = 'http://xyz/abc/'
Local $Url2 = 'http://xyz/abc'

ConsoleWrite(_WinAPI_UrlCombine($Url1, 'bar') & @CRLF)
ConsoleWrite(_WinAPI_UrlCombine($Url2, 'bar') & @CRLF)

#include <WinAPIShPath.au3>

Local $Url1 = 'http://xyz/abc/'
Local $Url2 = 'http://xyz/abc'

ConsoleWrite('URLs comparison result: ' & _WinAPI_UrlCompare($Url1, $Url2) & @CRLF)

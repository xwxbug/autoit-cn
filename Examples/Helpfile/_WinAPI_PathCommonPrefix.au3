#include <WinAPIShPath.au3>

Local $Path1 = 'C:\Documents\Test.txt'
Local $Path2 = 'C:\Documents\Archive\Sample.txt'

ConsoleWrite('Path1 : ' & $Path1 & @CRLF)
ConsoleWrite('Path2 : ' & $Path2 & @CRLF)
ConsoleWrite('Prefix: ' & _WinAPI_PathCommonPrefix($Path1, $Path2) & @CRLF)

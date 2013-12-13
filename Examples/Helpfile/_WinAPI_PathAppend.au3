#include <WinAPIShPath.au3>

Local $Path1 = 'C:\Documents\Text'
Local $Path2 = '..\Test.txt'

ConsoleWrite('Path1 : ' & $Path1 & @CRLF)
ConsoleWrite('Path2 : ' & $Path2 & @CRLF)
ConsoleWrite('Result: ' & _WinAPI_PathAppend($Path1, $Path2) & @CRLF)

#include <WinAPIShPath.au3>

Local $Path = 'C:\Documents\Test.txt'

ConsoleWrite('Before: ' & $Path & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathStripToRoot($Path) & @CRLF)

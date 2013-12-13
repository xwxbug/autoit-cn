#include <WinAPIShPath.au3>

Local $Path = 'C:\Documents\'

ConsoleWrite('Before: ' & $Path & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathRemoveBackslash($Path) & @CRLF)

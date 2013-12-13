#include <WinAPIShPath.au3>

Local $Path[2] = ['C:\Documents\', 'C:\Documents']

For $i = 0 To 1
	ConsoleWrite($Path[$i] & ' => ' & _WinAPI_PathAddBackslash($Path[$i]) & @CRLF)
Next

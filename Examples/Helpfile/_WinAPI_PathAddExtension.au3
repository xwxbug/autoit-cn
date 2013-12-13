#include <WinAPIShPath.au3>

Local $Path[2] = ['C:\Documents\Test.txt', 'C:\Documents\Test']

For $i = 0 To 1
	ConsoleWrite($Path[$i] & ' => ' & _WinAPI_PathAddExtension($Path[$i], '.doc') & @CRLF)
Next

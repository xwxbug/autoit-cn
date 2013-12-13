#include <WinAPIProc.au3>

Local $ID = ProcessExists('SciTE.exe')

If $ID Then
	ConsoleWrite(_WinAPI_GetProcessFileName($ID) & @CRLF)
EndIf

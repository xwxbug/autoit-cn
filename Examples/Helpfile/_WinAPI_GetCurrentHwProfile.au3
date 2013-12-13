#include <WinAPISys.au3>

Local $Data = _WinAPI_GetCurrentHwProfile()
If IsArray($Data) Then
	ConsoleWrite('State: ' & $Data[0] & @CRLF)
	ConsoleWrite('GUID:  ' & $Data[1] & @CRLF)
	ConsoleWrite('Name:  ' & $Data[2] & @CRLF)
EndIf

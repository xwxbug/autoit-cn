#include <WinAPIFiles.au3>

Local $Drive = DriveGetDrive('ALL')

If IsArray($Drive) Then
	For $i = 1 To $Drive[0]
		ConsoleWrite(StringUpper($Drive[$i]) & ' => ' & _WinAPI_QueryDosDevice($Drive[$i]) & @CRLF)
	Next
EndIf

#include <WinAPIFiles.au3>

Local $Drive = DriveGetDrive('ALL')

If IsArray($Drive) Then
	Local $Text
	For $i = 1 To $Drive[0]
		If _WinAPI_IsWritable($Drive[$i]) Then
			$Text = 'Writable'
		Else
			$Text = 'Not writable'
		EndIf
		If Not @error Then
			ConsoleWrite(StringUpper($Drive[$i]) & ' => ' & $Text & @CRLF)
		EndIf
	Next
EndIf

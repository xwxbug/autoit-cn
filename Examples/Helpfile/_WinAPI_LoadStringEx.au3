#include <WinAPIRes.au3>
#include <APIResConstants.au3>
#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>
#include <MsgBoxConstants.au3>

Local $hInstance = _WinAPI_LoadLibraryEx(@ScriptDir & '\Extras\Resources.dll', $LOAD_LIBRARY_AS_DATAFILE)
If Not $hInstance Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', @ScriptDir & '\Extras\Resources.dll not found.')
	Exit
EndIf

; Why is the resource name for the string with ID = 6000 is 376? 6000 / 16 + 1 = 376
Local $Data = _WinAPI_EnumResourceLanguages($hInstance, $RT_STRING, 376)
If IsArray($Data) Then
	For $i = 1 To $Data[0]
		ConsoleWrite(StringFormat('%-10s - %s', _WinAPI_GetLocaleInfo($Data[$i], $LOCALE_SENGLANGUAGE), _WinAPI_LoadStringEx($hInstance, 6000, $Data[$i])) & @CRLF)
	Next
EndIf

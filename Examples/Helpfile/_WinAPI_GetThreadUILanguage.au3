#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>
#include <WinAPI.au3>
#include <WinAPISys.au3>
#include <WinAPIRes.au3>
#include <APIResConstants.au3>
#include <MsgBoxConstants.au3>

Local $hInstance = _WinAPI_LoadLibraryEx(@ScriptDir & '\Extras\Resources.dll', $LOAD_LIBRARY_AS_DATAFILE)
If Not $hInstance Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', @ScriptDir & '\Extras\Resources.dll not found.')
	Exit
EndIf

; Get the language (locale) identifier for the current process
Local $Prev
If _WinAPI_GetVersion() >= '6.0' Then
	$Prev = _WinAPI_GetThreadUILanguage()
Else
	$Prev = _WinAPI_GetThreadLocale()
EndIf

; Why is the resource name for the string with ID = 6000 is 376? 6000 / 16 + 1 = 376
Local $Data = _WinAPI_EnumResourceLanguages($hInstance, $RT_STRING, 376)
If Not @error Then
	For $i = 1 To $Data[0]
		If _WinAPI_GetVersion() >= '6.0' Then
			_WinAPI_SetThreadUILanguage($Data[$i])
		Else
			_WinAPI_SetThreadLocale($Data[$i])
		EndIf
		ConsoleWrite(StringFormat('%-10s - %s', _WinAPI_GetLocaleInfo($Data[$i], $LOCALE_SENGLANGUAGE), _WinAPI_LoadString($hInstance, 6000)) & @CRLF)
	Next
EndIf

; Restore the previous language for the current process
If _WinAPI_GetVersion() >= '6.0' Then
	_WinAPI_SetThreadUILanguage($Prev)
Else
	_WinAPI_SetThreadLocale($Prev)
EndIf

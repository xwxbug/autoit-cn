#include <WinAPIRes.au3>
#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>
#include <Array.au3>

Local $Data = _WinAPI_VerQueryValueEx(@ScriptDir & '\Extras\Resources.dll', 'FileDescription|FileVersion|OriginalFilename', -1)

If Not @error Then
	For $i = 1 To $Data[0][0]
		$Data[$i][0] = _WinAPI_GetLocaleInfo($Data[$i][0], $LOCALE_SLANGUAGE)
	Next
EndIf

_ArrayDisplay($Data, '_WinAPI_VerQueryValueEx')

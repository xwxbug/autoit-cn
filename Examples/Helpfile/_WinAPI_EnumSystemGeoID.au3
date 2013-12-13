#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>
#include <Array.au3>

Local $Data = _WinAPI_EnumSystemGeoID()

If IsArray($Data) Then
	For $i = 1 To $Data[0]
		$Data[$i] = _WinAPI_GetGeoInfo($Data[$i], $GEO_FRIENDLYNAME)
	Next
EndIf

_ArrayDisplay($Data, '_WinAPI_EnumSystemGeoID')

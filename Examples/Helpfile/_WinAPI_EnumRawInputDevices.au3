#include <WinAPISys.au3>
#include <APISysConstants.au3>
#include <Array.au3>

Local $tText, $pText, $Data = _WinAPI_EnumRawInputDevices()

If IsArray($Data) Then
	ReDim $Data[$Data[0][0] + 1][3]
	$tText = DllStructCreate('wchar[256]')
	$pText = DllStructGetPtr($tText)
	For $i = 1 To $Data[0][0]
		If _WinAPI_GetRawInputDeviceInfo($Data[$i][0], $pText, 256, $RIDI_DEVICENAME) Then
			$Data[$i][2] = DllStructGetData($tText, 1)
		Else
			$Data[$i][2] = ''
		EndIf
	Next

EndIf

_ArrayDisplay($Data, '_WinAPI_EnumRawInputDevices')

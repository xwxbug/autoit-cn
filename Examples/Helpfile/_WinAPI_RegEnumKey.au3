#include <WinAPIReg.au3>
#include <APIRegConstants.au3>
#include <WinAPIDiag.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $hKey = _WinAPI_RegOpenKey($HKEY_CLASSES_ROOT, 'CLSID', $KEY_READ)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
	Exit
EndIf
Local $Count = _WinAPI_RegQueryInfoKey($hKey)
Local $aKey[$Count[0]]
For $i = 0 To UBound($aKey) - 1
	$aKey[$i] = _WinAPI_RegEnumKey($hKey, $i)
Next

_WinAPI_RegCloseKey($hKey)

_ArrayDisplay($aKey, '_WinAPI_RegEnumKey')

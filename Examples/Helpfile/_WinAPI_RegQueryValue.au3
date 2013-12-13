#include <WinAPIReg.au3>
#include <APIRegConstants.au3>
#include <WinAPIDiag.au3>
#include <MsgBoxConstants.au3>

Local $hKey = _WinAPI_RegOpenKey($HKEY_LOCAL_MACHINE, 'SOFTWARE\AutoIt v3\AutoIt', $KEY_QUERY_VALUE)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
	Exit
EndIf

Local $tData = DllStructCreate('wchar[260]')
_WinAPI_RegQueryValue($hKey, 'InstallDir', $tData)
_WinAPI_RegCloseKey($hKey)

ConsoleWrite(DllStructGetData($tData, 1) & @CRLF)

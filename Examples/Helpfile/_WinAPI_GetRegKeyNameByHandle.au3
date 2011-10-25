#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hKey

$hKey = _WinAPI_RegOpenKey($HKEY_CURRENT_USER, 'Software\AutoIt v3 ', $KEY_QUERY_VALUE)
If @error Then
	msgbox(16, @extended ', _WinAPI_GetErrorMessage ( @extended ))
	Exit
EndIf

msgbox(64, 'Key ', _WinAPI_GetRegKeyNameByHandle($hKey))

_WinAPI_RegCloseKey($hKey)


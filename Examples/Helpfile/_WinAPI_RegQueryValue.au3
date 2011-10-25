#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hKey, $tData

$hKey = _WinAPI_RegOpenKey($HKEY_CURRENT_USER, 'Software\AutoIt v3\AutoIt v3')
$tData = DllStructCreate('wchar[260]')
_WinAPI_RegQueryValue($hKey, 'InstallDir ', $tData)
_WinAPI_RegCloseKey($hKey)
msgbox(0, 'InstallDir ', DllStructGetData($tData, 1))


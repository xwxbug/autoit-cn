#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hKey, $Count

$hKey = _WinAPI_RegOpenKey($HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run')
$Count = _WinAPI_RegQueryInfoKey($hKey)
Dim $aKey[$Count[2]]
For $i = 0 To UBound($aKey) - 1
	$aKey[$i] = _WinAPI_RegEnumValue($hKey, $i)
Next
_WinAPI_RegCloseKey($hKey)

_arraydisplay($aKey, '_WinAPI_RegEnumValue')


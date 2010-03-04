#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $hKey, $tFILETIME, $tSYSTEMTIME

$hKey = _WinAPI_RegOpenKey($HKEY_LOCAL_MACHINE, 'SOFTWARE\AutoIt v3\AutoIt')
$tFILETIME = _WinAPI_RegQueryLastWriteTime($hKey)
$tSYSTEMTIME = _WinAPI_FileTimeToSystemTime(_WinAPI_FileTimeToLocalFileTime($tFILETIME))
_WinAPI_RegCloseKey($hKey)

ConsoleWrite('Last modified at: ' & _WinAPI_GetDateFormat(0, $tSYSTEMTIME) & ' ' & _WinAPI_GetTimeFormat(0, $tSYSTEMTIME) & @CR)

#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hKey, $tSYSTEMTIME

$hKey = _WinAPI_RegOpenKey($HKEY_LOCAL_MACHINE, 'SOFTWARE\AutoIt v3\AutoIt')
$tSYSTEMTIME = _WinAPI_RegQueryLastWriteTime($hKey)
_WinAPI_RegCloseKey($hKey)

msgbox('', '', 'Last modified at:' & DllStructGetData($tSYSTEMTIME, 'Day') & '/' & DllStructGetData($tSYSTEMTIME, 'Month') & '/' & DllStructGetData($tSYSTEMTIME, 'Year') & '' & DllStructGetData($tSYSTEMTIME, 'Hour') & ' :' & DllStructGetData($tSYSTEMTIME, 'Minute') & ' :' & DllStructGetData($tSYSTEMTIME, 'Second') & @CR)


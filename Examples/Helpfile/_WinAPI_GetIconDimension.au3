#Include  <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hIcon, $tSIZE

$hIcon = _WinAPI_ShellExtractIcon(@SystemDir & ' \shell32.dll ', 130, 48, 48)
$tSIZE = _WinAPI_GetIconDimension($hIcon)
_WinAPI_FreeIcon($hIcon)

msgbox('', 'icon size ', DllStructGetData($tSIZE, 'X') & ' x' & DllStructGetData($tSIZE, 'Y'))


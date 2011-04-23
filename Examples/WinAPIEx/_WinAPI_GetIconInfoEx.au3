#Include <Constants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $tIIEX, $hInstance, $hIcon

$hInstance = _WinAPI_LoadLibrary(@AutoItExe)
$hIcon = _WinAPI_LoadImage($hInstance, 99, $IMAGE_ICON, 0, 0, $LR_DEFAULTSIZE)
$tIIEX = _WinAPI_GetIconInfoEx($hIcon)

ConsoleWrite('Handle: ' & $hIcon & @CR)
ConsoleWrite('Path:   ' & DllStructGetData($tIIEX, 'ModName') & @CR)
ConsoleWrite('ID:     ' & DllStructGetData($tIIEX, 'ResID') & @CR)
ConsoleWrite('Name:   ' & DllStructGetData($tIIEX, 'ResName') & @CR)

_WinAPI_FreeLibrary($hInstance)
_WinAPI_DestroyIcon($hIcon)

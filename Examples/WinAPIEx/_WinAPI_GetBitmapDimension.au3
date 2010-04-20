#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $hBitmap, $tSIZE

$hBitmap = _WinAPI_LoadBitmap(_WinAPI_GetModuleHandle(@SystemDir & '\shell32.dll'), 131)
$tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
_WinAPI_FreeObject($hBitmap)

ConsoleWrite(DllStructGetData($tSIZE, 'X') & ' x ' & DllStructGetData($tSIZE, 'Y') & @CR)

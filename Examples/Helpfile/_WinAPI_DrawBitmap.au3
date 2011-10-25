#Include  <WinAPIEx.au3>

Global $hForm, $hDC, $tSIZE, $hBitmap

$hBitmap = _WinAPI_LoadBitmap( _WinAPI_GetModuleHandle(@SystemDir & ' \shell32.dll'), 131)
$tSIZE = _WinAPI_GetBitmapDimension($hBitmap)

$hForm = GUICreate('MyGUI ', DllStructGetData($tSIZE, 'X'), DllStructGetData($tSIZE, 'Y'))
$hDC = _WinAPI_GetDC($hForm)
GUISetState()

_WinAPI_DrawBitmap($hDC, 0, 0, $hBitmap)
_WinAPI_ReleaseDC($hForm, $hDC)
_WinAPI_FreeObject($hBitmap)

Do
Until GUIGetMsg() = -3


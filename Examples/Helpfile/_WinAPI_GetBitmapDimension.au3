#Include <Constants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $var = FileOpenDialog('pls choose a .bmp file ', @WindowsDir & ' \ ', 'bmp file (*.bmp) ', 1 + 4)
Global $hForm, $Label, $hInstance, $hCursor = _WinAPI_LoadCursorFromFile($var)

Global $tSIZE, $hBitmap

$hBitmap = _WinAPI_LoadImage(0, $var, $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
$tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
_WinAPI_DeleteObject($hBitmap)

msgbox('', 'BitmapDimension ', DllStructGetData($tSIZE, 'X') & ' x' & DllStructGetData($tSIZE, 'Y'))


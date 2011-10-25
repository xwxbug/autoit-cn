#Include <Constants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $IIEX, $hInstance, $hIcon

$hInstance = _WinAPI_LoadLibrary(@AutoItExe)
$hIcon = _WinAPI_LoadImage($hInstance, 99, $IMAGE_ICON, 0, 0, $LR_DEFAULTSIZE)
$IIEX = _WinAPI_GetIconInfoEx($hIcon)

msgbox(0, 'info ', 'Handle:' & $hIcon & @CR & ' Path:' & $IIEX[0] & @CR & _
		' ID:' & $IIEX[1] & @CR & ' Name:' & $IIEX[2])

_WinAPI_FreeLibrary($hInstance)
_WinAPI_DestroyIcon($hIcon)


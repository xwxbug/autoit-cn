#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global Const $WM_HOTKEY = 0x0312

Global $hWnd

$hWnd = GUICreate('')
GUIRegisterMsg($WM_HOTKEY, 'WM_HOTKEY')

; ÉèÖÃALT-D
_WinAPI_RegisterHotKey($hWnd, 0x0144, $MOD_ALT, 0x44)

While 1
	Sleep(100)
WEnd

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	MsgBox(0, '', 'You pressed ALT-D')
endfunc   ;==>WM_HOTKEY

Func OnAutoItExit()
	_WinAPI_UnregisterHotKey($hWnd, 0x0144)
endfunc   ;==>OnAutoItExit


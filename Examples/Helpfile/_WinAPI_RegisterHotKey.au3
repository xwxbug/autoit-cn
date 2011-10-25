#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)
Opt('TrayAutoPause ', 0)

Global Const $WM_HOTKEY = 0x0312

Global $hWnd

OnAutoItExitRegister('OnAutoItExit')

$hWnd = GUICreate('')
GUIRegisterMsg($WM_HOTKEY, 'WM_HOTKEY')

; ÉèÖÃALT-D
_WinAPI_RegisterHotKey($hWnd, 0x0144, $MOD_ALT, 0x44)
; ÉèÖÃESC
_WinAPI_RegisterHotKey($hWnd, 0x011B, 0, 0x1B)

While 1
	Sleep(100)
WEnd

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	Switch _WinAPI_HiWord($lParam)
		Case 0x44
			MsgBox(0, '', 'You pressed ALT-D')
		Case 0x1B
			Exit
	EndSwitch
endfunc   ;==>WM_HOTKEY

Func OnAutoItExit()
	_WinAPI_UnregisterHotKey($hWnd, 0x0144)
endfunc   ;==>OnAutoItExit


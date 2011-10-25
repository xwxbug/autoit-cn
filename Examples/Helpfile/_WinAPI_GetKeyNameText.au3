#Include <GUIConstantsEx.au3>
#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

GUICreate('MyGUI')
GUIRegisterMsg($WM_KEYDOWN, 'WM_KEYDOWN')
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_KEYDOWN($hWnd, $iMsg, $wParam, $lParam)
	MsgBox('', 'KeyDown ', _WinAPI_GetKeyNameText($lParam))
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_KEYDOWN


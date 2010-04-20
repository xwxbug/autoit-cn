#Include <GUIConstantsEx.au3>
#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $hForm, $Label, $hCursor

;$hCursor = _WinAPI_LoadCursor(0, 32649) ; IDC_HAND
$hCursor = _WinAPI_LoadCursor(_WinAPI_GetModuleHandle(@SystemDir & '\user32.dll'), 116)

$hForm = GUICreate('MyGUI', 400, 400)
$Label = GUICtrlCreateLabel('', 100, 100, 200, 200)
GUICtrlSetBkColor(-1, 0xFFBFBF)
GUICtrlSetState(-1, $GUI_DISABLE)
GUIRegisterMsg($WM_SETCURSOR, 'WM_SETCURSOR')
GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_SETCURSOR($hWnd, $iMsg, $wParam, $lParam)
	Switch $hWnd
		Case $hForm

			Local $Cursor = GUIGetCursorInfo($hForm)

			If (Not @error) And ($Cursor[4] = $Label) Then
				_WinAPI_SetCursor($hCursor)
				Return 0
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SETCURSOR

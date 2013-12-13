#include <WinAPIRes.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global $hCursor = _WinAPI_LoadCursorFromFile(@ScriptDir & '\Extras\Lens.cur')

OnAutoItExitRegister('OnAutoItExit')

Global $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Global $Label = GUICtrlCreateLabel('', 100, 100, 200, 200)
GUICtrlSetBkColor(-1, 0xD3D8EF)
GUICtrlSetState(-1, $GUI_DISABLE)
GUIRegisterMsg($WM_SETCURSOR, 'WM_SETCURSOR')
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_SETCURSOR($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam, $lParam

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

Func OnAutoItExit()
	_WinAPI_DestroyCursor($hCursor)
EndFunc   ;==>OnAutoItExit

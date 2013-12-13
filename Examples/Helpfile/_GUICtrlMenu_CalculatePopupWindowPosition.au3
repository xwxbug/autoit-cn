#include <GuiMenu.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $Button = GUICtrlCreateButton('New Window', 145, 366, 110, 23)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			_PopupDlg($hForm)
	EndSwitch
WEnd

Func _PopupDlg($hParent)
	GUISetState(@SW_DISABLE, $hParent)

	Local $tPOINT = DllStructCreate($tagPOINT)
	For $i = 1 To 2
		DllStructSetData($tPOINT, $i, 0)
	Next
	_WinAPI_ClientToScreen($hParent, $tPOINT)
	Local $hDlg = GUICreate('New Window', 400, 400)
	Local $Button = GUICtrlCreateButton('Close', 165, 366, 70, 23)
	Local $tRECT = _GUICtrlMenu_CalculatePopupWindowPosition(DllStructGetData($tPOINT, 1), DllStructGetData($tPOINT, 2), _WinAPI_GetWindowWidth($hDlg), _WinAPI_GetWindowHeight($hDlg))
	If @error Then
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later.')
		Exit
	EndIf
	WinMove($hDlg, '', DllStructGetData($tRECT, 1), DllStructGetData($tRECT, 2))
	GUISetState(@SW_SHOW, $hDlg)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $Button
				ExitLoop
		EndSwitch
	WEnd

	GUISetState(@SW_ENABLE, $hParent)
	GUIDelete($hDlg)
EndFunc   ;==>_PopupDlg

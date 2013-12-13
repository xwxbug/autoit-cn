#include <WinAPIDlg.au3>
#include <GUIConstantsEx.au3>

Local $Last[2] = [@SystemDir & '\shell32.dll', 3]

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 160, 160)
Local $Button = GUICtrlCreateButton('Change Icon...', 25, 130, 110, 23)
Local $Icon = GUICtrlCreateIcon($Last[0], -(1 + $Last[1]), 64, 54, 32, 32)
GUISetState()

Local $Data
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			$Data = _WinAPI_PickIconDlg($Last[0], $Last[1], $hForm)
			If IsArray($Data) Then
				GUICtrlSetImage($Icon, $Data[0], -(1 + $Data[1]))
				$Last = $Data
			EndIf
	EndSwitch
WEnd

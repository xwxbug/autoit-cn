#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("Custom MsgBox", 225, 80)

	GUICtrlCreateLabel("Please select a button.", 10, 10)
	Local $iYesID = GUICtrlCreateButton("Yes", 10, 50, 65, 25)
	Local $iNoID = GUICtrlCreateButton("No", 80, 50, 65, 25)
	Local $iExitID = GUICtrlCreateButton("Exit", 150, 50, 65, 25)

	; Set GUIAccelerators for the button controlIDs, these being Ctrl + y and Ctrl + n
	Local $aAccelKeys[2][2] = [["^y", $iYesID],["^n", $iNoID]]
	GUISetAccelerators($aAccelKeys)

	GUISetState() ; Display the GUI.

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				MsgBox(4096, "You selected", "Close")
				ExitLoop

			Case $iYesID
				MsgBox(4096, "You selected", "Yes") ; Displays if the button was selected or the hotkey combination Ctrl + y was pressed.

			Case $iNoID
				MsgBox(4096, "You selected", "No") ; Displays if the button was selected or the hotkey combination Ctrl + n was pressed.

			Case $iExitID
				MsgBox(4096, "You selected", "Exit")
				ExitLoop

		EndSwitch
	WEnd
	GUIDelete() ; Delete the GUI.
EndFunc   ;==>Example
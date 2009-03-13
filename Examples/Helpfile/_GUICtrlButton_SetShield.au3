#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <WindowsConstants.au3>
#include <GuiMenu.au3>

Opt("MustDeclareVars", 1)

Global $btn, $btn2

; Note the controlId from these buttons can NOT be read with GuiCtrlRead

_Main()

Func _Main()
	Local $hGUI

	$hGUI = GUICreate("Buttons", 400, 400)

	$btn = _GUICtrlButton_Create($hGUI, "Button1", 10, 10, 90, 30)
	_GUICtrlButton_SetShield($btn)

	$btn2 = _GUICtrlButton_Create($hGUI, "Button2", 10, 60, 90, 30, $BS_SPLITBUTTON)
	_GUICtrlButton_SetShield($btn2)

	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit

EndFunc   ;==>_Main
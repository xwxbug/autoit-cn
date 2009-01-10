#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)

Example()

Func Example()
	Local $radio_1, $radio_2, $msg
	
	GUICreate("My GUI group")  ; will create a dialog box that when displayed is centered

	GUICtrlCreateGroup("Group 1", 190, 60, 90, 140)
	$radio_1 = GUICtrlCreateRadio("Radio 1", 210, 90, 50, 20)
	$radio_2 = GUICtrlCreateRadio("Radio 2", 210, 110, 60, 50)
	GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group

	GUISetState()       ; will display an empty dialog box

	; Run the GUI until the dialog is closed
	While 1
		$msg = GUIGetMsg()
		
		If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
EndFunc   ;==>Example
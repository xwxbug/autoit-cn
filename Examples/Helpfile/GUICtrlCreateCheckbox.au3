#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)

Example()

Func Example()
	Local $checkCN, $msg
	GUICreate("My GUI Checkbox")  ; will create a dialog box that when displayed is centered

	$checkCN = GUICtrlCreateCheckbox("CHECKBOX 1", 10, 10, 120, 20)

	GUISetState()       ; will display an  dialog box with 1 checkbox

	; Run the GUI until the dialog is closed
	While 1
		$msg = GUIGetMsg()
		
		If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
EndFunc   ;==>Example
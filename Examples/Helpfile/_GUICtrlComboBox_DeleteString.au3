#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIComboBox.au3>
#include <GuiConstantsEx.au3>
#include <Constants.au3>

Opt('MustDeclareVars', 1)

$Debug_CB = False ; Check ClassName being passed to ComboBox/ComboBoxEx functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hCombo
	
	; Create GUI
	GUICreate("ComboBox Delete String", 400, 296)
	$hCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState()

	; Add drives
	_GUICtrlComboBox_AddDir($hCombo, "", $DDL_DRIVES, False)
	
	;Delete string
	MsgBox(4160, "Information", "Deleting string at index 1")
	_GUICtrlComboBox_DeleteString($hCombo, 1)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
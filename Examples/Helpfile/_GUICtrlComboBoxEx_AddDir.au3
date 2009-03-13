#include <GuiComboBoxEx.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_CB = False ; Check ClassName being passed to ComboBox/ComboBoxEx functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hGUI, $hImage, $input, $hCombo
	
	; Create GUI
	$hGUI = GUICreate("ComboBoxEx Add Dir", 400, 300, -1, -1, -1)
	$hCombo = _GUICtrlComboBoxEx_Create ($hGUI, "", 2, 2, 394, 100)
	$input = GUICtrlCreateInput("Input control", 2, 30, 120)
	GUISetState()

	; Add files
;~ 	_GUICtrlComboBoxEx_BeginUpdate ($input) ; check that ClassName checking works properly
	_GUICtrlComboBoxEx_BeginUpdate ($hCombo)
	_GUICtrlComboBoxEx_AddDir ($hCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBoxEx_EndUpdate ($hCombo)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

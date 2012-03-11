#include <GuiComboBoxEx.au3>
#include <GUIConstantsEx.au3>

$Debug_CB = False ; Check ClassName being passed to ComboBox/ComboBoxEx functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hGUI, $hCombo

	; 创建 GUI
	$hGUI = GUICreate("ComboBoxEx Destroy", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "This is a test|Line 2", 2, 2, 394, 268)
	GUISetState()

	_GUICtrlComboBoxEx_AddString($hCombo, "Some More Text")
	_GUICtrlComboBoxEx_InsertString($hCombo, "Inserted Text", 1)

	;Destroy control
	MsgBox(266256, "信息", "Destroy the control")
	_GUICtrlComboBoxEx_Destroy($hCombo)


	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

#include <GuiComboBoxEx.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给ComboBox/ComboBoxEx函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hGUI, $hCombo

	; 创建界面
	$hGUI = GUICreate(" ComboBoxEx Destroy ", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "This is a test|Line 2 ", 2, 2, 394, 268)
	GUISetState()

	_GUICtrlComboBoxEx_AddString($hCombo, "Some More Text ")
	_GUICtrlComboBoxEx_InsertString($hCombo, "Inserted Text ", 1)

	; 销毁控件
	MsgBox(266256, "Information ", "Destroy the control ")
	_GUICtrlComboBoxEx_Destroy($hCombo)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main


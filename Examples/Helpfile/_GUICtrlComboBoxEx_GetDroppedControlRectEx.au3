#include <GuiComboBoxEx.au3>
#include <GuiConstantsEx.au3>
#include <Constants.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hGUI, $aRect, $hCombo

	; 创建界面
	$hGUI = GUICreate(" ComboBoxEx Get Dropped Control Rect ", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 2, 2, 394, 100)
	GUISetState()

	; 添加文件
	_GUICtrlComboBoxEx_BeginUpdate($hCombo)
	_GUICtrlComboBoxEx_AddDir($hCombo, "", $DDL_DRIVES, False)
	_GUICtrlComboBoxEx_AddDir($hCombo, "", $DDL_DRIVES)
	_GUICtrlComboBoxEx_BeginUpdate($hCombo)
	_GUICtrlComboBoxEx_AddDir($hCombo, @WindowsDir & " \*.exe ")
	_GUICtrlComboBoxEx_EndUpdate($hCombo)
	_GUICtrlComboBoxEx_EndUpdate($hCombo)

	; 获取下拉控件矩形
	$aRect = _GUICtrlComboBoxEx_GetDroppedControlRectEx($hCombo)
	MsgBox(4160, "Information ", "Dropped Control Rect:" & _
			StringFormat(" [%d][%d][%d][%d] ", DllStructGetData($tRect, "Left "), DllStructGetData($tRect, "Top "), _
			DllStructGetData($tRect, "Right "), DllStructGetData($tRect, "Bottom ")))

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main


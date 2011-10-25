
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIComboBox.au3>
#include <GuiConstantsEx.au3>
#include <Constants.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名 , 设置为真并使用另一控件句柄观察其工作

_Main()

Func _Main()
	Local $hCombo

	; 创建界面
	GUICreate(" ComboBox Delete String ", 400, 296)
	$hCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState()

	; 添加驱动器
	_GUICtrlComboBox_AddDir($hCombo, "", $DDL_DRIVES, False)

	; 删除字符串
	MsgBox(4160, "Information ", "Deleting string at index 1 ")
	_GUICtrlComboBox_DeleteString($hCombo, 1)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main


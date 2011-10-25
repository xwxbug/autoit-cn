示例
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIComboBox.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作

_Main()

Func _Main()
	Local $hCombo

	; 创建界面
	GUICreate(" ComboBox Reset Content ", 400, 296)
	$hCombo = GUICtrlCreateCombo(Courier New " )
	GUISetState()

	; 设置编辑框内选中的文本
	_GUICtrlComboBox_SetEditText($hCombo, "Edit Text ")

	; 添加文件
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, @WindowsDir & " \*.exe ")
	_GUICtrlComboBox_EndUpdate($hCombo)

	Sleep(500)

	; 重新设置内容(清空列表框)
	_GUICtrlComboBox_ResetContent($hCombo)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main


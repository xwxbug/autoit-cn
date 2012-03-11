#include <GuiListBox.au3>
#include <GUIConstantsEx.au3>

$Debug_LB = False ;检查传递给 ListBox 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

; 警告此操作不应该用于使用内置函数创建的项目上
; 项目数据为对应于每个字符串的 ControlID

_Main()

Func _Main()
	Local $hListBox

	; 创建 GUI
	GUICreate("List Box Set Item Data", 400, 296)
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState()

	; 添加字符串
	_GUICtrlListBox_BeginUpdate($hListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($hListBox, StringFormat("%03d : Random string", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_EndUpdate($hListBox)

	; 设置项目数据
	_GUICtrlListBox_SetItemData($hListBox, 4, 1234)

	; 获取项目数据
	MsgBox(4160, "信息", "Item 5 Data: " & _GUICtrlListBox_GetItemData($hListBox, 4))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

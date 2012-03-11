#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Insert Item", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; Insert columns
	_GUICtrlListView_InsertColumn($hListView, 0, "Column 1", 100)

	; 添加项目
	_GUICtrlListView_InsertItem($hListView, "Item 1", 0)
	_GUICtrlListView_InsertItem($hListView, "Item 2", 1)
	_GUICtrlListView_InsertItem($hListView, "Item 3", 1)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

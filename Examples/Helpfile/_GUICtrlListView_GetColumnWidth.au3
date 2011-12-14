#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为 True 并使用指向另一控件的句柄来检查它是否工作

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Get Column Width", 400, 300)
	$hListView = GUICtrlCreateListView("Column 1|Column 2|Column 3", 2, 2, 394, 268)
	GUISetState()

	_GUICtrlListView_SetColumnWidth($hListView, 0, 100)

	; 改变首列宽度
	MsgBox(4160, "Information", "Column 1 Width: " & _GUICtrlListView_GetColumnWidth($hListView, 0))
	_GUICtrlListView_SetColumnWidth($hListView, 0, 150)
	MsgBox(4160, "Information", "Column 1 Width: " & _GUICtrlListView_GetColumnWidth($hListView, 0))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

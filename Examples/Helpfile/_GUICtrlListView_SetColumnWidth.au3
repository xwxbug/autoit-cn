#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Set Column Width", 400, 300)
	$hListView = GUICtrlCreateListView("Column 1|Column 2|Column 3|Column 4", 2, 2, 394, 268)
	GUISetState()

	; Change column 1 width
	MsgBox(4160, "信息", "Column 1 Width: " & _GUICtrlListView_GetColumnWidth($hListView, 0))
	_GUICtrlListView_SetColumnWidth($hListView, 0, 150)
	MsgBox(4160, "信息", "Column 1 Width: " & _GUICtrlListView_GetColumnWidth($hListView, 0))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>_Main

#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $a_order[5] = [4, 3, 2, 0, 1], $hListView

	GUICreate("ListView Set Column Order Array", 400, 300)
	$hListView = GUICtrlCreateListView("Column 1|Column 2|Column 3|Column 4", 2, 2, 394, 268)
	GUISetState()

	; Set column order
	MsgBox(4160, "信息", "Changing column order")
	_GUICtrlListView_SetColumnOrderArray($hListView, $a_order)

	; Show column order
	$a_order = _GUICtrlListView_GetColumnOrderArray($hListView)
	MsgBox(4160, "信息", StringFormat("Column order: [%d, %d, %d, %d]", $a_order[1], $a_order[2], $a_order[3], $a_order[4]))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>_Main

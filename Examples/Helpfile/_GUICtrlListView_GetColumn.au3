#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $aInfo, $hListView

	GUICreate("ListView Get Column", 400, 300)
	$hListView = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES))
	_GUICtrlListView_SetColumnWidth($hListView, 0, 100)
	GUISetState()

	GUICtrlCreateListViewItem("index 0|data1|more1", $hListView)
	GUICtrlCreateListViewItem("index 1|data2|more2", $hListView)
	GUICtrlCreateListViewItem("index 2|data3|more3", $hListView)
	GUICtrlCreateListViewItem("index 3|data4|more4", $hListView)
	GUICtrlCreateListViewItem("index 4|data5|more5", $hListView)

	; Change column
	$aInfo = _GUICtrlListView_GetColumn($hListView, 0)
	MsgBox(4160, "信息", "Column 1 Width: " & $aInfo[4])
	_GUICtrlListView_SetColumn($hListView, 0, "New Column 1", 150)
	$aInfo = _GUICtrlListView_GetColumn($hListView, 0)
	MsgBox(4160, "信息", "Column 1 Width: " & $aInfo[4])

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>_Main

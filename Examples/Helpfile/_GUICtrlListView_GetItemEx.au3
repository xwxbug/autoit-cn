#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $tItem, $hListView

	GUICreate("ListView Get ItemEX", 400, 300)

	$hListView = GUICtrlCreateListView("Items", 2, 2, 394, 268)
	GUISetState()

	GUICtrlCreateListViewItem("Item 1", $hListView)
	GUICtrlCreateListViewItem("Item 2", $hListView)
	GUICtrlCreateListViewItem("Item 3", $hListView)

	; Show item 1 raw state
	$tItem = DllStructCreate($tagLVITEM)
	DllStructSetData($tItem, "Mask", $LVIF_STATE)
	DllStructSetData($tItem, "Item", 1)
	DllStructSetData($tItem, "StateMask", -1)
	_GUICtrlListView_GetItemEx($hListView, $tItem)
	MsgBox(4160, "信息", "Item 2 State: " & DllStructGetData($tItem, "State"))

	; Select item 2
	_GUICtrlListView_SetItemSelected($hListView, 1)

	; Show item 1 raw state
	_GUICtrlListView_GetItemEx($hListView, $tItem)
	MsgBox(4160, "信息", "Item 2 State: " & DllStructGetData($tItem, "State"))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $iI, $hListView

	GUICreate("ListView Find In Text", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_InsertColumn($hListView, 0, "Items", 100)

	; 添加项目
	_GUICtrlListView_BeginUpdate($hListView)
	For $iI = 1 To 49
		_GUICtrlListView_AddItem($hListView, "Item " & $iI)
	Next
	_GUICtrlListView_AddItem($hListView, "Target item")
	For $iI = 51 To 100
		_GUICtrlListView_AddItem($hListView, "Item " & $iI)
	Next
	_GUICtrlListView_EndUpdate($hListView)

	; Search for target item
	$iI = _GUICtrlListView_FindInText($hListView, "tArGeT")
	MsgBox(4160, "信息", "Target Item Index: " & $iI)
	_GUICtrlListView_EnsureVisible($hListView, $iI)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

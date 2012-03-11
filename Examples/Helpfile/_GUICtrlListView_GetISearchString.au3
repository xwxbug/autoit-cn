#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hImage, $hListView

	GUICreate("ListView Get ISearch", 400, 300)

	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUICtrlSetStyle($hListView, $LVS_ICON)
	GUISetState()

	; 加载图像
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0xFF0000, 16, 16))
	_GUICtrlListView_SetImageList($hListView, $hImage, 0)

	_GUICtrlListView_BeginUpdate($hListView)
	For $x = 1 To 10
		_GUICtrlListView_InsertItem($hListView, "Item " & $x, -1, 0)
	Next
	_GUICtrlListView_EndUpdate($hListView)

	Send("Item 1")

	; Get incremental search string
	MsgBox(4160, "信息", "Incremental Search String: " & _GUICtrlListView_GetISearchString($hListView))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>_Main

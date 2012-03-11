#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $aInfo, $hImage, $hListView

	GUICreate("ListView Get Group Info", 400, 300)

	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 加载图像
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($hListView), 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($hListView), 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($hListView), 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Column 1", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 2", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 3", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Row 1: Col 1", 0)
	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 2", 1)
	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 3", 2)
	_GUICtrlListView_AddItem($hListView, "Row 2: Col 1", 1)
	_GUICtrlListView_AddSubItem($hListView, 1, "Row 2: Col 2", 1)
	_GUICtrlListView_AddItem($hListView, "Row 3: Col 1", 2)

	; Build groups
	_GUICtrlListView_EnableGroupView($hListView)
	_GUICtrlListView_InsertGroup($hListView, -1, 1, "Group 1", 1)
	_GUICtrlListView_InsertGroup($hListView, -1, 2, "Group 2")
	_GUICtrlListView_SetItemGroupID($hListView, 0, 1)
	_GUICtrlListView_SetItemGroupID($hListView, 1, 2)
	_GUICtrlListView_SetItemGroupID($hListView, 2, 2)

	; Change group information
	For $x = 0 To _GUICtrlListView_GetGroupCount($hListView) - 1
		$aInfo = _GUICtrlListView_GetGroupInfoByIndex($hListView, $x)
		MsgBox(4160, "信息", "Index " & $x + 1 & "Text: " & $aInfo[0])
	Next
	_GUICtrlListView_SetGroupInfo($hListView, 1, "New Group 1")

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>_Main

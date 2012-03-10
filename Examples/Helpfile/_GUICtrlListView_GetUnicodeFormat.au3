#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; Check ClassName being passed to ListView functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Get Unicode Format", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; 设置 Unicode 格式
	MsgBox(4160, "Information", "Unicode: " & _GUICtrlListView_GetUnicodeFormat($hListView))
	_GUICtrlListView_SetUnicodeFormat($hListView, True)
	MsgBox(4160, "Information", "Unicode: " & _GUICtrlListView_GetUnicodeFormat($hListView))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

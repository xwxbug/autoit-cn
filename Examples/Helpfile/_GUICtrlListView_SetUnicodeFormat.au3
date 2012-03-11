#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Set Unicode Format", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; 设置 Unicode 格式
	_GUICtrlListView_SetUnicodeFormat($hListView, False)
	MsgBox(4160, "信息", "Unicode: " & _GUICtrlListView_GetUnicodeFormat($hListView))
	_GUICtrlListView_SetUnicodeFormat($hListView, True)
	MsgBox(4160, "信息", "Unicode: " & _GUICtrlListView_GetUnicodeFormat($hListView))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

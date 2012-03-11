#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $aInfo, $hListView

	GUICreate("ListView Set Column", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Column 1", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 2", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 3", 100)

	; 改变列
	$aInfo = _GUICtrlListView_GetColumn($hListView, 0)
	MsgBox(4160, "信息", "Column 1 Width: " & $aInfo[4])
	_GUICtrlListView_SetColumn($hListView, 0, "New Column 1", 150, 1)
	$aInfo = _GUICtrlListView_GetColumn($hListView, 0)
	MsgBox(4160, "信息", "Column 1 Width: " & $aInfo[4])

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

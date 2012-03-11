#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hGui, $hToolTip, $hListView

	$hGui = GUICreate("ListView Get ToolTips", 400, 300)
	$hListView = _GUICtrlListView_Create($hGui, "", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Item 1")
	_GUICtrlListView_AddItem($hListView, "Item 2")
	_GUICtrlListView_AddItem($hListView, "Item 3")

	; Show tooltip handle
	$hToolTip = _GUICtrlListView_GetToolTips($hListView)
	MsgBox(4160, "信息", "ToolTip Handle: 0x" & Hex($hToolTip) & @CRLF & _
			"IsPtr = " & IsPtr($hToolTip) & " IsHWnd = " & IsHWnd($hToolTip))

	_GUICtrlListView_SetToolTips($hListView, $hToolTip)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

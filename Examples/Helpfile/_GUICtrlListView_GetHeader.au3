#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Get Header", 400, 300)
	$hListView = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
	GUISetState()

	MsgBox(4160, "Information", "ListView Header Handle: 0x" & Hex(_GUICtrlListView_GetHeader($hListView)) & @CRLF & _
			"IsPtr = " & IsPtr(_GUICtrlListView_GetHeader($hListView)) & " IsHwnd = " & IsHWnd(_GUICtrlListView_GetHeader($hListView)))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>_Main

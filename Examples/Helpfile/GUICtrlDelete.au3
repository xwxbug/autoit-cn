#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $date, $del, $msg

	GUICreate("我的GUI-删除控件", 200, 200, 800, 200)
	$date = GUICtrlCreateDate("1953/04/25", 10, 10, 185, 20)
	$del = GUICtrlCreateButton("删除控件", 50, 50, 70, 20)
	GUISetState()

	; 运行 GUI 等待对话框关闭
	Do
		$msg = GUIGetMsg()
		If $msg = $del Then
			GUICtrlDelete($date)
			GUICtrlDelete($del)
		EndIf
	Until $msg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
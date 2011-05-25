#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $n, $msg

	GUICreate("My GUI (GetControlState)")
	$n = GUICtrlCreateCheckbox("checkbox", 10, 10)
	GUICtrlSetState(-1, 1) 	; 调整指定控件的状态

	GUISetState()       ; 显示一个空白的窗口

	; 运行界面,直到窗口被关闭
	While 1
		$msg = GUIGetMsg()

		If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd

	MsgBox(0, "状态", StringFormat("GUICtrlRead=%d\nGUICtrlGetState=%d", GUICtrlRead($n), GUICtrlGetState($n)))
EndFunc   ;==>Example
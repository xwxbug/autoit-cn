#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $msg

	GUICreate("My GUI")  ; 创建一个居中显示的 GUI 窗口

	GUISetState()       ; 显示一个空白的窗口

	; 运行界面,直到窗口被关闭
	While 1
		$msg = GUIGetMsg()

		If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd

	GUIDelete()	; 将返回 1
EndFunc   ;==>Example
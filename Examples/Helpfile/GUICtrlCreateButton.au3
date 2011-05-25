#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $Button_1, $Button_2, $msg
	GUICreate("My GUI Button") ; 创建一个对话框，并居中显示

	Opt("GUICoordMode", 2)
	$Button_1 = GUICtrlCreateButton("打开记事本", 10, 30, 100)
	$Button_2 = GUICtrlCreateButton("测试按钮", 0, -1)

	GUISetState()      ; 显示有两个按钮的对话框

	; 运行界面，直到窗口被关闭
	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $msg = $Button_1
				Run('Notepad.exe')    ; 点击按钮 1 打开记事本
			Case $msg = $Button_2
				MsgBox(0, '测试', '你点击了测试按钮')    ; 点击按钮 2 显示一个简单的对话框
		EndSelect
	WEnd
EndFunc   ;==>Example
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $ani1, $buttonstart, $buttonstop, $msg

	GUICreate("My GUI Animation", 360, 200)
	$ani1 = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 165, 50, 10)

	$buttonstart = GUICtrlCreateButton("开始", 100, 150, 70, 22)
	$buttonstop = GUICtrlCreateButton("停止", 200, 150, 70, 22)

	GUISetState()

	; 运行界面,直到窗口被关闭
	While 1
		$msg = GUIGetMsg()

		Select
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop

			Case $msg = $buttonstart
				GUICtrlSetState($ani1, 1)

			Case $msg = $buttonstop
				GUICtrlSetState($ani1, 0)

		EndSelect
	WEnd
EndFunc   ;==>Example

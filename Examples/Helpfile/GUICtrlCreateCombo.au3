#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $msg
	GUICreate("My GUI combo")  ; 创建一个对话框,并居中显示

	GUICtrlCreateCombo("item1", 10, 10) ; 创建一个组合列表框(ComboBox)控件
	GUICtrlSetData(-1, "item2|item3", "item3") ; 在列表框中添加新的项目，并设置一个新的默认值

	GUISetState()

	; 运行界面,直到窗口被关闭
	While 1
		$msg = GUIGetMsg()

		If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
EndFunc   ;==>Example
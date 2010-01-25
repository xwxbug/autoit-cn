#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)

Example()

Func Example()
	Local $menu1, $n1, $n2, $msg, $menustate, $menutext
	
	GUICreate("My GUICtrlRead") ; 创建一个居中显示的 GUI 窗口

	$menu1 = GUICtrlCreateMenu("File")

	$n1 = GUICtrlCreateList("", 10, 10, -1, 100)
	GUICtrlSetData(-1, "item1|item2|item3", "item2")

	$n2 = GUICtrlCreateButton("读取", 10, 110, 50)
	GUICtrlSetState(-1, $GUI_FOCUS) ; 这个按钮是重点

	GUISetState() ; 显示一个空白的窗口
	; 运行界面，直到窗口被关闭
	Do
		$msg = GUIGetMsg()
		If $msg = $n2 Then
			MsgBox(0, "读取选中的项目", GUICtrlRead($n1)) ; 读取选中的项目
			$menustate = GUICtrlRead($menu1) ; 读取指定控件的状态或相关数据.
			$menutext = GUICtrlRead($menu1, 1) ; 读取指定控件的扩展信息.
			MsgBox(0, "读取菜单的状态和文本", "状态:" & $menustate & @LF & "文本:" & $menutext)
		EndIf
	Until $msg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
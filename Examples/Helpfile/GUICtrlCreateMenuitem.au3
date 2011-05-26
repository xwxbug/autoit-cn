#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

Example()

Func Example()
	Local $filemenu, $fileitem, $helpmenu
	Local $infoitem, $exititem, $recentfilesmenu, $viewmenu
	Local $viewstatusitem, $cancelbutton, $statuslabel, $msg, $file

	GUICreate("我的图形菜单", 300, 200)

	Global $defaultstatus = "Ready"

	$filemenu = GUICtrlCreateMenu("文件(&F)")
	$fileitem = GUICtrlCreateMenuItem("打开", $filemenu)
	GUICtrlSetState(-1, $GUI_DEFBUTTON);调整指定控件为窗口的默认按钮
	$helpmenu = GUICtrlCreateMenu("?"); 创建一个菜单控件
	GUICtrlCreateMenuItem("保存", $filemenu)
	GUICtrlSetState(-1, $GUI_DISABLE);调整指定控件为灰色状态
	$infoitem = GUICtrlCreateMenuItem("信息", $helpmenu)
	$exititem = GUICtrlCreateMenuItem("退出", $filemenu)
	$recentfilesmenu = GUICtrlCreateMenu("历史文件", $filemenu, 1)

	GUICtrlCreateMenuItem("", $filemenu, 2) 	; 创建分隔线

	$viewmenu = GUICtrlCreateMenu("查看", -1, 1); 创建一个菜单控件
	$viewstatusitem = GUICtrlCreateMenuItem("状态栏", $viewmenu)
	GUICtrlSetState(-1, $GUI_CHECKED);调整指定控件为选中状态
	GUICtrlCreateButton("确定", 50, 130, 70, 20)
	GUICtrlSetState(-1, $GUI_FOCUS)
	$cancelbutton = GUICtrlCreateButton("取消", 180, 130, 70, 20)

	$statuslabel = GUICtrlCreateLabel($defaultstatus, 0, 165, 300, 16, BitOR($SS_SIMPLE, $SS_SUNKEN))

	GUISetState()
	While 1
		$msg = GUIGetMsg()

		If $msg = $fileitem Then
			$file = FileOpenDialog("选择文件...", @TempDir, "All (*.*)")
			If @error <> 1 Then GUICtrlCreateMenuItem($file, $recentfilesmenu)
		EndIf
		If $msg = $viewstatusitem Then
			If BitAND(GUICtrlRead($viewstatusitem), $GUI_CHECKED) = $GUI_CHECKED Then
				GUICtrlSetState($viewstatusitem, $GUI_UNCHECKED)
				GUICtrlSetState($statuslabel, $GUI_HIDE)
			Else
				GUICtrlSetState($viewstatusitem, $GUI_CHECKED)
				GUICtrlSetState($statuslabel, $GUI_SHOW)
			EndIf
		EndIf
		If $msg = $GUI_EVENT_CLOSE Or $msg = $cancelbutton Or $msg = $exititem Then ExitLoop
		If $msg = $infoitem Then MsgBox(0, "信息", "仅仅测试...")
	WEnd
	GUIDelete()
EndFunc   ;==>Example
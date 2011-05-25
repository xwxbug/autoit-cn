#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

Local $exititem = TrayCreateItem("退出")

TraySetState()

Local $start = 0
While 1
	Local $msg = TrayGetMsg()
	If $msg = $exititem Then ExitLoop
	Local $diff = TimerDiff($start)
	If $diff > 1000 Then
		Local $num = -Random(0,100,1)	; 负的随机数
		ToolTip("#icon=" & $num)
		TraySetIcon("Shell32.dll", $num)
		$start = TimerInit()
	EndIf
WEnd

Exit

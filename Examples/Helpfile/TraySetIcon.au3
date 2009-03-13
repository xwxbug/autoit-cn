#Include <Constants.au3>
#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

$exititem		= TrayCreateItem("Exit")

TraySetState()

$start = 0
While 1
	$msg = TrayGetMsg()
	If $msg = $exititem Then ExitLoop
	$diff = TimerDiff($start)
	If $diff > 1000 Then
		$num = -Random(0,100,1)	; negative to use ordinal numbering
		ToolTip("#icon=" & $num)
		TraySetIcon("Shell32.dll",$num)
		$start = TimerInit()
	EndIF
WEnd

Exit

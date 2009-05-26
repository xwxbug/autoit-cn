#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

$getitem	= TrayCreateItem("得到文本")
TrayCreateItem("")
$aboutitem	= TrayCreateItem("关于")
TrayCreateItem("")
$exititem	= TrayCreateItem("退出")

TraySetState()

While 1
	$msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $getitem
			Msgbox(64,"状态",TrayItemGetText($aboutitem))
		Case $msg = $aboutitem
			Msgbox(64,"关于:","AutoIt3-托盘例子")
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit

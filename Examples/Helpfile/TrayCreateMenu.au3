#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

$settingsitem	= TrayCreateMenu("设置")
$displayitem	= TrayCreateItem("显示", $settingsitem)
$printeritem	= TrayCreateItem("打印", $settingsitem)
TrayCreateItem("")
$aboutitem		= TrayCreateItem("关于")
TrayCreateItem("")
$exititem		= TrayCreateItem("退出")

TraySetState()

While 1
	$msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $aboutitem
			Msgbox(64,"关于:","AutoIt3-托盘-例子")
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit

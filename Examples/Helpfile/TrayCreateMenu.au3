#Include <Constants.au3>
#NoTrayIcon

Opt("TrayMenuMode",1)	; Default tray menu items (Script Paused/Exit) will not be shown.

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

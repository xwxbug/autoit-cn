#Include <Constants.au3>
#NoTrayIcon

Opt("TrayAutoPause",0)	; Script will not be paused when clicking the tray icon.

$valitem	= TrayCreateItem("值:")
TrayCreateItem("")
$aboutitem	= TrayCreateItem("关于")

TraySetState()

TrayItemSetText($TRAY_ITEM_EXIT,"退出程序")
TrayItemSetText($TRAY_ITEM_PAUSE,"暂停程序")

While 1
	$msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $valitem
			TrayItemSetText($valitem,"值:" & Int(Random(1,10,1)))
		Case $msg = $aboutitem
			Msgbox(64,"关于:","AutoIt3-托盘-例子")
	EndSelect
WEnd

Exit

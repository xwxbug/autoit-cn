#Include <Constants.au3>
#NoTrayIcon

Opt("TrayMenuMode",1)	; Default tray menu items (Script Paused/Exit) will not be shown.

$getitem	= TrayCreateItem("Get Text")
TrayCreateItem("")
$aboutitem	= TrayCreateItem("About")
TrayCreateItem("")
$exititem	= TrayCreateItem("Exit")

TraySetState()

While 1
	$msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $getitem
			Msgbox(64,"State",TrayItemGetText($aboutitem))
		Case $msg = $aboutitem
			Msgbox(64,"About:","AutoIt3-Tray-sample")
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit

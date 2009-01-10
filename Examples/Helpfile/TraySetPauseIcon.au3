#Include <Constants.au3>
#NoTrayIcon

TraySetPauseIcon("shell32.dll",12)
TraySetState()

While 1
	$msg = TrayGetMsg()
WEnd

Exit

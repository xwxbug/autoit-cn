#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

Local $settingsitem	= TrayCreateMenu("设置")
TrayCreateItem("显示", $settingsitem)
TrayCreateItem("打印", $settingsitem)
TrayCreateItem("")
Local $aboutitem		= TrayCreateItem("关于")
TrayCreateItem("")
Local $exititem		= TrayCreateItem("退出")

TraySetState()
TraySetClick(16)

While 1
	Local $msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $aboutitem
			MsgBox(64,"关于:","AutoIt3-托盘-例子")
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit

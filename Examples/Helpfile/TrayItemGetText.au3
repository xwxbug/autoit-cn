#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

Local $getitem	= TrayCreateItem("得到文本")
TrayCreateItem("")
Local $aboutitem	= TrayCreateItem("关于")
TrayCreateItem("")
Local $exititem	= TrayCreateItem("退出")

TraySetState()

While 1
	Local $msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $getitem
			MsgBox(64,"状态",TrayItemGetText($aboutitem))
		Case $msg = $aboutitem
			MsgBox(64,"关于:","AutoIt3-托盘例子")
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit

#Include <Constants.au3>
#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

$exititem		= TrayCreateItem("退出")

TraySetIcon("警告")
TraySetToolTip("SOS")

TraySetState()	; 显示托盘图标

$toggle = 0

While 1
	$msg = TrayGetMsg()
	Select
		Case $msg = 0
			Sleep(1000)
			If $toggle = 0 Then
				TraySetState()	; 显示托盘图标
				$toggle = 1
			Else
				TraySetState(2)	; 隐藏托盘图标
				$toggle = 0
			EndIF
		Case $msg = $exititem
			ExitLoop
	EndSelect
		
WEnd

Exit

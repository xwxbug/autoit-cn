#NoTrayIcon

Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

TraySetClick(16)	; 只有单击第二个鼠标按键(默认右键)才会显示托盘菜单.

TrayCreateItem("信息")
TrayItemSetOnEvent(-1, "ShowInfo")

TrayCreateItem("")

TrayCreateItem("退出")
TrayItemSetOnEvent(-1, "ExitScript")

TraySetState()

While 1
	Sleep(10)	; 空闲循环
WEnd

Exit


; Functions
Func ShowInfo()
	MsgBox(0,"Info","托盘 OnEvent 模式演示")
EndFunc   ;==>ShowInfo


Func ExitScript()
	Exit
EndFunc   ;==>ExitScript

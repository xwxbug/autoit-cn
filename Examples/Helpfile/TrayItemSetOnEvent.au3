#NoTrayIcon

Opt("TrayMenuMode", 3) ; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示,并且所选项目不能被选中(checkbox不会打勾) . 请参考TrayMenuMode选项1和2(3=1+2).
Opt("TrayOnEventMode", 1)

Example()

Func Example()
	TrayCreateItem("关于")
	TrayItemSetOnEvent(-1, "关于")

	TrayCreateItem("") ; Create a separator line.

	TrayCreateItem("退出")
	TrayItemSetOnEvent(-1, "ExitScript")

	TraySetState(1) ; Show the tray menu.

	While 1
		Sleep(100)	; 空闲循环
	WEnd
EndFunc   ;==>Example

Func About()
	; Display a message box about the AutoIt version and installation path of the AutoIt executable.
	MsgBox(4096, "", "AutoIt tray menu example." & @CRLF & @CRLF & _
			"Version: " & @AutoItVersion & @CRLF & _
			"Install Path: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1)) ; Find the folder of a full path.
EndFunc   ;==>About

Func ExitScript()
	Exit
EndFunc   ;==>ExitScript

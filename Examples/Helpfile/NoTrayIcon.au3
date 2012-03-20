#NoTrayIcon

Example()

Func Example()
	MsgBox(4096, "", "点击确定后，将会显示托盘图标.")

	; 显示托盘图标
	Opt("TrayIconHide", 0)

	; 5秒后将自动关闭脚本
	Sleep(5000)
EndFunc   ;==>Example

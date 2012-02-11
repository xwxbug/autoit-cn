#NoTrayIcon

Example()

Func Example()
	TraySetState(1) ; Show the tray menu.
	TraySetToolTip("An example of a tray menu tooltip.") ; 这是我一个新的托盘工具提示文本!

	While 1
	Sleep(100)	; 空闲循环
	WEnd
EndFunc   ;==>Example


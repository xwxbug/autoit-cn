Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止
	WinWait("[CLASS:Notepad]", "", 10)

	; 设置2秒等待时间
	Sleep(2000)

	; 通过记事本的类名来关闭记事本窗口.
	WinClose("[CLASS:Notepad]")
EndFunc   ;==>Example

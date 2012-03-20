Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

    ; 10秒内暂停脚本执行,直至记事本窗口被激活(成为活动状态)为止
	WinWaitActive("[CLASS:Notepad]", "", 10)

	; 设置2秒等待时间
	Sleep(2000)

	; 通过记事本的类名来关闭记事本窗口.
	WinClose("[CLASS:Notepad]")
EndFunc   ;==>Example

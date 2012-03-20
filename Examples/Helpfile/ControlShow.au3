Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 隐藏记事本窗口控件.
	ControlHide($hWnd, "", "Edit1")

	; 设置2秒等待时间
	Sleep(2000)

	; 显示已经隐藏的记事本窗口控件.
	ControlShow($hWnd, "", "Edit1")

	; 设置2秒等待时间
	Sleep(2000)

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)
EndFunc   ;==>Example
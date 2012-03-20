Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 使记事本编辑框控件变成灰色不可用状态.
	ControlDisable($hWnd, "", "Edit1")

	; 设置2秒等待时间
	Sleep(2000)

	; 使记事本编辑框控件变为可用状态.
	ControlEnable($hWnd, "", "Edit1")

	; 设置2秒等待时间
	Sleep(2000)

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)
EndFunc   ;==>Example

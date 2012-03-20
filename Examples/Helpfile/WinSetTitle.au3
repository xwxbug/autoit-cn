Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 通过 WinWait 的返回句柄来修改记事本窗口的标题.
	WinSetTitle($hWnd, "", "New Notepad Title - AutoIt")

	; 设置2秒等待时间
	Sleep(2000)

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)
EndFunc   ;==>Example

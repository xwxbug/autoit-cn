Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 设置2秒等待时间
	Sleep(2000)

    ; 向记事本编辑框控件发送字符串.
	ControlSend($hWnd, "", "Edit1", "This is some text")

	; 设置2秒等待时间
	Sleep(2000)

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)

    ; 暂停脚本的执行,直至弹出询问保存窗口存在(出现)为止.
	WinWaitActive("[CLASS:#32770]")
	Sleep(500)
	Send("{TAB}{ENTER}")
EndFunc   ;==>Example

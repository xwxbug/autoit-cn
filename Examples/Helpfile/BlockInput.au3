Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 屏蔽用户鼠标与键盘输入
	BlockInput(1)

	; 设置2秒等待时间
	Sleep(2000)

    ; 通过 ControlSend 直接发送 F5 按键到记事本窗口，从而实现时间日期的输入操作.
	ControlSend($hWnd, "", "Edit1", "{F5}")

	; 启用用户鼠标与键盘输入
	BlockInput(0)

	; 设置2秒等待时间
	Sleep(2000)

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)

    ; 暂停脚本的执行直至指定的询问保存更改窗口被激活为止
	WinWaitActive("[CLASS:#32770]")

	; 设置0.5秒等待时间
	Sleep(500)
	
	; 模拟键盘 TAB键 + ENTER键 输入操作
	Send("{TAB}{ENTER}")
EndFunc   ;==>Example

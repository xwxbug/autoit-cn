Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 获取记事本窗口编辑框控件的内部句柄.
	Local $hControl = ControlGetHandle($hWnd, "", "Edit1")

	; 显示记事本编辑框控件的内部句柄.
	MsgBox(4096, "", "记事本编辑框控件的内部句柄是: " & $hControl)

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)
EndFunc   ;==>Example

Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)
	
	; 向记事本编辑框控件发送读取编辑框总行数的命令.
	Local $iCount = ControlCommand($hWnd, "", "Edit1", "GetLineCount", "");GetLineCount = 返回目标编辑框中的总行数

	; 显示总行数.
	MsgBox(4096, "提示", "记事本编辑框总行数: " & $iCount)

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)
EndFunc   ;==>Example

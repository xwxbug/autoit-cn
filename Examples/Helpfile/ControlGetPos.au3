Example()

Func Example()
	; 运行记事本程序
	Run("notepad.exe")

	; 10秒内暂停脚本的执行,直至记事本窗口存在(出现)为止.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 获取记事本编辑框控件相对其窗口的坐标位置和大小等信息.
	Local $aPos = ControlGetPos($hWnd, "", "Edit1")

	; 显示记事本编辑框控件相对其窗口的坐标位置和大小等信息.
	MsgBox(4096, "窗口状态:", "坐标: " & $aPos[0] & "," & $aPos[1] & @CRLF & "大小: " & $aPos[2] & "," & $aPos[3] )

	; 通过 WinWait 的返回句柄来关闭记事本窗口.
	WinClose($hWnd)
EndFunc   ;==>Example

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	;等待记事本窗口出现并是活动状态,超时10秒
	WinWaitActive("[CLASS:Notepad]", "", 10)

	; 等待记事本窗口显示两秒
	Sleep(2000)

	; 使用记事本的类名关闭记事本窗口.
	WinClose("[CLASS:Notepad]")
EndFunc   ;==>Example

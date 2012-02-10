Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; 等待10秒,等着记事本窗口出现
	WinWait("[CLASS:Notepad]", "", 10)

	;再蛋疼等待2秒
	Sleep(2000)

	;使用记事本的"类"名称关闭记事本窗口
	WinClose("[CLASS:Notepad]")
EndFunc   ;==>Example

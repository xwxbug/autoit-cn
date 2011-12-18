Run("notepad.exe")
WinWait("[CLASS:Notepad]")

SendKeepActive("[CLASS:Notepad]")

; 当在暂停期间保持窗口激活状态.
For $i = 1 To 10
	Sleep(1000)
	Send("Hello")
Next

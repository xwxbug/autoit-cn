Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")


If WinExists("无标题 - 记事本") Then
	MsgBox(0, "", "记事本窗口存在")
EndIf

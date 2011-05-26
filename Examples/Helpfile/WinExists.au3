Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")


If WinExists("[CLASS:Notepad]") Then
	MsgBox(0, "", "记事本窗口存在")
EndIf

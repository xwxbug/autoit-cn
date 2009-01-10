
Run("notepad.exe")
Sleep(1000)


If WinActive("无标题 - 记事本") Then
	MsgBox(0, "", "记事本窗口是活动的")
EndIf

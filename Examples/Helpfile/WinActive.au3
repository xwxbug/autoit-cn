
Run("notepad.exe")
Sleep(1000)


If WinActive("[CLASS:Notepad]") Then
	MsgBox(0, "", "记事本窗口是活动的")
EndIf

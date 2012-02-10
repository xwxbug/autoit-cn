Run("notepad.exe")
Sleep(1000)
If WinActive("[CLASS:Notepad]") Then ; Check if Notepad is currently active.
	MsgBox(4096, "WinActive", "记事本窗口是活动的")
Else
	MsgBox(4096, "WinActive", "记事本窗口不是活动的.")
EndIf

Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
WinSetState("[CLASS:Notepad]","",@SW_MINIMIZE)

; Check if a new notepad window is minimized
$state = WinGetState("[CLASS:Notepad]", "")

; Is the "minimized" value set?
If BitAnd($state, 16) Then
	MsgBox(0, "例子", "记事本窗口是最小化的")
Else
	MsgBox(0, "例子", "记事本窗口不是最小化的")	
EndIf


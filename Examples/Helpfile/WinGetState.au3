Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
WinSetState("[CLASS:Notepad]","",@SW_MINIMIZE)

; 检查记事本窗口状态
$state = WinGetState("[CLASS:Notepad]", "")

; 检查记事本窗口是不是"最小化"状态.
If BitAnd($state, 16) Then
	MsgBox(0, "例子", "记事本窗口是最小化的")
Else
	MsgBox(0, "例子", "记事本窗口不是最小化的")	
EndIf


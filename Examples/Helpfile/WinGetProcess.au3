Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")




$pid = WinGetProcess("[CLASS:Notepad]")
MsgBox(0, "进程 PID 为", $pid)

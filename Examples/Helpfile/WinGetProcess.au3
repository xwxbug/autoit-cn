Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")




$pid = WinGetProcess("[CLASS:Notepad]")
MsgBox(0, "½ø³Ì PID Îª", $pid)

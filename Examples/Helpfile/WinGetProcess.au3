Run("notepad.exe")
WinWait("[CLASS:Notepad]")
Local $pid = WinGetProcess("[CLASS:Notepad]")
MsgBox(0, "½ø³Ì PID Îª", $pid)

Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")



Local $title = WinGetTitle("[CLASS:Notepad]", "")
MsgBox(0, "完整的标题为:", $title)

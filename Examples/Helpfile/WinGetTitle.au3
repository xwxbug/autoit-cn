Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")



$title = WinGetTitle("[CLASS:Notepad]", "")
MsgBox(0, "完整的标题为:", $title)

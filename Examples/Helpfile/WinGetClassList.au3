
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")





Local $text = WinGetClassList("[CLASS:Notepad]", "")
MsgBox(0, "类列表为:", $text)

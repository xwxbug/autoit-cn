Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]","")
ControlCommand("[CLASS:Notepad]", "", "Edit1", "EditPaste", "放点文本进去")

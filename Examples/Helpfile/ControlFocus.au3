Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]","")
ControlFocus("[CLASS:Notepad]", "", "Edit1")

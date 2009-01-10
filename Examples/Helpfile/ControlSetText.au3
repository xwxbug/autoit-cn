Run("notepad.exe")
WinWait("Untitled -")
ControlSetText("Untitled -", "", "Edit1", "New Text Here" )

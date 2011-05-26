Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")


WinMove("[CLASS:Notepad]", "", 0, 0, 200, 200)

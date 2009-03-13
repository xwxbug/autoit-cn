Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")


WinSetTitle("[CLASS:Notepad]", "", "我新的记事本")

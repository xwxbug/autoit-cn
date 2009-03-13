Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")

WinSetOnTop("[CLASS:Notepad]", "", 1)

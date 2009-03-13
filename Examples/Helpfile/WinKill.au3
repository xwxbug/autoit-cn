
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
Sleep(1000)


WinKill("[CLASS:Notepad]", "")

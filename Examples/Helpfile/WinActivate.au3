Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
Send("!{tab}")
Sleep(1000)


WinActivate("[CLASS:Notepad]", "")

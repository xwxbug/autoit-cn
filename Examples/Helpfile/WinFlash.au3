; flashes the window 4 times with a break in between each one of 1/2 second
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")



WinFlash("[CLASS:Notepad]","", 4, 500) 
; 闪烁4次,每次闪烁间隔0.5秒
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")

WinFlash("[CLASS:Notepad]","", 4, 500) 
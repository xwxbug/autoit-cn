Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
ControlSend("[CLASS:Notepad]","","[CLASSNN:Edit1]","text")
Sleep(500)

WinClose("[CLASS:Notepad]", "")

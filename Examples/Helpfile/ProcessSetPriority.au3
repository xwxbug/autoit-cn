Run("notepad.exe")
WinWait("[CLASS:Notepad]")
ProcessSetPriority("notepad.exe", 0)
; 设置记事本的优先级为：空闲/低


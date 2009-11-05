Run("notepad.exe")

;等待记事本窗口出现
;WinWait("未命名")
WinWait("[CLASS:Notepad]")

;等待记事本窗口出现,等待5秒,如果仍未出现.脚本继续
;WinWait("未命名", "", 5)
WinWait("[CLASS:Notepad]", "", 5)
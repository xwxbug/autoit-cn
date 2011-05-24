Run("notepad.exe")

;等待记事本窗口出现并是活动状态
WinWaitActive("[CLASS:Notepad]")

;等待记事本窗口出现并是活动状态,最多等待5秒,5秒后不管如何，脚本继续
WinWaitActive("[CLASS:Notepad]", "", 5)

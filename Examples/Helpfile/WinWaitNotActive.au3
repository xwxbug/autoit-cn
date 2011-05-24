Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")

;等待记事本窗口为不活动状态,如果一直是活动状态,脚本暂停
WinWaitNotActive("[CLASS:Notepad]")

;等待记事本窗口为不活动状态(延迟5秒,5秒后不管如何,脚本继续)
WinWaitNotActive("[CLASS:Notepad]", "", 5)
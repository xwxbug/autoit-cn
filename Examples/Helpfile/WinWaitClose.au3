Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
;等待记事本窗口被关闭
WinWaitClose("[CLASS:Notepad]")

;等待记事本窗口被关闭,最大等5秒,如果任然未关闭,脚本继续
WinWaitClose("[CLASS:Notepad]", "", 5)

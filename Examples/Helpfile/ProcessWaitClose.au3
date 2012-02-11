;暂停脚本的执行,直至记事本进程不再存在为止.
ProcessWaitClose("notepad.exe")

; 运行记事本,等待记事本进程结束后再执行脚本.
Local $iPID = Run("notepad.exe")
ProcessWaitClose($iPID)
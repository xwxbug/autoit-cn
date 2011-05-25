; 返回当前进程的内存信息
Local $mem = ProcessGetStats()

; 返回当前进程的输入输出(IO)信息
Local $IO = ProcessGetStats(-1, 1)

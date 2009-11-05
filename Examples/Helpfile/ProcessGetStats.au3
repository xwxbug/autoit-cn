; 返回当前进程的内存信息
$mem = ProcessGetStats()

; 返回当前进程的输入输出(IO)信息
$IO = ProcessGetStats(-1, 1)

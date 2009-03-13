; retrieve memory infos of the current running process
$mem = ProcessGetStats()

; retrieve IO infos of the current running process
$IO = ProcessGetStats(-1, 1)

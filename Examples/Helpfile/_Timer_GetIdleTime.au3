
#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include  <Timers.au3>

; 鼠标/键盘动作将在10秒延迟期间报告空置时间
Sleep(10 * 1000) ; 10秒

Global $iIdleTime = _Timer_GetIdleTime()

msgbox(64, "_Timer_GetIdleTime", "Idle time =" & $iIdleTime & "ms")


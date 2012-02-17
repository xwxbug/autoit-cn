#include <Timers.au3>

; 在这 10 秒里鼠标/键盘的操作将改变报告的空闲时间
Sleep(10 * 1000); 10秒

Global $iIdleTime = _Timer_GetIdleTime()

MsgBox(4160, "_Timer_GetIdleTime", "Idle time = " & $iIdleTime & "ms")

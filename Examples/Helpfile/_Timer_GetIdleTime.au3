#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include <Timers.au3>

; Mouse/Keyboard action during this 10 sec delay will change reported idle time
Sleep(10 * 1000); 10sec

Global $iIdleTime = _Timer_GetIdleTime()

MsgBox(64, "_Timer_GetIdleTime", "Idle time = " & $iIdleTime & "ms")
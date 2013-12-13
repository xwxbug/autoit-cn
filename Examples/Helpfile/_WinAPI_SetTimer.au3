#include <WinAPISys.au3>
#include <Misc.au3>

Opt('TrayAutoPause', 0)

Local $hTimerProc = DllCallbackRegister('_TimerProc', 'none', 'hwnd;uint;uint_ptr;dword')
Global $Count = 0

Local $TimerID = _WinAPI_SetTimer(0, 0, 1000, DllCallbackGetPtr($hTimerProc))

Do
	Sleep(100)
Until _IsPressed('1B')

_WinAPI_KillTimer(0, $TimerID)
DllCallbackFree($hTimerProc)

Func _TimerProc($hWnd, $iMsg, $iTimerId, $iTime)
	#forceref $hWnd, $iMsg, $iTimerId, $iTime

	ConsoleWrite($Count & @CRLF)
	$Count += 1
EndFunc   ;==>_TimerProc

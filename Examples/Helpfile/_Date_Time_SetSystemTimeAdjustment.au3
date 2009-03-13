#include <Date.au3>

_Main()

Func _Main()
	Local $aInfo

	; Open the clock so we can watch the fun
	Run("RunDll32.exe shell32.dll,Control_RunDLL timedate.cpl")
	WinWaitActive("Date and Time Properties")

	; Get current time adjustments
	$aInfo = _Date_Time_GetSystemTimeAdjustment()

	; Slow down clock
	MsgBox(4096, "Information", "Slowing down system clock")
	_Date_Time_SetSystemTimeAdjustment($aInfo[1] / 10, False)
	Sleep(5000)

	; Speed up clock
	MsgBox(4096, "Information", "Speeding up system clock")
	_Date_Time_SetSystemTimeAdjustment($aInfo[1] * 10, False)
	Sleep(5000)

	; Reset time adjustment
	_Date_Time_SetSystemTimeAdjustment($aInfo[1], True)
	MsgBox(4096, "Information", "System clock restored")

EndFunc   ;==>_Main

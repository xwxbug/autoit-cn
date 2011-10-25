
#include <Array.au3>
#include <WinAPIEx.au3>

Dim $results[1]

_ArrayAdd($results, "_WinAPI_ZwDelayExecution() ")

For $i = 0 To 5
	$t = TimerInit()
	_WinAPI_ZwDelayExecution(1000) ; 1000∫¡√Î = 1√Î
	_ArrayAdd($results, TimerDiff($t))
Next

_ArrayAdd($results, "")
_ArrayAdd($results, "AutoIt Sleep() ")

For $i = 0 To 5
	$t = TimerInit()
	Sleep(1)
	_ArrayAdd($results, TimerDiff($t))
Next

_arraydisplay($results)


#include <Array.au3>

Local $limit = 500
Local $values[51]
Local $t, $n

For $i = 1 To $limit
	$t = TimerInit()
	Sleep(10)
	$n = Round(TimerDiff($t))
	$values[$n] += 1
Next
Local $aArray = _Array1DToHistogram($values)
_ArrayDisplay($aArray, "_Array1DToHistogram", "10:20")

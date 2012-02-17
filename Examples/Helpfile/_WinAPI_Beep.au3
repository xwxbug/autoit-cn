#include <WinAPI.au3>

_Main()

Func _Main()
	Local $iFreqStart = 100
	Local $iFreqEnd = 250

	MsgBox(4096, "_WinAPI_Beep Example", "Ascending")

	For $iFreq = $iFreqStart To $iFreqEnd
		_WinAPI_Beep($iFreq, 100)
		ToolTip("Frequency = " & $iFreq)
	Next

	MsgBox(4096, "_WinAPI_Beep Example", "Descending")

	For $iFreq = $iFreqEnd To $iFreqStart Step -1
		_WinAPI_Beep($iFreq, 100)
		ToolTip("Frequency = " & $iFreq)
	Next
EndFunc   ;==>_Main

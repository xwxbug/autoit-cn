#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $iFreqStart = 100
	Local $iFreqEnd = 250

	MsgBox(0, "_WinAPI_Beep Ê¾Àý", "Ascending")

	For $iFreq = $iFreqStart To $iFreqEnd
		_WinAPI_Beep($iFreq, 100)
		ToolTip("Frequency =" & $iFreq)
	Next

	MsgBox(0, "_WinAPI_Beep Ê¾Àý", "Descending")

	For $iFreq = $iFreqEnd To $iFreqStart Step -1
		_WinAPI_Beep($iFreq, 100)
		ToolTip("Frequency =" & $iFreq)
	Next
endfunc   ;==>_Main


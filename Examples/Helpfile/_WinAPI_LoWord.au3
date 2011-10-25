#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>

_Main()

Func _Main()
	Local $iWord = 11 * 65535
	MsgBox(0, $iWord, "HiWord:" & _WinAPI_HiWord($iWord) & @LF & " LoWord:" & _WinAPI_LoWord($iWord))
endfunc   ;==>_Main


#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $cursor, $text
	$cursor = _WinAPI_GetCursorInfo()
	$text = "Was the operation sucessful? " & $cursor[0] & @LF
	$text &= "Is the cursor showing? " & $cursor[1] & @LF & @LF
	$text &= "Cursor Handle: " & $cursor[2] & @LF
	$text &= "X Coordinate: " & $cursor[3] & @LF
	$text &= "Y Coordinate: " & $cursor[4]
	MsgBox(0, "_WinApi_GetCursorInfo Example", $text)
EndFunc   ;==>_Main
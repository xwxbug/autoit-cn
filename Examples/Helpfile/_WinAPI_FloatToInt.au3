#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $float, $text, $INT
	$float = 10.55
	$INT = _WinAPI_FloatToInt($float)
	$text = "The float " & $float & " is converted to the Integer " & $INT & " (Hex = " & Hex($INT) & ")"
	MsgBox(0, "_WinAPI_FloatToInt Example Results", $text)
EndFunc   ;==>_Main
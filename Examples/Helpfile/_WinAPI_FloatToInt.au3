#include <WinAPI.au3>

_Main()

Func _Main()
	Local $float, $text, $INT
	$float = 10.55
	$INT = _WinAPI_FloatToInt($float)
	$text = "The float " & $float & " is converted to the Integer " & $INT & " (Hex = " & Hex($INT) & ")"
	MsgBox(4096, "_WinAPI_FloatToInt Example Results", $text)
EndFunc   ;==>_Main

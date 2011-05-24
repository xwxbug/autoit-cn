#include <Misc.au3>

Local $dll = DllOpen("user32.dll")

While 1
	Sleep(250)
	If _IsPressed("24", $dll) Then
		ConsoleWrite("_IsPressed - Home Key Pressed" & @CRLF)
		; Wait until key is released
		While _IsPressed("24", $dll)
			Sleep(250)
		WEnd
	ElseIf _IsPressed("23", $dll) Then
		MsgBox(0, "_IsPressed", "End Key Pressed")
		ExitLoop
	EndIf
WEnd
DllClose($dll)

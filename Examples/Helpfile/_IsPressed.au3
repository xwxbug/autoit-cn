#include <Misc.au3>

Local $hDLL = DllOpen("user32.dll")

While 1
	If _IsPressed("10", $hDLL) Then
		ConsoleWrite("_IsPressed - Shift Key was pressed." & @CRLF)
		; 一直等待,直到按键被释放
		While _IsPressed("10", $hDLL)
			Sleep(250)
		WEnd
		ConsoleWrite("_IsPressed - Shift Key was released." & @CRLF)
	ElseIf _IsPressed("1B", $hDLL) Then
		MsgBox(0, "_IsPressed", "The Esc Key was pressed, therefore we will close the application.")
		ExitLoop
	EndIf
	Sleep(250)
WEnd

DllClose($hDLL)

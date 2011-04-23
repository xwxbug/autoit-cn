#include <ACN_BlockInputEx.au3>

;================== Lock on password Example ==================

;Sleep(5000)

_BlockInputEx(1, "[:ALPHA:]|[:NUMBER:]|{ENTER}|{ALT}|{TAB}|{BACKSPACE}")

AdlibRegister("_Quit", 15000)

While 1
	$sPasss = InputBox("Computer is locked", "Please type a password to unlock this computer:", "", "*")
	
	If $sPasss = "password" Or @error Then ;we exit also on Cancel, to prevent complete block for this specific example
		_Quit()
	Else
		MsgBox(48, "Error", "Wrong password.")
	EndIf
WEnd

Func _Quit()
	Exit
EndFunc

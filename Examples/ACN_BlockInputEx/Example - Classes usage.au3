#include <ACN_BlockInputEx.au3>

;================== CLASSes usage Example ==================

HotKeySet("{ESC}", "_Quit") ;This will trigger an exit

;Here we block Numeric keyboard keys, "Test" string (every char in this group), and UP / DOWN arrow keys.
_BlockInputEx(3, "", "[:NUMBER:]|[Test]|{UP}|{DOWN}")

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
	Sleep(100)
WEnd

Func _Quit()
	Exit
EndFunc

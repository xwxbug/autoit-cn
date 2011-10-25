#include <BlockInputEx.au3>

;================== MouseEvents blocking Example ==================

HotKeySet("{ESC}", "_Quit") ;This will trigger an exit

;Here we block *Mouse* input, except the mouse movement and the wheel button scrolling.
_BlockInputEx(2, "{MMOVE}|{MWSCROLL}")

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
	Sleep(100)
WEnd

Func _Quit()
	Exit
endfunc

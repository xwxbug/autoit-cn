#include <BlockInputEx.au3>

;================== Block Mouse only Example ==================

HotKeySet("{ESC}", "_Quit") ;This will trigger an exit.

;Here we block only *Mouse* input (without keyboard).
_BlockInputEx(2)

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
    Sleep(100)
WEnd

Func _Quit()
	Exit
endfunc

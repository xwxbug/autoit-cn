#include <BlockInputEx.au3>

;================== Block keyboard only Example ==================

HotKeySet("{ESC}", "_Quit") ;This will fail due to full keyboard blocking.

;Here we block only *Keyboard* input (without mouse).
_BlockInputEx(3)

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
    Sleep(100)
WEnd

Func _Quit()
	Exit
EndFunc

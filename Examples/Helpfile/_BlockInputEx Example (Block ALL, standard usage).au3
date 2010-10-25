#include <BlockInputEx.au3>

;================== Block All Example ==================

HotKeySet("{ESC}", "_Quit") ;This will fail due to keyboard blocking.

;Here we block *All* inputs - Mouse *and* Keyboard. The same as built-in BlockInput() function.
_BlockInputEx(1)

;Script will UnBlock the inputs and exit after 5 seconds.
Sleep(5000)
_BlockInputEx(0)

Func _Quit()
	Exit
EndFunc

#include <BlockInputEx.au3>

;================== Exclude usage Example ==================

HotKeySet("{ESC}", "_Quit")
HotKeySet("{F1}", "_Quit")
HotKeySet("{F2}", "_Quit")
HotKeySet("{F3}", "_Quit")

;All keyboard keys and mouse clicks are blocked except these keys: 0x1B = {ESC}, 0x70 = "{F1}", 0x71 = "{F2}", 0x72 = "{F3}"
_BlockInputEx(1, "0x1B|0x70|0x71|0x72")

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
    Sleep(100)
WEnd

Func _Quit()
	Exit
endfunc

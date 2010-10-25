#include <BlockInputEx.au3>

;================== Include usage Example ==================

HotKeySet("{ESC}", "_Quit") ;This will trigger an exit, the rest HotKeySets will not.
HotKeySet("1", "_Quit")
HotKeySet("2", "_Quit")
HotKeySet("3", "_Quit")

;Here we block only the following keyboard keys (try to press them ;) ):
; 0x31 = "1"
; 0x32 = "2"
; 0x33 = "3"
; 0x61 = "Numpad1"
; 0x62 = "Numpad2"
; 0x63 = "Numpad3"
_BlockInputEx(1, "", "0x31|0x32|0x33|0x61|0x62|0x63")
;_BlockInputEx(1, "", "1|2|3|{NUMPAD1}|{NUMPAD2}|{NUMPAD3}") ;Equivalent to previous line

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
    Sleep(100)
WEnd

Func _Quit()
	Exit
EndFunc

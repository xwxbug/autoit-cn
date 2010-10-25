#include <BlockInputEx.au3>

;================== hWindows usage Example ==================

HotKeySet("{ESC}", "_Quit") ;This will trigger an exit (on any window except the window of Notepad).

Run(@WindowsDir & "\Notepad.exe", "", @SW_MAXIMIZE)
WinWait("[REGEXPCLASS:Notepad.*]")
$hNotepad_Wnd = WinGetHandle("[REGEXPCLASS:Notepad.*]")

ControlSetText($hNotepad_Wnd, "", "", _
	"Now try to input some keys in here..." & @CRLF & _
	"Well, that's the idea, you can't, don't you?" & @CRLF & @CRLF & ":)")

;Here we block *All* keyboard keys for specific window (in this case the Notepad's window).
_BlockInputEx(3, "", "", $hNotepad_Wnd)

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
    Sleep(100)
WEnd

Func _Quit()
	Exit
EndFunc

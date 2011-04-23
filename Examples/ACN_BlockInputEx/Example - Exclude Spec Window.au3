#include <ACN_BlockInputEx.au3>

HotKeySet("{ESC}", "_Quit") ;This will trigger an exit (on the Notepad's window).

Global $iMark = 0

Run(@WindowsDir & "\Notepad.exe", "", @SW_MAXIMIZE)
WinWait("[REGEXPCLASS:Notepad.*]")
$hNotepad_Wnd = WinGetHandle("[REGEXPCLASS:Notepad.*]")

_BlockInputEx(3)

;This is only for testing, so if anything go wrong, the script will exit after 10 seconds.
AdlibRegister("_Quit", 10000)

While 1
	If $iMark = 0 And WinActive($hNotepad_Wnd) Then
		$iMark = 1
		_BlockInputEx(0)
	ElseIf $iMark = 1 And Not WinActive($hNotepad_Wnd) Then
		$iMark = 0
		_BlockInputEx(3)
	EndIf
	
    Sleep(10)
WEnd

Func _Quit()
	Exit
EndFunc

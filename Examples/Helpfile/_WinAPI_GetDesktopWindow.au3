#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $win = _WinAPI_GetDesktopWindow()
	MsgBox(0, "", WinGetTitle($win))
	MsgBox(0, "", $win)
EndFunc   ;==>_Main
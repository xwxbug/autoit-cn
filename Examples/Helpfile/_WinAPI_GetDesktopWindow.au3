#include <WinAPI.au3>

_Main()

Func _Main()
	Local $win = _WinAPI_GetDesktopWindow()
	MsgBox(4096, "", WinGetTitle($win))
	MsgBox(4096, "", $win)
EndFunc   ;==>_Main

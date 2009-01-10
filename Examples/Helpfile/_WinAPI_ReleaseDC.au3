#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt('MustDeclareVars', 1)

#include <WinAPI.au3>

_Main()

Func _Main()
	Local $hwnd, $hDC
	$hwnd = GUICreate("test")
	$hDC = _WinAPI_GetDC($hwnd)
	MsgBox(4096, "Handle", "Display Device: " & $hDC)
	_WinAPI_ReleaseDC($hwnd, $hDC)
EndFunc   ;==>_Main
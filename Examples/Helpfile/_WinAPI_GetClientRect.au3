#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt('MustDeclareVars', 1)

#include <WinAPI.au3>

_Main()

Func _Main()
	Local $hwnd, $tRect
	$hwnd = GUICreate("test")
	$tRect = _WinAPI_GetClientRect($hwnd)
	MsgBox(4096, "Rect", _
			"Left..:" & DllStructGetData($tRect, "Left") & @LF & _
			"Right.:" & DllStructGetData($tRect, "Right") & @LF & _
			"Top...:" & DllStructGetData($tRect, "Top") & @LF & _
			"Bottom:" & DllStructGetData($tRect, "Bottom"))
endfunc   ;==>_Main


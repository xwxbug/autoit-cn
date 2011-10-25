#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt('MustDeclareVars ', 1)

#include  <WinAPI.au3>

_Main()

Func _Main()
	Local $hwnd = GUICreate(" test ")
	Local $tPoint = _WinAPI_GetMousePos()
	Local $tPoint2 = _WinAPI_GetMousePos(True, $hwnd)

	MsgBox(4096, "Mouse Pos ", _
			" X =" & DllStructGetData($tPoint, "X ") & @LF & " Y =" & DllStructGetData($tPoint, "Y ") & @LF & @LF & _
			" Client" & @LF & " X =" & DllStructGetData($tPoint2, "X ") & @LF & " Y =" & DllStructGetData($tPoint2, "Y "))
endfunc   ;==>_Main


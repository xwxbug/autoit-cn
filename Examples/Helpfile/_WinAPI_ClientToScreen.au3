#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>
Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hwnd = GUICreate("Example", 200, 200)
	Local $tpoint = DllStructCreate("int X;int Y")
	DllStructSetData($tpoint, "X", 100)
	DllStructSetData($tpoint, "Y", 160)
	GUISetState(@SW_SHOW)
	Sleep(1000)
	_WinAPI_ClientToScreen($hwnd, $tpoint)
	MsgBox(0, "_WINAPI_ClientToScreen Example", "Screen Cordinates of client's x,y position: 100,160 is: " & @LF & _
			"X: " & DllStructGetData($tpoint, "X") & @LF & _
			"Y: " & DllStructGetData($tpoint, "Y") & @LF)
EndFunc   ;==>_Main
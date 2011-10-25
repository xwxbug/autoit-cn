#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>
Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hwnd = GUICreate("Ê¾Àý", 200, 200)
	Local $tpoint = DllStructCreate("int X;int Y")
	DllStructSetData($tpoint, "X", 641)
	DllStructSetData($tpoint, "Y", 459)
	GUISetState(@SW_SHOW)
	Sleep(1000)
	_WinAPI_ScreenToClient($hwnd, $tpoint)
	MsgBox(0, "_WINAPI_ClientToScreen Example", "Screen Cordinates of 641,459 is x,y position of client:" & @LF & _
			"X:" & DllStructGetData($tpoint, "X") & @LF & _
			"Y:" & DllStructGetData($tpoint, "Y") & @LF)
endfunc   ;==>_Main


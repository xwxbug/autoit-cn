#include <WinAPI.au3>

Global $Struct = DllStructCreate($tagPoint)

_Main()

Func _Main()
	HotKeySet("{ESC}", "_Quit")

	While 1
		Sleep(100)
		ToolTip("")
		Pos()
		Local $hwnd = _WinAPI_WindowFromPoint($Struct)
		ToolTip($hwnd)
	WEnd
EndFunc   ;==>_Main

Func Pos()
	DllStructSetData($Struct, "x", MouseGetPos(0))
	DllStructSetData($Struct, "y", MouseGetPos(1))
EndFunc   ;==>Pos

Func _Quit()
	Exit
EndFunc   ;==>_Quit

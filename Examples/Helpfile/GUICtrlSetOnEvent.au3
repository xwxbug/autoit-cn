#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)

Example()

Func Example()
	Local $parent1, $ok1, $cancel1
	
	Opt("GUICoordMode", 2)
	Opt("GUIResizeMode", 1)
	Opt("GUIOnEventMode", 1)

	$parent1 = GUICreate("Parent1")
	GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
	GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
	GUISetOnEvent($GUI_EVENT_RESTORE, "SpecialEvents")

	$ok1 = GUICtrlCreateButton("OK", 10, 30, 50)
	GUICtrlSetOnEvent(-1, "OKPressed")

	$cancel1 = GUICtrlCreateButton("Cancel", 0, -1)
	GUICtrlSetOnEvent(-1, "CancelPressed")

	GUISetState(@SW_SHOW)

	; Just idle around
	While 1
		Sleep(10)
	WEnd

EndFunc   ;==>Example


Func OKPressed()
	MsgBox(0, "OK Pressed", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle & " CtrlHandle=" & @GUI_CtrlHandle)
EndFunc   ;==>OKPressed


Func CancelPressed()
	MsgBox(0, "Cancel Pressed", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle & " CtrlHandle=" & @GUI_CtrlHandle)
EndFunc   ;==>CancelPressed


Func SpecialEvents()
	Select
		Case @GUI_CtrlId = $GUI_EVENT_CLOSE
			MsgBox(0, "Close Pressed", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle)
			Exit

		Case @GUI_CtrlId = $GUI_EVENT_MINIMIZE
			MsgBox(0, "Window Minimized", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle)

		Case @GUI_CtrlId = $GUI_EVENT_RESTORE
			MsgBox(0, "Window Restored", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle)

	EndSelect
EndFunc   ;==>SpecialEvents
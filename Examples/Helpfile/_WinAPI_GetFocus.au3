#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>
#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $gui, $msg, $btnFocus, $win, $text
	$gui = GUICreate("__WinAPI_GetFocus Example", 200, 200)
	$btnFocus = GUICtrlCreateButton("Get Focus", 50, 85, 100, 30)
	GUISetState(@SW_SHOW)
	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				Exit
			Case $msg = $btnFocus
				$win = _WinAPI_GetFocus()
				$text = "Full Title: " & WinGetTitle($win) & @LF
				$text &= "Full Text: " & WinGetText($win) & @LF
				$text &= "Handle: " & WinGetHandle($win) & @LF
				$text &= "Process: " & WinGetProcess($win) & @LF
				MsgBox(0, "", $text)
		EndSelect
	WEnd
EndFunc   ;==>_Main
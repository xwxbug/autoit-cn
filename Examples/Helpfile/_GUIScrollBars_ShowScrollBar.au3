#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIScrollBars.au3>
#include <ScrollBarConstants.au3>

Opt("MustDeclareVars", 1)

_Main()

Func _Main()
	Local $GUIMsg, $hGUI

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	GUISetBkColor(0x88AABB)

	GUISetState()

	_GUIScrollBars_Init($hGUI)

	_GUIScrollBars_ShowScrollBar($hGUI, $SB_HORZ, False)
	Sleep(1000)
	_GUIScrollBars_ShowScrollBar($hGUI, $SB_HORZ)

	Sleep(1000)
	_GUIScrollBars_ShowScrollBar($hGUI, $SB_VERT, False)
	Sleep(1000)
	_GUIScrollBars_ShowScrollBar($hGUI, $SB_VERT)

	While 1
		$GUIMsg = GUIGetMsg()

		Switch $GUIMsg
			Case $GUI_EVENT_CLOSE ;, $nExititem
				ExitLoop
		EndSwitch
	WEnd

	Exit
endfunc   ;==>_Main

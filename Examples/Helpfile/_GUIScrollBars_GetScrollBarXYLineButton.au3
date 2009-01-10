#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIScrollBars.au3>
#include <ScrollBarConstants.au3>

Opt("MustDeclareVars", 1)

Global $iMemo

_Main()

Func _Main()
	Local $GUIMsg, $hGUI

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	$iMemo = GUICtrlCreateEdit("", 2, 2, 380, 360, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetResizing($iMemo, $GUI_DOCKALL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetBkColor(0x88AABB)
	
	GUISetState()

	_GUIScrollBars_Init($hGUI)

	MemoWrite("Horizontal" & @CRLF & "--------------------------------------")
	MemoWrite("Height of thumb: " & _GUIScrollBars_GetScrollBarXYLineButton($hGUI, $OBJID_HSCROLL) & @CRLF)

	MemoWrite("Vertical" & @CRLF & "--------------------------------------")
	MemoWrite("Width of thumb: " & _GUIScrollBars_GetScrollBarXYLineButton($hGUI, $OBJID_VSCROLL))

	While 1
		$GUIMsg = GUIGetMsg()

		Switch $GUIMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>_Main

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
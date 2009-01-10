#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StructureConstants.au3>
#include <GUIScrollBars.au3>
#include <ScrollBarConstants.au3>

Opt("MustDeclareVars", 1)

Global $iMemo

_Main()

Func _Main()
	Local $GUIMsg, $hGUI, $tSCROLLBARINFO

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 226, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetResizing($iMemo, $GUI_DOCKALL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetBkColor(0x88AABB)
	
	GUISetState()

	_GUIScrollBars_Init($hGUI)

	$tSCROLLBARINFO = _GUIScrollBars_GetScrollBarInfoEx($hGUI, $OBJID_HSCROLL)
	MemoWrite("Horizontal" & @CRLF & "--------------------------------------")
	MemoWrite("Left.........: " & DllStructGetData($tSCROLLBARINFO, "Left"))
	MemoWrite("Top..........: " & DllStructGetData($tSCROLLBARINFO, "Top"))
	MemoWrite("Right........: " & DllStructGetData($tSCROLLBARINFO, "Right"))
	MemoWrite("Bottom.......: " & DllStructGetData($tSCROLLBARINFO, "Bottom"))
	MemoWrite("dxyLineButton: " & DllStructGetData($tSCROLLBARINFO, "dxyLineButton"))
	MemoWrite("xyThumbTop...: " & DllStructGetData($tSCROLLBARINFO, "xyThumbTop"))
	MemoWrite("xyThumbBottom: " & DllStructGetData($tSCROLLBARINFO, "xyThumbBottom"))
	For $x = 0 To 5
		MemoWrite("rgstate[" & $x & "]...: " & DllStructGetData($tSCROLLBARINFO, "rgstate", $x + 1))
	Next

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
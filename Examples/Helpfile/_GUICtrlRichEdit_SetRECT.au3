
#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiRichEdit.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $lblMsg, $hRichEdit

Main()

Func Main()
	Local $hGui, $iMsg, $btnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$lblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$btnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState()

	_GuiCtrlRichEdit_SetText($hRichEdit, "First paragraph")
	_GuiCtrlRichEdit_AppendText($hRichEdit, @CR & "Second paragraph")

	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				GUIDelete()
				Exit
			Case $iMsg = $btnNext
				$iStep += 1
				Switch $iStep
					Case 1
						Report("1. Default settings ")
					Case 2
						_GuiCtrlRichEdit_SetRECT($hRichEdit, 10, 10, 100, 100)
						Report("2. Settings ")
					Case 3
						_GuiCtrlRichEdit_SetRECT($hRichEdit)
						Report("3. ReSettings to default")
						GUICtrlSetState($btnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
endfunc   ;==>Main

Func Report($sMsg)
	Local $aRect = _GUICtrlRichEdit_GetRECT($hRichEdit)
	$sMsg = $sMsg & @CR & @CR & "Left=" & $aRect[0] & " Top=" & $aRect[1] & " Right=" & $aRect[2] & " Bottom=" & $aRect[3]
	GUICtrlSetData($lblMsg, $sMsg)
	ControlFocus($hRichEdit, "", "")
endfunc   ;==>Report



#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiRichEdit.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $lblMsg, $hRichEdit

Main()

Func Main()
	Local $hGui, $iMsg, $btnDoIt
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$lblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$btnDoIt = GUICtrlCreateButton("Do it", 270, 310, 40, 30)
	GUISetState()

	_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1) ; select all

	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				GUIDelete()
				Exit
			Case $iMsg = $btnDoIt
				ChangeFontSize()
		EndSelect
	WEnd
endfunc   ;==>Main

Func ChangeFontSize()
	Local $av, $iOld, $iNew
	$av = _GuiCtrlRichEdit_GetFont($hRichEdit)
	$iOld = $av[0]
	_GuiCtrlRichEdit_ChangeFontSize($hRichEdit, 2)
	$av = _GuiCtrlRichEdit_GetFont($hRichEdit)
	$iNew = $av[0]
	Report("Was" & $iOld & " points; is now" & $iNew & " points")
endfunc   ;==>ChangeFontSize

Func Report($sMsg)
	GUICtrlSetData($lblMsg, $sMsg)
endfunc   ;==>Report


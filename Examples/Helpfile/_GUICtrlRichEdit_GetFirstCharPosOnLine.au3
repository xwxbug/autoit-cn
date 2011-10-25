
#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiRichEdit.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

Global $lblMsg, $hRichEdit

Main()

Func Main()
	Local $hGui, $iMsg, $iCp1
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$lblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	GUISetState()

	_GuiCtrlRichEdit_AutoDetectURL($hRichEdit, True)
	_GuiCtrlRichEdit_AppendText($hRichEdit, @CR & "http://www.autoitscript.com")
	$iCp1 = _GuiCtrlRichEdit_GetFirstCharPosOnLine($hRichEdit, 2)
	_GuiCtrlRichEdit_SetSel($hRichEdit, $iCp1, $iCp1 + 3)
	Report("Character attributes at start of line 2 are" & _
			_GuiCtrlRichEdit_GetCharAttributes($hRichEdit))

	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				GUIDelete()
				Exit
		EndSelect
	WEnd
endfunc   ;==>Main

Func Report($sMsg)
	GUICtrlSetData($lblMsg, $sMsg)
endfunc   ;==>Report


#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Color.au3>

Global $lblMsg, $hRichEdit

Main()

Func Main()
	Local $hGui, $iMsg, $btnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$lblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$btnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState()

	_GUICtrlRichEdit_SetText($hRichEdit, "Paragraph 1")
	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($hRichEdit) ; 除非脚本崩溃才需要
;~ 				GUIDelete() 	; 同样行
				Exit
			Case $iMsg = $btnNext
				$iStep += 1
				Switch $iStep
					Case 1
						Report("1. Initial setting")
					Case 2
						_GUICtrlRichEdit_SetCharColor($hRichEdit, "304050")
						Report("2. Setting is now")
					Case 3
						_GUICtrlRichEdit_SetSel($hRichEdit, 1, 5)
						_GUICtrlRichEdit_SetCharColor($hRichEdit, "sys")
						_GUICtrlRichEdit_SetSel($hRichEdit, 0, 0)
						Report("3. Background of a few characters changed")
					Case 4
						_GUICtrlRichEdit_Deselect($hRichEdit)
						; 把所有的文本流保存到桌面,这样您可以在 Word 中查看设置.
						_GUICtrlRichEdit_StreamToFile($hRichEdit, @DesktopDir & "\gcre.rtf")
						GUICtrlSetState($btnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Main

Func Report($sMsg)
	Local $iColor = _GUICtrlRichEdit_GetCharBkColor($hRichEdit)
	Local $aRet = _ColorGetRGB($iColor)
	$sMsg = $sMsg & @CR & @CR & $aRet[0] & ";" & $aRet[1] & ";" & $aRet[2] & " BkColor=0x" & Hex($iColor)
	GUICtrlSetData($lblMsg, $sMsg)
EndFunc   ;==>Report


#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiRichEdit.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>
#include  <GuiMenu.au3>

Opt('MustDeclareVars', 1)

Global $hRichEdit, $mnu, $mnuUndo, $mnuRedo, $mnuCut, $mnuCopy
Global $mnuPaste, $mnuPasteSpl, $mnuPasteSplRTF, $mnuPasteSplwObjs

Main()

Func Main()
	Local $hGui
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_AppendText($hRichEdit, ReadBmpToRtf( FindFirstBMP()) & @CR)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	$mnu = GUICtrlCreateContextMenu( GUICtrlCreateDummy())
	$mnuUndo = GUICtrlCreateMenuItem("Undo", $mnu)
	$mnuRedo = GUICtrlCreateMenuItem("Redo", $mnu)
	GUICtrlCreateMenuItem("", $mnu)
	$mnuCut = GUICtrlCreateMenuItem("Cut", $mnu)
	$mnuCopy = GUICtrlCreateMenuItem("Copy", $mnu)
	$mnuPaste = GUICtrlCreateMenuItem("Paste", $mnu)
	$mnuPasteSpl = GUICtrlCreateMenu("Paste Special", $mnu)
	$mnuPasteSplRTF = GUICtrlCreateMenuItem("RTF only", $mnuPasteSpl)
	$mnuPasteSplwObjs = GUICtrlCreateMenuItem("With objects", $mnuPasteSpl)
	_GuiCtrlRichEdit_SetEventMask($hRichEdit, $ENM_MOUSEEVENTS)

	While True
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete()
				Exit
			Case $mnuUndo
				_GuiCtrlRichEdit_Undo($hRichEdit)
			Case $mnuRedo
				_GuiCtrlRichEdit_Redo($hRichEdit)
			Case $mnuCut
				_GuiCtrlRichEdit_Cut($hRichEdit)
			Case $mnuCopy
				_GuiCtrlRichEdit_Copy($hRichEdit)
			Case $mnuPaste
				_GuiCtrlRichEdit_Paste($hRichEdit)
			Case $mnuPasteSplRTF
				_GuiCtrlRichEdit_PasteSpecial($hRichEdit, False)
			Case $mnuPasteSplwObjs
				_GuiCtrlRichEdit_PasteSpecial($hRichEdit, True)
		EndSwitch
	WEnd
endfunc   ;==>Main

Func WM_NOTIFY($hWnd, $iMsg, $iWparam, $iLparam)
	#forceref $iMsg, $iWparam
	Local $hWndFrom, $iCode, $tNMHDR, $tMsgFilter, $hMenu
	$tNMHDR = DllStructCreate($tagNMHDR, $iLparam)
	$hWndFrom = HWnd( DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hRichEdit
			Select
				Case $iCode = $EN_MSGFILTER
					$tMsgFilter = DllStructCreate($tagEN_MSGFILTER, $iLparam)
					If DllStructGetData($tMsgFilter, "msg") = $WM_RBUTTONUP Then
						$hMenu = GUICtrlGetHandle($mnu)
						SetMenuTexts($hWndFrom, $hMenu)
						_GUICtrlMenu_TrackPopupMenu($hMenu, $hWnd)
					EndIf
			EndSelect
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_NOTIFY

Func SetMenuTexts($hWnd, $hMenu)
	Local $fState
	If _GUICtrlRichEdit_CanUndo($hWnd) Then
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuUndo, True, False)
		_GUICtrlMenu_SetItemText($hMenu, $mnuUndo, "Undo:" & _GUICtrlRichEdit_GetNextUndo($hWnd), False)
	Else
		_GUICtrlMenu_SetItemText($hMenu, $mnuUndo, "Undo", False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuUndo, False, False)
	EndIf
	If _GUICtrlRichEdit_CanRedo($hWnd) Then
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuRedo, True, False)
		_GUICtrlMenu_SetItemText($hMenu, $mnuRedo, "Redo:" & _GUICtrlRichEdit_GetNextRedo($hWnd), False)
	Else
		_GUICtrlMenu_SetItemText($hMenu, $mnuRedo, "Redo", False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuRedo, False, False)
	EndIf
	$fState = _GuiCtrlRichEdit_IsTextSelected($hWnd)
	_GUICtrlMenu_SetItemEnabled($hMenu, $mnuCut, $fState, False)
	_GUICtrlMenu_SetItemEnabled($hMenu, $mnuCopy, $fState, False)

	_GUICtrlMenu_SetItemEnabled($hMenu, $mnuPaste, _GUICtrlRichEdit_CanPaste($hWnd))

	_GUICtrlMenu_SetItemEnabled($hMenu, $mnuPasteSpl, _GUICtrlRichEdit_CanPasteSpecial($hWnd), False)
endfunc   ;==>SetMenuTexts

Func ReadBmpToRtf($sBmpFilspc)
	Local $hFile, $sRtf
	$hFile = FileOpen($sBmpFilspc, 16)
	If FileRead($hFile, 2) <> "0x424D" Then Return SetError(1, 0, "")
	FileRead($hFile, 12)
	$sRtf = '{\rtf1{\pict\dibitmap' & Hex( FileRead($hFile)) & '}}'
	FileClose($hFile)
	Return $sRtf
endfunc   ;==>ReadBmpToRtf

Func FindFirstBMP($sPath = @WindowsDir)
	Local $hFind, $sBmpFilspc
	$hFind = FileFindFirstFile($sPath & "\*.bmp")
	$sBmpFilspc = FileFindNextFile($hFind)
	FileClose($hFind)
	Return $sPath & "\" & $sBmpFilspc
endfunc   ;==>FindFirstBMP


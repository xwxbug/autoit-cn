#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiMenu.au3>

Global $hRichEdit, $mnu, $mnuUndo, $mnuRedo, $mnuEmpty

Main()

Func Main()
	Local $hGui
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName,4) &")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	$mnu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
	$mnuUndo = GUICtrlCreateMenuItem("Undo", $mnu)
	$mnuRedo = GUICtrlCreateMenuItem("Redo", $mnu)
	GUICtrlCreateMenuItem("", $mnu)
	$mnuEmpty = GUICtrlCreateMenuItem("Empty Undo buffer", $mnu)

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
			Case $mnuEmpty
				_GuiCtrlRichEdit_EmptyUndoBuffer($hRichEdit)
		EndSwitch
	WEnd
EndFunc   ;==>Main

Func WM_NOTIFY($hWnd, $iMsg, $iWparam, $iLparam)
	#forceref $iMsg, $iWparam
	Local $hWndFrom, $iCode, $tNMHDR, $tMsgFilter, $hMenu
	$tNMHDR = DllStructCreate($tagNMHDR, $iLparam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
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
EndFunc   ;==>WM_NOTIFY

Func SetMenuTexts($hWnd, $hMenu)
	If _GUICtrlRichEdit_CanUndo($hWnd) Then
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuUndo, True, False)
		_GUICtrlMenu_SetItemText($hMenu, $mnuUndo, "Undo: " & _GUICtrlRichEdit_GetNextUndo($hWnd), False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuEmpty, True, False)
	Else
		_GUICtrlMenu_SetItemText($hMenu, $mnuUndo, "Undo", False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuUndo, False, False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuEmpty, False, False)
	EndIf
	If _GUICtrlRichEdit_CanRedo($hWnd) Then
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuRedo, True, False)
		_GUICtrlMenu_SetItemText($hMenu, $mnuRedo, "Redo: " & _GUICtrlRichEdit_GetNextRedo($hWnd), False)
	Else
		_GUICtrlMenu_SetItemText($hMenu, $mnuRedo, "Redo", False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $mnuRedo, False, False)
	EndIf
EndFunc   ;==>SetMenuTexts

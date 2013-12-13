#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>

Global $iMemo, $MainGUI, $hStatus

Example()

Func Example()
	Local $hGUI
	Local $aParts[3] = [75, 150, -1]

	; Create GUI
	$hGUI = GUICreate("(Example 2) StatusBar Create", 400, 300)

	;===============================================================================
	; sets parts with no text
	$hStatus = _GUICtrlStatusBar_Create($hGUI, $aParts)
	;===============================================================================

	; Create memo control
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 274, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUICtrlSendMsg($iMemo, $EM_SETREADONLY, True, 0)
	GUICtrlSetBkColor($iMemo, 0xFFFFFF)
	GUISetState()

	MemoWrite("StatusBar Created with:" & @CRLF & _
			@TAB & "Handle to GUI window" & @CRLF & _
			@TAB & "part width array of 3 elements" & @CRLF)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; Get border sizes
	MemoWrite("Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz($hStatus))
	MemoWrite("Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert($hStatus))
	MemoWrite("Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect($hStatus))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUISetState(@SW_ENABLE, $MainGUI)
	GUIDelete($hGUI)
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Local $tinfo
	Switch $hWndFrom
		Case $hStatus
			Switch $iCode
				Case $NM_CLICK ; The user has clicked the left mouse button within the control
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd(DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					_DebugPrint("$NM_CLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tinfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_DBLCLK ; The user has double-clicked the left mouse button within the control
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd(DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					_DebugPrint("$NM_DBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tinfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_RCLICK ; The user has clicked the right mouse button within the control
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd(DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					_DebugPrint("$NM_RCLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tinfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_RDBLCLK ; The user has double-clicked the right mouse button within the control
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd(DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					_DebugPrint("$NM_RDBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tinfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $SBN_SIMPLEMODECHANGE ; Simple mode changes
					_DebugPrint("$SBN_SIMPLEMODECHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; No return value
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_text, $line = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @CRLF & _
			"+======================================================" & @CRLF & _
			"-->Line(" & StringFormat("%04d", $line) & "):" & @TAB & $s_text & @CRLF & _
			"+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint

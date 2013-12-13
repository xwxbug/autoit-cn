#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $iMemo

Example()

Func Example()
	Local $hGUI, $hStatus
	Local $aParts[4] = [75, 150, 300, 400]

	; Create GUI
	$hGUI = GUICreate("(Example 2) StatusBar Get Icon", 400, 300)
	$hStatus = _GUICtrlStatusBar_Create($hGUI)

	; Create memo control
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 274, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; Set parts
	_GUICtrlStatusBar_SetParts($hStatus, $aParts)
	_GUICtrlStatusBar_SetText($hStatus, "Part 1")
	_GUICtrlStatusBar_SetText($hStatus, "Part 2", 1)

	; Set icons
	_GUICtrlStatusBar_SetIcon($hStatus, 0, 23, "shell32.dll")
	_GUICtrlStatusBar_SetIcon($hStatus, 1, 40, "shell32.dll")

	; Show icon handles
	MemoWrite("Part 1 icon handle .: 0x" & Hex(_GUICtrlStatusBar_GetIcon($hStatus, 0)))
	MemoWrite("Part 2 icon handle .: 0x" & Hex(_GUICtrlStatusBar_GetIcon($hStatus, 1)))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>
Global $hToolTip, $aPos, $hAdd
; Press g to display the current tooltip information.
HotKeySet("g", "GetInfo")
Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iAdd = GUICtrlCreateButton("Button ToolTip", 30, 32, 130, 28)
	$hAdd = GUICtrlGetHandle($iAdd)

	$hToolTip = _GUIToolTip_Create($hGUI, $TTS_CLOSE + $TTS_BALLOON)

	_GUIToolTip_AddTool($hToolTip, 0, "X: " &@TAB & " Y: " & @TAB, $hAdd)

	Local $hIcon = _WinAPI_LoadShell32Icon(15)

	_GUIToolTip_SetTitle($hToolTip, 'Title', $hIcon)
	GUISetState()
	$aPos = MouseGetPos()
	_GUIToolTip_TrackPosition($hToolTip, $aPos[0] + 10, $aPos[1] + 20)
	_GUIToolTip_TrackActivate($hToolTip, True, 0, $hAdd)
	_GUIToolTip_UpdateTipText($hToolTip, 0, $hAdd, "X: " & $aPos[0] & " Y: " & $aPos[1])
	While 1
		Sleep(10)
		$aPos = MouseGetPos()
		_GUIToolTip_TrackPosition($hToolTip, $aPos[0] + 10, $aPos[1] + 20)
		_GUIToolTip_UpdateTipText($hToolTip, 0, $hAdd, "X: " & $aPos[0] & " Y: " & $aPos[1])
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	_GUIToolTip_Destroy($hToolTip)
EndFunc   ;==>Example
Func GetInfo()
	$aTool = _GUIToolTip_HitTest($hToolTip, $hAdd, $aPos[0], $aPos[1])
	MsgBox($MB_SYSTEMMODAL, "Tooltip info", "Flags: " & @TAB & _GUIToolTip_BitsToTTF($aTool[0]) & @CRLF & _
			"HWnd: " & @TAB & $aTool[1] & @CRLF & _
			"ID: " & @TAB & $aTool[2] & @CRLF & _
			"Left X:" & @TAB & $aTool[3] & @CRLF & _
			"Left Y:" & @TAB & $aTool[4] & @CRLF & _
			"Right X:" & @TAB & $aTool[5] & @CRLF & _
			"Right Y:" & @TAB & $aTool[6] & @CRLF & _
			"Instance:" & @TAB & $aTool[7] & @CRLF & _
			"Text:" & @TAB & $aTool[8] & @CRLF & _
			"lParam:" & @TAB & $aTool[9])
EndFunc   ;==>GetInfo
#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iButton = GUICtrlCreateButton(" Button ", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)

	Local $hToolTip = _GUIToolTip_Create($hGUI, BitOr($_TT_ghTTDefaultStyle, $TTS_BALLOON))

	_GUIToolTip_AddTool($hToolTip, 0, " ", $hButton)


	_GUIToolTip_SetTitle($hToolTip, 'Mouse position', $TTI_INFO)
	GUISetState()
    ; Find the mouse's position to use as the starting point for tracking
	Local $aPos = MouseGetPos()
	_GUIToolTip_TrackPosition($hToolTip, $aPos[0], $aPos[1])
	_GUIToolTip_TrackActivate($hToolTip, True, 0, $hButton)
	Local $Display = True, $msg

While 1
        ; Read the mouse position
		$aPos = MouseGetPos()
        ; Use the position of the mouse to set the location of the tooltip
		_GUIToolTip_TrackPosition($hToolTip, $aPos[0], $aPos[1])
		_GUIToolTip_UpdateTipText($hToolTip, 0, $hButton, "X: " & $aPos[0] & " Y: " & $aPos[1])
		$msg = GUIGetMsg()
		Switch $msg
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example

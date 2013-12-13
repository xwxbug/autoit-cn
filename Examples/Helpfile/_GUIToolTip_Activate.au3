#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iToggleTips = GUICtrlCreateButton("Tips: On", 30, 32, 180, 28)
	Local $hToggleTips = GUICtrlGetHandle($iToggleTips)
	; create a tooltip control using the balloon style
	Local $hToolTip = _GUIToolTip_Create(0, $TTS_BALLOON)

    ; add a tool to the tooltip control using the default settings.
    _GUIToolTip_AddTool($hToolTip, 0, "Tooltip for the GUI", $hGUI)
    ; add a tool to the tooltip control centering the tip below the button instead of above the mouse pointer
	_GUIToolTip_AddTool($hToolTip, 0, "This button toggles the tooltips on and off", $hToggleTips, 0, 0, 0, 0, BitOR($TTF_CENTERTIP, $TTF_SUBCLASS, $TTF_IDISHWND))
	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $iToggleTips
				$fActivate = Not $fActivate
				If $fActivate Then
					_GUIToolTip_Activate($hToolTip)
                    GUICtrlSetData($iToggleTips, 'Tips: On')
				Else
					_GUIToolTip_Deactivate($hToolTip)
                    GUICtrlSetData($iToggleTips, 'Tips: Off')
				EndIf

			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

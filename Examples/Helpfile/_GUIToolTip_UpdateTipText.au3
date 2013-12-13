#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iButton = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)

	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI)

	; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "Click this to change tooltip text", $hButton)
	GUISetState()
	$New = False
	While 1
		Switch GUIGetMsg()
			Case $iButton ; Press the button to change the text of the tooltip
				$New = Not $New
				If $New Then
					_GUIToolTip_UpdateTipText($hToolTip, 0, $hButton, 'New text')
				Else
					_GUIToolTip_UpdateTipText($hToolTip, 0, $hButton, "Click this to change tooltip text")
				EndIf
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>
Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iButton = GUICtrlCreateButton("This is a button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)
    ; create a tooltip control using default settings
	Local $hToolTip = _GUIToolTip_Create(0)

    ; add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is a ToolTip", $hButton)
    _GUIToolTip_TrackActivate($hToolTip, True, 0, $hButton)
	GUISetState()
    ; Display the height of the tooltip bubble in pixels
    MsgBox($MB_SYSTEMMODAL, "Info", "Bubble Width = " & _GUIToolTip_GetBubbleWidth($hToolTip, 0, $hButton) & " Pixels")

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

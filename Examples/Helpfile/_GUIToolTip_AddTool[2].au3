#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <StaticConstants.au3>
; This example demonstrates how to add a tool, it does not assign the tool to any control, just an area of the GUI
Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)
    ; create a frame to indicate where the tooltip will display when the mouse is in the
    ; correct location on the GUI, this frame does not have a tooltip assigned to it
    ; this frame is ONLY for visual representation as to where the tooltip will display,
    ; it is not needed to make the tooltip display.
    GUICtrlCreateLabel("", 10, 10, 300, 150, $SS_GRAYRECT)
    ; this label control must be disabled or the tooltip will not display when the mouse
    ; is over it.
    GUICtrlSetState(-1, $GUI_DISABLE)
	Local $iButton = GUICtrlCreateButton("This is a button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)
    ; create a tooltip control using default settings
	Local $hToolTip = _GUIToolTip_Create(0)

    ; add 4 tools to the tooltip control, these tools are created using the location on the GUI
    ; rather than assigning them to a specific control.
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Upper Left corner", 0, 10, 10, 160, 85, $TTF_SUBCLASS)
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Upper Right corner", 1, 161, 10, 300, 85, $TTF_SUBCLASS)
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Bottom Left corner", 0, 10, 86, 160, 160, $TTF_SUBCLASS)
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Bottom Right corner", 0, 160, 86, 300, 160, $TTF_SUBCLASS)
    ; add a tool to the tooltip control that is assigned to the button control
    _GUIToolTip_AddTool($hToolTip, 0, "This tooltip belongs to the button", $hButton)
	GUISetState()

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

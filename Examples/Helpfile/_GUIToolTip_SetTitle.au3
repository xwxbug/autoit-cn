#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iAdd = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hAdd = GUICtrlGetHandle($iAdd)

	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI)

	; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hAdd)

	; Set the title of the tooltip
	_GUIToolTip_SetTitle($hToolTip, 'This is the ToolTip title', $TTI_INFO)

	GUISetState()

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

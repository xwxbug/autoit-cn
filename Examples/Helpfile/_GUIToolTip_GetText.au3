#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iButton = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)

	Local $hToolTip = _GUIToolTip_Create($hGUI)

	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hButton)

	GUISetState()
    ; Retrieve the text of the tool
	MsgBox($MB_SYSTEMMODAL, 'Message', _GUIToolTip_GetText($hToolTip, 0, $hButton))

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iButton = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)

    ; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI, $TTS_BALLOON)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hToolTip, "wstr", 0, "wstr", 0)

    ; Change the color settings for the tooltip, color setting is a COLORREF (BGR) value.
	_GUIToolTip_SetTipBkColor($hToolTip, 0x395A00)
	_GUIToolTip_SetTipTextColor($hToolTip, 0x1EBFFF)

    ; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hButton)
	GUISetState()

    ; Retrieve the background color of the tooltip.
	MsgBox($MB_SYSTEMMODAL, 'Message', 'Background color : 0x' & Hex(_GUIToolTip_GetTipBkColor($hToolTip), 6))

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

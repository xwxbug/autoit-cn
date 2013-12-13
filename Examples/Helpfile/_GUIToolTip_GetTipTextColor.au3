#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iAdd = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hAdd = GUICtrlGetHandle($iAdd)

    ; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI, $TTS_BALLOON)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hToolTip, "wstr", 0, "wstr", 0)

    ; Change the color settings for the tooltip
    ; The color value used in the _GUIToolTip_SetTipBkColor function is a COLORREF (BGR) value
	_GUIToolTip_SetTipBkColor($hToolTip, 0x395A00)
    ; The color value used in the _GUIToolTip_SetTipTextColor function is a COLORREF (BGR) value
	_GUIToolTip_SetTipTextColor($hToolTip, 0x1EBFFF)

    ; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hAdd)
	GUISetState()

    ; Retrieve the text color of the tooltip.
	MsgBox($MB_SYSTEMMODAL, 'Message', 'Text color : 0x' & Hex(_GUIToolTip_GetTipTextColor($hToolTip), 6))

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

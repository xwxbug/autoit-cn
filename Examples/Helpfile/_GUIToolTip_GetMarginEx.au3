#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iButton = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)
	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI, BitOR($_TT_ghTTDefaultStyle, $TTS_BALLOON))

	; If using a Windows theme setting, this will disable that for the tooltip displayed, so you can change
	; the margin settings. If you don't do this, the margins won't appear any different
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hToolTip, "wstr", 0, "wstr", 0)

	; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hButton)
	; Manually set the margins of the tooltip instead of using default settings.
	_GUIToolTip_SetMargin($hToolTip, 30, 10, 20, 12)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hToolTip, "wstr", 0, "wstr", 0)

	; Retrieve the margin settings of the tooltip
	Local $tRect = _GUIToolTip_GetMarginEx($hToolTip)
	GUISetState()
	MsgBox($MB_SYSTEMMODAL, 'Message', _
			'Left :' & @TAB & DllStructGetData($tRect, "Left") & @LF & _
			'Top :' & @TAB & DllStructGetData($tRect, "Top") & @LF & _
			'Right :' & @TAB & DllStructGetData($tRect, "Right") & @LF & _
			'Bottom :' & @TAB & DllStructGetData($tRect, "Bottom"))
	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

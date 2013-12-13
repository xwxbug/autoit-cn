#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 270, 200)

	Local $iAdd = GUICtrlCreateButton("Get Count 1", 30, 32, 75, 25)
	Local $hAdd = GUICtrlGetHandle($iAdd)
	Local $iClear = GUICtrlCreateButton("Get Count 2", 30, 72, 75, 25)
	Local $hClear = GUICtrlGetHandle($iClear)
	Local $iMylist = GUICtrlCreateList("Item 1", 120, 32, 121, 97)
	Local $hMylist = GUICtrlGetHandle($iMylist)
	Local $iClose = GUICtrlCreateButton("Exit button", 80, 150, 110, 28)
	Local $hClose = GUICtrlGetHandle($iClose)

	; Create 2 tooltip controls
	Local $hToolTip1 = _GUIToolTip_Create(0, BitOR($_TT_ghTTDefaultStyle, $TTS_BALLOON) ); balloon style tooltip
	Local $hToolTip2 = _GUIToolTip_Create(0) ; default style tooltip
	_GUIToolTip_SetMaxTipWidth($hToolTip2, 100) ; this allows multiline tooltips to be used with $hToolTip2
	; add tools to the tooltip controls
    ; 3 tools for $hToolTip1
	_GUIToolTip_AddTool($hToolTip1, 0, "Click to display the # of tools assigned to $hToolTip1", $hAdd)
	_GUIToolTip_AddTool($hToolTip1, 0, "Exit the script", $hClose)
	_GUIToolTip_AddTool($hToolTip1, 0, "The listbox", $hMylist)
	; 2 tools for $hToolTip2
    _GUIToolTip_AddTool($hToolTip2, 0, "Click to display the # of tools assigned to $hToolTip2", $hClear)
	_GUIToolTip_AddTool($hToolTip2, 0, "Multiline tooltip" & @CRLF & "for the GUI", $hGUI) ; Multiline ToolTip
	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $iAdd
				MsgBox($MB_SYSTEMMODAL, "Tool count", "Number of tools:" & @TAB & _GUIToolTip_GetToolCount($hToolTip1))
			Case $iClear
				MsgBox($MB_SYSTEMMODAL, "Tool count", "Number of tools:" & @TAB & _GUIToolTip_GetToolCount($hToolTip2))
			Case $iClose, $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	; Destroy the tooltip controls
	_GUIToolTip_Destroy($hToolTip1)
	_GUIToolTip_Destroy($hToolTip2)
    GUIDelete($hGUI)
EndFunc   ;==>Example
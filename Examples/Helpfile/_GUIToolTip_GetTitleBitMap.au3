#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>
Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

	Local $iButton = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($iButton)

	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI)

	; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hButton)

	Local $hIcon = _WinAPI_LoadShell32Icon(15)

	; Set the title of the tooltip
	_GUIToolTip_SetTitle($hToolTip, 'This is the Title Text', $hIcon)

	GUISetState()

	While 1
        $msg = GUIGetMsg()
        Switch $msg
            Case $GUI_EVENT_CLOSE
                ExitLoop
            Case $iButton
                MsgBox($MB_SYSTEMMODAL, "Title Bitmap", _GUIToolTip_GetTitleBitMap($hToolTip))
        EndSwitch
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example

#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
    Local $hGUI = GUICreate(StringTrimRight(@ScriptName, 4), 350, 200)

    Local $iButton = GUICtrlCreateButton("ToolTip showing", 30, 32, 130, 28)
    Local $hButton = GUICtrlGetHandle($iButton)

    Local $hToolTip = _GUIToolTip_Create($hGUI, BitOR($_TT_ghTTDefaultStyle, $TTS_BALLOON))
    _GUIToolTip_AddTool($hToolTip, 0, " ", $hButton)
    GUISetState()

    _GUIToolTip_TrackActivate($hToolTip, True, 0, $hButton)
    Local $Msg, $Display = True
    $hTimer = TimerInit()
    While 1
        Sleep(10)
        Local $aMousePos = MouseGetPos()
        _GUIToolTip_TrackPosition($hToolTip, $aMousePos[0] + 10, $aMousePos[1] + 20)
        _GUIToolTip_UpdateTipText($hToolTip, 0, $hButton, "X: " & $aMousePos[0] & " Y: " & $aMousePos[1])
        $Msg = GUIGetMsg()
        Switch $Msg
            Case $GUI_EVENT_CLOSE
                ExitLoop
        EndSwitch
        ; Every 8 seconds the tooltip will be "popped" in or out of view
        ; to get it to display after the 8 seconds has passed, you have to hover
        ; over the button.
        If TimerDiff($hTimer) > 8000 Then
            $Display = Not $Display
            $hTimer = TimerInit()
            If $Display Then
                GUICtrlSetData($iButton, "ToolTip showing")
                _GUIToolTip_PopUp($hToolTip)
            Else
                GUICtrlSetData($iButton, "Hover here now")
                _GUIToolTip_Pop($hToolTip)
            EndIf
        EndIf
    WEnd
    ; Destroy the tooltip control
    _GUIToolTip_Destroy($hToolTip)
    GUIDelete($hGUI)
EndFunc   ;==>Example
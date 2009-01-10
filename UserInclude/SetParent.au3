#cs ----------------------------------------------------------------------------
    
    AutoIt Version: 3.2.4.9
    Author:         Senton-Bomb
    
        $TitleP: The title of the parent window
        $TitleC: The title of the child window
        
        If a window doesn't exist, It returns -1, otherwise it returns 1
    
    Script Function:
    Wrapper for the "SetParent" dllcall + Example.
    
#ce ----------------------------------------------------------------------------

; Script Stizzle - Add your codeizzle

Func _SetParent($TitleP, $TitleC)
    If WinExists($TitleP) Then
        If WinExists($TitleC) Then
            $HwndP = WinGetHandle($TitleP)
            $HwndC = WinGetHandle($TitleC)
            $user32 = DllOpen("user32.dll")
            DllCall($user32, "str", "SetParent", "HWnd", $HwndP, "HWnd", $HwndC)
            Return 1
        Else
            Return -1
        EndIf
    Else
        Return -1
    EndIf
EndFunc   ;==>_SetParent
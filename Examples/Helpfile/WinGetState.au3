Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the state of the Notepad window using the handle returned by WinWait.
	Local $iState = WinGetState($hWnd)

	; Check if the Notepad window is minimized and display the appropriate message box.
	If BitAND($iState, 16) Then
		MsgBox(4096, "", "Notepad is minimized and the state returned by WinGetState was - " & $iState)
	Else
		MsgBox(4096, "", "Notepad isn't minimized and the state returned by WinGetState was - " & $iState)
	EndIf

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example

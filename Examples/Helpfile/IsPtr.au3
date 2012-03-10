Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Test if $hWnd is a valid pointer and display the results.
	If IsPtr($hWnd) Then
		MsgBox(4096, "", "It's a valid Ptr")
	Else
		MsgBox(4096, "", "It's not a valid Ptr")
	EndIf

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example

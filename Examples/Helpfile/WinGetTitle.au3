Example()

Func Example()
	; Retrieve the window title of the active window.
	Local $sText = WinGetTitle("[ACTIVE]")

	; Display the window title.
	MsgBox(4096, "", $sText)
EndFunc   ;==>Example

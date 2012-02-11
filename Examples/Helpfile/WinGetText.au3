Example()

Func Example()
	; Retrieve the window text of the active window.
	Local $sText = WinGetText("[ACTIVE]")

	; Display the window text.
	MsgBox(4096, "", $sText)
EndFunc   ;==>Example
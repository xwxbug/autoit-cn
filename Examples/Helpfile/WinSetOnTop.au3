Example()

Func Example()
	; Retrieve the handle of the active window.
	Local $hWnd = WinGetHandle("[ACTIVE]")

	; Set the active window as being ontop using the handle returned by WinGetHandle.
	WinSetOnTop($hWnd, "", 1)

	; Wait for 2 seconds to display the change.
	Sleep(2000)

	; Remove the "topmost" state from the active window.
	WinSetOnTop($hWnd, "", 0)
EndFunc   ;==>Example

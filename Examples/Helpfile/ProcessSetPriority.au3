Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; 设置记事本的优先级为：空闲/低
	ProcessSetPriority("notepad.exe", 0)

	; Wait for 2 seconds.
	Sleep(2000)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example


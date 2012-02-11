Example()

Func Example()
	; Execute Notepad and wait for the Notepad process to close.
	Local $iReturn = ShellExecuteWait("notepad.exe")

	; Display the return code of the Notepad process.
	MsgBox(4096, "", "The return code from Notepad was: " & $iReturn)
EndFunc   ;==>Example

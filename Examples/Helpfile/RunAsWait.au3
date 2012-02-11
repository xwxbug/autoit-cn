Example()

Func Example()
	; Change the username and password to the appropriate values for your system.
	Local $sUserName = "Username"
	Local $sPassword = "Password"

	; Run Notepad and wait for the Notepad process to close. Notepad is run under the user previously specified.
	Local $iReturn = RunAsWait($sUserName, @ComputerName, $sPassword, 0, "notepad.exe")

	; Display the return code of the Notepad process.
	MsgBox(4096, "", "The return code from Notepad was: " & $iReturn)
EndFunc   ;==>Example


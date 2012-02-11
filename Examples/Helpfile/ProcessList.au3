Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Display a list of Notepad processes returned by ProcessList.
	Local $aProcessList = ProcessList("notepad.exe")
	For $i = 1 To $aProcessList[0][0]
		MsgBox(4096, $aProcessList[$i][0], "PID: " & $aProcessList[$i][1])
	Next

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example

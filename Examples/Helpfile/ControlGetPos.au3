Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the position x, y and size (width and height) of the edit control in Notepad. The handle returned by WinWait is used for the "title" parameter of ControlGetPos.
	Local $aPos = ControlGetPos($hWnd, "", "Edit1")

	; Display the position and size of the edit control.
	MsgBox(4096, "窗口状态:", "坐标: " & $aPos[0] & "," & $aPos[1] & @CRLF & "大小: " & $aPos[2] & "," & $aPos[3] )

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example

Run("notepad.exe")
Local $hWnd = WinGetHandle("[CLASS:Notepad]")
If IsHWnd($hWnd) Then
	MsgBox(4096, "", "It's a valid HWND")
Else
	MsgBox(4096, "", "It's not an HWND")
EndIf

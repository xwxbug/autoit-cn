Local $pos = WinGetPos("[CLASS:Notepad]")
If IsArray($pos) Then
	MsgBox(0, "´°¿Ú¿í¶È", $pos[3])
EndIf

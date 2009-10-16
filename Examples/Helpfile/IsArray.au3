$pos = WinGetPos("[CLASS:Notepad]")
If IsArray($pos) Then
	MsgBox(0, "窗口宽度", $pos[3])
EndIf

$pos = WinGetPos("无标题")
If IsArray($pos) Then
	MsgBox(0, "窗口宽度", $pos[3])
EndIf

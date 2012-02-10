Local $sDefault = Default
If IsKeyword($sDefault) Then
	MsgBox(4096,"嗯", "它的确是一个关键字")
Else
	MsgBox(4096, "擦", "这变量不是一个关键字")
EndIf

Local $result = myDiv(5, 0)
If @error Then
	MsgBox(4096,"错误", "除数为 0")
Else
	MsgBox(4096, "结果", $result)
EndIf
Exit

Func myDiv($dividend, $divisor)
	If $dividend = 0 And $divisor = 0 Then
		SetError(2) ;表达式为 0/0
	ElseIf $divisor = 0 Then
		SetError(1) ;除数为 0
	EndIf
	Return $dividend / $divisor
EndFunc   ;==>myDiv

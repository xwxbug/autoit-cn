Local $iResult = myDiv(5, 0)
If @error Then
	MsgBox(4096,"错误", "除数为 0")
Else
	MsgBox(4096, "结果", $iResult)
EndIf
Exit

Func myDiv($iDividend, $iDivisor)
	If $iDividend = 0 And $iDivisor = 0 Then
		SetError(2) ;表达式为 0/0
	ElseIf $iDivisor = 0 Then
		SetError(1) ;除数为 0
	EndIf
	Return $iDividend / $iDivisor
EndFunc   ;==>myDiv

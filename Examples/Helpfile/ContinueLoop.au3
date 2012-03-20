Example_1(); 示例 1 显示从 1 到 10 中除了 7 以外的所有数字
Example_2(); 示例 2 显示从 1 到 10 中除了 3 和 7 以外的所有数字

Func Example_1()
	Local $Number = ''
	For $i = 1 To 10
		If $i = 7 Then ContinueLoop
		$Number = $Number & "[" & $i & "]"
	Next
	MsgBox(4096, "提示", "显示从 1 到 10 中除了 7 以外的所有数字：" & @CRLF & $Number)
EndFunc   ;==>Example_1

Func Example_2()
	Local $Number = ''
	For $i = 1 To 10
		If $i = 3 Or $i = 7 Then ContinueLoop
		$Number = $Number & "[" & $i & "]"
	Next
	MsgBox(4096, "提示", "显示从 1 到 10 中除了 3 和 7 以外的所有数字：" & @CRLF & $Number)
EndFunc   ;==>Example_2

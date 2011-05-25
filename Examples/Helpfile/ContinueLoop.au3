;示例 1 显示从 1 到 10 中除了 7 以外的所有数字
For $i = 1 to 10
	If $i = 7 Then ContinueLoop
	MsgBox(0, "$i 的当前值为:", $i, 1)
Next

;示例 2 显示从 1 到 10 中除了 3 和 7 以外的所有数字
For $i = 1 to 10
	If $i = 3 Or $i = 7 Then ContinueLoop
	MsgBox(0, "$i 的当前值为:", $i, 1)
Next
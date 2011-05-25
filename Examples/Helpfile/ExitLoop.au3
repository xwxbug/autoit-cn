Local $sum = 0
While 1 ;除非调用 ExitLoop ,则无限循环
	Local $ans = InputBox("运行次数=" & $sum, _
		"	输入一个正数.  (负数将退出)")
	If $ans < 0 Then ExitLoop
	$sum = $sum + $ans
WEnd
MsgBox(0,"次数为:", $sum)

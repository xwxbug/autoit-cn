; 三个自定义函数的示例脚本
; 注意变量(variables), 传递(ByRef), 与 返回值(Return)的用法

$foo = 2
$bar = 5
msgBox(0,"今天是 " & today(), "$foo 等于:" & $foo)
swap($foo, $bar)
msgBox(0,"变量 $foo 和 $bar 交换后", "现在 $foo 的值是：" & $foo)
msgBox(0,"最后", "3 和 4 中较大的数是:" & max(3,4))
Exit

Func swap(ByRef $a, ByRef $b)  ;交换两个变量的内容
	Local $t
	$t = $a
	$a = $b
	$b = $t
EndFunc

Func today()  ;以 mm/dd/yyyy 的形式返回当前日期
	return (@MON & "/" & @MDAY & "/" & @YEAR)
EndFunc

Func max($x, $y)  ;返回两个数中的较大值
	If $x > $y Then
		return $x
	Else
		return $y
	EndIf
EndFunc

;示例脚本结束

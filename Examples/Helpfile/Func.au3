Opt('MustDeclareVars', 1)

Example1()
Example2()

; example1
Func Example1()
; Sample script with three user-defined functions
; Notice the use of variables, ByRef, and Return

Local $foo = 2
Local $bar = 5
msgBox(0,"今天是 " & today(), "$foo 等于:" & $foo)
swap($foo, $bar)
msgBox(0,"变量 $foo 和 $bar 交换后", "现在 $foo 的值是：" & $foo)
msgBox(0,"最后", "3 和 4 中较大的数是:" & max(3,4))
EndFunc   ;==>Example1

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

;End of sample script 1

; example2
Func Example2()
; Sample scriptusing @NumParams macro
	Test_Numparams(1,2,3,4,5,6,7,8,9,10,11,12,13,14)
EndFunc   ;==>Example2

Func Test_Numparams($v1 = 0, $v2 = 0, $v3 = 0, $v4 = 0, $v5 = 0, $v6 = 0, $v7 = 0, $v8 = 0, $v9 = 0, _
	$v10 = 0, $v11 = 0, $v12 = 0, $v13 = 0, $v14 = 0, $v15 = 0, $v16 = 0, $v17 = 0, $v18 = 0, $v19 = 0)
	Local $val
	For $i = 1 To @NumParams
		$val &= Eval("v" & $i) & " "
	Next
	MsgBox(0, "@NumParams example", "@NumParams =" & @NumParams & @CRLF & @CRLF & $val)
EndFunc
 
;End of sample script 2
 

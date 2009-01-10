; Sample script with three user-defined functions
; Notice the use of variables, ByRef, and Return

$foo = 2
$bar = 5
msgBox(0,"Today is " & today(), "$foo equals " & $foo)
swap($foo, $bar)
msgBox(0,"After swapping $foo and $bar", "$foo now contains " & $foo)
msgBox(0,"Finally", "The larger of 3 and 4 is " & max(3,4))
Exit

Func swap(ByRef $a, ByRef $b)  ;swap the contents of two variables
	Local $t
	$t = $a
	$a = $b
	$b = $t
EndFunc

Func today()  ;Return the current date in mm/dd/yyyy form
	return (@MON & "/" & @MDAY & "/" & @YEAR)
EndFunc

Func max($x, $y)  ;Return the larger of two numbers
	If $x > $y Then
		return $x
	Else
		return $y
	EndIf
EndFunc

;End of sample script

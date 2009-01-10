$n = 18
If mod($n, 2) = 0 Then
	MsgBox(0,"", $n & " is an even number.")
Else
	MsgBox(0, "", $n & " is an odd number.")
EndIf

$x = mod(4, 7)  ;$x == 4 because the divisor > dividend

$y = mod(1, 3/4)  ;$y == 0.25 because the divisor is a float

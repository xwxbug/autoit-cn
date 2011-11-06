#include <Math.au3>

;See if 3 is odd
$Odd = _IsOdd(3)
If $Odd == 1 Then
	$Odd = "yes"
Else
	$Odd = "no"
EndIf
;Display the value
MsgBox(0, "_IsOdd", "Is 3 odd?" & @CRLF & $Odd)

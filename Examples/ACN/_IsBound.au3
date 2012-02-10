#include <Math.au3>
;See if 3 is between 1 and 5
$Bound = _IsBound(3, 1, 5)
If $Bound == 1 Then
	$Bound = "yes"
Else
	$Bound = "no"
EndIf
;Display the value
MsgBox(0, "_IsBound", "Is 3 is between 1 and 5?" & @CRLF & $Bound)

#include <Math.au3>

;See if 3 is even
$Even=_IsEven(3)
If $Even == 1 Then
	$Even="yes"
Else
	$Even="no"
EndIf
;Display the value
MsgBox(0,"_IsEven","Is 3 even?"&@CRLF&$Even)
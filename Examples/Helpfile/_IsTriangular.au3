#include <Math.au3>

;See if 3 is triangular
$Triangular=_IsTriangular(3)
If $Triangular>1 Then
	$Triangular="yes"
Else
	$Triangular="no"
EndIf
;Display the value
MsgBox(0,"_IsTriangular","Is 3 triangular?"&@CRLF&$Triangular)
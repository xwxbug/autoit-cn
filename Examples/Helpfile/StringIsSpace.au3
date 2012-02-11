Local $x = "   " & @LF & Chr(11) & @TAB & " " & @CRLF
If StringIsSpace($x) Then
	MsgBox(4096, "", "String only contained whitespace characters.")
EndIf

Local $encoding = FileGetEncoding("c:\boot.ini")
If @error Then
	MsgBox(4096, "Error", "Could not obtain encoding.")
	Exit
Else
	MsgBox(4096, "", "File encoding is " & $encoding)
EndIf

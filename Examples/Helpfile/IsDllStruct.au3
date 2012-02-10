Local $tStruct = DllStructCreate("wchar[256]")
If IsDllStruct($tStruct) Then
	MsgBox(4096, "", "The variable is a dll structure")
Else
	MsgBox(4096, "", "The variable is not a dll structure")
EndIf

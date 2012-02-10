Local $oShell = ObjCreate("shell.application")
If IsObj($oShell) Then
	MsgBox(4096,"","变量是一个对象")
Else
	MsgBox(4096,"","变量不是一个对象.")
EndIf

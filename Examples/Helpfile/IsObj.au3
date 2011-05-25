Local $oShell = ObjCreate("shell.application")
If Not IsObj($oShell) Then
	MsgBox(0,"错误","$oShell 不是一个对象.")
Else
	MsgBox(0,"成功","成功创建对象 $oShell.")
EndIf

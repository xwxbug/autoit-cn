Opt("OnExitFunc", "endscript")
MsgBox(0,"","first statement")

Func endscript()
	MsgBox(0,"","after last statement " & @EXITMETHOD)
EndFunc

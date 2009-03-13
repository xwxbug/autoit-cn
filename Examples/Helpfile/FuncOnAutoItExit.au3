Opt("OnExitFunc", "endscript")
MsgBox(0,"","程序中的第一个语句")

Func endscript()
	MsgBox(0,"","程序中的最后一个语句,程序退出方式: " & @EXITMETHOD)
EndFunc

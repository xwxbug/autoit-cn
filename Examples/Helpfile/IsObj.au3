$oShell = ObjCreate("shell.application")
if not IsObj($oShell) then
	Msgbox(0,"错误","$oShell 不是一个对象.")
else
	Msgbox(0,"成功","成功创建对象 $oShell.")
endif

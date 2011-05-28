AdlibRegister("MyAdlib")
;...
AdlibUnRegister("MyAdlib")

Func MyAdlib()
	;... 运行中尽量避免使用带有等待效果的函数, 例如 Wait(), MsgBox(), InputBox()等...
	;... 那样会导致整个程序中断.
EndFunc   ;==>MyAdlib

; 注册一个名称为 MyAdlib 的 Adlib 函数
AdlibRegister("MyAdlib")

; 取消注册一个名称为 MyAdlib 的 Adlib 函数
AdlibUnRegister("MyAdlib")

Func MyAdlib()
	; 尽量避免使用等待效果的函数, 例如 Wait(), MsgBox(), InputBox()等，那样会导致整个程序中断.
EndFunc   ;==>MyAdlib

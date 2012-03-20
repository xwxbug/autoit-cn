; 注册一个名称为 MyAdlib 的 Adlib 函数
AdlibRegister("MyAdlib")

Exit

Func MyAdlib()
	; 尽量避免使用等待效果的函数, 例如 Wait(), MsgBox(), InputBox()等，那样会导致整个程序中断.
	If WinActive("Error") Then
		; ...
	EndIf
EndFunc   ;==>MyAdlib

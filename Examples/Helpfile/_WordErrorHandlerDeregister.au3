; *******************************************************
; 示例 - 注册然后注销一个用户错误句柄.
; *******************************************************
#include <Word.au3>
; 注册一个用户错误句柄
_WordErrorHandlerRegister(" MyErrFunc ")
; 其他操作
; 注销用户错误句柄
_WordErrorHandlerDeregister()
; 其他操作

Exit

Func MyErrFunc()
	$HexNumber = Hex($oWordErrorHandler.number, 8)
	MsgBox(0, "", "We intercepted a COM Error !" & @CRLF & _
			" Number is:" & $HexNumber & @CRLF & _
			" Windescription is:" & $oWordErrorHandler.windescript)
	SetError(1) ; 函数返回时检查
endfunc   ;==>MyErrFunc


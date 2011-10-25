; *******************************************************
; 示例 - 注册一个自定义错误句柄, 稍后注销
; *******************************************************
#include  <IE.au3>
; 注册一个自定义错误句柄
_IEErrorHandlerRegister(" MyErrFunc ")
; 做些什么
; 注销自定义错误句柄
_IEErrorHandlerDeregister()
; 另外做些什么

Exit

Func MyErrFunc()
	$HexNumber = Hex($oIEErrorHandler .number, 8)
	MsgBox(0, "", "We intercepted a COM Error !" & @CRLF & _
			" Number is:" & $HexNumber & @CRLF
	" Windescription is:" & $oIEErrorHandler .windescription)
	SetError(1) ; 函数返回时检查
endfunc   ;==>MyErrFunc


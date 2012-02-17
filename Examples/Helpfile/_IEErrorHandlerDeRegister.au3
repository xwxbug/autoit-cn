; *******************************************************
; 示例 1 - 注册并在后来取消注册自定义错误处理程序
; *******************************************************

#include <IE.au3>

; 注册自定义错误处理程序
_IEErrorHandlerRegister("MyErrFunc")
; 执行一些操作
; 取消注册自定义错误处理程序
_IEErrorHandlerDeRegister()
; 执行其他操作

Exit

Func MyErrFunc()
	Local $HexNumber = Hex($oIEErrorHandler.number, 8)
	MsgBox(4096, "", "We intercepted a COM Error !" & @CRLF & _
			"Number is: " & $HexNumber & @CRLF & _
			"Windescription is: " & $oIEErrorHandler.windescription)
	SetError(1) ; 当此函数返回时用来检查的一些信息
EndFunc   ;==>MyErrFunc

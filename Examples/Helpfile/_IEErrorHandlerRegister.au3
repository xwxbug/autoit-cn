; *******************************************************
; 示例 1 - 注册并在后来取消注册自定义和默认 IE.au3 错误处理程序
; *******************************************************

#include <IE.au3>

; 注册自定义错误处理程序
_IEErrorHandlerRegister("MyErrFunc")
; 执行一些操作
; 取消注册自定义错误处理程序
_IEErrorHandlerDeRegister()
; 执行其他操作
; 注册默认 IE.au3 COM 错误处理程序
_IEErrorHandlerRegister()
; 执行更多操作

Exit

Func MyErrFunc()
	; 重要提示: 错误对象变量名称必须为 $oIEErrorHandler
	Local $ErrorScriptline = $oIEErrorHandler.scriptline
	Local $ErrorNumber = $oIEErrorHandler.number
	Local $ErrorNumberHex = Hex($oIEErrorHandler.number, 8)
	Local $ErrorDescription = StringStripWS($oIEErrorHandler.description, 2)
	Local $ErrorWinDescription = StringStripWS($oIEErrorHandler.WinDescription, 2)
	Local $ErrorSource = $oIEErrorHandler.Source
	Local $ErrorHelpFile = $oIEErrorHandler.HelpFile
	Local $ErrorHelpContext = $oIEErrorHandler.HelpContext
	Local $ErrorLastDllError = $oIEErrorHandler.LastDllError
	Local $ErrorOutput = ""
	$ErrorOutput &= "--> COM Error Encountered in " & @ScriptName & @CR
	$ErrorOutput &= "----> $ErrorScriptline = " & $ErrorScriptline & @CR
	$ErrorOutput &= "----> $ErrorNumberHex = " & $ErrorNumberHex & @CR
	$ErrorOutput &= "----> $ErrorNumber = " & $ErrorNumber & @CR
	$ErrorOutput &= "----> $ErrorWinDescription = " & $ErrorWinDescription & @CR
	$ErrorOutput &= "----> $ErrorDescription = " & $ErrorDescription & @CR
	$ErrorOutput &= "----> $ErrorSource = " & $ErrorSource & @CR
	$ErrorOutput &= "----> $ErrorHelpFile = " & $ErrorHelpFile & @CR
	$ErrorOutput &= "----> $ErrorHelpContext = " & $ErrorHelpContext & @CR
	$ErrorOutput &= "----> $ErrorLastDllError = " & $ErrorLastDllError
	MsgBox(4096, "COM Error", $ErrorOutput)
	SetError(1)
	Return
EndFunc   ;==>MyErrFunc

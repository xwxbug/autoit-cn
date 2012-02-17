; *******************************************************
; 示例 1 - 注册并在后来注销自定义和默认 Word.au3 错误处理程序
; *******************************************************
;
#include <Word.au3>

; 注册自定义的错误句柄
_WordErrorHandlerRegister("MyErrFunc")
; 执行一些操作
; 注销自定义错误处理程序
_WordErrorHandlerDeRegister()
; 执行其他操作
; 注册默认 IE.au3 COM 错误处理程序
_WordErrorHandlerRegister()
; 执行更多操作

Exit

Func MyErrFunc()
	; 重要:错误对象变量必须命名为 $oWordErrorHandler
	Local $ErrorScriptline = $oWordErrorHandler.scriptline
	Local $ErrorNumber = $oWordErrorHandler.number
	Local $ErrorNumberHex = Hex($oWordErrorHandler.number, 8)
	Local $ErrorDescription = StringStripWS($oWordErrorHandler.description, 2)
	Local $ErrorWinDescription = StringStripWS($oWordErrorHandler.WinDescription, 2)
	Local $ErrorSource = $oWordErrorHandler.Source
	Local $ErrorHelpFile = $oWordErrorHandler.HelpFile
	Local $ErrorHelpContext = $oWordErrorHandler.HelpContext
	Local $ErrorLastDllError = $oWordErrorHandler.LastDllError
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
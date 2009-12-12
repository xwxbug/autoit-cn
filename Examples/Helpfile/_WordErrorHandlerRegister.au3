; *******************************************************
; Example 1 - Register and later deregister a custom and the default Word.au3 error handler
; *******************************************************
;
#include <Word.au3>
; 注册自定义的错误句柄
_WordErrorHandlerRegister ("MyErrFunc")
; Do something
; Deregister the customer error handler
_WordErrorHandlerDeregister ()
; Do something else
; Register the default IE.au3 COM Error Handler
_WordErrorHandlerRegister ()
; Do more work

Exit

Func MyErrFunc()
	;重要：错误对象变量必须命名为 $oWordErrorHandler
	$ErrorScriptline = $oWordErrorHandler.scriptline
	$ErrorNumber = $oWordErrorHandler.number
	$ErrorNumberHex = Hex($oWordErrorHandler.number, 8)
	$ErrorDescription = StringStripWS($oWordErrorHandler.description, 2)
	$ErrorWinDescription = StringStripWS($oWordErrorHandler.WinDescription, 2)
	$ErrorSource = $oWordErrorHandler.Source
	$ErrorHelpFile = $oWordErrorHandler.HelpFile
	$ErrorHelpContext = $oWordErrorHandler.HelpContext
	$ErrorLastDllError = $oWordErrorHandler.LastDllError
	$ErrorOutput = ""
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
	MsgBox(0, "COM Error", $ErrorOutput)
	SetError(1)
	Return
EndFunc   ;==>MyErrFunc
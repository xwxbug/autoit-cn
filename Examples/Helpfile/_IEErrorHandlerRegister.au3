
通过使用ObjEvent函数Autoit能够捕获COM错误并且把他们传递给一个定义的用户错误处理程序.对于UDF的作者会存在一个问题, 因为在同一时间只有一个COM错误处理程序可以被使用.当用户自定义函数(UDF) 要使用COM错误处理程序的时候, 必须首先注销用户错误处理程序, 安装UDF自己的错误处理程序然后把处理程序复原.不幸的是, 通常情况下, UDF没有办法取得用户错误处理程序的句柄.

在某种程度上你可以通过本函数注册你的COM错误处理程序, 这样当需要注册错误处理程序的时候IE.au3可以很好的用它来移除和复原.你可以使用你自己的错误处理程序或者使用IE.au3默认处理程序.使用默认的IE.au3错误处理程序, 你也可以从控制台得到一些很好的诊断信息并且默认的一些全局变量包含捕获到的错误信息.
如果你用默认的错误处理程序(__IEInternalErrorHandler), 下面这些全局变量可供你参考:
$IEComErrorNumber, $IEComErrorNumberHex, $IEComErrorDescription, $IEComErrorScriptline, $IEComErrorWinDescription, $IEComErrorSource, $IEComErrorHelpFile, $IEComErrorHelpContext, $IEComErrorLastDllError, $IEComErrorComObj和$IEComErrorOutput

你可以用_IEErrorNotify控制COM错误信息是否在控制台显示.

相关 _IEErrorHandlerDeRegister, _IEErrorNotify

示例
; *******************************************************
; 注册然后注销一个自定义和默认的IE.au3错误句柄
; *******************************************************
;
#include  <IE.au3>
; 注册一个自定义错误句柄
_IEErrorHandlerRegister(" MyErrFunc")
; 做些什么
; 注销自定义错误句柄
_IEErrorHandlerDeregister()
; 再做些什么
; 注册默认的IE.au3 COM错误句柄
_IEErrorHandlerRegister()
; 做更多

Exit

Func MyErrFunc()
	; 重要: 错误对象变量必须命名为$oIEErrorHandler
	$ErrorScriptline = $oIEErrorHandler .scriptline
	$ErrorNumber = $oIEErrorHandler .number
	$ErrorNumberHex = Hex($oIEErrorHandler .number, 8)
	$ErrorDescription = StringStripWS($oIEErrorHandler .description, 2)
	$ErrorWinDescription = StringStripWS($oIEErrorHandler .WinDescription, 2)
	$ErrorSource = $oIEErrorHandler .Source
	$ErrorHelpFile = $oIEErrorHandler .HelpFile
	$ErrorHelpContext = $oIEErrorHandler .HelpContext
	$ErrorLastDllError = $oIEErrorHandler .LastDllError
	$ErrorOutput = " "
	$ErrorOutput &= " --> COM Error Encountered in" & @ScriptName & @CR
	$ErrorOutput &= " ----> $ErrorScriptline =" & $ErrorScriptline & @CR
	$ErrorOutput &= " ----> $ErrorNumberHex =" & $ErrorNumberHex & @CR
	$ErrorOutput &= " ----> $ErrorNumber =" & $ErrorNumber & @CR
	$ErrorOutput &= " ----> $ErrorWinDescription =" & $ErrorWinDescription & @CR
	$ErrorOutput &= " ----> $ErrorDescription =" & $ErrorDescription & @CR
	$ErrorOutput &= " ----> $ErrorSource =" & $ErrorSource & @CR
	$ErrorOutput &= " ----> $ErrorHelpFile =" & $ErrorHelpFile & @CR
	$ErrorOutput &= " ----> $ErrorHelpContext =" & $ErrorHelpContext & @CR
	$ErrorOutput &= " ----> $ErrorLastDllError =" & $ErrorLastDllError
	MsgBox(0, "COM Error ", $ErrorOutput)
	SetError(1)
	Return
endfunc   ;==>MyErrFunc


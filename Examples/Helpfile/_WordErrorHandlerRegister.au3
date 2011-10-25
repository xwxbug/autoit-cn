
AutoIt 有能力捕获COM错误, 并通过使用ObjEvent函数传递自定义错误句柄. 这对于UDF的编写这是一个问题, 因为同一时间只能有一个COM错误句柄处于使用中. 对于使用COM错误句柄的UDF必须先将用户的句柄注销, 安装完自己的句柄之后再将用户句柄复位. 不幸的是, UDF默认无法再取得用户错误句柄.

你可以使用这一规则注册你的COM错误句柄，通过该方式Word.au3可被完美移除并在需要时重新释放.
你也可以指向你自己定义的或者一个为Word.au3(默认的) 开发的错误句柄. 使用默认的Word.au3错误句柄, 你可以获得一个被写入控制台的诊断信息和一些包含被拦截的错误的信息的全局变量.

如果你在实例化你自己的COM错误句柄时没有使用这一规则, Word.au3将无法拦截一些COM错误, 其结果将导致一些突然的脚本中断.


相关 _WordErrorHandlerDeRegister

示例

; *******************************************************
; 示例 - 注册一个自定义的和默认的Word.au3错误句柄，随后注销
; *******************************************************
#include <Word.au3>
; 注册自定义错误句柄
_WordErrorHandlerRegister(" MyErrFunc ")
; 做些什么
; 注销自定义错误句柄
_WordErrorHandlerDeregister()
; 再做些什么
; 注册默认的 IE.au3 COM 错误句柄
_WordErrorHandlerRegister()
; 多做些工作
Exit

Func MyErrFunc()
	; 重要: 错误对象变量必须命名为 $oWordErrorHandler
	$ErrorScriptline = $oWordErrorHandler.scriptline
	$ErrorNumber = $oWordErrorHandler.number
	$ErrorNumberHex = Hex($oWordErrorHandler.number, 8)
	$ErrorDescription = StringStripWS($oWordErrorHandler.description, 2)
	$ErrorWinDescription = StringStripWS($oWordErrorHandler.WinDescription, 2)
	$ErrorSource = $oWordErrorHandler.Source
	$ErrorHelpFile = $oWordErrorHandler.HelperFile
	$ErrorHelpContext = $oWordErrorHandler.HelpContext
	$ErrorLastDllError = $oWordErrorHandler.LastDllError
	$ErrorOutput = ""
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


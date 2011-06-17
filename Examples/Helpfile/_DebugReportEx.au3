#include <Debug.au3>

_DebugSetup()

_DebugReport("message1")

SomeUDF("anyfunction")
If @error Then _DebugReportEx("user32|anyfunction", True); 附加了最后的错误消息

Local $iRet = SomeUDF("CloseClipboard")
If @error Or $iRet = 0 Then _DebugReportEx("user32|CloseClipboard")

_DebugReport("message2")

$iRet = SomeUDF("CloseClipboard")
If @error Or $iRet = 0 Then _DebugReportEx("user32|CloseClipboard", False, True) ; 脚本将被终止

_DebugReport("message3") ; 将不会被报告

Func SomeUDF($func)
	Local $aResult = DllCall("user32.dll", "int", $func)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0]
EndFunc   ;==>SomeUDF

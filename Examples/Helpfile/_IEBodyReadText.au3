; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 准备好文本主体
;				(所有 HTML 标签被移除后的内容) 并显示在 MsgBox
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $sText = _IEBodyReadText($oIE)
MsgBox(4096, "Body Text", $sText)

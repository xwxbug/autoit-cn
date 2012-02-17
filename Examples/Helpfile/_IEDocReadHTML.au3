; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 读取 HTML document
;				(包括 <HEAD> 和脚本的所有 HTML) 并显示在 MsgBox
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $sHTML = _IEDocReadHTML($oIE)
MsgBox(4096, "Document Source", $sHTML)

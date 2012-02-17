; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 获取到
;				ID 为 "line1" 的 DIV 元素的对象引用. 显示此元素的 innerText
;				到控制台.
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $oDiv = _IEGetObjById($oIE, "line1")
ConsoleWrite(_IEPropertyGet($oDiv, "innertext") & @CRLF)

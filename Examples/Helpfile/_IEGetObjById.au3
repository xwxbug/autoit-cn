; *******************************************************
; 示例 - 打开基本示例的浏览器, 获取ID为"line1"的DIV元素的对象的引用.
;        并将该元素的innerText显示到控制台.
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $oDiv = _IEGetObjById($oIE, "line1")
ConsoleWrite(_IEPropertyGet($oDiv, "innertext") & @CRLF)

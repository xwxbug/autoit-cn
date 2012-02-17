; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 获取到
;				所有元素的集合并显示其中每个的 tagname 和 innerText
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $oElements = _IETagNameAllGetCollection($oIE)
For $oElement In $oElements
	MsgBox(4096, "Element Info", "Tagname: " & $oElement.tagname & @CR & "innerText: " & $oElement.innerText)
Next

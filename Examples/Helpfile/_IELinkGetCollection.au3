; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 获取链接集合,
;				循环其中的每项并显示关联的 URL 引用
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $oLinks = _IELinkGetCollection($oIE)
Local $iNumLinks = @extended
MsgBox(4096, "Link Info", $iNumLinks & " links found")
For $oLink In $oLinks
	MsgBox(4096, "Link Info", $oLink.href)
Next

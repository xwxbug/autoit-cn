; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 准备好 HTML 主体,
;				附加新的 HTML 代码到其中并写回浏览器中
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $sHTML = _IEBodyReadHTML($oIE)
$sHTML = $sHTML & "<p><font color=red size=+5>Big RED text!</font>"
_IEBodyWriteHTML($oIE, $sHTML)

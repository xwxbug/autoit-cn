; *******************************************************
; 示例 - 打开带有基本实例的浏览器, 准备HTML, 附加新的HTML到原始的并写回浏览器
; *******************************************************
#include <IE.au3>
$oIE = _IE_Example("basic")
$sHTML = _IEBodyReadHTML($oIE)
$sHTML = $sHTML & "<p><font color=red size=+5>Big RED text!</font>"
_IEBodyWriteHTML($oIE, $sHTML)


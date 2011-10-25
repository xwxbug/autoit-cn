; *******************************************************
; 示例 - 创建带有要显示的示例页的浏览器窗口.
;       返回的对象变量仅被用作由_IECreate或_IEAttach创建的对象变量
; *******************************************************
#include <IE.au3>
$oIE_basic = _IE_Example("basic")
$oIE_form = _IE_Example("form")
$oIE_table = _IE_Example("table")
$oIE_frameset = _IE_Example("frameset")
$oIE_iframe = _IE_Example("iframe")


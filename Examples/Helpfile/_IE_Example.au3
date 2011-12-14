; *******************************************************
; 示例 1 - 创建显示每种示例页面的浏览器窗口.
;				返回的对象变量可以像
;				_IECreate 或 _IEAttach 返回的对象变量一样使用
; *******************************************************

#include <IE.au3>

Local $oIE_basic = _IE_Example("basic")
Local $oIE_form = _IE_Example("form")
Local $oIE_table = _IE_Example("table")
Local $oIE_frameset = _IE_Example("frameset")
Local $oIE_iframe = _IE_Example("iframe")

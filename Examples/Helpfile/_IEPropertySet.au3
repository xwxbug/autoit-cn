; *******************************************************
; 示例 - 打开一个带示例的浏览器, 查看地址栏是否可见, 如果可见则关闭, 不可见则打开
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
If Not _IEPropertyGet($oIE, "statusbar") Then _IEPropertySet($oIE, "statusbar", True)
_IEPropertySet($oIE, "statustext", "Look What I can Do")
Sleep(1000)
_IEPropertySet($oIE, "statustext", "I can change the status text")

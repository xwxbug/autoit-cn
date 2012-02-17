; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 检查
;				地址栏是否可见, 如果没有则让其显示. 然后改变
;				状态栏中显示的文本
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
If Not _IEPropertyGet($oIE, "statusbar") Then _IEPropertySet($oIE, "statusbar", True)
_IEPropertySet($oIE, "statustext", "Look What I can Do")
Sleep(1000)
_IEPropertySet($oIE, "statustext", "I can change the status text")

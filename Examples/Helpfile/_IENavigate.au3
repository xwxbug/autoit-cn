; *******************************************************
; 示例 1 - 创建浏览器窗口并导航到某个站点,
;				等待 5 秒后导航到另一个
;				等待 5 秒后导航到另一个
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate("www.autoitscript.com")
Sleep(5000)
_IENavigate($oIE, "http://www.autoitscript.com/forum/index.php?")
Sleep(5000)
_IENavigate($oIE, "http://www.autoitscript.com/forum/index.php?showforum=9")

; *******************************************************
; 示例 2 - 创建浏览器窗口并导航到某个站点,
;				不等待页面加载结束就移到下一行
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("www.autoitscript.com", 0)
MsgBox(4096, "_IENavigate()", "This code executes immediately")

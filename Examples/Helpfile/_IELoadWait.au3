; *******************************************************
; 示例 1 - 打开 AutoIt 论坛页面, 使用 tab 到 "View new posts"
;				链接并用回车键激活.
;				然后在继续前等待页面加载结束.
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate("http://www.autoitscript.com/forum/index.php")
Send("{TAB 12}")
Send("{ENTER}")
_IELoadWait($oIE)

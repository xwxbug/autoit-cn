; *******************************************************
; 例 1 - 创建一个隐藏的浏览器窗口, 导航到一个
;				网站, 获取一些信息并退出
; *******************************************************
;
#include <IE.au3>
$oIE = _IECreate ("http://sourceforge.net", 0, 0)
; 显示这个页面中名称是"sfmarquee"元素的innerText
$oMarquee = _IEGetObjByName ($oIE, "sfmarquee")
MsgBox(0, "SourceForge 信息", $oMarquee.innerText)
_IEQuit ($oIE)
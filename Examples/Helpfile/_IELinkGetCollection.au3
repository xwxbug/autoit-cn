; *******************************************************
; 示例 - 打开带有基本示例的浏览器, 获取链接集, 循环项目并显示相关链接地址的引用
; *******************************************************
#include  <IE.au3>
$oIE = _IE_Example(" basic ")
$oLinks = _IELinkGetCollection($oIE)
$iNumLinks = @extended
msgbox(0, "Link Info ", $iNumLinks & " links found ")
For $oLink In $oLinks
	msgbox(0, "Link Info ", $oLink .href)
Next


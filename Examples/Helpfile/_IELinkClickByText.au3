; *******************************************************
; 示例 - 打开带有基本示例的浏览器,
;				点击带有"user forum"文本的链接
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IELinkClickByText($oIE, "user forum")

; *******************************************************
; 示例 2 - 打开浏览器并导航到 AutoIt 主页, 循环页面上的
;				链接并点击文本为 "wallpaper" 的链接
;				使用子字符串匹配.
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.autoitscript.com")

Local $sMyString = "wallpaper"
Local $oLinks = _IELinkGetCollection($oIE)
For $oLink In $oLinks
	Local $sLinkText = _IEPropertyGet($oLink, "innerText")
	If StringInStr($sLinkText, $sMyString) Then
		_IEAction($oLink, "click")
		ExitLoop
	EndIf
Next

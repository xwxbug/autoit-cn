; *******************************************************
; 示例 1 - 打开浏览器并导航到 AutoIt 主页, 获取到
;				document 对象的引用并显示文档属性
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate("http://www.autoitscript.com")
Local $oDoc = _IEDocGetObj($oIE)
MsgBox(4096, "Document Created Date", $oDoc.fileCreatedDate)

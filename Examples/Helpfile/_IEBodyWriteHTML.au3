; *******************************************************
; 示例 - 打开带有iFrame示例的浏览器, 
;				获取名称为"iFrameTwo"的浮动框架的引用并替换其HTML代码
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("iframe")
Local $oFrame = _IEFrameGetObjByName($oIE, "iFrameTwo")
_IEBodyWriteHTML($oFrame, "Hello <b>iFrame!</b>")

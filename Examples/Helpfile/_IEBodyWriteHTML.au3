; *******************************************************
; 示例 1 - 打开含 iFrame 示例的浏览器, 通过
;				"iFrameTwo" 的名称获取到 iFrame 的引用并替换其 HTML 主体
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("iframe")
Local $oFrame = _IEFrameGetObjByName($oIE, "iFrameTwo")
_IEBodyWriteHTML($oFrame, "Hello <b>iFrame!</b>")

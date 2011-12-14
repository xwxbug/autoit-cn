; *******************************************************
; 示例 1 - 打开 iFrame 示例, 根据 "iFrameTwo" 名称获取到 iFrame 的引用
;				并替换其正文 HTML
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("iframe")
Local $oFrame = _IEFrameGetObjByName($oIE, "iFrameTwo")
_IEBodyWriteHTML($oFrame, "Hello <b>iFrame!</b>")
_IELoadWait($oFrame)

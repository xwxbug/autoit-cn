; *******************************************************
; 示例 - 打开iFrame示例, 获取名为"iFrameTwo"的并替换其HTML
; *******************************************************
#include  <IE.au3>
$oIE = _IE_Example(" iframe ")
$oFrame = _IEFrameGetObjByName($oIE, "iFrameTwo ")
_IEBodyWriteHTML($oFrame, "Hello <b>iFrame!</b> ")
_IELoadWait($oFrame)


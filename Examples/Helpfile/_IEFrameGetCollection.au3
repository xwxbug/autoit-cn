; *******************************************************
; 示例 1 - 打开框架集示例, 获取框架的集合
;				对集合进行循环显示它们的源 URL
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("frameset")
Local $oFrames = _IEFrameGetCollection($oIE)
Local $iNumFrames = @extended
For $i = 0 To ($iNumFrames - 1)
	Local $oFrame = _IEFrameGetCollection($oIE, $i)
	MsgBox(0, "Frame Info", _IEPropertyGet($oFrame, "locationurl"))
Next

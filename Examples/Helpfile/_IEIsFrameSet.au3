; *******************************************************
; 示例 - 显示框架集示例, 获取框架集, 检查框架数量, 显示框架或活动态框架的数量
; *******************************************************
#include  <IE.au3>
$oIE = _IE_Example(" frameset ")
$oFrames = _IEFrameGetCollection($oIE)
$iNumFrames = @extended
If $iNumFrames > 0 Then
	If _IEIsFrameSet($oIE) Then
		msgbox(0, "Frame Info ", "Page contains" & $iNumFrames & " frames in a FrameSet ")
	Else
		msgbox(0, "Frame Info ", "Page contains" & $iNumFrames & " iFrames ")
	EndIf
Else
	msgbox(0, "Frame Info ", "Page contains no frames ")
EndIf


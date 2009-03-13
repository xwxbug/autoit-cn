; *******************************************************
; Example 1 - Open frameset example, get collection of frames
;				and loop through them displaying their source URL's
; *******************************************************
;
#include <IE.au3>
$oIE = _IE_Example ("frameset")
$oFrames = _IEFrameGetCollection ($oIE)
$iNumFrames = @extended
For $i = 0 to ($iNumFrames - 1)
	$oFrame = _IEFrameGetCollection ($oIE, $i)
	MsgBox(0, "Frame Info", _IEPropertyGet ($oFrame, "locationurl"))
Next
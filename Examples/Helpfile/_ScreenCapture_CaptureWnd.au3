#include <ScreenCapture.au3>

_Main()

Func _Main()
	Local $hGUI

	; 创建 GUI
	$hGUI = GUICreate("Screen Capture", 400, 300)
	GUISetState()

	; 捕获窗口
	_ScreenCapture_CaptureWnd(@MyDocumentsDir & "\GDIPlus_Image.jpg", $hGUI)

EndFunc   ;==>_Main

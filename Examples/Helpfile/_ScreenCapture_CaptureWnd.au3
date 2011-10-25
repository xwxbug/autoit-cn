#include  <ScreenCapture.au3>

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" Screen Capture ", 400, 300)
	GUISetState()

	; 捕捉窗口
	_ScreenCapture_CaptureWnd(@MyDocumentsDir & " \GDIPlus_Image.jpg ", $hGUI)

endfunc   ;==>_Main


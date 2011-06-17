#include <ScreenCapture.au3>

_Main()

Func _Main()
	Local $hBmp

	; 捕获整个屏幕
	$hBmp = _ScreenCapture_Capture("")

	; 保存位图到文件
	_ScreenCapture_SaveImage(@MyDocumentsDir & "\GDIPlus_Image.jpg", $hBmp)

EndFunc   ;==>_Main

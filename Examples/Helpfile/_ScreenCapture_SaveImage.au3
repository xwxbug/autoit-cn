#include <ScreenCapture.au3>

_Main()

Func _Main()
	Local $hBmp

	; 捕捉全屏
	$hBmp = _ScreenCapture_Capture("")

	; 将位图保存到文件
	_ScreenCapture_SaveImage(@MyDocumentsDir & " \GDIPlus_Image.jpg ", $hBmp)

endfunc   ;==>_Main


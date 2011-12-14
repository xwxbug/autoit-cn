#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

_Main()

Func _Main()
	Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphics

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 捕获整个屏幕
	$hBitmap1 = _ScreenCapture_Capture("")
	$hImage1 = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap1)

	; 捕获屏幕区域
	$hBitmap2 = _ScreenCapture_Capture("", 0, 0, 400, 300)
	$hImage2 = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap2)

	; 在一幅图像上描绘另一幅图像
	$hGraphics = _GDIPlus_ImageGetGraphicsContext($hImage1)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hImage2, 100, 100)

	; 在插入的图像周围描绘边框
	_GDIPlus_GraphicsDrawRect($hGraphics, 100, 100, 400, 300)

	; 保存由此产生的图像
	_GDIPlus_ImageSaveToFile($hImage1, @MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 清理资源
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
	_WinAPI_DeleteObject($hBitmap1)
	_WinAPI_DeleteObject($hBitmap2)

	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

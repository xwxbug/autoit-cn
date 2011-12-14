#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

_Main()

Func _Main()
	Local $hBitmap, $hImage, $hGraphic

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 捕获屏幕区域
	$hBitmap = _ScreenCapture_Capture("", 0, 0, 400, 300)
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)

	; 填充屏幕捕获为纯蓝色
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)
	_GDIPlus_GraphicsClear($hGraphic)

	; 保存由此产生的图像
	_GDIPlus_ImageSaveToFile($hImage, @MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 清理资源
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)

	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

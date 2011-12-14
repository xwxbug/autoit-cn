#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>

_Main()

Func _Main()
	Local $hBMP, $hImage, $iX, $iY, $hClone

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 捕获到 32 位位图
	$hBMP = _ScreenCapture_Capture("")
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)

	; 创建 24 位位图副本
	$iX = _GDIPlus_ImageGetWidth($hImage)
	$iY = _GDIPlus_ImageGetHeight($hImage)
	$hClone = _GDIPlus_BitmapCloneArea($hImage, 0, 0, $iX, $iY, $GDIP_PXF24RGB)

	; 保存位图到文件
	_GDIPlus_ImageSaveToFile($hClone, @TempDir & "\GDIPlus_Image.bmp")

	; 清理资源
	_GDIPlus_BitmapDispose($hClone)
	_GDIPlus_BitmapDispose($hImage)
	_WinAPI_DeleteObject($hBMP)

	; 加载图像
	$hImage = _GDIPlus_ImageLoadFromFile(@TempDir & "\GDIPlus_Image.bmp")
	$hBMP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

	; 保存位图到文件
	_ScreenCapture_SaveImage(@TempDir & "\Image.bmp", $hBMP, True) ; True -> 释放 $hBMP

	; 清理资源
	_GDIPlus_ImageDispose($hImage)

	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

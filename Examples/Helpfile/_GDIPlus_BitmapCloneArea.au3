
#include  <GuiConstantsEx.au3>
#include  <GDIPlus.au3>
#include  <ScreenCapture.au3>
#include  <WinAPI.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hBitmap, $hClone, $hImage, $iX, $iY

	; 初始化GDI+库
	_GDIPlus_StartUp()

	; 捕捉32位位图
	$hBitmap = _ScreenCapture_Capture("")
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)

	; 创建24位位图副本
	$iX = _GDIPlus_ImageGetWidth($hImage)
	$iY = _GDIPlus_ImageGetHeight($hImage)
	$hClone = _GDIPlus_BitmapCloneArea($hImage, 0, 0, $iX, $iY, $GDIP_PXF24RGB)

	; 将位图保存到文件
	_GDIPlus_ImageSaveToFile($hClone, @MyDocumentsDir & "\GDIPlus_Image.bmp")

	; 清除资源
	_GDIPlus_ImageDispose($hClone)
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)

	; 关闭GDI+库
	_GDIPlus_ShutDown()

endfunc   ;==>_Main


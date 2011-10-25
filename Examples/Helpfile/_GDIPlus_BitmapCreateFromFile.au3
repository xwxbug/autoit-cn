#include  <GuiConstantsEx.au3>
#include  <GDIPlus.au3>
#include  <ScreenCapture.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hBitmap, $hGraphic, $hImage, $iX, $iY, $hClone

	; 创建界面
	$hGUI = GUICreate("GDI+", 400, 300)
	GUISetState()

	; 初始化GDI+库
	_GDIPlus_Startup()

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

	; 将位图绘制到GUI
	$hBitmap = _GDIPlus_BitmapCreateFromFile(@MyDocumentsDir & "\GDIPlus_Image.bmp")
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hBitmap, 0, 0)

	; 清除资源
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBitmap)

	; 关闭GDI+库
	_GDIPlus_ShutDown()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main


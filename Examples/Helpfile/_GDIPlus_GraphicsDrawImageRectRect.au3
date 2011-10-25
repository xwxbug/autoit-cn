#include  <GuiConstantsEx.au3>
#include  <GDIPlus.au3>
#include  <ScreenCapture.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI1, $hGUI2, $hImage, $hGraphic1, $hGraphic2

	; 捕捉屏幕左上角
	_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image.jpg", 0, 0, 400, 300)

	; 为源图像创建界面
	$hGUI1 = GUICreate("Original", 400, 300, 0, 0)
	GUISetState()

	; 为放大的图像创建界面
	$hGUI2 = GUICreate("Zoomed", 400, 300, 0, 400)
	GUISetState()

	; 初始化GDI+库并加载图像
	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 绘制源图像
	$hGraphic1 = _GDIPlus_GraphicsCreateFromHWND($hGUI1)
	_GDIPlus_GraphicsDrawImage($hGraphic1, $hImage, 0, 0)

	; 绘制2x放大的图像
	$hGraphic2 = _GDIPlus_GraphicsCreateFromHWND($hGUI2)
	_GDIPlus_GraphicsDrawImageRectRect($hGraphic2, $hImage, 0, 0, 200, 200, 0, 0, 400, 300)

	; 释放资源
	_GDIPlus_GraphicsDispose($hGraphic1)
	_GDIPlus_GraphicsDispose($hGraphic2)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()

	; 清除屏幕快照文件
	FileDelete(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main


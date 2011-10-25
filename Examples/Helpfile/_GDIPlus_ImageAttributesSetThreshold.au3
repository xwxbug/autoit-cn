#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $hIA, $iWidth, $iHeight, $aSize

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	; 设置插值模式为高质量双三次插值. 绘制压缩图像时确保高质量
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)

	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	; 从GDI位图对象创建GDI+位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; 获取图像大小
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]

	; 创建用于调整图像颜色的ImageAttributes对象
	$hIA = _GDIPlus_ImageAttributesCreate()
	; 设置阈值为0.4
	_GDIPlus_ImageAttributesSetThreshold($hIA, 1, True, 0.4)

	GUISetState()
	; 绘制不变图像，然后改变图象
	_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, 0, @DesktopWidth, @DesktopHeight / 2, $hIA)
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, @DesktopHeight / 2, @DesktopWidth, @DesktopHeight / 2, $hIA)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_ImageAttributesDispose($hIA)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $hIA, $tColorMatrix, $pColorMatrix, $iWidth, $iHeight, $aSize

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)

	; 从GDI位图对象创建GDI+位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; 创建ImageAttribute对象
	$hIA = _GDIPlus_ImageAttributesCreate()

	; 创建用于调整图像颜色的颜色矩阵
	; 使用透明颜色矩阵增加图像亮度
	$tColorMatrix = _GDIPlus_ColorMatrixCreateTranslate(0.15, 0.15, 0.15)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)

	; 调整ImageAttribute关键色颜色矩阵
	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $pColorMatrix)

	GUISetState()

	; 获取图像大小
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]

	; 设置补偿模式提高压缩质量
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)

	; 绘制捕捉的图像
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, @DesktopWidth, @DesktopHeight / 2) ; 绘制使用颜色调整的图像
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


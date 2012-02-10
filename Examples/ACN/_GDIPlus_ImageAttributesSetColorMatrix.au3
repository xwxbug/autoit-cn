#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $tPreHue, $tPostHue, $tColorMatrix, $pColorMatrix, $iWidth, $iHeight, $aSize
	Local $hBrightIA, $hHueIA, $hGrayIA, $hContIA

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体 , 按ESC退出
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)

	; 由GDI位图对象创建GDI+位图
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)

	; 创建亮度ImageAttributes对象
	$hBrightIA = _GDIPlus_ImageAttributesCreate()
	; 创建色调ImageAttributes对象
	$hHueIA = _GDIPlus_ImageAttributesCreate()
	; 创建灰度ImageAttributes对象
	$hGrayIA = _GDIPlus_ImageAttributesCreate()
	; 创建对比度ImageAttributes对象
	$hContIA = _GDIPlus_ImageAttributesCreate()

	; 创建颜色亮度矩阵
	$tColorMatrix = _GDIPlus_ColorMatrixCreateTranslate(0.5, 0.5, 0.5)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)

	; 将图像调亮50%
	_GDIPlus_ImageAttributesSetColorMatrix($hBrightIA, 0, True, $pColorMatrix)

	; 创建单位颜色矩阵及色调颜色矩阵
	$tColorMatrix = _GDIPlus_ColorMatrixCreate()
	$tPreHue = _GDIPlus_ColorMatrixCreate()
	$tPostHue = _GDIPlus_ColorMatrixCreate()
	_GDIPlus_ColorMatrixInitHue($tPreHue, $tPostHue)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)

	; 通过旋转90度调整图像色调
	_GDIPlus_ColorMatrixRotateHue($tColorMatrix, $tPreHue, $tPostHue, 90)
	_GDIPlus_ImageAttributesSetColorMatrix($hHueIA, 0, True, $pColorMatrix)

	; 创建灰度颜色矩阵
	$tColorMatrix = _GDIPlus_ColorMatrixCreateGrayScale()
	$pColorMatrix = DllStructGetPtr($tColorMatrix)

	; 调整将被灰度化的图像颜色
	_GDIPlus_ImageAttributesSetColorMatrix($hGrayIA, 0, True, $pColorMatrix)

	; 创建对比度颜色矩阵
	$tColorMatrix = _GDIPlus_ColorMatrixCreateScale(4, 4, 4)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)

	; 通过色调旋转修正颜色
	_GDIPlus_ColorMatrixRotateHue($tColorMatrix, $tPreHue, $tPostHue, 0)

	; 调整图形对比度
	_GDIPlus_ImageAttributesSetColorMatrix($hContIA, 0, True, $pColorMatrix)

	GUISetState()

	; 获取图像尺寸
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]

	; 设置插入模式以提高压缩质量
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)

	; 绘制调整亮度后的图像
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, 0, @DesktopWidth / 2, @DesktopHeight / 2, $hBrightIA)

	; 绘制调整色调后的图像
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth / 2, 0, @DesktopWidth / 2, @DesktopHeight / 2, $hHueIA)

	; 绘制通过灰度矩阵调整的图像
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, @DesktopHeight / 2, @DesktopWidth / 2, @DesktopHeight / 2, $hGrayIA)

	; 绘制调整对比度后的图像
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth / 2, @DesktopHeight / 2, @DesktopWidth / 2, @DesktopHeight / 2, $hContIA)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_ImageAttributesDispose($hContIA)
	_GDIPlus_ImageAttributesDispose($hGrayIA)
	_GDIPlus_ImageAttributesDispose($hHueIA)
	_GDIPlus_ImageAttributesDispose($hBrightIA)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 释放GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


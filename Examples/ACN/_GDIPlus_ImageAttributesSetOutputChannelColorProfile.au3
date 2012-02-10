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
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)

	; 从GDI位图对象创建GDI+位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)

	; 获取图像大小
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]

	GUISetState()

	; 设置插值模式为高质量双三次插值. 绘制压缩图像时确保高质量
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)

	; 创建用于调整图像颜色的ImageAttributes对象
	$hIA = _GDIPlus_ImageAttributesCreate()

	; 设置输出通道颜色配置文件
	_GDIPlus_ImageAttributesSetOutputChannelColorProfile($hIA, 1, True, "sRGB Color Space Profile.icm ")

	; 绘制图像, 显示青色通道的强度
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 0) ; 青色
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, 0, @DesktopHeight / 2, @DesktopHeight / 2, $hIA)

	; 绘制图像, 显示紫红色通道的强度
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 1) ; 紫红色
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth / 2, 0, @DesktopWidth / 2, @DesktopHeight / 2, $hIA)

	; 绘制图像, 显示黄色通道的强度
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 2) ; 黄色
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, @DesktopHeight / 2, @DesktopWidth / 2, @DesktopHeight / 2, $hIA)

	; 绘制图像, 显示黑色通道的强度
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 3) ; 黑色
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth / 2, @DesktopHeight / 2, @DesktopWidth / 2, @DesktopHeight / 2, $hIA)

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


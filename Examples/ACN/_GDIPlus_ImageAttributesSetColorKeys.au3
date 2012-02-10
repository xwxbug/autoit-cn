#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $hIA

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight / 2)
	GUISetBkColor(0x00C080)

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)

	; 从GDI位图对象创建GDI+位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; 创建ImageAttribute对象并设置颜色键
	$hIA = _GDIPlus_ImageAttributesCreate()
	; 生成4210752颜色的全范围透明
	_GDIPlus_ImageAttributesSetColorKeys($hIA, 0, True, 0xFF000000, 0xFF404040)

	GUISetState()

	; 设置插值模式以提高压缩质量
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)

	; 应用图像调整时绘制图像
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, @DesktopWidth, @DesktopHeight, 0, 0, @DesktopWidth, @DesktopHeight / 2, $hIA)

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


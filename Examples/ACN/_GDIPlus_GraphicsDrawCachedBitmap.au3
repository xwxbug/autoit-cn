#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hGUI
	Local $hBitmap, $hBmp, $hGraphics, $hCachedBitmap

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)

	; 用GDI位图对象创建GDI+位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; 从已存在的位图和图形对象创建缓存位图
	$hCachedBitmap = _GDIPlus_GraphicsDrawCachedBitmap($hBitmap, $hGraphics)
	GUISetState()

	; 绘制缓存位图
	_GDIPlus_GraphicsDrawCachedBitmap($hGraphics, $hCachedBitmap, 0, 0)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_CachedBitmapDispose($hCachedBitmap)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+库
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>
#Include <WinAPIEX.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hGUI
	Local $hBitmap, $hBmp, $hGraphics
	Local $iColor, $iX, $iY, $iImageWidth, $iImageHeight
	Local $aSize

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)

	; 用GDI位图对象创建GDI+位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iColor = $GDIP_DARKSEAGREEN

	$iImageWidth = $aSize[0]
	$iImageHeight = $aSize[1]

	For $iX = 0 To $iImageWidth Step 16
		For $iY = 0 To $iImageHeight Step 16
			_GDIPlus_BitmapSetPixel($hBitmap, $iX, $iY, $iColor)
		Next
	Next
	GUISetState()

	; 绘制选定的屏幕捕捉
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+库
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


#Include <GDIPlusEx.au3>
#Include <ScreenCapture.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hBitmap, $hBmp, $iColor

	; 初始化GDI+
	_GDIPlus_Startup()

	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)

	; 用GDI位图对象创建GDI+位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	$iColor = _GDIPlus_BitmapGetPixel($hBitmap, 150, 150)

	MsgBox(0x40, "Color ", "Bitmap Pixel Color at [150, 150] is: 0x" & Hex($iColor))

	; 清除资源
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)

	; 关闭GDI+库
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


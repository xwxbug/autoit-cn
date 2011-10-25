#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hBitmap, $hBmp, $hGraphics

	; 初始化GDI+
	_GDIPlus_Startup()

	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)

	; 设置每英寸96x144点, 通常为96x96或120x120: 各向同性
	_GDIPlus_BitmapSetResolution($hBitmap, 96, 144)

	_GDIPlus_ImageSaveToFile($hBitmap, @MyDocumentsDir & " \96x144.jpg ")

	; 清除资源
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)

	; 关闭GDI+库
	_GDIPlus_Shutdown()

	ShellExecute(@MyDocumentsDir & " \96x144.jpg ")
endfunc   ;==>_Example


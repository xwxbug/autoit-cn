#Include <GDIPlusEx.au3>
#Include <ScreenCapture.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hInst, $hIcon, $hBitmap

	; 初始化GDI+
	_GDIPlus_Startup()

	$hInst = _WinAPI_GetModuleHandle(" user32.dll ")
	$hIcon = _WinAPI_LoadIcon($hInst, 104)

	$hBitmap = _GDIPlus_BitmapCreateFromHICON($hIcon)

	; 将图标图像保存为文件
	_GDIPlus_ImageSaveToFile($hBitmap, @MyDocumentsDir & " \Information.jpg ")

	; 清除资源
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DestroyIcon($hIcon)

	; 关闭GDI+库
	_GDIPlus_Shutdown()

	ShellExecute(@MyDocumentsDir & " \Information.jpg ")
endfunc   ;==>_Example


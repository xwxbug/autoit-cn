#Include <GDIPlusEx.au3>
#Include <ScreenCapture.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hInst, $hBitmap

	; 初始化GDI+
	_GDIPlus_Startup()

	$hInst = _WinAPI_LoadLibrary(@SystemDir & " taskmgr.exe ")
	$hBitmap = _GDIPlus_BitmapCreateFromResource($hInst, 103)

	; 将图标图像保存为文件
	_GDIPlus_ImageSaveToFile($hBitmap, @MyDocumentsDir & " \ResourceTest.jpg ")

	; 清除资源
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_FreeLibrary($hInst)

	; 关闭GDI+库
	_GDIPlus_Shutdown()

	ShellExecute(@MyDocumentsDir & " \ResourceTest.jpg ")
endfunc   ;==>_Example


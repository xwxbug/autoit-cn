#Include <FontConstants.au3>
#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hDC, $hCDC, $hTheme
	Local $hBitmap, $hDIBBmp, $hOldBmp, $hFont, $hOldFont
	Local $pBitmapData, $tBmpInfo, $tDTTOptions, $tClientRect

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	GUISetState()

	; 打开GUI窗体及其相关类的主题数据
	$hTheme = _WinAPI_OpenThemeData($hGUI, "globals ")

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hDC = _GDIPlus_GraphicsGetDC($hGraphics)
	$hCDC = _WinAPI_CreateCompatibleDC($hDC)
	$tClientRect = _WinAPI_GetClientRect($hGUI)


	$tBmpInfo = DllStructCreate($tagBITMAPINFO)
	DllStructSetData($tBmpInfo, "Size ", DllStructGetSize($tBmpInfo) - 4)
	DllStructSetData($tBmpInfo, "Width ", @DesktopWidth)
	DllStructSetData($tBmpInfo, "Height ", @DesktopHeight)
	DllStructSetData($tBmpInfo, "Planes ", 1)
	DllStructSetData($tBmpInfo, "BitCount ", 32)
	DllStructSetData($tBmpInfo, "Compression ", 0) ; BI_RGB

	; 创建DIB对象并选择分配到内存设备场景
	$hDIBBmp = _WinAPI_CreateDIBSection($hDC, $tBmpInfo, $DIB_RGB_COLORS, $pBitmapData)
	$hFont = _WinAPI_CreateFont(50, 30, 0, 0, 400, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 'Courier New')

	$hOldBmp = _WinAPI_SelectObject($hCDC, $hDIBBmp) ; 绘制文本前选取DIBBMP对象
	$hOldFont = _WinAPI_SelectObject($hCDC, $hFont) ; 选取字体对象

	$tDTTOptions = DllStructCreate($tagDTTOPTS)
	DllStructSetData($tDTTOptions, "Size ", DllStructGetSize($tDTTOptions))
	DllStructSetData($tDTTOptions, "Flags ", BitOR($DTT_GLOWSIZE, $DTT_TEXTCOLOR, $DTT_COMPOSITED)) ; GlowSize和ClrText成员可用
	DllStructSetData($tDTTOptions, "GlowSize ", 25)
	DllStructSetData($tDTTOptions, "clrText ", _RGBtoBGR($GDIP_CHOCOLATE))

	_WinAPI_DrawThemeTextEx($hTheme, 0, 0, $hCDC, "AutoIt GDI+ ", BitOR($DT_SINGLELINE, $DT_CENTER, $DT_VCENTER, $DT_NOPREFIX), $pDTTOptions)

	; 释放绘制时的图形场景
	_WinAPI_SelectObject($hCDC, $hOldFont)
	_WinAPI_SelectObject($hCDC, $hOldBmp)
	_WinAPI_DeleteObject($hFont)
	_WinAPI_DeleteDC($hCDC)
	_GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)

	$hBitmap = _GDIPlus_BitmapCreateFromGdiDib($tBmpInfo, $pBitmapData)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)


	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_WinAPI_DeleteObject($hDIBBmp)

	_WinAPI_CloseThemeData($hTheme)

	; 关闭GDI+库
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

Func _RGBtoBGR($iRGB)
	Return Dec( StringMid( Binary($iRGB), 3, 6))
endfunc   ;==>_RGBtoBGR


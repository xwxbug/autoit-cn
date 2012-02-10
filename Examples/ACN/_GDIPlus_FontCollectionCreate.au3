#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <WindowsConstants.au3>

Opt(" MustDeclareVars ", 1)

Global $iARGBBackground, $hGraphics, $aFontFamilies

_Example()

Func _Example()
	Local $hGUI, $hFontCollection

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_FontCollection* Example ", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建包含系统支持的字体的InstalledFontCollection对象
	$hFontCollection = _GDIPlus_FontCollectionCreate()

	; 获取全部字体族
	$aFontFamilies = _GDIPlus_FontCollectionGetFamilyList($hFontCollection)

	; 获取典型对话框的背景色
	$iARGBBackground = BitOR(0xFF000000, $_WinAPI_GetSysColor($COLOR_BTNFACE)

	; 每2秒使用随机字体族绘制字符串
	_PrintFonts()
	AdlibRegister(" _PrintFonts ", 2000)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	AdlibUnRegister()

	; 清除
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

Func _PrintFonts()
	Local $iI, $iIndex, $iMaxIndex, $hFontFamily, $iIndex
	If IsArray($aFontFamilies) Then
		$iMaxIndex = $aFontFamilies[0]
		_GDIPlus_GraphicsClear($hGraphics, $iARGBBackground)

		For $iI = 1 To 3
			$iIndex = Random(1, $iMaxIndex, 1)

			; 从字体集随机获取一个字体族对象
			$hFontFamily = $aFontFamilies[$iIndex]
			; 获取字体族名称
			$sFamilyName = _GDIPlus_FontFamilyGetFamilyName($hFontFamily)
			; 以该字体族作为字体绘制字体族名称
			_GDIPlus_GraphicsDrawString($hGraphics, $sFamilyName, 20, $iI * 40, $sFamilyName, 15)
		Next
	EndIf
endfunc   ;==>_PrintFonts


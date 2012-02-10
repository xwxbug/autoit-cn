#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $hIA, $tColorPalette, $pColorPalette, $aRemap[2][2], $iI

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_ImageAttributesGetAdjustedPalette Example ", 450, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建含有四个值的调色板
	$tColorPalette = DllStructCreate(" uint Flags;uint Count;uint Entries[4] ")
	$pColorPalette = DllStructGetPtr($tColorPalette)

	DllStructSetData($tColorPalette, "Flags ", 0)
	DllStructSetData($tColorPalette, "Count ", 4)
	DllStructSetData($tColorPalette, "Entries ", 0xFF00FFFF, 1) ; 水色
	DllStructSetData($tColorPalette, "Entries ", 0xFF000000, 2) ; 黑色
	DllStructSetData($tColorPalette, "Entries ", 0xFFFF0000, 3) ; 红色
	DllStructSetData($tColorPalette, "Entries ", 0xFF00FF00, 4) ; 绿色

	; 创建画刷填充绘制的矩形
	$hBrush = _GDIPlus_BrushCreateSolid()

	; 显示四个未调整的调色板
	For $iI = 1 To 4
		_GDIPlus_BrushSetSolidColor($hBrush, DllStructGetData($tColorPalette, "Entries ", $iI))
		_GDIPlus_GraphicsFillRect($hGraphics, $iI * 30, 10, 20, 20, $hBrush)
	Next

	; 创建将绿色转为蓝色的重映射表
	$aRemap[0][0] = 1
	$aRemap[1][0] = 0xFF00FF00 ; 绿色为过去的颜色
	$aRemap[1][1] = 0xFF0000FF ; 蓝色为新颜色

	; 创建ImageAttribute对象并设置其的位图重映射表
	$hIA = _GDIPlus_ImageAttributesCreate()
	_GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemap)
	; 调整调色板
	_GDIPlus_ImageAttributesGetAdjustedPalette($hIA, $pColorPalette, 1)

	; 显示四个调整后的调色板
	For $iI = 1 To 4
		_GDIPlus_BrushSetSolidColor($hBrush, DllStructGetData($tColorPalette, "Entries ", $iI))
		_GDIPlus_GraphicsFillRect($hGraphics, $iI * 30, 40, 20, 20, $hBrush)
	Next

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


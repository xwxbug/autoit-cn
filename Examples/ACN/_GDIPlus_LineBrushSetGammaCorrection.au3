#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_LineBrushSetGammaCorrection Example ", 420, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建从红色到蓝色的渐变刷
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 0, 200, 0xFFFF0000, 0xFF0000FF, 1)

	; 使用渐变刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 200, 200, $hBrush)

	; 使用伽玛校正
	_GDIPlus_LineBrushSetGammaCorrection($hBrush, True)
	; 使用伽玛校正后的渐变刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 220, 0, 200, 200, $hBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


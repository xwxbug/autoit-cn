#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_LineBrushSetColors Example ", 420, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建从红色到绿色的渐变刷
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 0, 100, 0xFFFF0000, 0xFF00FF00, 1)

	; 使用渐变刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 200, 200, $hBrush)

	; 将渐变刷起始色和终止色改为黑色和白色
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFFFFFFFF)
	; 使用从黑色到白色的渐变刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 200, 0, 200, 200, $hBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


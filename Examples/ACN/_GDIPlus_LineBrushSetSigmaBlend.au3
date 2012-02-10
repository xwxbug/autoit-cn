#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_LineBrushSetSigmaBlend Example ", 400, 320)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建从红色到蓝色的渐变刷
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 400, 0, 0xFFFF0000, 0xFF0000FF, 1)

	; 将渐变刷焦点设置在左侧的50%处并按60%混合(40%红色60%蓝色)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 0.5, 0.6)
	; 使用渐变刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 100, $hBrush)

	; 将渐变刷焦点设置在左侧的20%处并按80%混合(20%红色80%蓝色)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 0.2, 0.8)
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 110, 400, 100, $hBrush)

	; 将渐变刷焦点设置在左侧的80%处并按100%混合(0%红色100%蓝色)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 0.8, 1)
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 220, 400, 100, $hBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


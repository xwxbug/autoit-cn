#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $iGraphicsCont, $tDstRect, $tSrcRect

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsBeginContainer Example ", 400, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建图形容器使用的矩形
	$tSrcRect = _GDIPlus_RectFCreate(0, 0, 200, 100)
	$tDstRect = _GDIPlus_RectFCreate(100, 100, 200, 200)

	; Create a Graphics container with a (100, 100) translation and (1, 2) scale
	$iGraphicsCont = _GDIPlus_GraphicsBeginContainer($hGraphics, $tDstRect, $tSrcRect)

	; 填充容器内的椭圆
	$hBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; Red
	_GDIPlus_GraphicsFillEllipse($hGraphics, 0, 0, 100, 60, $hBrush)

	; 结束容器并重新设置图形状态为容器开始前的图形状态
	_GDIPlus_GraphicsEndContainer($hGraphics, $iGraphicsCont)

	; 填充容器外的椭圆
	_GDIPlus_BrushSetSolidColor($hBrush, 0xFF0000FF) ; Blue
	_GDIPlus_GraphicsFillEllipse($hGraphics, 0, 0, 100, 60, $hBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


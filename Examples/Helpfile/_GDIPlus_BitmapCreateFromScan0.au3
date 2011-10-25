#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hPathBrush, $hLineBrush, $hBitmap, $hContext
	Local $avColors[2] = [1, 0x00FFFFFF]

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_BitmapCreateFromScan0 Example ", 400 - 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建带有大小但没有数据的位图
	$hBitmap = _GDIPlus_BitmapCreateFromScan0(200, 200)

	; 获取位图图形场景以便使用双倍缓冲进行绘制
	$hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	; 创建用以填充形状的线性梯度画刷
	$hLineBrush = _GDIPlus_LineBrushCreate(1, 1, 200 - 2, 200 - 2, 0x000000FF, 0xA00000FF)

	; 使用默认填充模式创建绘制图形的图形路径
	$hPath = _GDIPlus_PathCreate()

	; 开始绘图
	_GDIPlus_PathStartFigure($hPath)
	; 绘制椭圆
	_GDIPlus_PathAddEllipse($hPath, 2, 2, 200 - 4, 200 - 4)

	; 创建与图形路径相关的路径刷
	$hPathBrush = _GDIPlus_PathBrushCreateFromPath($hPath)

	_GDIPlus_PathBrushSetCenterColor($hPathBrush, 0x8000FFFF)
	_GDIPlus_PathBrushSetCenterPoint($hPathBrush, 200 / 2, 200 / 2)
	_GDIPlus_PathBrushSetFocusScales($hPathBrush, 0.1, 0.1)
	_GDIPlus_PathBrushSetSurroundColorsWithCount($hPathBrush, $avColors)

	; 设置图形平滑模式及使用路径刷绘制的位图场景
	_GDIPlus_GraphicsSetSmoothingMode($hContext, $SmoothingModeAntiAlias)
	_GDIPlus_GraphicsFillPath($hContext, $hPath, $hLineBrush)
	_GDIPlus_GraphicsFillPath($hContext, $hPath, $hPathBrush)

	; 最后, 在图形上绘制位图
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 100, 0)

	Do
	Until GUIGetMsg(() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_BrushDispose($hPathBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hLineBrush)
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 卸载GDI+库
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


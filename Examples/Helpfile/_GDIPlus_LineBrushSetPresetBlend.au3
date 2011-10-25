#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $aInterpolations[5][2]

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_LineBrushSetBlend Example ", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建从黑色到白色的渐变刷
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 400, 200,, 0xFF000000, 0xFFFFFFFF, 1)

	; 定义渐变刷颜色和位置
	$aInterpolations[0][0] = 4 ; 使用4个要素和位置

	$aInterpolations[1][0] = 0xFFFF0000 ; 红色
	$aInterpolations[1][1] = 0 ; 从左侧0%
	$aInterpolations[2][0] = 0xFF00FF00 ; 绿色
	$aInterpolations[2][1] = 0.3 ; 从左侧30%
	$aInterpolations[3][0] = 0xFF0000FF ; 蓝色
	$aInterpolations[3][1] = 0.7 ; 从左侧70%
	$aInterpolations[4][0] = 0xFFFFFF00 ; 黄色
	$aInterpolations[4][1] = 1 ; 从左侧100%

	; 设置渐变刷位置和要素
	_GDIPlus_LineBrushSetPresetBlend($hBrush, $aInterpolations)

	; 使用渐变刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 200, $hBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


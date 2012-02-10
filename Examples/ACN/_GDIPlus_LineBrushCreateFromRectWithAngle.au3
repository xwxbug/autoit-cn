#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $tRectF

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_LineBrushCreateFromRectWithAngle Example ", 420, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 为渐变刷创建定义的矩形
	$tRectF = _GDIPlus_RectFCreate(0, 0, 50, 100)
	; 以20度角创建从红色到绿色梯度改变的渐变刷
	$hBrush20 = _GDIPlus_LineBrushCreateFromRectWithAngle($tRectF, 0xFFFF0000, 0xFF00FF00, 20, True, 1)
	; 以120度角创建从红色到绿色梯度改变的渐变刷
	$hBrush120 = _GDIPlus_LineBrushCreateFromRectWithAngle($tRectF, 0xFFFF0000, 0xFF00FF00, 120, True, 1)

	; 使用20度渐变梯度刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 200, 200, $hBrush20)
	; 使用120度渐变梯度刷填充矩形
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 200, 200, $hBrush120)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush20)
	_GDIPlus_BrushDispose($hBrush120)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


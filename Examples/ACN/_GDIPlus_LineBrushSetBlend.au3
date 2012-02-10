#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $tRectF, $aBlends[5][2]

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_LineBrushSetBlend Example ", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 为渐变梯度刷创建定义的矩形
	$tRectF = _GDIPlus_RectFCreate(0, 0, 50, 100)
	; 创建从红色到绿色梯度改变的渐变梯度刷
	$hBrush = _GDIPlus_LineBrushCreateFromRect($tRectF, 0xFFFF0000, 0xFF00FF00, 0, 1)

	; 定义渐变刷颜色和位置
	$aBlends[0][0] = 4 ; 使用4个要素和位置

	$aBlends[1][0] = 0 ; 要素
	$aBlends[1][1] = 0 ; 位置
	$aBlends[2][0] = 1 ; 混合百分比为100% (从左侧开始到20%完成从红色到绿色渐变)
	$aBlends[2][1] = 0.2 ; 画刷从左侧绑定的距离百分比为20%
	$aBlends[3][0] = 0 ; 混合百分比为0% (从左侧开始的20%到70%完成从绿色到红色的渐变)
	$aBlends[3][1] = 0.7 ; 画刷从左侧绑定的距离百分比为70%
	$aBlends[4][0] = 1 ; 混合百分比为100% (从左侧70%到100%完成从红色到绿色渐变)
	$aBlends[4][1] = 1 ; 画刷从左侧绑定的距离百分比为100%

	; 设置渐变刷位置和要素
	_GDIPlus_LineBrushSetBlend($hBrush, $aBlends)

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


#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPen, $hBitmap, $aPoints[11][2], $iI, $iJ

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsDrawCurve2 Example ", 400, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 使用反锯齿
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	; 创建一些点
	$aPoints[0][0] = 10

	For $iI = 0 To 1
		For $iJ = 1 To 5
			$aPoints[$iI * 5 + $iJ][0] = 300 * $iI + 50
			$aPoints[$iI * 5 + $iJ][1] = $iJ * 50
		Next
	Next

	; 创建画笔对象
	$hPen = _GDIPlus_PenCreate($GDIP_ORCHID, 8)

	; 绘制指定使用的点的数量, 首个点的偏移及张力值的曲线
	; 从第2点开始并仅使用第3个点绘制曲线
	_GDIPlus_GraphicsDrawCurve3($hGraphics, $aPoints, 1, 3, 0.8, $hPen)
	; 从第6点开始并仅使用第3个点绘制曲线
	_GDIPlus_GraphicsDrawCurve3($hGraphics, $aPoints, 5, 3, 0.8, $hPen)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


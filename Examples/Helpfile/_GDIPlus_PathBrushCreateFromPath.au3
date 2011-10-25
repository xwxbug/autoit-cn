#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hBrush
	Local $aColors[11] = [10, 0xFFFF0000, 0xFFFF0000, 0xFF0000FF, 0xFFFF0000, 0xFFFF0000, 0xFF0000FF, 0xFFFF0000, 0xFFFFFFFF, 0xFFFF0000, 0xFF0000FF]
	Local $aPoints[11][2] = [[10],[0, 100],[130, 100],[200, 0],[270, 100],[400, 100],[300, 150],[400, 300],[200, 200],[0, 300],[100, 150]]

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_PathBrushCreateFromPath Example ", 400, 300)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	;  从点创建路径对象并添加线
	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddLines($hPath, $aPoints)

	;  从路径创建路径梯度刷
	$hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	;  设置路径梯度刷中心色
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFF00FF00)
	;  设置路径梯度刷环绕色
	_GDIPlus_PathBrushSetSurroundColorsWithCount($hBrush, $aColors)

	;  填充路径
	_GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


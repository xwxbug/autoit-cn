#include <GuiConstantsEx.au3>
#include <GDIPlusEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $aPoints[21][2], $iI

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsFillPolygon2 Example ", 400, 400)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)

	; 创建画刷对象
	$hBrush = _GDIPlus_BrushCreateSolid($GDIP_BROWN)

	; 创建随机点
	$aRects[0][0] = 20

	For $iI = 1 To 20
		$aPoints[$iI][0] = Random(1, 399, 1)
		$aPoints[$iI][1] = Random(1, 399, 1)
	Next
	; 绘制填充的多边形
	_GDIPlus_GraphicsFillPolygon2($hGraphics, $aPoints, $hBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


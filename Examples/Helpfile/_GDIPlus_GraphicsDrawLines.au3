#include <GuiConstantsEx.au3>
#include <GDIPlusEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hHatchBrush, $hPen, $aPoints[6][2]

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsDrawLines Example ", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)

	; 通过画笔创建阴影刷
	$hHatchBrush = _GDIPlus_HatchBrushCreate($HatchStyleDiagonalCross, 0xFF00FF80, 0x80000000)

	; 创建画笔
	$hPen = _GDIPlus_PenCreate2($hHatchBrush, 5)

	; 定义平行四边形坐标
	$aPoints[0][0] = 5
	$aPoints[1][0] = 10
	$aPoints[1][1] = 10
	$aPoints[2][0] = 350
	$aPoints[2][1] = 10
	$aPoints[3][0] = 390
	$aPoints[3][1] = 190
	$aPoints[4][0] = 50
	$aPoints[4][1] = 190
	$aPoints[5][0] = 10
	$aPoints[5][1] = 10

	_GDIPlus_GraphicsDrawLines($hGraphics, $aPoints, $hPen)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hHatchBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


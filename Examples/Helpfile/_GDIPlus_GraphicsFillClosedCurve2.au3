#include <GuiConstantsEx.au3>
#include <GDIPlusEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hHatchBrush, $aPoints[11][2], $iI, $iJ

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsFillClosedCurve2 Example ", 400, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 使用反锯齿
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	; 创建一些随机点
	$aPoints[0][0] = 10

	For $iI = 0 To 1
		For $iJ = 0 To 5
			$aPoints[$iI * 5 + $iJ][0] = 300 * $iI + 50
			$aPoints[$iI * 5 + $iJ][1] = $iJ * 50
		Next
	Next

	; 创建阴影刷填充封闭曲线
	$hHatchBrush = _GDIPlus_HatchBrushCreate($HatchStyleZigZag, 0xCC00FF80, 0x40000000)

	; 填充指定张力值的封闭曲线
	_GDIPlus_GraphicsFillClosedCurve2($hGraphics, $aPoints, 1.5, $hHatchBrush)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hHatchBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example


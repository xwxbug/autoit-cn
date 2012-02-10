#include <GuiConstantsEx.au3>
#include <GDIPlusEx.au3>

Opt('MustDeclareVars ', 1)

_Main()

Func _Main()
	Local $hGUI, $hGraphics, $hPen, $aPoints[11][2], $iI, $iJ

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建界面
	$hGUI = GUICreate(" _GDIPlus_GraphicsDrawClosedCurve2 Example ", 400, 350)
	GUISetState()

	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 使用反锯齿
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)

	; 创建一些点
	For $iI = 0 To 1
		For $iJ = 0 To 5
			$aPoints[$iI * 5 + $iJ][0] = 300 * $iI + 50
			$aPoints[$iI * 5 + $iJ][1] = $iJ * 50
		Next
	Next

	; 创建画笔对象
	$hPen = _GDIPlus_PenCreate($GDIP_ORCHID, 0)

	; 绘制指定张力值的曲线
	_GDIPlus_GraphicsDrawClosedCurve2($hGraphic, $aPoints, 1.2, $hPen)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)

	; 释放GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Main


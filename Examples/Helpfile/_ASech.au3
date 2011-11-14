#include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hBrush, $hFormat, $hFamily, $hFont, $tLayout, $hPen
	Local $aPoint[10002][2], $m = 1, $hBrush1

	; 创建界面
	$hGUI = GUICreate("Inverse Hyperbolic Secant", 400, 300)
	$hWnd = WinGetHandle("Inverse Hyperbolic Secant")
	GUISetState()

	; 绘制字符串
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)
	$hBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	$hFormat = _GDIPlus_StringFormatCreate()
	$hFamily = _GDIPlus_FontFamilyCreate("Arial")
	$hFont = _GDIPlus_FontCreate($hFamily, 8, 2)
	$tLayout = _GDIPlus_RectFCreate(50, 250, 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'O(0,0)', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(200, 20, 200, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'Inverse Hyperbolic Secant', $hFont, $tLayout, $hFormat, $hBrush)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($hGraphic, 0, 250, 400, 250, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 50, 0, 50, 300, $hPen)

	$aPoint[0][0] = 10001
	For $i = 0 To 1 Step 0.0001
		$aPoint[$m][0] = $i * 200 + 50
		$aPoint[$m][1] = 250 - _ASech($i) * 50
		$m += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint)
	$tLayout = _GDIPlus_RectFCreate(245, 250, 200, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '1', $hFont, $tLayout, $hFormat, $hBrush)
	$hBrush1 = _GDIPlus_BrushCreateSolid(0xFF000000)
	_GDIPlus_GraphicsDrawEllipse($hGraphic, 248, 248, 4, 4)
	_GDIPlus_GraphicsFillEllipse($hGraphic, 248, 248, 4, 4, $hBrush1)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_BrushDispose($hBrush1)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

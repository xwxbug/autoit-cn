#include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hBrush, $tLayout1, $hFormat, $hFamily, $hFont, $tLayout, $hPen
	Local $aPoint1[401][2], $aPoint2[401][2], $m = 1, $j = 1

	; 创建界面
	$hGUI = GUICreate("Hyperbolic Cosecant", 400, 300)
	$hWnd = WinGetHandle("Hyperbolic Cosecant")
	GUISetState()

	; 绘制字符串
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)
	$hBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	$hFormat = _GDIPlus_StringFormatCreate()
	$hFamily = _GDIPlus_FontFamilyCreate("Arial")
	$hFont = _GDIPlus_FontCreate($hFamily, 8, 2)
	$tLayout = _GDIPlus_RectFCreate(200, 150, 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'OO(0, 0)', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(20, 20, 200, 1000)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'Hyperbolic Cosecant', $hFont, $tLayout, $hFormat, $hBrush)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($hGraphic, 0, 150, 400, 150, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, 0, 200, 300, $hPen)

	$aPoint1[0][0] = 400
	$aPoint2[0][0] = 400
	For $i = -4 To -0.01 Step 0.01
		$aPoint1[$m][0] = $i * 50 + 200
		$aPoint1[$m][1] = 150 - _Csch($i) * 10
		$m += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint1)
	For $i = 0.01 To 4 Step 0.01
		$aPoint2[$j][0] = $i * 50 + 200
		$aPoint2[$j][1] = 150 - _Csch($i) * 10
		$j += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint2)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

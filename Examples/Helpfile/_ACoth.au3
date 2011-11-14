#include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hBrush, $hFormat, $hFamily, $hFont, $aPoint2[391][2], $aPoint1[391][2]
	Local $j = 1, $m = 1, $hAsymPen, $hPen, $tLayout

	; 创建界面
	$hGUI = GUICreate("Inverse Hyperbolic Cotangent", 400, 300)
	$hWnd = WinGetHandle("Inverse Hyperbolic Cotangent")
	GUISetState()

	; 绘制字符串
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)
	$hBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	$hFormat = _GDIPlus_StringFormatCreate()
	$hFamily = _GDIPlus_FontFamilyCreate("Arial")
	$hFont = _GDIPlus_FontCreate($hFamily, 8, 2)
	$tLayout = _GDIPlus_RectFCreate(200, 150,100, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'O(0,0)', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(20, 20, 200, 1000)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'Inverse Hyperbolic Cotangent', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(150, 150, 60, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '-1', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(250, 150, 60, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '1', $hFont, $tLayout, $hFormat, $hBrush)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($hGraphic, 0, 150, 400, 150, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, 0, 200, 300, $hPen)
	$hAsymPen = _GDIPlus_PenCreate()
	_GDIPlus_PenSetDashStyle($hAsymPen, $GDIP_DASHSTYLEDASH)
	_GDIPlus_GraphicsDrawLine($hGraphic, 150, 0, 150, 300, $hAsymPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 250, 0, 250, 300, $hAsymPen)

    $aPoint2[0][0] = 299
	$aPoint1[0][0] = 299
	For $i = -4 To -1 Step 0.01
		If $i = -1 Then ExitLoop
		$aPoint2[$j][0] = $i * 50 + 200
		$aPoint2[$j][1] = 150 - _ACoth($i) * 10
		$j += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint2)
	For $i = 1 To 4 Step 0.01
		If $i = 1 Then ContinueLoop
		$aPoint1[$m][0] = $i * 50 + 200
		$aPoint1[$m][1] = 150 - _ACoth($i) * 10
		$m += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint1)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_PenDispose($hAsymPen)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

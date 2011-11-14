#include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hBrush, $hBrush1, $hFormat, $hFamily, $hFont, $tLayout, $hPen
	Local $aPoint1[302][2], $aPoint2[302][2], $j = 1, $m = 1, $hAsymPen

	; 创建界面
	$hGUI = GUICreate("Inverse Cosecant", 400, 300)
	$hWnd = WinGetHandle("Inverse Cosecant")
	GUISetState()

	; 绘制字符串
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)
	$hBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	$hFormat = _GDIPlus_StringFormatCreate()
	$hFamily = _GDIPlus_FontFamilyCreate("Arial")
	$hFont = _GDIPlus_FontCreate($hFamily, 8, 2)
	$tLayout = _GDIPlus_RectFCreate(200, 150, 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'O(0,0)', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(20, 20, 200, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'Inverse Cosecant', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(248, 150, 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '1', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(148, 150, 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '-1', $hFont, $tLayout, $hFormat, $hBrush)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($hGraphic, 0, 150, 400, 150, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, 0, 200, 300, $hPen)
	$hAsymPen = _GDIPlus_PenCreate()
	_GDIPlus_PenSetDashStyle($hAsymPen, $GDIP_DASHSTYLEDASH)
	_GDIPlus_GraphicsDrawLine($hGraphic, 150, 0, 150, 300, $hAsymPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 250, 0, 250, 300, $hAsymPen)

	$aPoint1[0][0] = 301
	$aPoint2[0][0] = 301
	For $i = -4 To -1 Step 0.01
		$aPoint1[$m][0] = $i * 50 + 200
		$aPoint1[$m][1] = 150 - _ACsc($i) * 50
		$m += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint1)
	For $i = 1 To 4 Step 0.01
		$aPoint2[$j][0] = $i * 50 + 200
		$aPoint2[$j][1] = 150 - _ACsc($i) * 50
		$j += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint2)
	$tLayout = _GDIPlus_RectFCreate(200, $aPoint1[$m-1][1], 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '-π/2', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(200, $aPoint2[1][1], 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'π/2', $hFont, $tLayout, $hFormat, $hBrush)
	
	_GDIPlus_GraphicsDrawLine($hGraphic, 150, $aPoint1[$m-1][1]+2, 200, $aPoint1[$m-1][1]+2, $hAsymPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, $aPoint2[1][1]+2, 250, $aPoint2[1][1]+2, $hAsymPen)
	
	$hBrush1 = _GDIPlus_BrushCreateSolid(0xFF000000)
	_GDIPlus_GraphicsDrawEllipse($hGraphic, 148, $aPoint1[$m - 1][1], 4, 4, $hBrush1)
	_GDIPlus_GraphicsFillEllipse($hGraphic, 148, $aPoint1[$m - 1][1], 4, 4, $hBrush1)
	_GDIPlus_GraphicsDrawEllipse($hGraphic, 248, $aPoint2[1][1], 4, 4, $hBrush1)
	_GDIPlus_GraphicsFillEllipse($hGraphic, 248, $aPoint2[1][1], 4, 4, $hBrush1)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_PenDispose($hAsymPen)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

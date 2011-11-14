#include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hBrush, $hFormat, $hFamily, $hFont, $tLayout, $hPen, $hPen1
	Local $aPoint1[301][2],$aPoint2[301][2] , $m =1, $j=1, $hAsymPen


	; 创建界面
	$hGUI = GUICreate("Inverse Secant", 400, 300)
	$hWnd = WinGetHandle("Inverse Secant")
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
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'Inverse Secant', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(244, 150, 20, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '1', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(150, 150, 20, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, '-1', $hFont, $tLayout, $hFormat, $hBrush)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($hGraphic, 0, 150, 248, 150, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 252, 150, 400, 150, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, 0, 200, 300, $hPen)
	_GDIPlus_GraphicsDrawEllipse($hGraphic, 248, 148, 4, 4)

	$aPoint1[0][0] = 299
	$aPoint2[0][0] = 299
	For $i = -4 To -1.01 Step 0.01
		$aPoint1[$m][0] = $i * 50 + 200
		$aPoint1[$m][1] = 150 - _ASec($i) * 30
		$m += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint1)
	For $i = 1.01 To 4 Step 0.01
		$aPoint2[$j][0] = $i * 50 + 200
		$aPoint2[$j][1] = 150 - _ASec($i) * 30
		$j += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint2)
	_GDIPlus_GraphicsDrawEllipse($hGraphic, $aPoint1[$m-1][0] -1, $aPoint1[$m-1][1]-1, 4, 4)
	$hAsymPen = _GDIPlus_PenCreate()
	_GDIPlus_PenSetDashStyle($hAsymPen, $GDIP_DASHSTYLEDOT)
	_GDIPlus_GraphicsDrawLine($hGraphic, 150, 0, 150, $aPoint1[$m-1][1]-1, $hAsymPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 150, $aPoint1[$m-1][1]+3, 150, 300, $hAsymPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 0, ($aPoint1[1][1]+$aPoint2[$j-1][1])/2, 400, ($aPoint1[1][1]+$aPoint2[$j-1][1])/2, $hAsymPen)
	$tLayout = _GDIPlus_RectFCreate(200, ($aPoint1[1][1]+$aPoint2[$j-1][1])/2 - 15, 40, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'π/2', $hFont, $tLayout, $hFormat, $hBrush)
	
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

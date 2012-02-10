#Include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
  Local $hGUI, $hWnd, $hGraphic, $hBrush, $tLayout1, $hFormat, $hFamily, $hFont, $tLayout, $hPen
  Local $aPoint1[500][2], $aPoint2[500][2], $j = 1, $m = 1, $hBrush1, $tLayout2

  ; 创建界面
  $hGUI = GUICreate("Inverse Cotangent", 400, 300)
  $hWnd = WinGetHandle("Inverse Cotangent")
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
  $tLayout1 = _GDIPlus_RectFCreate(20, 20, 200, 20)
  _GDIPlus_GraphicsDrawStringEx($hGraphic, 'Inverse Cotangent', $hFont, $tLayout1, $hFormat, $hBrush)
  $tLayout2 = _GDIPlus_RectFCreate(200, 70, 50, 20)
  _GDIPlus_GraphicsDrawStringEx($hGraphic, 'π/2', $hFont, $tLayout2, $hFormat, $hBrush)
  $hPen = _GDIPlus_PenCreate()
  _GDIPlus_GraphicsDrawLine($hGraphic, 0, 150, 400, 150, $hPen)
  
	$aPoint2[0][0] = 400
	$aPoint1[0][0] = 401
	For $i = -4 To 0 Step 0.01
		If Not ($i = 0) Then
			$aPoint2[$j][0] = $i * 50 + 200
			$aPoint2[$j][1] = 150 - _ACot($i * $pi) * 50
			$j += 1
		EndIf
	Next
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, 0, 200, $aPoint2[$j - 1][1] - 2, $hPen)
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint2)
	_GDIPlus_GraphicsDrawEllipse($hGraphic, 198, $aPoint2[$j - 1][1] - 2, 4, 4)
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, $aPoint2[$j - 1][1] + 2, 200, 300, $hPen)
	For $i = 0 To 4 Step 0.01
		$aPoint1[$m][0] = $i * 50 + 200
		$aPoint1[$m][1] = 150 - _ACot($i * $pi) * 50
		$m += 1
	Next
	_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint1)
	$hBrush1 = _GDIPlus_BrushCreateSolid(0xFF000000)
	_GDIPlus_GraphicsDrawEllipse($hGraphic, 198, $aPoint1[1][1], 4, 4)
	_GDIPlus_GraphicsFillEllipse($hGraphic, 198, $aPoint1[1][1], 4, 4, $hBrush1)


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

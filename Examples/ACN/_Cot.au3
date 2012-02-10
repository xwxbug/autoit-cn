#Include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hBrush, $hFormat, $hFamily, $hFont, $tLayout, $hPen, $hDashPen
	Dim $aPoint[802][2], $j = 0, $w = -3
  ; 创建界面
  $hGUI = GUICreate("Cotangent", 400, 300)
  $hWnd = WinGetHandle("Cotangent")
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
  $tLayout = _GDIPlus_RectFCreate(20, 20, 200, 50)
  _GDIPlus_GraphicsDrawStringEx($hGraphic, 'Cotangent',$hFont, $tLayout, $hFormat, $hBrush)
  $hPen = _GDIPlus_PenCreate()
  _GDIPlus_GraphicsDrawLine($hGraphic, 0, 150, 400, 150, $hPen)
  _GDIPlus_GraphicsDrawLine($hGraphic, 200, 0, 200, 300, $hPen)
	$hDashPen = _GDIPlus_PenCreate()
	_GDIPlus_PenSetDashStyle($hDashPen, $GDIP_DASHSTYLEDOT)


	$aPoint[0][0] = 801
	For $i = -19 To 20 Step 0.01
		$aPoint[$j][0] = $i * 10 + 200
		$aPoint[$j][1] = 150 - _cot($i/2) * 50
		If $j Then
			If $j > 2 Then
				Dim $a0 = 150 - $aPoint[$j][1]
				Dim $a1 = 150 - $aPoint[$j - 1][1]
				Dim $a2 = 150 - $aPoint[$j - 2][1]
				If (150 - $a0) * (150 - $a2) < 0 Then
					_GDIPlus_GraphicsDrawLine($hGraphic, $aPoint[$j - 1][0] +1, 0, $aPoint[$j - 1][0]+1, 300, $hDashPen)
					$tLayout = _GDIPlus_RectFCreate($aPoint[$j - 1][0] - 4, 150, 70, 40)
					If $w<>0 And Not(Abs($w) = 1) Then _GDIPlus_GraphicsDrawStringEx($hGraphic,$w & 'π', $hFont, $tLayout, $hFormat, $hBrush)
					If Abs($w) = 1 then _GDIPlus_GraphicsDrawStringEx($hGraphic,StringTrimRight(String($w), 1) & 'π', $hFont, $tLayout, $hFormat, $hBrush)
					$w+=1
				EndIf
			EndIf

			If $aPoint[$j][1] * $aPoint[$j - 1][1] < 0 Then
				ReDim $aPoint[$j][2]
				$aPoint[0][0] = $j-1
				_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint)
				$aPoint[0][0] = 0
				ReDim $aPoint[802][2]
				$aPoint[0][0] = 801
				$j = 0
			EndIf
		EndIf
		$j += 1
	Next

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